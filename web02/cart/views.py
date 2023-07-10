from rest_framework import mixins, status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.viewsets import GenericViewSet

from .permissions import CartPermission
from .serializers import CartSerializer, ReadCartSerializer

from cart.models import Cart


class CartView(GenericViewSet,
               mixins.DestroyModelMixin,
               mixins.CreateModelMixin,
               mixins.UpdateModelMixin,
               mixins.ListModelMixin,
               ):
    """购物车管理"""
    queryset = Cart.objects.all()
    serializer_class = CartSerializer
    # 权限: 用户需要登录之后才能访问，每个用户只能修改自己的数据
    permission_classes = [IsAuthenticated, CartPermission]

    filterset_fields = ['is_checked']

    def get_serializer_class(self):
        """实现读写操作使用不同的序列化器"""
        if self.action == 'list':
            return ReadCartSerializer
        else:
            return self.serializer_class

    def create(self, request, *args, **kwargs):
        """添加商品到购物车"""
        # 获取用户信息
        user = request.user
        # 获取参数
        goods = request.data.get('goods')
        # 1、校验该用户的购物车中是否有该商品
        if Cart.objects.filter(user=user, goods=goods).exists():
            # 这个用户已经添加过该商品到购物车,直接修改商品的数量
            cart_goods = Cart.objects.get(user=user, goods=goods)
            cart_goods.number += 1
            cart_goods.save()
            # 对该商品进行序列化
            serializer = self.get_serializer(cart_goods)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            # 没有商品，则调用继承的create方法进行创建
            request.data['user'] = user.id
            return super().create(request, *args, **kwargs)

    def list(self, request, *args, **kwargs):
        """获取用户购物车的所有商品"""
        queryset = self.filter_queryset(self.get_queryset())
        query = queryset.filter(user=request.user)
        serializer = self.get_serializer(query, many=True)
        return Response(serializer.data)

    def update_goods_status(self, request, *args, **kwargs):
        """修改商品的选中状态"""
        # 修改商品的选中状态
        obj = self.get_object()
        obj.is_checked = not obj.is_checked
        obj.save()
        return Response({'message': "修改成功"}, status=status.HTTP_200_OK)

    def update_goods_number(self, request, *args, **kwargs):
        """修改商品的数量"""
        # 获取参数
        number = request.data.get('number')
        obj = self.get_object()
        # 校验参数
        if not isinstance(number, int):
            return Response({'error': "参数number只能时int类型，并且不能为空"},
                            status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 判断商品的数量是否超过商品的库存
        if number > obj.goods.stock:
            return Response({'error': "数量不能超过该商品的库存!"},
                            status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        elif number <= 0:
            # 删除该商品
            obj.delete()
            return Response({'message': "修改成功,数量小于1，已经从购物车移除该商品"},
                            status=status.HTTP_200_OK)
        else:
            # 修改商品的数量
            obj.number = number
            obj.save()
            return Response({'message': "修改成功"},
                            status=status.HTTP_200_OK)

