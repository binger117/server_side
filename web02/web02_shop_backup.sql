-- MySQL dump 10.13  Distrib 5.7.40, for Win64 (x86_64)
--
-- Host: localhost    Database: web02_shop
-- ------------------------------------------------------
-- Server version	5.7.40-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addr`
--

DROP TABLE IF EXISTS `addr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `province` varchar(20) NOT NULL,
  `city` varchar(20) NOT NULL,
  `county` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `addr_user_id_65e09bac_fk_users_id` (`user_id`),
  CONSTRAINT `addr_user_id_65e09bac_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addr`
--

LOCK TABLES `addr` WRITE;
/*!40000 ALTER TABLE `addr` DISABLE KEYS */;
INSERT INTO `addr` VALUES (12,'18436099538','斌戈尔117','河南省','商丘市','华邑城小区','guess117',0,2),(13,'18436099538','斌戈尔01','河南省3','商丘市','华邑城','guess',0,1),(14,'18436099538','斌戈尔02','河南省3','商丘市','华邑城','guess',1,2);
/*!40000 ALTER TABLE `addr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `level` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area`
--

LOCK TABLES `area` WRITE;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
/*!40000 ALTER TABLE `area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add 用户表',6,'add_user'),(22,'Can change 用户表',6,'change_user'),(23,'Can delete 用户表',6,'delete_user'),(24,'Can view 用户表',6,'view_user'),(25,'Can add 地狱表',7,'add_area'),(26,'Can change 地狱表',7,'change_area'),(27,'Can delete 地狱表',7,'delete_area'),(28,'Can view 地狱表',7,'view_area'),(29,'Can add 验证码表',8,'add_verifcode'),(30,'Can change 验证码表',8,'change_verifcode'),(31,'Can delete 验证码表',8,'delete_verifcode'),(32,'Can view 验证码表',8,'view_verifcode'),(33,'Can add 收货表',9,'add_addr'),(34,'Can change 收货表',9,'change_addr'),(35,'Can delete 收货表',9,'delete_addr'),(36,'Can view 收货表',9,'view_addr'),(37,'Can add 首页商品轮播',10,'add_goodsbanner'),(38,'Can change 首页商品轮播',10,'change_goodsbanner'),(39,'Can delete 首页商品轮播',10,'delete_goodsbanner'),(40,'Can view 首页商品轮播',10,'view_goodsbanner'),(41,'Can add 商品详情',11,'add_detail'),(42,'Can change 商品详情',11,'change_detail'),(43,'Can delete 商品详情',11,'delete_detail'),(44,'Can view 商品详情',11,'view_detail'),(45,'Can add 商品分类表',12,'add_goodsgroup'),(46,'Can change 商品分类表',12,'change_goodsgroup'),(47,'Can delete 商品分类表',12,'delete_goodsgroup'),(48,'Can view 商品分类表',12,'view_goodsgroup'),(49,'Can add 商品表',13,'add_goods'),(50,'Can change 商品表',13,'change_goods'),(51,'Can delete 商品表',13,'delete_goods'),(52,'Can view 商品表',13,'view_goods'),(53,'Can add 收藏商品',14,'add_collect'),(54,'Can change 收藏商品',14,'change_collect'),(55,'Can delete 收藏商品',14,'delete_collect'),(56,'Can view 收藏商品',14,'view_collect');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banner` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `title` varchar(20) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `seq` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

LOCK TABLES `banner` WRITE;
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
INSERT INTO `banner` VALUES (1,'2023-06-17 03:19:30.743255','2023-06-18 00:21:02.391820',0,'水果图','carousel01.png',1,1);
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collect`
--

DROP TABLE IF EXISTS `collect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collect` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collect_goods_id_696c83a5_fk_goods_id` (`goods_id`),
  KEY `collect_user_id_9b5330ca_fk_users_id` (`user_id`),
  CONSTRAINT `collect_goods_id_696c83a5_fk_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`),
  CONSTRAINT `collect_user_id_9b5330ca_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collect`
--

LOCK TABLES `collect` WRITE;
/*!40000 ALTER TABLE `collect` DISABLE KEYS */;
INSERT INTO `collect` VALUES (2,2,2);
/*!40000 ALTER TABLE `collect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail`
--

DROP TABLE IF EXISTS `detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `producer` varchar(200) NOT NULL,
  `norms` varchar(200) NOT NULL,
  `details` longtext NOT NULL,
  `goods_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `goods_id` (`goods_id`),
  CONSTRAINT `detail_goods_id_9bb8c24d_fk_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail`
--

LOCK TABLES `detail` WRITE;
/*!40000 ALTER TABLE `detail` DISABLE KEYS */;
INSERT INTO `detail` VALUES (1,'2023-06-20 06:36:52.451725','2023-06-20 06:40:09.640425',0,'佳农（Goodfarmer）','5.32kg','<p>&nbsp;</p>\r\n\r\n<ul>\r\n	<li>商品名称：佳农佳农 陕西洛川苹果红富士5kg 75果 单果克重约170g-200g 高原超甜 水果礼盒 生鲜水果</li>\r\n	<li>商品编号：100011322041</li>\r\n	<li>商品产地：中国 陕西省延安市洛川县</li>\r\n	<li>品种：富士</li>\r\n	<li>特产品类：洛川苹果</li>\r\n	<li>原产地：陕西</li>\r\n	<li>贮存条件：冷藏</li>\r\n	<li>国产/进口：国产</li>\r\n	<li><img src=\"https://img30.360buyimg.com/popWareDetail/jfs/t1/180527/15/25830/262371/63117e8bEeb81d114/abff8273ac3b46ac.jpg\" /></li>\r\n</ul>',1);
/*!40000 ALTER TABLE `detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-06-17 00:17:17.628733','6','python04',1,'[{\"added\": {}}]',6,5),(2,'2023-06-17 01:01:10.252357','1','蔬菜',1,'[{\"added\": {}}]',12,5),(3,'2023-06-17 01:02:22.700560','1','水果蔬菜',2,'[{\"changed\": {\"fields\": [\"\\u540d\\u79f0\"]}}]',12,5),(4,'2023-06-17 01:03:59.924310','2','肉类制品',1,'[{\"added\": {}}]',12,5),(5,'2023-06-17 01:04:13.370437','3','鱼虾海鲜',1,'[{\"added\": {}}]',12,5),(6,'2023-06-17 01:04:16.953128','3','鱼虾海鲜',2,'[{\"changed\": {\"fields\": [\"\\u662f\\u5426\\u542f\\u7528\"]}}]',12,5),(7,'2023-06-17 01:11:47.722357','3','鱼虾海鲜',2,'[{\"changed\": {\"fields\": [\"\\u5206\\u7c7b\\u56fe\\u6807\"]}}]',12,5),(8,'2023-06-17 01:11:51.850068','2','肉类制品',2,'[{\"changed\": {\"fields\": [\"\\u5206\\u7c7b\\u56fe\\u6807\"]}}]',12,5),(9,'2023-06-17 03:08:13.818197','1','苹果',1,'[{\"added\": {}}]',13,5),(10,'2023-06-17 03:11:32.407714','2','香蕉',1,'[{\"added\": {}}]',13,5),(11,'2023-06-17 03:12:44.310735','1','苹果',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u94fe\\u63a5\"]}}]',13,5),(12,'2023-06-17 03:19:30.745251','1','水果图',1,'[{\"added\": {}}]',10,5),(13,'2023-06-17 07:59:59.815803','3','秋刀鱼',1,'[{\"added\": {}}]',13,5),(14,'2023-06-17 08:02:33.153265','4','五花肉一斤',1,'[{\"added\": {}}]',13,5),(15,'2023-06-17 08:02:43.354911','4','五花肉一斤',2,'[{\"changed\": {\"fields\": [\"\\u662f\\u5426\\u4e0a\\u67b6\", \"\\u662f\\u5426\\u63a8\\u8350\"]}}]',13,5),(16,'2023-06-18 00:20:00.534235','3','秋刀鱼',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u94fe\\u63a5\"]}}]',13,5),(17,'2023-06-18 00:20:08.397161','4','五花肉一斤',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u94fe\\u63a5\"]}}]',13,5),(18,'2023-06-18 00:20:14.528549','2','香蕉',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u94fe\\u63a5\"]}}]',13,5),(19,'2023-06-18 00:20:20.382450','1','苹果',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u94fe\\u63a5\"]}}]',13,5),(20,'2023-06-18 00:20:34.274013','3','鱼虾海鲜',2,'[{\"changed\": {\"fields\": [\"\\u5206\\u7c7b\\u56fe\\u6807\"]}}]',12,5),(21,'2023-06-18 00:20:40.186629','2','肉类制品',2,'[{\"changed\": {\"fields\": [\"\\u5206\\u7c7b\\u56fe\\u6807\"]}}]',12,5),(22,'2023-06-18 00:20:46.939767','1','水果蔬菜',2,'[{\"changed\": {\"fields\": [\"\\u5206\\u7c7b\\u56fe\\u6807\"]}}]',12,5),(23,'2023-06-18 00:21:02.394810','1','水果图',2,'[{\"changed\": {\"fields\": [\"\\u8f6e\\u64ad\\u56fe\\u94fe\\u63a5\"]}}]',10,5),(24,'2023-06-18 00:21:33.159491','3','秋刀鱼',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u94fe\\u63a5\"]}}]',13,5),(25,'2023-06-18 00:22:02.846046','3','秋刀鱼',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u94fe\\u63a5\"]}}]',13,5),(26,'2023-06-18 03:21:37.236274','2','香蕉',2,'[{\"changed\": {\"fields\": [\"\\u662f\\u5426\\u4e0a\\u67b6\"]}}]',13,5),(27,'2023-06-18 09:10:44.054780','4','五花肉一斤',2,'[{\"changed\": {\"fields\": [\"\\u5e93\\u5b58\"]}}]',13,5),(28,'2023-06-18 09:10:48.469286','3','秋刀鱼',2,'[]',13,5),(29,'2023-06-18 09:10:55.785896','2','香蕉',2,'[{\"changed\": {\"fields\": [\"\\u9500\\u91cf\"]}}]',13,5),(30,'2023-06-18 09:11:03.995247','1','苹果',2,'[{\"changed\": {\"fields\": [\"\\u9500\\u91cf\"]}}]',13,5),(31,'2023-06-18 09:11:09.003661','3','秋刀鱼',2,'[{\"changed\": {\"fields\": [\"\\u9500\\u91cf\"]}}]',13,5),(32,'2023-06-18 09:15:13.647624','5','龙虾',1,'[{\"added\": {}}]',13,5),(33,'2023-06-20 06:36:52.463733','1','Detail object (1)',1,'[{\"added\": {}}]',11,5),(34,'2023-06-20 06:40:09.644415','1','Detail object (1)',2,'[{\"changed\": {\"fields\": [\"\\u5546\\u54c1\\u8be6\\u60c5\"]}}]',11,5);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(14,'goods','collect'),(11,'goods','detail'),(13,'goods','goods'),(10,'goods','goodsbanner'),(12,'goods','goodsgroup'),(5,'sessions','session'),(9,'users','addr'),(7,'users','area'),(6,'users','user'),(8,'users','verifcode');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-05-30 09:12:01.673520'),(2,'contenttypes','0002_remove_content_type_name','2023-05-30 09:12:01.728171'),(3,'auth','0001_initial','2023-05-30 09:12:01.888514'),(4,'auth','0002_alter_permission_name_max_length','2023-05-30 09:12:01.921008'),(5,'auth','0003_alter_user_email_max_length','2023-05-30 09:12:01.926122'),(6,'auth','0004_alter_user_username_opts','2023-05-30 09:12:01.932139'),(7,'auth','0005_alter_user_last_login_null','2023-05-30 09:12:01.937125'),(8,'auth','0006_require_contenttypes_0002','2023-05-30 09:12:01.940599'),(9,'auth','0007_alter_validators_add_error_messages','2023-05-30 09:12:01.946147'),(10,'auth','0008_alter_user_username_max_length','2023-05-30 09:12:01.963102'),(11,'auth','0009_alter_user_last_name_max_length','2023-05-30 09:12:01.974094'),(12,'auth','0010_alter_group_name_max_length','2023-05-30 09:12:02.013108'),(13,'auth','0011_update_proxy_permissions','2023-05-30 09:12:02.018292'),(14,'auth','0012_alter_user_first_name_max_length','2023-05-30 09:12:02.022745'),(15,'users','0001_initial','2023-05-30 09:12:02.290526'),(16,'admin','0001_initial','2023-05-30 09:12:02.532948'),(17,'admin','0002_logentry_remove_auto_add','2023-05-30 09:12:02.540449'),(18,'admin','0003_logentry_add_action_flag_choices','2023-05-30 09:12:02.547402'),(19,'sessions','0001_initial','2023-05-30 09:12:02.581797'),(20,'goods','0001_initial','2023-06-16 02:29:32.320524'),(21,'users','0002_auto_20230616_1728','2023-06-16 09:28:07.626991');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('hn414lrt1uis2w3wru6qy1dc8p6mxip9','.eJxVy00KwjAQQOG7ZC2lSTOTiUv3niHM5IcUaQo2XYh4dy240O37eE8VeO817Fu-hzmpswJ1-m3C8ZbbAXFdlrUNB-XW58g9D9fH5et_U-Wtfg5HHk2x6N1UNIjR6CkKCfEIEQUcERmrk0VJ2nBBkx2MDs0kQKBFvd7u2zJP:1qA5bN:tH_0bQke3Cqi_YdEmt5p-OUp3wotf0f-4CZa_5w6lT4','2023-06-30 09:18:41.827794');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `title` varchar(10) NOT NULL,
  `desc` varchar(20) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `cover` varchar(100) DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `sales` int(11) NOT NULL,
  `is_on` tinyint(1) NOT NULL,
  `recommend` tinyint(1) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_group_id_a4f95326_fk_goods_group_id` (`group_id`),
  CONSTRAINT `goods_group_id_a4f95326_fk_goods_group_id` FOREIGN KEY (`group_id`) REFERENCES `goods_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (1,'2023-06-17 03:08:13.815209','2023-06-18 09:11:03.994249',0,'苹果','大凉山苹果',2.00,'goods01.jpg',999,88,1,1,1),(2,'2023-06-17 03:11:32.405718','2023-06-18 09:10:55.785896',0,'香蕉','特产香蕉',5.00,'goods02.jpg',999,9,0,1,1),(3,'2023-06-17 07:59:59.813808','2023-06-18 09:11:09.001658',0,'秋刀鱼','神户秋刀鱼',999.00,'goods03.jpg',999,77,1,1,3),(4,'2023-06-17 08:02:33.152266','2023-06-18 09:10:44.051779',0,'五花肉一斤','新鲜五花肉',15.00,'goods04.jpg',99,99,1,1,2),(5,'2023-06-18 09:15:13.645630','2023-06-18 09:15:13.645630',0,'龙虾','神户龙虾',65.00,'goods05.jpg',999,55,1,1,3);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_group`
--

DROP TABLE IF EXISTS `goods_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_group`
--

LOCK TABLES `goods_group` WRITE;
/*!40000 ALTER TABLE `goods_group` DISABLE KEYS */;
INSERT INTO `goods_group` VALUES (1,'水果蔬菜','vegetable.png',1),(2,'肉类制品','meat.png',1),(3,'鱼虾海鲜','seafood.png',1);
/*!40000 ALTER TABLE `goods_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'pbkdf2_sha256$260000$BE8WDnPSDIBTFCTU3jeLVM$I6D5JIpFODlhITQuBC9K/eMRqMB6VbbSVLfuAnz0iPQ=',NULL,0,'python01','','binger117','mrbinger117@wwqq.com',0,1,'2023-06-05 08:56:14.905573','2023-06-05 08:56:15.040213','2023-06-14 09:21:30.754719',0,'','91763390411a3479a860337580343daed6dc2e39.jpg'),(2,'pbkdf2_sha256$260000$BJFzx9xdmSMXbyF7f9AxQV$yJu64uFFRpbRqld3dsOcRuKKPjmAWG/SbW6ClhbCrEs=',NULL,0,'python02','','','1311@qq.com',0,1,'2023-06-06 02:53:29.268654','2023-06-06 02:53:29.402297','2023-06-15 07:14:44.269841',0,'17629774869','91763390411a3479a860337580343daed6dc2e39.jpg'),(3,'pbkdf2_sha256$260000$203gDTTJ3XqM1d94IkIFlg$dT3QgBZ/02r7Y+t4H2cLhsRAvwXMsukuKl7BwGpOeNg=',NULL,0,'python03','','','1411@qq.com',0,1,'2023-06-09 01:53:06.965016','2023-06-09 01:53:07.100386','2023-06-09 01:53:07.100386',0,'',''),(5,'pbkdf2_sha256$260000$JLezXsQbbaq7TFE2Ca84JD$f2Z5l1E5YrzuDuzTaMlme7cqBhePvlnjrfT0LY3JL3A=','2023-06-16 09:18:41.825776',1,'admin','','','mrbinger117@gmail.com',1,1,'2023-06-16 09:16:33.608213','2023-06-16 09:16:33.739861','2023-06-16 09:16:33.739861',0,'',''),(6,'qwe123',NULL,0,'python04','','斌04','11704@qq.com',0,1,'2023-06-17 00:15:51.000000','2023-06-17 00:17:17.624844','2023-06-17 00:17:17.624844',0,'11704','');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_groups_user_id_group_id_fc7788e8_uniq` (`user_id`,`group_id`),
  KEY `users_groups_group_id_2f3517aa_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_groups_group_id_2f3517aa_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `users_groups_user_id_f500bee5_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_permissions`
--

DROP TABLE IF EXISTS `users_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_permissions_user_id_permission_id_3b86cbdf_uniq` (`user_id`,`permission_id`),
  KEY `users_user_permissio_permission_id_6d08dcd2_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_user_permissio_permission_id_6d08dcd2_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_user_permissions_user_id_92473840_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_permissions`
--

LOCK TABLES `users_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verifcode`
--

DROP TABLE IF EXISTS `verifcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `verifcode` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(11) NOT NULL,
  `code` varchar(6) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verifcode`
--

LOCK TABLES `verifcode` WRITE;
/*!40000 ALTER TABLE `verifcode` DISABLE KEYS */;
INSERT INTO `verifcode` VALUES (1,'17629774869','556355','2023-06-12 02:30:17.400546');
/*!40000 ALTER TABLE `verifcode` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-28 15:54:38
