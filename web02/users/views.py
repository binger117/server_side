import os.path
import re

from django.http import FileResponse
from django.shortcuts import render

# Create your views here.
from rest_framework import status, mixins
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.viewsets import GenericViewSet
from rest_framework_simplejwt.exceptions import TokenError, InvalidToken

from rest_framework_simplejwt.views import TokenObtainPairView

from users.models import User, Addr
from users.permissions import UserPermission, AddrPermission
from users.serializers import UserSerializer, AddrSerializer
from web02.settings import MEDIA_ROOT


class RegisterView(APIView):
    def post(self, request):
        """注册接口"""
        # 一、接受用户参数
        username = request.data.get("username")
        password = request.data.get("password")
        email = request.data.get("email")
        password_confirmation = request.data.get('password_confirmation')
        # 二、参数验证
        # 1、参数验证是否为空
        if not all([username, password, email, password_confirmation]):
            return Response({'error': "用户名已存在"}, status=status.HTTP_402_PAYMENT_REQUIRED)
        # 2、校验用户名是否已注册
        if User.objects.filter(username=username).exists():
            return Response({'error': "用户名已存在"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 3、校验两次密码是否一致
        if password != password_confirmation:
            return Response({'error': "两次密码不一致"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 4、校验密码长度
        if not (6 <= len(password) <= 18):
            return Response({'error': "密码长度需要在6到18位之间"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 5、校验邮箱是否存在
        if User.objects.filter(email=email).exists():
            return Response({'error': "该邮箱已被其他用户使用"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 6、校验邮箱格式是否正确
        if not re.match(r'^[a-z0-9][\w.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
            return Response({'error': "邮箱格式有误！"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 三、创建用户
        obj = User.objects.create_user(username=username, email=email, password=password)
        res = {"username": username, 'id': obj.id, 'email': obj.email}
        return Response(res, status=status.HTTP_201_CREATED)


class LoginView(TokenObtainPairView):
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)

        try:
            serializer.is_valid(raise_exception=True)
        except TokenError as e:
            raise InvalidToken(e.args[0])
        # 自定义登录成功之后返回的结果
        result = serializer.validated_data
        result['id'] = serializer.user.id
        result['mobile'] = serializer.user.mobile
        result['email'] = serializer.user.email
        result['username'] = serializer.user.username
        result['token'] = result.pop('access')
        print()
        return Response(serializer.validated_data, status=status.HTTP_200_OK)


class UserView(GenericViewSet, mixins.RetrieveModelMixin):
    """用户相关操作的视图集"""
    queryset = User.objects.all()
    serializer_class = UserSerializer
    # 设置认证用户才能有权限访问
    permission_classes = [IsAuthenticated, UserPermission]

    def upload_avatar(self, request, *args, **kwargs):
        """上传用户头像"""
        avatar = request.data.get('avatar')
        # 校验是否有上传文件
        if not avatar:
            return Response({'error': '上传失败，文件不能为空'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 校验文件大小不能超过300kb
        if avatar.size > 1024 * 300:
            return Response({'error': '上传失败，文件大小不能超过300kb'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 保存文件
        user = self.get_object()
        # 获取序列化对象
        ser = self.get_serializer(user, data={"avatar": avatar}, partial=True)
        # 校验
        ser.is_valid(raise_exception=True)
        ser.save()
        return Response({'url': ser.data['avatar']})

    '''
    def bind_mobile(self, request, *args, **kwargs):
        """绑定手机视图"""
        # 1、获取参数
        code = request.data.get('code')  # 获取验证码
        codeID = request.data.get('codeID')  # 获取验证码的ID
        mobile = request.data.get('mobile')  # 绑定手机号
        # 2、校验参数
        if not code:
            return Response({'error': "验证码不能为空"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if not codeID:
            return Response({'error': "验证码ID不能为空"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if not mobile:
            return Response({'error': "手机号不能为空"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 3、校验验证码
        if VerifCode.objects.filter(id=codeID, code=code, mobile=mobile).exists():
            # 校验验证码是否过期(过期时间3分钟)
            c_obj = VerifCode.objects.get(id=codeID, code=code, mobile=mobile)
            # 获取验证码创建的时间戳
            ct = c_obj.create_time.timestamp()
            # 获取当前时间的时间戳
            et = time.time()
            # 删除验证码(避免出现用户在有效期类，使用同一个验证码重复请求)
            c_obj.delete()
            if ct + 180 < et:
                return Response({'error': "验证码已过期，请从新获取验证码"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        else:
            return Response({'error': "验证码验证失败，请从新获取验证码！"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 4、绑定手机号
        # 校验手机号
        if User.objects.filter(mobile=mobile).exists():
            return Response({'error': "手机号不能重复绑定多个用户"},
                            status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 绑定手机号(把手机号保存到用户的mobile字段)
        user = request.user
        user.mobile = mobile
        user.save()
        return Response({'message': "绑定成功"}, status=status.HTTP_200_OK)

    def unbind_mobile(self, request, *args, **kwargs):
        """解绑手机视图"""
        # 1、获取参数
        code = request.data.get('code')  # 获取验证码
        codeID = request.data.get('codeID')  # 获取验证码的ID
        mobile = request.data.get('mobile')  # 绑定手机号
        # 2、校验参数和验证码
        result = self.verif_code(code, codeID, mobile)
        if result:
            return Response(result, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 3、解绑手机(验证用户已绑定手机号)
        user = request.user
        if user.mobile == mobile:
            user.mobile = ''
            user.save()
            return Response({'message': "解绑成功"}, status=status.HTTP_200_OK)
        else:
            return Response({'error': "当前用户没有绑定该号码"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)

    def update_name(self, request, *args, **kwargs):
        """修改用户昵称"""
        # 1、获取参数
        last_name = request.data.get('last_name')
        # 2、校验参数
        if not last_name:
            return Response({'error': "参数last_name不能为空"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 3、修改用户名
        user = self.get_object()
        user.last_name = last_name
        user.save()
        return Response({'message': "修改成功"}, status=status.HTTP_200_OK)

    def update_email(self, request, *args, **kwargs):
        """修改用户邮箱的视图"""
        # 1、获取参数
        email = request.data.get('email')
        user = self.get_object()
        # 2、校验参数
        # 参数不能为空
        if not email:
            return Response({'error': "邮箱不能为空"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 校验邮箱格式是否正确
        if not re.match(r'^\w+@[A-Za-z]+(\.[A-Za-z0-9]+){1,}$', email):
            return Response({'error': "邮箱格式有误！"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 邮箱地址和之前的是否一样
        if user.email == email:
            return Response({'message': "OK"}, status=status.HTTP_200_OK)
        # 邮箱有没有被其他用户绑定
        if User.objects.filter(email=email).exists():
            return Response({'error': "该邮箱已被其他用户绑定"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 3、修改邮箱
        user.email = email
        user.save()
        return Response({'message': "OK"}, status=status.HTTP_200_OK)

    def update_password(self, request, *args, **kwargs):
        """修改密码视图"""
        user = self.get_object()
        # 1、获取参数
        code = request.data.get('code')
        codeID = request.data.get('codeID')
        mobile = request.data.get('mobile')
        password = request.data.get('password')
        password_confirmation = request.data.get('password_confirmation')
        # 2、校验验证码
        result = self.verif_code(code, codeID, mobile)
        if result:
            return Response(result, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if user.mobile != mobile:
            return Response({'error': "此验证码，不是该用户绑定手机发送的验证码！"},
                            status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 3、校验密码
        if not password:
            return Response({'error': "密码不能为空！"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if password != password_confirmation:
            return Response({'error': "两次密码输入的不一致！"}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 4、修改密码
        # 密码再数据库再是加密存储的，修改密码必须要使用用户的set_password方法
        user.set_password(password)
        user.save()
        return Response({"message": "修改密码成功"})

    @staticmethod
    def verif_code(code, codeID, mobile):
        """
        验证码校验的通用逻辑
        :param code: 验证码
        :param codeID: 验证码ID
        :param mobile: 手机号
        :return: 验证通过返回None ,验证失败返回Response
        """
        # 1、校验参数
        if not code:
            return {'error': "验证码不能为空"}
        if not codeID:
            return {'error': "验证码ID不能为空"}
        if not mobile:
            return {'error': "手机号不能为空"}
        # 2、校验验证码
        if VerifCode.objects.filter(id=codeID, code=code, mobile=mobile).exists():
            # 校验验证码是否过期(过期时间3分钟)
            c_obj = VerifCode.objects.get(id=codeID, code=code, mobile=mobile)
            # 获取验证码创建的时间戳
            ct = c_obj.create_time.timestamp()
            # 获取当前时间的时间戳
            et = time.time()
            # 删除验证码(避免出现用户在有效期类，使用同一个验证码重复请求)
            c_obj.delete()
            if ct + 180 < et:
                return {'error': "验证码已过期，请从新获取验证码"}
        else:
            return {'error': "验证码验证失败，请从新获取验证码！"}
'''


class FileView(APIView):
    # 获取文件的视图
    def get(self, request, name):
        path = MEDIA_ROOT / name
        if os.path.isfile(path):
            return FileResponse(open(path, 'rb'))
        return Response({'error': "没有找到该文件！"}, status=status.HTTP_404_NOT_FOUND)


class AddrView(GenericViewSet,
               mixins.ListModelMixin,
               mixins.CreateModelMixin,
               mixins.DestroyModelMixin,
               mixins.UpdateModelMixin):
    """收货地址管理视图"""
    queryset = Addr.objects.all()
    serializer_class = AddrSerializer
    # 设置认证用户才能有权限访问
    permission_classes = [IsAuthenticated, AddrPermission]

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        # 通过请求过来的认证用户进行过滤
        queryset = queryset.filter(user=request.user)
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)