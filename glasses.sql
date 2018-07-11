/*
 Navicat Premium Data Transfer

 Source Server         : 139.224.19.74
 Source Server Type    : MySQL
 Source Server Version : 50713
 Source Host           : 139.224.19.74
 Source Database       : glasses

 Target Server Type    : MySQL
 Target Server Version : 50713
 File Encoding         : utf-8

 Date: 07/20/2017 23:28:29 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `tb_admin_menu`
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin_menu`;
CREATE TABLE `tb_admin_menu` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `pid` bigint(20) DEFAULT NULL COMMENT '父菜单id',
  `name` varchar(64) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(128) DEFAULT NULL COMMENT '菜单url',
  `sorter` int(11) DEFAULT '0' COMMENT '排序',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运营端菜单';

-- ----------------------------
--  Table structure for `tb_admin_role`
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin_role`;
CREATE TABLE `tb_admin_role` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(64) DEFAULT NULL COMMENT '角色名称',
  `intro` varchar(64) DEFAULT NULL COMMENT '角色介绍',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(4) DEFAULT '0' COMMENT '是否有效(虚拟删除)  0:ENABLE:有效  1:DISABLE:无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运营角色';

-- ----------------------------
--  Table structure for `tb_admin_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin_role_menu`;
CREATE TABLE `tb_admin_role_menu` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色Id',
  `menuId` bigint(20) DEFAULT NULL COMMENT '菜单Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运营端角色和菜单关系';

-- ----------------------------
--  Table structure for `tb_admin_user`
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin_user`;
CREATE TABLE `tb_admin_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(64) DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(128) DEFAULT NULL COMMENT '头像',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(4) DEFAULT '0' COMMENT '是否有效(虚拟删除)  0:ENABLE:有效  1:DISABLE:无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='运营管理员';

-- ----------------------------
--  Records of `tb_admin_user`
-- ----------------------------
BEGIN;
INSERT INTO `tb_admin_user` VALUES ('1', 'admin', 'admin', '管理员', null, '13816881688', null, '2017-06-23 11:10:49', '0');
COMMIT;

-- ----------------------------
--  Table structure for `tb_admin_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin_user_role`;
CREATE TABLE `tb_admin_user_role` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户Id',
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运营用户和角色的关系';

-- ----------------------------
--  Table structure for `tb_enterprise`
-- ----------------------------
DROP TABLE IF EXISTS `tb_enterprise`;
CREATE TABLE `tb_enterprise` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `number` varchar(64) DEFAULT NULL COMMENT '编号',
  `name` varchar(128) DEFAULT NULL COMMENT '企业名称',
  `logo` varchar(128) DEFAULT NULL COMMENT '企业logo',
  `banner` varchar(128) DEFAULT NULL COMMENT '企业banner',
  `description` varchar(512) DEFAULT NULL COMMENT '介绍',
  `utime` datetime DEFAULT '1970-01-01 08:00:00' COMMENT '修改时间',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(4) DEFAULT '0' COMMENT '是否有效(虚拟删除)  0:ENABLE:有效  1:DISABLE:无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业表';

-- ----------------------------
--  Table structure for `tb_enterprise_customer`
-- ----------------------------
DROP TABLE IF EXISTS `tb_enterprise_customer`;
CREATE TABLE `tb_enterprise_customer` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `entId` bigint(20) DEFAULT NULL COMMENT '企业Id',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户Id',
  `name` varchar(64) DEFAULT NULL COMMENT '顾客名称',
  `phone` varchar(16) DEFAULT NULL COMMENT '手机号',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `description` varchar(512) DEFAULT NULL COMMENT '描述',
  `laststore` bigint(20) DEFAULT NULL COMMENT '最后服务的门店',
  `lastMember` bigint(20) DEFAULT NULL COMMENT '最后服务的企业成员',
  `lastOpt` datetime DEFAULT '1970-01-01 08:00:00' COMMENT '最后验光时间',
  `lastSale` datetime DEFAULT '1970-01-01 08:00:00' COMMENT '最后销售时间',
  `utime` datetime DEFAULT '1970-01-01 08:00:00' COMMENT '最后更新时间',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(4) DEFAULT '0' COMMENT '是否有效(虚拟删除)  0:ENABLE:有效  1:DISABLE:无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业(门店)顾客';

-- ----------------------------
--  Table structure for `tb_enterprise_member`
-- ----------------------------
DROP TABLE IF EXISTS `tb_enterprise_member`;
CREATE TABLE `tb_enterprise_member` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `entId` bigint(20) DEFAULT NULL COMMENT '企业Id',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户Id',
  `memName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `realName` varchar(64) DEFAULT NULL COMMENT '成员真实姓名',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `position` varchar(64) DEFAULT NULL COMMENT '职位',
  `workId` varchar(64) DEFAULT NULL COMMENT '工号',
  `extension` varchar(32) DEFAULT NULL COMMENT '分机号',
  `location` varchar(128) DEFAULT NULL COMMENT '办公地点',
  `entUserId` varchar(64) DEFAULT NULL COMMENT '描述',
  `role` tinyint(4) DEFAULT '0' COMMENT '角色 0:MEM:普通员工  1:ADMIN:管理员 2:OWNER:创建者((唯一，不能允许删除冻结等操作) )',
  `description` varchar(512) DEFAULT NULL COMMENT '描述',
  `utime` datetime DEFAULT '1970-01-01 08:00:00' COMMENT '修改时间',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(4) DEFAULT '0' COMMENT '是否有效(虚拟删除)  0:ENABLE:有效  1:DISABLE:无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业成员表';

-- ----------------------------
--  Table structure for `tb_enterprise_store`
-- ----------------------------
DROP TABLE IF EXISTS `tb_enterprise_store`;
CREATE TABLE `tb_enterprise_store` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `number` varchar(64) DEFAULT NULL COMMENT '编号',
  `entId` bigint(20) DEFAULT NULL COMMENT '企业id',
  `name` varchar(64) DEFAULT NULL COMMENT '名称',
  `contact` varchar(256) DEFAULT NULL COMMENT '联系方式',
  `address` varchar(256) DEFAULT NULL COMMENT '门店地址',
  `description` varchar(512) DEFAULT NULL COMMENT '描述',
  `utime` datetime DEFAULT '1970-01-01 08:00:00' COMMENT '修改时间',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(4) DEFAULT '0' COMMENT '是否有效(虚拟删除)  0:ENABLE:有效  1:DISABLE:无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业下门店';

-- ----------------------------
--  Table structure for `tb_enterprise_store_member`
-- ----------------------------
DROP TABLE IF EXISTS `tb_enterprise_store_member`;
CREATE TABLE `tb_enterprise_store_member` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `storeId` bigint(20) DEFAULT NULL COMMENT '门店Id',
  `memId` bigint(20) DEFAULT NULL COMMENT '用户Id',
  `role` tinyint(4) DEFAULT '0' COMMENT '角色 0:MEM:一般成员 1:OWNER:创建者',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(4) DEFAULT '0' COMMENT '是否有效(虚拟删除)  0:ENABLE:有效  1:DISABLE:无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='门店成员（门店与企业成员关系）';

-- ----------------------------
--  Table structure for `tb_record`
-- ----------------------------
DROP TABLE IF EXISTS `tb_record`;
CREATE TABLE `tb_record` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `number` varchar(64) DEFAULT NULL COMMENT '编号',
  `entId` bigint(20) DEFAULT NULL COMMENT '企业Id',
  `storeId` bigint(20) DEFAULT NULL COMMENT '门店Id',
  `memId` bigint(20) DEFAULT NULL COMMENT '成员Id',
  `cusId` bigint(20) DEFAULT NULL COMMENT '顾客Id',
  `name` varchar(64) DEFAULT NULL COMMENT '服务名称',
  `price` varchar(32) DEFAULT NULL COMMENT '价格',
  `description` varchar(512) DEFAULT NULL COMMENT '描述',
  `utime` datetime DEFAULT '1970-01-01 08:00:00' COMMENT '修改时间',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(4) DEFAULT '0' COMMENT '是否有效(虚拟删除)  0:ENABLE:有效  1:DISABLE:无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='门店对客户的服务记录';

-- ----------------------------
--  Table structure for `tb_record_optometry`
-- ----------------------------
DROP TABLE IF EXISTS `tb_record_optometry`;
CREATE TABLE `tb_record_optometry` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `recordId` bigint(20) DEFAULT NULL COMMENT '服务记录Id',
  `sph` varchar(32) DEFAULT NULL COMMENT '球镜',
  `cyl` varchar(32) DEFAULT NULL COMMENT '柱镜',
  `prism` varchar(32) DEFAULT NULL COMMENT '棱镜',
  `bottom` varchar(32) DEFAULT NULL COMMENT '底',
  `axial` varchar(32) DEFAULT NULL COMMENT '轴位',
  `vision` varchar(32) DEFAULT NULL COMMENT '视力',
  `distance` varchar(32) DEFAULT NULL COMMENT '瞳距',
  `putLight` varchar(32) DEFAULT NULL COMMENT '加光',
  `type` tinyint(4) DEFAULT '0' COMMENT '类型  0:FAR:远用 1:NEAR近用',
  `eye` tinyint(4) DEFAULT '0' COMMENT ' 左右眼 0:LEFT:左眼 1:RIGTH:右眼',
  `utime` datetime DEFAULT '1970-01-01 08:00:00' COMMENT '修改时间',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(4) DEFAULT '0' COMMENT '是否有效(虚拟删除)  0:ENABLE:有效  1:DISABLE:无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务验光记录';

-- ----------------------------
--  Table structure for `tb_record_resource`
-- ----------------------------
DROP TABLE IF EXISTS `tb_record_resource`;
CREATE TABLE `tb_record_resource` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `recordId` bigint(20) DEFAULT NULL COMMENT '服务记录Id',
  `rid` bigint(20) DEFAULT NULL COMMENT '资源Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务与资源关系表';

-- ----------------------------
--  Table structure for `tb_region_area`
-- ----------------------------
DROP TABLE IF EXISTS `tb_region_area`;
CREATE TABLE `tb_region_area` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `cityCode` varchar(32) DEFAULT NULL COMMENT '市编码',
  `code` varchar(32) DEFAULT NULL COMMENT '区域编码',
  `name` varchar(64) DEFAULT NULL COMMENT '区域名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tb_region_city`
-- ----------------------------
DROP TABLE IF EXISTS `tb_region_city`;
CREATE TABLE `tb_region_city` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `provinceCode` varchar(32) DEFAULT NULL COMMENT '省编号',
  `code` varchar(32) DEFAULT NULL COMMENT '市编号',
  `name` varchar(64) DEFAULT NULL COMMENT '市名称',
  `initials` varchar(16) DEFAULT NULL COMMENT '拼音首字母',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政区域之市';

-- ----------------------------
--  Table structure for `tb_region_province`
-- ----------------------------
DROP TABLE IF EXISTS `tb_region_province`;
CREATE TABLE `tb_region_province` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `code` varchar(32) DEFAULT NULL COMMENT '编号',
  `name` varchar(64) DEFAULT NULL COMMENT '名称',
  `shorter` varchar(16) DEFAULT NULL COMMENT '简称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政区域之省';

-- ----------------------------
--  Table structure for `tb_sys_dic`
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_dic`;
CREATE TABLE `tb_sys_dic` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(128) DEFAULT NULL COMMENT '名称',
  `keyName` varchar(32) DEFAULT NULL COMMENT '英文名称key',
  `type` tinyint(4) DEFAULT '0' COMMENT '类型 0:默认(暂无其他分类)',
  `input` varchar(64) DEFAULT NULL COMMENT '数据类型',
  `defValue` varchar(64) DEFAULT NULL COMMENT '默认值',
  `fieldVals` varchar(128) DEFAULT NULL COMMENT '值域',
  `sorter` bigint(20) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统数据字典';

-- ----------------------------
--  Table structure for `tb_sys_resource`
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_resource`;
CREATE TABLE `tb_sys_resource` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `resourceType` tinyint(4) DEFAULT '0' COMMENT '资源类型 0:IMG:图片  1:AUDIO:音频  2:VIDEO:视频  3:FILE:文件',
  `name` varchar(64) DEFAULT NULL COMMENT '文件名称',
  `path` varchar(256) DEFAULT NULL COMMENT '文件路径',
  `url` varchar(256) DEFAULT NULL COMMENT '文件访问地址',
  `suffix` varchar(16) DEFAULT NULL COMMENT '文件后缀',
  `length` bigint(20) DEFAULT NULL COMMENT '文件大小',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(4) DEFAULT '0' COMMENT '是否有效(虚拟删除)  0:ENABLE:有效  1:DISABLE:无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统资源表';

-- ----------------------------
--  Table structure for `tb_user`
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `username` varchar(64) DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(128) DEFAULT NULL COMMENT '昵称',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(256) DEFAULT NULL COMMENT '头像',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `gender` tinyint(4) DEFAULT '0' COMMENT '性别 0 男 1 女  2 保密',
  `openid` varchar(64) DEFAULT NULL COMMENT '微信关注唯一表示',
  `description` varchar(512) DEFAULT NULL COMMENT '介绍',
  `token` varchar(64) DEFAULT NULL COMMENT '登录票据',
  `state` tinyint(4) DEFAULT '0' COMMENT '用户状态 0 正常 1 锁定',
  `source` tinyint(4) DEFAULT '0' COMMENT '用户来源 0 :注册 1:微信',
  `province` varchar(128) DEFAULT NULL COMMENT '所属省(code,name)',
  `city` varchar(128) DEFAULT NULL COMMENT '所属市(code,name)',
  `area` varchar(128) DEFAULT NULL COMMENT '所属区(code,name)',
  `street` varchar(312) DEFAULT NULL COMMENT '所在街道',
  `utime` datetime DEFAULT '1970-01-01 08:00:00' COMMENT '修改日期',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enable` tinyint(4) DEFAULT '0' COMMENT '是否有效(虚拟删除)  0:ENABLE:有效  1:DISABLE:无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

SET FOREIGN_KEY_CHECKS = 1;
