/*
Navicat MySQL Data Transfer

Source Server         : 本人ubuntu
Source Server Version : 50633
Source Host           : 101.201.67.210:3306
Source Database       : memberweb

Target Server Type    : MYSQL
Target Server Version : 50633
File Encoding         : 65001

Date: 2019-03-09 10:45:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `trya_admin`
-- ----------------------------
DROP TABLE IF EXISTS `trya_admin`;
CREATE TABLE `trya_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_code` varchar(10) NOT NULL DEFAULT '' COMMENT '用户编号',
  `user_name` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) NOT NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(100) NOT NULL DEFAULT '' COMMENT '头像',
  `login_failure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `token` varchar(59) NOT NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) NOT NULL DEFAULT 'normal' COMMENT '状态',
  `referee_achievement` decimal(20,4) DEFAULT '0.0000' COMMENT '总血缘业绩',
  `referee_user_code` varchar(20) DEFAULT NULL COMMENT '推荐人编号',
  `service_centre_code` varchar(10) DEFAULT NULL COMMENT '服务中心编号',
  `declaration_form_code` varchar(10) DEFAULT NULL COMMENT '报单人编号',
  `manage_achievement` decimal(20,4) DEFAULT '0.0000' COMMENT '总安置业绩',
  `manage_user_code` varchar(10) DEFAULT NULL COMMENT '安置人编号',
  `user_area` enum('A','B') DEFAULT NULL COMMENT '安置区域:A=A区,B=B区',
  `grade_code` varchar(11) DEFAULT NULL COMMENT '会员等级编号',
  `second_pass_word` varchar(50) NOT NULL COMMENT '二级密码',
  `second_salt` varchar(30) NOT NULL DEFAULT '' COMMENT '二级密码盐',
  `bank_code` int(11) DEFAULT NULL COMMENT '银行编号',
  `open_bank_name` varchar(100) DEFAULT NULL COMMENT '开户行名称',
  `bank_account` varchar(50) DEFAULT NULL COMMENT '银行账户',
  `id_card` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `phone_number` varchar(20) DEFAULT NULL COMMENT '电话号码',
  `register_money` decimal(20,4) DEFAULT '0.0000' COMMENT '注册金额',
  `receive_address` varchar(200) DEFAULT NULL COMMENT '收货地址',
  `mark` text COMMENT '备注',
  `delete_time` datetime(5) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`user_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员表';

-- ----------------------------
-- Records of trya_admin
-- ----------------------------
INSERT INTO `trya_admin` VALUES ('1', '1234567', '开发管理员', 'c8bd912b78b5aca03b13fad1ad75a0d3', 'hczM6H', '/assets/img/avatar.png', '0', '1528964280', '1524740059', '1524740059', 'db1ef40d-c980-41c1-bd42-86ae7faffbba', 'normal', '0.0000', '1000000', '1000000', '1000000', '0.0000', '1000000', 'A', 'lv4', '513b349472055e49e57dd6664ec38b15', 'C5JU7i', '123456', null, null, null, '12345678912', '0.0000', null, null, null);
INSERT INTO `trya_admin` VALUES ('2', '0000001', '公司管理员', 'c8bd912b78b5aca03b13fad1ad75a0d3', 'hczM6H', '/assets/img/avatar.png', '0', '1527258259', '1524740059', '1524740059', '83417b54-1bbb-4374-b3c3-0300fdf7fab8', 'normal', '0.0000', '1234567', '1234567', '1234567', '0.0000', '1234567', 'A', 'lv4', '513b349472055e49e57dd6664ec38b15', 'C5JU7i', '123456', null, null, null, '12345678912', '0.0000', null, null, null);
INSERT INTO `trya_admin` VALUES ('3', '0000002', '公司会计账户', 'c8bd912b78b5aca03b13fad1ad75a0d3', 'hczM6H', '/assets/img/avatar.png', '0', '0', '1524740059', '1524740059', '', 'normal', '0.0000', '1234567', '1234567', '1234567', '0.0000', '1234567', 'A', 'lv4', '513b349472055e49e57dd6664ec38b15', 'C5JU7i', '123456', null, null, null, '12345678912', '0.0000', null, null, null);
INSERT INTO `trya_admin` VALUES ('4', '0000003', '公司物流账户', 'c8bd912b78b5aca03b13fad1ad75a0d3', 'hczM6H', '/assets/img/avatar.png', '0', '0', '1524740059', '1524740059', '', 'normal', '0.0000', '1234567', '1234567', '1234567', '0.0000', '1234567', 'A', 'lv4', '513b349472055e49e57dd6664ec38b15', 'C5JU7i', '123456', null, null, null, '12345678912', '0.0000', null, null, null);

-- ----------------------------
-- Table structure for `trya_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `trya_admin_log`;
CREATE TABLE `trya_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `user_name` varchar(30) NOT NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1000) NOT NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `user_agent` varchar(255) NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员日志表';

-- ----------------------------
-- Records of trya_admin_log
-- ----------------------------
INSERT INTO `trya_admin_log` VALUES ('1', '2', '0000001', '/index/login', '登录', '{\"__token__\":\"42bfd93e15c999ca5126d8f5982a882a\",\"user_code\":\"0000001\"}', '117.136.2.154', 'Mozilla/5.0 (Linux; U; Android 6.0; zh-cn; PLK-TL01H Build/HONORPLK-TL01H) AppleWebKit/537.36 (KHTML, like Gecko)Version/4.0 Chrome/37.0.0.0 MQQBrowser/6.0 Mobile Safari/537.36', '1527258259');
INSERT INTO `trya_admin_log` VALUES ('2', '0', 'Unknown', '/index/login', '', '{\"__token__\":\"85ca2c428c24c92cc2a91ecf3ead847e\",\"user_code\":\"123456\"}', '222.222.191.100', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.79 Safari/537.36', '1528506076');
INSERT INTO `trya_admin_log` VALUES ('3', '1', '1234567', '/index/login', '登录', '{\"__token__\":\"8e7a1ffe6796cf69c9a6a7d12dab5c96\",\"user_code\":\"1234567\"}', '222.222.191.100', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.79 Safari/537.36', '1528506079');
INSERT INTO `trya_admin_log` VALUES ('4', '1', '1234567', '/finance/bonuscount/getParamsByType', '财务管理 奖金管理 查看 列表查看', '[]', '222.222.191.100', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.79 Safari/537.36', '1528506084');
INSERT INTO `trya_admin_log` VALUES ('5', '1', '1234567', '/index/login', '登录', '{\"__token__\":\"b4ffcf6b32de07d3c33303904317368a\",\"user_code\":\"1234567\"}', '222.222.191.100', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.79 Safari/537.36', '1528639202');
INSERT INTO `trya_admin_log` VALUES ('6', '1', '1234567', '/index/login', '登录', '{\"__token__\":\"81eb114cf0d019e0d06b2bf0b4ef43ed\",\"user_code\":\"1234567\"}', '222.222.191.99', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36', '1528964280');

-- ----------------------------
-- Table structure for `trya_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `trya_attachment`;
CREATE TABLE `trya_attachment` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '物理路径',
  `image_width` varchar(30) NOT NULL DEFAULT '' COMMENT '宽度',
  `image_height` varchar(30) NOT NULL DEFAULT '' COMMENT '高度',
  `image_type` varchar(30) NOT NULL DEFAULT '' COMMENT '图片类型',
  `image_frames` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `file_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `mime_type` varchar(100) NOT NULL DEFAULT '' COMMENT 'mime类型',
  `ext_param` varchar(255) NOT NULL DEFAULT '' COMMENT '透传数据',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建日期',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `upload_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `storage` enum('local','upyun','qiniu') NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='附件表';

-- ----------------------------
-- Records of trya_attachment
-- ----------------------------
INSERT INTO `trya_attachment` VALUES ('1', '/assets/img/qrcode.png', '150', '150', 'png', '0', '21859', 'image/png', '', '1499681848', '1499681848', '1499681848', 'local', '17163603d0263e4838b9387ff2cd4877e8b018f6');
INSERT INTO `trya_attachment` VALUES ('2', '/uploads/20180226/579252f71934ab3cb5f26019e3907441.jpg', '500', '500', 'jpg', '0', '12441', 'image/jpeg', '', '1519623521', '1519623521', '1519623521', 'local', '986592af0866b47803bd9324660fc9fd465de750');
INSERT INTO `trya_attachment` VALUES ('3', '/uploads/20180228/c75113ffa2015d1f4805dfb2894f27ba.jpg', '300', '200', 'jpg', '0', '22737', 'image/jpeg', '', '1519779721', '1519779721', '1519779721', 'local', '499354f4f741e9c8a3653f2453f640ac00027ad8');
INSERT INTO `trya_attachment` VALUES ('4', '/uploads/20180228/fc6f16fae003ea984d135155502a093b.jpg', '1200', '1200', 'jpg', '0', '107995', 'image/jpeg', '', '1519780812', '1519780812', '1519780812', 'local', 'db5ff25c314c76c45c07fefdc269288cb2d33996');
INSERT INTO `trya_attachment` VALUES ('5', '/uploads/20180228/fc6f16fae003ea984d135155502a093b.jpg', '1200', '1200', 'jpg', '0', '107995', 'image/jpeg', '', '1519780837', '1519780837', '1519780837', 'local', 'db5ff25c314c76c45c07fefdc269288cb2d33996');

-- ----------------------------
-- Table structure for `trya_auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `trya_auth_group`;
CREATE TABLE `trya_auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父组别',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text NOT NULL COMMENT '规则ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='分组表';

-- ----------------------------
-- Records of trya_auth_group
-- ----------------------------
INSERT INTO `trya_auth_group` VALUES ('1', '0', 'Admin group', '*', '1490883540', '149088354', 'normal');
INSERT INTO `trya_auth_group` VALUES ('2', '1', '管理员', '9,40,41,42,43,47,49,66,67,97,98,99,100,101,106,107,108,112,118,119,120,121,122,123,124,128,129,132,133,137,138,139,140,142,174,175,177,178,179,182,183,184,185,186,187,190,191,195,196,198,200,204,205,207,208,209,212,213,214,217,218,221,222,223,224,228,229,230,231,232,233,234,239,240,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,298,299,301,302,307,308,309,310,311,312,313,314,321,322,324,330,331,332,333,334,335,336,337,338,339,349,350,394,395,396,397,398,399,400,401,402,403,404,405,406,416,417,418,426,427,444,445,453,454,455,456,457,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,486,488,489,490,11,5', '1521948299', '1527164559', 'normal');
INSERT INTO `trya_auth_group` VALUES ('3', '2', '服务中心', '66,67,97,98,99,100,101,106,107,108,112,118,119,120,121,137,138,139,140,142,174,175,183,184,185,195,196,198,200,204,205,207,208,209,212,222,223,224,228,229,230,232,233,234,239,240,269,270,273,274,298,299,301,302,307,308,309,321,322,324,330,331,394,405,406,479,480,481,482,486,489,490', '1519652912', '1527164576', 'normal');
INSERT INTO `trya_auth_group` VALUES ('4', '3', '会员角色', '66,97,98,99,100,101,106,107,108,112,118,119,120,121,137,138,139,140,142,174,175,183,184,185,195,196,198,200,204,205,207,208,209,212,222,223,224,228,229,230,239,240,269,270,273,274,298,299,301,302,307,308,309,321,322,324,394,405,406,479,480,481,482,486,489,490', '1519736063', '1527164588', 'normal');
INSERT INTO `trya_auth_group` VALUES ('5', '2', '财务角色', '9,40,41,42,43,66,97,98,99,100,101,106,107,108,112,118,119,120,121,122,123,124,128,129,132,133,137,138,139,140,142,174,175,177,178,179,182,183,184,185,186,187,190,191,195,196,198,200,213,214,217,218,221,222,223,224,228,229,230,231,239,240,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,275,276,298,299,301,302,307,308,309,310,311,312,313,314,321,322,324,349,350,394,395,396,397,398,405,406,416,417,418,426,427,444,445,453,456,457,468,469,470,471,472,473,483,489,490', '1525054588', '1527164607', 'normal');
INSERT INTO `trya_auth_group` VALUES ('6', '2', '物流角色', '118,128,129,132,133,231,310,311,312,313,314', '1525245242', '1525245242', 'normal');

-- ----------------------------
-- Table structure for `trya_auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `trya_auth_group_access`;
CREATE TABLE `trya_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '会员ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '级别ID',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='权限分组表';

-- ----------------------------
-- Records of trya_auth_group_access
-- ----------------------------
INSERT INTO `trya_auth_group_access` VALUES ('1', '1', '1');
INSERT INTO `trya_auth_group_access` VALUES ('2', '2', '2');
INSERT INTO `trya_auth_group_access` VALUES ('3', '5', '3');
INSERT INTO `trya_auth_group_access` VALUES ('4', '6', '4');

-- ----------------------------
-- Table structure for `trya_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `trya_auth_rule`;
CREATE TABLE `trya_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) NOT NULL DEFAULT '' COMMENT '图标',
  `condition` varchar(255) NOT NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为菜单',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`),
  KEY `weigh` (`weigh`)
) ENGINE=InnoDB AUTO_INCREMENT=491 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='节点表';

-- ----------------------------
-- Records of trya_auth_rule
-- ----------------------------
INSERT INTO `trya_auth_rule` VALUES ('2', 'file', '0', 'general', 'General', 'fa fa-cogs', '', '', '1', '1497429920', '1497430169', '48', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('4', 'file', '0', 'addon', 'Addon', 'fa fa-rocket', '', 'Addon tips', '1', '1502035509', '1502035509', '46', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('5', 'file', '0', 'auth', 'Auth', 'fa fa-group', '', '', '1', '1497429920', '1497430092', '59', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('6', 'file', '2', 'general/config', 'Config', 'fa fa-cog', '', 'Config tips', '1', '1497429920', '1497430683', '112', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('7', 'file', '2', 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', 'Attachment tips', '1', '1497429920', '1497430699', '105', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('9', 'file', '66', 'auth/admin', '会员管理', 'fa fa-user', '', '', '1', '1497429920', '1525591670', '132', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('10', 'file', '5', 'auth/adminlog', 'Admin log', 'fa fa-list-alt', '', 'Admin log tips', '1', '1497429920', '1497430307', '127', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('11', 'file', '5', 'auth/group', 'Group', 'fa fa-group', '', 'Group tips', '1', '1497429920', '1497429920', '123', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('12', 'file', '5', 'auth/rule', 'Rule', 'fa fa-bars', '', 'Rule tips', '1', '1497429920', '1497430581', '118', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('18', 'file', '6', 'general/config/index', 'View', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '104', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('19', 'file', '6', 'general/config/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '103', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('20', 'file', '6', 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '102', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('21', 'file', '6', 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '101', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('22', 'file', '6', 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '100', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('23', 'file', '7', 'general/attachment/index', 'View', 'fa fa-circle-o', '', 'Attachment tips', '0', '1497429920', '1497429920', '111', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('24', 'file', '7', 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '110', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('25', 'file', '7', 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '109', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('26', 'file', '7', 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '108', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('27', 'file', '7', 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '107', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('28', 'file', '7', 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '106', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('40', 'file', '9', 'auth/admin/index', 'View', 'fa fa-circle-o', '', 'Admin tips', '0', '1497429920', '1497429920', '131', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('41', 'file', '9', 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '130', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('42', 'file', '9', 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '129', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('43', 'file', '9', 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '128', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('44', 'file', '10', 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', 'Admin log tips', '0', '1497429920', '1497429920', '126', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('45', 'file', '10', 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '125', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('46', 'file', '10', 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '124', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('47', 'file', '11', 'auth/group/index', 'View', 'fa fa-circle-o', '', 'Group tips', '0', '1497429920', '1497429920', '122', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('48', 'file', '11', 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '121', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('49', 'file', '11', 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '120', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('50', 'file', '11', 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '119', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('51', 'file', '12', 'auth/rule/index', 'View', 'fa fa-circle-o', '', 'Rule tips', '0', '1497429920', '1497429920', '117', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('52', 'file', '12', 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '116', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('53', 'file', '12', 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '115', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('54', 'file', '12', 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '114', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('55', 'file', '4', 'addon/index', 'View', 'fa fa-circle-o', '', 'Addon tips', '0', '1502035509', '1502035509', '35', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('56', 'file', '4', 'addon/add', 'Add', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '36', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('57', 'file', '4', 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '37', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('58', 'file', '4', 'addon/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '38', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('59', 'file', '4', 'addon/local', 'Local install', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '39', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('60', 'file', '4', 'addon/state', 'Update state', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '40', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('61', 'file', '4', 'addon/install', 'Install', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '41', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('62', 'file', '4', 'addon/uninstall', 'Uninstall', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '42', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('63', 'file', '4', 'addon/config', 'Setting', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '43', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('64', 'file', '4', 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '44', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('65', 'file', '4', 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '45', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('66', 'file', '0', 'user', '会员管理', 'fa fa-address-book', '', '', '1', '1517475546', '1525491015', '120', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('67', 'file', '66', 'user/register/index', '会员注册', 'fa fa-address-card-o', '', '', '1', '1517475632', '1519703612', '47', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('97', 'file', '0', 'messageleave', '信息管理', 'fa fa-comments', '', '', '1', '1517624712', '1525491092', '100', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('98', 'file', '97', 'messageleave/outbox', '发件箱', 'fa fa-upload', '', '', '1', '1517624712', '1517924159', '49', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('99', 'file', '98', 'messageleave/outbox/index', '查看', 'fa fa-circle-o', '', '', '0', '1517624713', '1517624713', '50', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('100', 'file', '98', 'messageleave/outbox/add', '添加', 'fa fa-circle-o', '', '', '0', '1517624713', '1517624713', '51', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('101', 'file', '98', 'messageleave/outbox/del', '删除', 'fa fa-circle-o', '', '', '0', '1517624713', '1517624713', '52', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('106', 'file', '98', 'messageleave/outbox/multi', '批量更新', 'fa fa-circle-o', '', '', '0', '1517624713', '1517624713', '53', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('107', 'file', '97', 'messageleave/inbox', '收件箱', 'fa fa-envelope-square', '', '', '1', '1517624723', '1517924576', '54', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('108', 'file', '107', 'messageleave/inbox/index', '查看', 'fa fa-circle-o', '', '', '0', '1517624724', '1517624724', '55', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('112', 'file', '107', 'messageleave/inbox/del', '删除', 'fa fa-circle-o', '', '', '0', '1517624724', '1517624724', '56', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('118', 'file', '0', 'product', '产品管理', 'fa fa-cubes', '', '', '1', '1517820456', '1525491052', '110', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('119', 'file', '118', 'product/productinfo', '产品列表', 'fa fa-cube', '', '', '1', '1517820456', '1525078645', '60', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('120', 'file', '119', 'product/productinfo/index', '查看', 'fa fa-circle-o', '', '', '0', '1517820457', '1517831593', '61', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('121', 'file', '119', 'product/productinfo/detail', '详情', 'fa fa-circle-o', '', '', '0', '1517894297', '1517894297', '62', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('122', 'file', '119', 'product/productinfo/add', '添加', 'fa fa-circle-o', '', '', '0', '1517820457', '1517820457', '63', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('123', 'file', '119', 'product/productinfo/edit', '编辑', 'fa fa-circle-o', '', '', '0', '1517820457', '1517820457', '64', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('124', 'file', '119', 'product/productinfo/del', '删除', 'fa fa-circle-o', '', '', '0', '1517820458', '1517820458', '65', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('128', 'file', '118', 'product/orderform', '会员提货管理', 'fa fa-shekel', '', '', '1', '1517894296', '1525078883', '66', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('129', 'file', '128', 'product/orderform/index', '查看', 'fa fa-circle-o', '', '', '0', '1517894297', '1517894297', '68', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('132', 'file', '128', 'product/orderform/deal', '处理', 'fa fa-circle-o', '', '', '0', '1517894298', '1519740431', '67', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('133', 'file', '128', 'product/orderform/del', '删除', 'fa fa-circle-o', '', '', '0', '1517894298', '1517894298', '69', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('137', 'file', '118', 'product/personorderform', '会员提货', 'fa fa-sheqel', '', '', '1', '1517895777', '1525078837', '70', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('138', 'file', '137', 'product/personorderform/index', '查看', 'fa fa-circle-o', '', '', '0', '1517894297', '1517894297', '71', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('139', 'file', '137', 'product/personorderform/detail', '详情', 'fa fa-circle-o', '', '', '0', '1517894297', '1517894297', '72', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('140', 'file', '137', 'product/personorderform/add', '添加', 'fa fa-circle-o', '', '', '0', '1517894297', '1517894297', '73', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('142', 'file', '137', 'product/personorderform/del', '删除', 'fa fa-circle-o', '', '', '0', '1517894298', '1517894298', '74', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('174', 'file', '97', 'messageleave/notice', '通知管理', 'fa fa-bell', '', '', '1', '1518344412', '1518344519', '85', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('175', 'file', '174', 'messageleave/notice/index', '查看', 'fa fa-circle-o', '', '', '0', '1518344413', '1518344413', '86', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('177', 'file', '174', 'messageleave/notice/add', '添加', 'fa fa-circle-o', '', '', '0', '1518344413', '1518344413', '87', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('178', 'file', '174', 'messageleave/notice/edit', '编辑', 'fa fa-circle-o', '', '', '0', '1518344413', '1518344413', '88', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('179', 'file', '174', 'messageleave/notice/del', '删除', 'fa fa-circle-o', '', '', '0', '1518344413', '1518344413', '89', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('182', 'file', '174', 'messageleave/notice/multi', '批量更新', 'fa fa-circle-o', '', '', '0', '1518344413', '1518344413', '90', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('183', 'file', '0', 'personal', '个人事务', 'fa fa-male', '', '', '1', '1518351210', '1518351210', '141', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('184', 'file', '183', 'personal/home/index', '我的首页', 'fa fa-map', '', '', '1', '1518351637', '1519704365', '92', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('185', 'file', '0', 'finance', '财务管理', 'fa fa-dollar', '', '', '1', '1519265280', '1519265432', '134', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('186', 'file', '185', 'finance/rechargemanage', '充值申请管理', 'fa fa-battery', '', '', '1', '1519265280', '1519265809', '140', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('187', 'file', '186', 'finance/rechargemanage/index', '查看', 'fa fa-circle-o', '', '', '0', '1519265280', '1519265280', '139', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('190', 'file', '186', 'finance/rechargemanage/edit', '编辑', 'fa fa-circle-o', '', '', '0', '1519265281', '1519265281', '138', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('191', 'file', '186', 'finance/rechargemanage/del', '删除', 'fa fa-circle-o', '', '', '0', '1519265281', '1519265281', '137', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('195', 'file', '185', 'finance/rechargeapplication', '充值', 'fa fa-battery-0', '', '', '1', '1519265866', '1525854282', '160', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('196', 'file', '195', 'finance/rechargeapplication/index', '查看', 'fa fa-battery-0', '', '', '0', '1519265280', '1519265280', '149', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('198', 'file', '195', 'finance/rechargeapplication/details', '详情', 'fa fa-battery-0', '', '', '0', '1519265281', '1521966782', '147', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('200', 'file', '195', 'finance/rechargeapplication/del', '删除', 'fa fa-battery-0', '', '', '0', '1519265281', '1519265281', '145', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('204', 'file', '185', 'finance/cashapplication', '提现', 'fa fa-yen', '', '', '1', '1519312716', '1525854528', '150', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('205', 'file', '204', 'finance/cashapplication/index', '查看', 'fa fa-circle-o', '', '', '0', '1519312717', '1519312717', '2', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('207', 'file', '204', 'finance/cashapplication/add', '添加', 'fa fa-circle-o', '', '', '0', '1519312717', '1519312717', '4', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('208', 'file', '204', 'finance/cashapplication/details', '详情', 'fa fa-circle-o', '', '', '0', '1519312717', '1521969865', '5', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('209', 'file', '204', 'finance/cashapplication/del', '删除', 'fa fa-circle-o', '', '', '0', '1519312717', '1519312717', '6', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('212', 'file', '204', 'finance/cashapplication/multi', '批量更新', 'fa fa-circle-o', '', '', '0', '1519312717', '1519312717', '9', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('213', 'file', '185', 'finance/cashapplicationmanage', '会员提现申请管理', 'fa fa-circle-o', '', '', '1', '1519312741', '1525854327', '120', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('214', 'file', '213', 'finance/cashapplicationmanage/index', '查看', 'fa fa-circle-o', '', '', '0', '1519312742', '1519312742', '11', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('217', 'file', '213', 'finance/cashapplicationmanage/edit', '编辑', 'fa fa-circle-o', '', '', '0', '1519312743', '1519312743', '14', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('218', 'file', '213', 'finance/cashapplicationmanage/del', '删除', 'fa fa-circle-o', '', '', '0', '1519312743', '1519312743', '15', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('221', 'file', '213', 'finance/cashapplicationmanage/multi', '批量更新', 'fa fa-circle-o', '', '', '0', '1519312743', '1519312743', '18', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('222', 'file', '183', 'personal/infoedit/index', '个人信息查看', 'fa fa-street-view', '', '', '1', '1519483210', '1525053504', '18', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('223', 'file', '183', 'personal/passwordedit/index', '密码修改', 'fa fa-mars', '', '', '1', '1519625346', '1519703542', '20', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('224', 'file', '183', 'personal/secondpasswordedit/index', '二级密码修改', 'fa fa-mars-double', '', '', '1', '1519625397', '1520170920', '19', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('228', 'file', '140', 'product/personorderform/getrealpricebyid', '获取产品价格', 'fa fa-dot', '', '', '0', '1519779291', '1519779291', '24', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('229', 'file', '140', 'product/personorderform/getinventorybyid', '获取产品库存', 'fa fa-dot', '', '', '0', '1519779361', '1519779361', '25', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('230', 'file', '140', 'product/personorderform/getremainingsumbyid', '获取会员余额', 'fa fa-dot', '', '', '0', '1519779517', '1519779517', '26', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('231', 'file', '132', 'product/orderform/orderstate', '设置订单状态', 'fa fa-dot', '', '', '0', '1519779619', '1519779619', '27', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('232', 'file', '67', 'user/register/getrandomcode', '获取随机编号', 'fa fa-dot', '', '', '0', '1519781019', '1519781019', '28', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('233', 'file', '67', 'user/register/isexistcode', '验证编号', 'fa fa-dot', '', '', '0', '1519781064', '1519781064', '29', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('234', 'file', '67', 'user/register/getusernamebycode', '获取用户名', 'fa fa-dot', '', '', '0', '1519781106', '1519781106', '30', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('239', 'file', '185', 'finance/mywallet', '我的钱包', 'fa fa-archive', '', '', '1', '1520735039', '1525854210', '190', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('240', 'file', '174', 'messageleave/notice/details', '详情', 'fa fa-dot', '', '', '0', '1520910267', '1521858105', '85', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('250', 'file', '185', 'finance/parameter', '参数管理', 'fa fa-cog', '', '', '1', '1521166543', '1521620187', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('251', 'file', '250', 'finance/parameter/index', '查看', 'fa fa-circle-o', '', '', '0', '1521166544', '1521166544', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('252', 'file', '250', 'finance/parameter/recyclebin', '回收站', 'fa fa-circle-o', '', '', '0', '1521166544', '1521166544', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('253', 'file', '250', 'finance/parameter/add', '添加', 'fa fa-circle-o', '', '', '0', '1521166544', '1521166544', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('254', 'file', '250', 'finance/parameter/edit', '编辑', 'fa fa-circle-o', '', '', '0', '1521166544', '1521166544', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('255', 'file', '250', 'finance/parameter/del', '删除', 'fa fa-circle-o', '', '', '0', '1521166544', '1521166544', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('256', 'file', '250', 'finance/parameter/destroy', '真实删除', 'fa fa-circle-o', '', '', '0', '1521166544', '1521166544', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('257', 'file', '250', 'finance/parameter/restore', '还原', 'fa fa-circle-o', '', '', '0', '1521166544', '1521166544', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('258', 'file', '250', 'finance/parameter/multi', '批量更新', 'fa fa-circle-o', '', '', '0', '1521166544', '1521166544', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('259', 'file', '185', 'finance/bonuscount', '奖金管理', 'fa fa-balance-scale', '', '', '1', '1521290071', '1525854389', '90', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('260', 'file', '185', 'finance/companyaccount', '公司财务表', 'fa fa-align-justify', '', '', '1', '1521891183', '1525943660', '110', 'hidden');
INSERT INTO `trya_auth_rule` VALUES ('261', 'file', '260', 'finance/transactionalflow/index', '流水列表', 'fa fa-dot', '', '', '0', '1521895679', '1521895734', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('262', 'file', '260', 'finance/transactionalflow/details', '流水详情', 'fa fa-dot', '', '', '0', '1521895929', '1521895929', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('263', 'file', '259', 'finance/bonuscount/index', '查看', 'fa fa-dot', '', '', '0', '1521948568', '1521948568', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('264', 'file', '259', 'finance/bonuscount/edit', '奖金调整', 'fa fa-dot', '', '', '0', '1521948621', '1521948621', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('265', 'file', '259', 'finance/bonuscount/calculate', '奖金核算', 'fa fa-dot', '', '', '0', '1521948654', '1521948654', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('266', 'file', '259', 'finance/bonuscount/giveout', '奖金发放', 'fa fa-dot', '', '', '0', '1521948716', '1521948716', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('267', 'file', '263', 'finance/bonuscount/getparamsbytype', '列表查看', 'fa fa-dot', '', '', '0', '1521948787', '1521948787', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('268', 'file', '260', 'finance/companyaccount/index', '查看', 'fa fa-dot', '', '', '0', '1521950440', '1521950451', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('269', 'file', '239', 'finance/mywallet/index', '查看', 'fa fa-dot', '', '', '0', '1521955504', '1521955504', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('270', 'file', '239', 'finance/mywallet/detail', '详情', 'fa fa-dot', '', '', '0', '1521955561', '1521955815', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('271', 'file', '190', 'finance/rechargemanage/recharge', '充值确认', 'fa fa-dot', '', '', '0', '1521966661', '1521966797', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('272', 'file', '190', 'finance/rechargemanage/rechargecancel', '拒绝充值', 'fa fa-dot', '', '', '0', '1521966700', '1521966807', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('273', 'file', '195', 'finance/rechargeapplication/add', '添加', 'fa fa-dot', '', '', '0', '1521967121', '1521967167', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('274', 'file', '207', 'finance/cashapplication/getrateaandbalance', '更新信息', 'fa fa-dot', '', '', '0', '1521967397', '1521967397', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('275', 'file', '217', 'finance/cashapplicationmanage/applicationcompletion', '确认充值', 'fa fa-dot', '', '', '0', '1521971464', '1521971464', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('276', 'file', '259', 'finance/bonuscount/calsuggest', '生成建议奖金发放结果', 'fa fa-dot', '', '', '0', '1521981189', '1524750767', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('298', 'file', '118', 'product/personregisterform', '注册提货', 'fa fa-sheqel', '', '', '1', '1523010067', '1525065913', '130', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('299', 'file', '298', 'product/personregisterform/index', '查看', 'fa fa-circle-o', '', '', '0', '1523010139', '1523010139', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('301', 'file', '298', 'product/personregisterform/add', '添加', 'fa fa-circle-o', '', '', '0', '1523010139', '1523010139', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('302', 'file', '298', 'product/personregisterform/edit', '编辑', 'fa fa-circle-o', '', '', '0', '1523010139', '1523010139', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('307', 'file', '301', 'product/personregisterform/getremainingsumby', '获取会员余额', 'fa fa-dot', '', '', '0', '1523010681', '1523010811', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('308', 'file', '301', 'product/personregisterform/getinventorybyid', '获取产品库存', 'fa fa-dot', '', '', '0', '1523010754', '1523010754', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('309', 'file', '301', 'product/personregisterform/getrealpricebyid', '获取产品价格', 'fa fa-dot', '', '', '0', '1523010886', '1526612996', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('310', 'file', '118', 'product/registerform', '注册提货管理', 'fa fa-sheqel', '', '', '1', '1523011038', '1525078861', '68', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('311', 'file', '310', 'product/registerform/index', '查看', 'fa fa-circle-o', '', '', '0', '1523011039', '1523011039', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('312', 'file', '310', 'product/registerform/deal', '处理', 'fa fa-circle-o', '', '', '0', '1523011039', '1523011237', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('313', 'file', '310', 'product/registerform/del', '删除', 'fa fa-circle-o', '', '', '0', '1523011039', '1523011039', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('314', 'file', '312', 'product/registerform/orderstate', '设置订单状态', 'fa fa-circle-o', '', '', '0', '1523011039', '1523011213', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('321', 'file', '185', 'finance/membertransaction', '转账', 'fa fa-address-book', '', '', '1', '1523083241', '1525854246', '170', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('322', 'file', '321', 'finance/membertransaction/index', '查看', 'fa fa-circle-o', '', '', '0', '1523083242', '1523083242', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('324', 'file', '321', 'finance/membertransaction/getusernamebycode', '验证', 'fa fa-circle-o', '', '', '0', '1523083242', '1524736618', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('330', 'file', '67', 'user/register/checkrefereeusercode', '推荐人验证', 'fa fa-dot', '', '', '0', '1523950529', '1523950529', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('331', 'file', '67', 'user/register/checkmanageusercode', '安置人验证', 'fa fa-dot', '', '', '0', '1523950623', '1523950623', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('332', 'file', '66', 'user/virtualsingle', '虚单', 'fa fa-address-card-o', '', '', '1', '1523950793', '1523950793', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('333', 'file', '332', 'user/virtualsingle/index', '查看', 'fa fa-dot', '', '', '0', '1523950828', '1523950828', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('334', 'file', '332', 'user/virtualsingle/getrandomcode', '获取随机编号', 'fa fa-dot', '', '', '0', '1523950916', '1523950916', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('335', 'file', '332', 'user/virtualsingle/isexistcode', '验证用户是否存在', 'fa fa-dot', '', '', '0', '1523950990', '1523950990', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('336', 'file', '332', 'user/virtualsingle/getusernamebycode', '获取用户名', 'fa fa-dot', '', '', '0', '1523951057', '1523951057', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('337', 'file', '332', 'user/virtualsingle/checkrefereeusercode', '推荐人验证', 'fa fa-dot', '', '', '0', '1523951159', '1523951159', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('338', 'file', '332', 'user/virtualsingle/checkmanageusercode', '安置人验证', 'fa fa-dot', '', '', '0', '1523951209', '1523951209', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('339', 'file', '66', 'user/insertpoint/index', '插入点', 'fa fa-angle-double-right', '', '', '1', '1523953460', '1524749868', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('349', 'file', '185', 'finance/historypersonalaccountflow', '会员账户流水', 'fa fa-circle-o', '', '', '1', '1524232820', '1525854428', '95', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('350', 'file', '349', 'finance/historypersonalaccountflow/index', '查看', 'fa fa-circle-o', '', '', '0', '1524232821', '1524232821', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('394', 'file', '321', 'finance/membertransaction/transaction', '转账计算', 'fa fa-dot', '', '', '0', '1524736667', '1524736667', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('395', 'file', '9', 'auth/admin/passwordreset', '密码重置', 'fa fa-dot', '', '', '0', '1524736797', '1524736797', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('396', 'file', '9', 'auth/admin/selectuser', '查找用户', 'fa fa-dot', '', '', '0', '1524736882', '1524736882', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('397', 'file', '9', 'auth/admin/confirmchange', '修改会员币', 'fa fa-dot', '', '', '0', '1524736975', '1524736975', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('398', 'file', '9', 'auth/admin/upgrade', '会员升级', 'fa fa-dot', '', '', '0', '1524737017', '1525940737', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('399', 'file', '339', 'user/insertpoint/findmanagecodearea', '查找安置区域', 'fa fa-dot', '', '', '0', '1524739595', '1524739595', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('400', 'file', '339', 'user/insertpoint/getrandomcode', '获得随机编号', 'fa fa-dot', '', '', '0', '1524739655', '1524739655', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('401', 'file', '339', 'user/insertpoint/isexistcode', '验证编号', 'fa fa-dot', '', '', '0', '1524739695', '1524739695', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('402', 'file', '339', 'user/insertpoint/getusernamebycode', '验证用户', 'fa fa-dot', '', '', '0', '1524739764', '1524739764', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('403', 'file', '339', 'user/insertpoint/checkrefereeusercode', '推荐人验证', 'fa fa-dot', '', '', '0', '1524739846', '1524740178', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('404', 'file', '339', 'user/insertpoint/checkmanageusercode', '安置人验证', 'fa fa-dot', '', '', '0', '1524739901', '1524739901', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('405', 'file', '298', 'product/personregisterform/detail', '详情', 'fa fa-dot', '', '', '0', '1525066002', '1525066002', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('406', 'file', '239', 'common/secondlogin/checkpassword', '二级密码验证', 'fa fa-dot', '', '', '0', '1525142445', '1525142445', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('416', 'file', '185', 'finance/xiaoquperformance/index', '小区业绩', 'fa fa-bank', '', '', '1', '1525166900', '1525245195', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('417', 'file', '185', 'finance/memberaccount', '会员账户表', 'fa fa-users', '', '', '1', '1525167806', '1525854375', '100', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('418', 'file', '417', 'finance/memberaccount/index', '查看', 'fa fa-circle-o', '', '', '0', '1525167807', '1525167807', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('426', 'file', '66', 'user/manage', '会员安置图（公司）', 'fa fa-sort-alpha-asc', '', '', '1', '1525487183', '1526545089', '55', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('427', 'file', '426', 'user/manage/index', '查看', 'fa fa-circle-o', '', '', '0', '1525487184', '1525947436', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('444', 'file', '66', 'user/referee', '血缘关系图（公司）', 'fa fa-sort-amount-asc', '', '', '1', '1525487938', '1526545060', '56', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('445', 'file', '444', 'user/referee/index', '查看', 'fa fa-circle-o', '', '', '0', '1525487939', '1525947335', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('453', 'file', '183', 'personal/home/finance_message', '财务通知', 'fa fa-dot', '', '', '0', '1525782336', '1526544241', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('454', 'file', '66', 'user/relationshipchange', '关系更改', 'fa fa-delicious', '', '', '1', '1525782464', '1525788392', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('455', 'file', '454', 'user/relationshipchange/index', '查看', 'fa fa-dot', '', '', '0', '1525782500', '1525782500', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('456', 'file', '185', 'finance/historybonus', '奖金历史', 'fa fa-hand-paper-o', '', '', '1', '1525784286', '1525854405', '80', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('457', 'file', '456', 'finance/historybonus/index', '查看', 'fa fa-circle-o', '', '', '0', '1525784287', '1525784287', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('468', 'file', '185', 'finance/refereeperformance', '血缘业绩', 'fa fa-sort-numeric-asc', '', '', '1', '1525941601', '1525941601', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('469', 'file', '468', 'finance/refereeperformance/index', '查看', 'fa fa-dot', '', '', '0', '1525941639', '1525941639', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('470', 'file', '185', 'finance/zhituiperformance', '直推业绩', 'fa fa-sort-amount-asc', '', '', '1', '1525941742', '1525941742', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('471', 'file', '470', 'finance/zhituiperformance/index', '查看', 'fa fa-dot', '', '', '0', '1525941790', '1525941790', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('472', 'file', '185', 'finance/manageperformance', '总业绩', 'fa fa-tasks', '', '', '1', '1525941873', '1525941873', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('473', 'file', '472', 'finance/manageperformance/index', '查看', 'fa fa-dot', '', '', '0', '1525941928', '1525941928', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('474', 'file', '454', 'user/relationshipchange/getuserinfobycode', '取会员信息', 'fa fa-dot', '', '', '0', '1525949742', '1525949742', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('475', 'file', '454', 'user/relationshipchange/getusernamebycode', '获取会员名', 'fa fa-dot', '', '', '0', '1525949797', '1525949797', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('476', 'file', '454', 'user/relationshipchange/checkmanageusercode', '验证安置人', 'fa fa-dot', '', '', '0', '1525949862', '1525949862', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('477', 'file', '454', 'user/relationshipchange/changerefereecode', '修改推荐人编号', 'fa fa-dot', '', '', '0', '1525949903', '1525949903', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('478', 'file', '454', 'user/relationshipchange/changemanagecode', '修改安置人编号', 'fa fa-dot', '', '', '0', '1525949937', '1525949937', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('479', 'file', '66', 'user/userreferee', '血缘关系图', 'fa fa-sort-amount-asc', '', '', '1', '1526545159', '1526603669', '56', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('480', 'file', '479', 'user/userreferee/index', '查看', 'fa fa-dot', '', '', '0', '1526545212', '1526545212', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('481', 'file', '66', 'user/usermanage', '会员安置图', 'fa fa-sort-alpha-asc', '', '', '1', '1526545270', '1526603693', '55', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('482', 'file', '481', 'user/usermanage/index', '查看', 'fa fa-dot', '', '', '0', '1526545308', '1526545308', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('483', 'file', '259', 'finance/bonuscount/countaftertime', '获取该计算时间后的报单数量', 'fa fa-dot', '', '', '0', '1526903294', '1526994990', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('486', 'file', '183', 'personal/personalupgrade/index', '原点升级', 'fa fa-arrow-up', '', '', '1', '1527031743', '1527031743', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('488', 'file', '183', 'personal/managepasswordedit/index', '管理密码修改', 'fa fa-envira', '', '', '1', '1527153256', '1527153256', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('489', 'file', '107', 'messageleave/inbox/details', '详情', 'fa fa-dot', '', '', '0', '1527164483', '1527164483', '0', 'normal');
INSERT INTO `trya_auth_rule` VALUES ('490', 'file', '98', 'messageleave/outbox/details', '详情', 'fa fa-dot', '', '', '0', '1527164538', '1527164538', '0', 'normal');

-- ----------------------------
-- Table structure for `trya_config`
-- ----------------------------
DROP TABLE IF EXISTS `trya_config`;
CREATE TABLE `trya_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) NOT NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) NOT NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` text NOT NULL COMMENT '变量值',
  `content` text NOT NULL COMMENT '变量字典数据',
  `rule` varchar(100) NOT NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) NOT NULL DEFAULT '' COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='系统配置';

-- ----------------------------
-- Records of trya_config
-- ----------------------------
INSERT INTO `trya_config` VALUES ('1', 'name', 'basic', 'Site name', '请填写站点名称', 'string', '天润怡安', '', 'required', '');
INSERT INTO `trya_config` VALUES ('2', 'beian', 'basic', 'Beian', '粤ICP备15054802号-4', 'string', '', '', '', '');
INSERT INTO `trya_config` VALUES ('3', 'cdnurl', 'basic', 'Cdn url', '如果静态资源使用第三方云储存请配置该值', 'string', '', '', '', '');
INSERT INTO `trya_config` VALUES ('4', 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '1.0.1', '', 'required', '');
INSERT INTO `trya_config` VALUES ('5', 'timezone', 'basic', 'Timezone', '', 'string', 'Asia/Shanghai', '', 'required', '');
INSERT INTO `trya_config` VALUES ('6', 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', '');
INSERT INTO `trya_config` VALUES ('7', 'languages', 'basic', 'Languages', '', 'array', '{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}', '', 'required', '');
INSERT INTO `trya_config` VALUES ('8', 'fixedpage', 'basic', 'Fixed page', '请尽量输入左侧菜单栏存在的链接', 'string', 'personal/home/index', '', 'required', '');
INSERT INTO `trya_config` VALUES ('9', 'categorytype', 'dictionary', 'Category type', '', 'array', '{\"default\":\"Default\",\"page\":\"Page\",\"article\":\"Article\",\"test\":\"Test\"}', '', '', '');
INSERT INTO `trya_config` VALUES ('10', 'configgroup', 'dictionary', 'Config group', '', 'array', '{\"basic\":\"Basic\",\"email\":\"Email\",\"dictionary\":\"Dictionary\",\"user\":\"User\",\"example\":\"Example\"}', '', '', '');
INSERT INTO `trya_config` VALUES ('11', 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '1', '[\"Please select\",\"SMTP\",\"Mail\"]', '', '');
INSERT INTO `trya_config` VALUES ('12', 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', 'smtp.qq.com', '', '', '');
INSERT INTO `trya_config` VALUES ('13', 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '465', '', '', '');
INSERT INTO `trya_config` VALUES ('14', 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '10000', '', '', '');
INSERT INTO `trya_config` VALUES ('15', 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码）', 'string', 'password', '', '', '');
INSERT INTO `trya_config` VALUES ('16', 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '2', '[\"None\",\"TLS\",\"SSL\"]', '', '');
INSERT INTO `trya_config` VALUES ('17', 'mail_from', 'email', 'Mail from', '', 'string', '10000@qq.com', '', '', '');
INSERT INTO `trya_config` VALUES ('18', 'manage_password', 'password', 'password', '奖金发放管理密码', 'string', 'df10ef8509dc176d733d59549e7dbfaf', ' ', '', '');

-- ----------------------------
-- Table structure for `trya_config_bank`
-- ----------------------------
DROP TABLE IF EXISTS `trya_config_bank`;
CREATE TABLE `trya_config_bank` (
  `bank_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bank_name` varchar(50) NOT NULL COMMENT '银行名称',
  `bank_code` int(11) NOT NULL COMMENT '银行编号',
  `mark` text COMMENT '备注',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`bank_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of trya_config_bank
-- ----------------------------
INSERT INTO `trya_config_bank` VALUES ('1', '中国银行', '1', null, null);
INSERT INTO `trya_config_bank` VALUES ('2', '中国工商银行', '2', null, null);
INSERT INTO `trya_config_bank` VALUES ('3', '中国建设银行', '3', null, null);
INSERT INTO `trya_config_bank` VALUES ('4', '中国农业银行', '4', null, null);

-- ----------------------------
-- Table structure for `trya_config_grade`
-- ----------------------------
DROP TABLE IF EXISTS `trya_config_grade`;
CREATE TABLE `trya_config_grade` (
  `grade_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `grade_code` varchar(11) NOT NULL COMMENT '会员等级编号',
  `grade_name` varchar(20) NOT NULL COMMENT '会员等级名称',
  `mark` text COMMENT '备注',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`grade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员等级表';

-- ----------------------------
-- Records of trya_config_grade
-- ----------------------------
INSERT INTO `trya_config_grade` VALUES ('1', 'lv4', '服务中心', 'lv4', null);
INSERT INTO `trya_config_grade` VALUES ('2', 'lv1', '银卡', 'lv1', null);
INSERT INTO `trya_config_grade` VALUES ('3', 'lv2', '金卡', 'lv2', null);
INSERT INTO `trya_config_grade` VALUES ('4', 'lv3', '钻石卡', 'lv3', null);

-- ----------------------------
-- Table structure for `trya_config_system_time`
-- ----------------------------
DROP TABLE IF EXISTS `trya_config_system_time`;
CREATE TABLE `trya_config_system_time` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(20) NOT NULL COMMENT '时间类型，tjj:推荐奖、xsj:销售奖、glj:管理奖、cxj:重消奖',
  `system_time` datetime NOT NULL COMMENT '系统时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `mark` text COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='系统时间表';

-- ----------------------------
-- Records of trya_config_system_time
-- ----------------------------
INSERT INTO `trya_config_system_time` VALUES ('1', 'tjj_out', '2018-05-24 18:00:23', '2018-03-17 10:20:34', '推荐奖发放时间');
INSERT INTO `trya_config_system_time` VALUES ('2', 'xsj_out', '2018-05-24 18:00:23', '2018-03-17 10:20:34', '销售奖发放时间');
INSERT INTO `trya_config_system_time` VALUES ('3', 'glj_out', '2018-05-24 18:00:23', '2018-03-17 10:20:34', '管理奖发放时间');
INSERT INTO `trya_config_system_time` VALUES ('4', 'cxj_out', '2018-05-24 18:00:23', '2018-03-17 10:20:34', '重消奖发放时间');
INSERT INTO `trya_config_system_time` VALUES ('5', 'tjj_cal', '2018-05-24 17:48:00', '2018-03-19 22:03:26', '推荐奖计算时间');
INSERT INTO `trya_config_system_time` VALUES ('6', 'xsj_cal', '2018-05-24 17:48:00', '2018-03-19 22:03:59', '销售奖计算时间');
INSERT INTO `trya_config_system_time` VALUES ('7', 'glj_cal', '2018-05-24 17:48:00', '2018-03-19 22:04:30', '管理奖计算时间');
INSERT INTO `trya_config_system_time` VALUES ('8', 'cxj_cal', '2018-05-24 17:48:00', '2018-03-19 22:04:52', '重消奖计算时间');
INSERT INTO `trya_config_system_time` VALUES ('9', 'tjj_cal_temp', '2018-05-24 19:41:00', '2018-05-24 19:41:40', '推荐奖计算临时时间');
INSERT INTO `trya_config_system_time` VALUES ('10', 'xsj_cal_temp', '2018-05-24 19:41:00', '2018-05-24 19:41:41', '销售奖计算临时时间');
INSERT INTO `trya_config_system_time` VALUES ('11', 'glj_cal_temp', '2018-05-24 19:41:00', '2018-05-24 19:41:41', '管理奖计算临时时间');
INSERT INTO `trya_config_system_time` VALUES ('12', 'cxj_cal_temp', '2018-05-24 19:41:00', '2018-05-24 19:41:42', '重消奖计算临时时间');
INSERT INTO `trya_config_system_time` VALUES ('13', 'fwj_out', '2018-05-24 18:00:23', '2018-04-13 16:56:28', '服务奖发放时间');
INSERT INTO `trya_config_system_time` VALUES ('14', 'fwj_cal', '2018-05-24 17:48:00', '2018-04-14 16:57:38', '服务奖计算时间');
INSERT INTO `trya_config_system_time` VALUES ('15', 'fwj_cal_temp', '2018-05-24 19:41:00', '2018-05-24 19:41:42', '服务奖计算临时时间');
INSERT INTO `trya_config_system_time` VALUES ('16', 'jdj_out', '2018-05-24 18:00:24', '2018-04-11 18:06:00', '见点奖发放时间');
INSERT INTO `trya_config_system_time` VALUES ('17', 'jdj_cal', '2018-05-24 17:48:00', '2018-04-10 18:07:13', '见点奖计算时间');
INSERT INTO `trya_config_system_time` VALUES ('18', 'jdj_cal_temp', '2018-05-24 19:41:00', '2018-05-24 19:41:42', '见点奖计算临时时间');

-- ----------------------------
-- Table structure for `trya_finance_accountingcode`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_accountingcode`;
CREATE TABLE `trya_finance_accountingcode` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `accounting_code` varchar(20) NOT NULL COMMENT '核算编码',
  `account_number` varchar(20) NOT NULL COMMENT '帐户号码',
  `account_name` varchar(20) NOT NULL COMMENT '帐户名称',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `mark` text COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='核算编码对照表';

-- ----------------------------
-- Records of trya_finance_accountingcode
-- ----------------------------
INSERT INTO `trya_finance_accountingcode` VALUES ('12', 'hyxjb', '2101', '会员现金币', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('13', 'hyjjb', '2102', '会员奖金币', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('14', 'hyjfb', '2103', '会员积分币', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('15', 'xjsk', '1001', '现金收款', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('16', 'xjfk', '1102', '现金付款', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('17', 'txsxfsr', '6101', '提现手续费收入', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('18', 'thxssr', '6102', '提货销售收入', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('19', 'bdfzc', '6004', '报单费支出', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('20', 'cxxssr', '6103', '重消销售收入', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('21', 'tjjzc', '6005', '推荐奖支出', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('22', 'xsjzc', '6006', '销售奖支出', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('23', 'gljzc', '6007', '管理奖支出', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('24', 'cxjzc', '6008', '重消奖支出', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('25', 'glfsr', '6109', '管理费收入', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('26', 'jjdhtc', '7001', '奖金兑换头寸', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('27', 'xjdhtc', '7002', '现金兑换头寸', '1518611240', null);
INSERT INTO `trya_finance_accountingcode` VALUES ('28', 'jfdhtc', '7003', '购物积分兑换头寸', '1518611240', null);

-- ----------------------------
-- Table structure for `trya_finance_application_cash`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_application_cash`;
CREATE TABLE `trya_finance_application_cash` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `application_user_code` varchar(10) NOT NULL DEFAULT '' COMMENT '申请会员编号',
  `bank_code` varchar(50) DEFAULT NULL COMMENT '银行账户',
  `application_type` enum('xj','jj') NOT NULL COMMENT '申请类型:xj=现金币提现申请,jj=奖金提现申请',
  `application_amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '申请提现金额',
  `real_amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '实际提现金额',
  `poundage` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '手续费',
  `after_balance` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '申请后余额',
  `application_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
  `state` enum('0','1') NOT NULL DEFAULT '0' COMMENT '处理状态:0=待处理,1=申请完成',
  `hand_user_code` varchar(10) DEFAULT '' COMMENT '处理人员编号',
  `hand_time` datetime DEFAULT NULL COMMENT '处理时间',
  `send_is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '申请人是否删除',
  `receive_is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '管理员是否删除',
  `mark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='会员提现申请';

-- ----------------------------
-- Records of trya_finance_application_cash
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_finance_application_recharge`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_application_recharge`;
CREATE TABLE `trya_finance_application_recharge` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `application_user_code` varchar(10) NOT NULL DEFAULT '' COMMENT '申请会员编号',
  `application_amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '申请金额',
  `after_balance` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '申请后余额',
  `application_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
  `hand_time` datetime DEFAULT NULL COMMENT '处理时间',
  `state` enum('0','1','2') NOT NULL DEFAULT '0' COMMENT '处理状态:0=待处理,1=申请完成,2=未通过',
  `hand_user_code` varchar(10) NOT NULL DEFAULT '' COMMENT '处理人员编号',
  `send_is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '发件人是否删除',
  `receive_is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '收件人是否删除',
  `user_mark` varchar(255) DEFAULT NULL COMMENT '申请人备注',
  `mark` varchar(255) DEFAULT NULL COMMENT '处理人备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员充值申请';

-- ----------------------------
-- Records of trya_finance_application_recharge
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_finance_bonustemp`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_bonustemp`;
CREATE TABLE `trya_finance_bonustemp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `serial_number` varchar(36) DEFAULT NULL COMMENT '流水号',
  `user_code` varchar(10) NOT NULL COMMENT '会员编号',
  `bonus_type` int(11) NOT NULL COMMENT '奖金类型:0=推荐奖,1=销售奖,2=管理奖,3=重消奖,4=服务奖,5=见点奖',
  `trade_direction` int(11) NOT NULL DEFAULT '1' COMMENT '交易方向:0=借方,1=贷方',
  `plan_money` decimal(20,2) NOT NULL COMMENT '计算奖金金额',
  `reality_money` decimal(20,2) NOT NULL COMMENT '实际奖金金额',
  `adjust_user_code` varchar(10) DEFAULT '' COMMENT '调整人编号',
  `bookkeeping_user_code` varchar(10) DEFAULT '' COMMENT '记账人编号',
  `entry_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入账时间',
  `mark` varchar(256) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='奖金计算临时表';

-- ----------------------------
-- Records of trya_finance_bonustemp
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_finance_businessconfig`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_businessconfig`;
CREATE TABLE `trya_finance_businessconfig` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `business_code` varchar(20) NOT NULL COMMENT '业务模块编号',
  `pro_name` varchar(100) NOT NULL COMMENT '存储过程名称',
  `additional_param` varchar(255) DEFAULT NULL COMMENT '附加参数，多个附加参数使用英文逗号隔开，没有参数置为null',
  `pro_instruction` varchar(255) DEFAULT NULL COMMENT '存储过程说明',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  `isdelete` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `mark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='业务配置表';

-- ----------------------------
-- Records of trya_finance_businessconfig
-- ----------------------------
INSERT INTO `trya_finance_businessconfig` VALUES ('12', 'hycz', 'pro_finance_company_incash', '0', '公司现金收款，附加参数：交易方向(0借，1贷)', '2', '0', '借');
INSERT INTO `trya_finance_businessconfig` VALUES ('13', 'hycz', 'pro_finance_member_cash', '1', '会员现金币，附加参数：交易方向(0借，1贷)', '1', '0', '贷');
INSERT INTO `trya_finance_businessconfig` VALUES ('15', 'hytx_xj', 'pro_finance_member_cash', '0', '会员现金币，附加参数：交易方向(0借，1贷)', '1', '0', '借');
INSERT INTO `trya_finance_businessconfig` VALUES ('16', 'hytx_xj', 'pro_finance_company_outcash', '1', '公司现金付款，附加参数：交易方向(0借，1贷)', '2', '0', '贷');
INSERT INTO `trya_finance_businessconfig` VALUES ('17', 'hytx_xj', 'pro_finance_company_poundage', '\"xj\"', '公司提现手续费，附加参数：手续费类别(“jj”奖金，“xj”现金)', '3', '0', '贷');
INSERT INTO `trya_finance_businessconfig` VALUES ('18', 'hyzclth', 'pro_finance_member_registered_integral', '0', '会员现金币，附加参数：交易方向(0借，1贷)', '1', '0', '借');
INSERT INTO `trya_finance_businessconfig` VALUES ('19', 'hyzclth', 'pro_finance_company_takedelivery_register', '1', '公司提货收入，附加参数：交易方向(0借，1贷)', '2', '0', '贷');
INSERT INTO `trya_finance_businessconfig` VALUES ('22', 'hycfxflth', 'pro_finance_member_cash', '0', '会员现金币，附加参数：交易方向(0借，1贷)', '1', '0', '借');
INSERT INTO `trya_finance_businessconfig` VALUES ('23', 'hycfxflth', 'pro_finance_company_takedelivery_repeat', '1', '公司重复消费收入，附加参数：交易方向(0借，1贷)', '2', '0', '贷');
INSERT INTO `trya_finance_businessconfig` VALUES ('26', 'pftjj', 'pro_finance_company_bonus_tjj', '0', '公司推荐奖支出，附加参数：交易方向(0借，1贷)', '4', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('27', 'pftjj', 'pro_finance_member_bonus', '1', '会员奖金，附加参数：交易方向(0借，1贷)', '3', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('28', 'pftjj', 'pro_finance_company_bonus_glf', '1', '公司管理费，附加参数：交易方向(0借，1贷)', '2', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('29', 'pftjj', 'pro_finance_member_bonus_shopping', '1', '奖金计算时会员购物积分，附加参数：交易方向(0借，1贷)', '1', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('30', 'hytx_jj', 'pro_finance_member_bonus', '0', '会员现金币，附加参数：交易方向(0借，1贷)', '1', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('31', 'hytx_jj', 'pro_finance_company_outcash', '1', '公司现金付款，附加参数：交易方向(0借，1贷)', '2', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('32', 'hytx_jj', 'pro_finance_company_poundage', '\"jj\"', '公司提现手续费，附加参数：手续费类别(“jj”奖金，“xj”现金)', '3', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('33', 'jj2xj', 'pro_finance_member_bonus', '0', '会员奖金币，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('34', 'jj2xj', 'pro_finance_company_jftc', '1', '公司奖金兑换头寸，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('35', 'jj2xj', 'pro_finance_company_xjtc', '0', '公司现金兑换头寸，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('36', 'jj2xj', 'pro_finance_member_cash', '1', '会员现金币，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('37', 'jj2jf', 'pro_finance_member_bonus', '0', '会员奖金币，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('38', 'jj2jf', 'pro_finance_company_jjtc', '1', '公司奖金头寸，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('39', 'jj2jf', 'pro_finance_company_jftc', '0', '公司购物积分头寸，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('40', 'jj2jf', 'pro_finance_member_shopping', '1', '会员购物积分，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('41', 'xj2jf', 'pro_finance_member_cash', '0', '会员现金币，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('42', 'xj2jf', 'pro_finance_company_xjtc', '1', '公司现金头寸，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('43', 'xj2jf', 'pro_finance_company_jftc', '0', '公司购物积分头寸，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('44', 'xj2jf', 'pro_finance_member_shopping', '1', '会员购物积分，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('45', 'hyzz', 'pro_finance_member_transaction', null, '会员转账，无附加参数', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('46', 'hybd', 'pro_finance_member_baodan', null, '会员报单，无附加参数', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('47', 'zcddzf', 'pro_finance_member_registered_integral', '1', '会员注册积分，附加参数：交易方向(0借，1贷)', '1', '0', '贷');
INSERT INTO `trya_finance_businessconfig` VALUES ('48', 'zcddzf', 'pro_finance_company_takedelivery_register', '0', '公司提货收入，附加参数：交易方向(0借，1贷)', '2', '0', '借');
INSERT INTO `trya_finance_businessconfig` VALUES ('50', 'cxddzf', 'pro_finance_member_cash', '1', '会员现金币，附加参数：交易方向(0借，1贷)', '1', '0', '贷');
INSERT INTO `trya_finance_businessconfig` VALUES ('51', 'cxddzf', 'pro_finance_company_takedelivery_repeat', '0', '公司重复消费收入，附加参数：交易方向(0借，1贷)', '2', '0', '借');
INSERT INTO `trya_finance_businessconfig` VALUES ('53', 'hysj', 'pro_finance_member_registered_integral', '1', '会员注册积分，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('54', 'hysj', 'pro_finance_company_incash', '0', '公司现金收款，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('55', 'ydsj', 'pro_finance_member_registered_integral', '1', '会员注册积分，附加参数：交易方向(0借，1贷)', '0', '0', null);
INSERT INTO `trya_finance_businessconfig` VALUES ('56', 'ydsj', 'pro_finance_member_cash', '0', '公司现金收款，附加参数：交易方向(0借，1贷)', '0', '0', null);

-- ----------------------------
-- Table structure for `trya_finance_businessmodule`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_businessmodule`;
CREATE TABLE `trya_finance_businessmodule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `business_code` varchar(20) NOT NULL COMMENT '业务模块编号',
  `business_name` varchar(100) NOT NULL COMMENT '业务模块名称',
  `mark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='业务模块表';

-- ----------------------------
-- Records of trya_finance_businessmodule
-- ----------------------------
INSERT INTO `trya_finance_businessmodule` VALUES ('1', 'hycz', '会员充值', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('2', 'hytx_xj', '会员现金提现', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('3', 'hyzclth', '会员注册类提货', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('4', 'hycfxflth', '会员重复消费类提货', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('5', 'jjpf', '奖金派发', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('6', 'hyzz', '会员转账', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('7', 'pftjj', '推荐奖派发', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('8', 'hytx_jj', '会员奖金提现', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('9', 'pfxsj', '销售奖派发', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('10', 'pfglj', '管理奖派发', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('11', 'pfcxj', '重消奖派发', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('12', 'jj2xj', '奖金转现金', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('13', 'jj2jf', '奖金转购物积分', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('14', 'xj2jf', '现金转购物积分', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('15', 'hybd', '会员注册报单', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('16', 'zcddzf', '注册类订单作废', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('17', 'cxddzf', '重消类订单作废', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('18', 'pfjdj', '见点奖派发', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('19', 'pffwj', '服务奖派发', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('20', 'hysj', '会员升级', null);
INSERT INTO `trya_finance_businessmodule` VALUES ('21', 'ydsj', ' 原点升级', null);

-- ----------------------------
-- Table structure for `trya_finance_companyaccount`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_companyaccount`;
CREATE TABLE `trya_finance_companyaccount` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `account_number` varchar(20) NOT NULL COMMENT '帐户号码',
  `account_name` varchar(20) NOT NULL COMMENT '帐户名称',
  `balance` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '当前余额',
  `last_day_balance` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '上日余额',
  `balance_direction` int(11) NOT NULL COMMENT '余额方向 0借方,1贷方',
  `time_stamp` bigint(20) NOT NULL COMMENT '时间戳',
  `mark` text COMMENT '备注',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` datetime(5) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='公司账户表';

-- ----------------------------
-- Records of trya_finance_companyaccount
-- ----------------------------
INSERT INTO `trya_finance_companyaccount` VALUES ('12', '2101', '会员现金币', '0.00', '0.00', '1', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('13', '2102', '会员奖金币', '0.00', '0.00', '1', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('14', '2103', '会员积分币', '0.00', '0.00', '1', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('15', '1001', '现金收款', '0.00', '0.00', '0', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('16', '1102', '现金付款', '0.00', '0.00', '1', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('17', '6101', '提现手续费收入', '0.00', '0.00', '1', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('18', '6102', '提货销售收入', '0.00', '0.00', '1', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('19', '6004', '报单费支出', '0.00', '0.00', '0', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('20', '6103', '重消销售收入', '0.00', '0.00', '1', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('21', '6005', '推荐奖支出', '0.00', '0.00', '0', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('22', '6006', '销售奖支出', '0.00', '0.00', '0', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('23', '6007', '管理奖支出', '0.00', '0.00', '0', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('24', '6008', '重消奖支出', '0.00', '0.00', '0', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('25', '6109', '管理费收入', '0.00', '0.00', '1', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('26', '7001', '奖金兑换头寸', '0.00', '0.00', '1', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('27', '7002', '现金兑换头寸', '0.00', '0.00', '1', '1518612234', null, '1518612234', '1518612234', null);
INSERT INTO `trya_finance_companyaccount` VALUES ('28', '7003', '购物积分兑换头寸', '0.00', '0.00', '1', '1518612234', null, '1518612234', '1518612234', null);

-- ----------------------------
-- Table structure for `trya_finance_history_accountentries`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_history_accountentries`;
CREATE TABLE `trya_finance_history_accountentries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `transaction_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '交易日期',
  `serial_number` varchar(36) NOT NULL COMMENT '流水号',
  `account_number` varchar(10) NOT NULL COMMENT '账户号码',
  `account_name` varchar(10) NOT NULL COMMENT '账户名称',
  `trade_direction` int(11) NOT NULL COMMENT '交易方向:0=借方,1=贷方',
  `transaction_amount` decimal(20,2) NOT NULL COMMENT '交易金额',
  `before_balance` decimal(20,2) NOT NULL COMMENT '交易前余额',
  `after_balance` decimal(20,2) NOT NULL COMMENT '交易后余额',
  `trading_time` datetime NOT NULL COMMENT '交易时间',
  `time_stamp` mediumtext NOT NULL COMMENT '时间戳',
  `mark` text COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司财务分录表';

-- ----------------------------
-- Records of trya_finance_history_accountentries
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_finance_history_bonus`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_history_bonus`;
CREATE TABLE `trya_finance_history_bonus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `transaction_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '交易日期',
  `serial_number` varchar(36) DEFAULT NULL COMMENT '流水号',
  `user_code` varchar(10) NOT NULL COMMENT '会员编号',
  `bonus_type` int(11) NOT NULL COMMENT '奖金类型:0=推荐奖,1=销售奖,2=管理奖,3=重消奖,4=服务奖,5=见点奖',
  `trade_direction` int(11) NOT NULL COMMENT '交易方向:0=借方,1=贷方',
  `plan_money` decimal(20,2) NOT NULL COMMENT '计算奖金金额',
  `reality_money` decimal(20,2) NOT NULL COMMENT '实际奖金金额',
  `pf_bouns` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '派发奖金',
  `pf_shopping` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '派发购物积分',
  `service_charge` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '手续费',
  `adjust_user_code` varchar(10) DEFAULT '' COMMENT '调整人编号',
  `bookkeeping_user_code` varchar(10) DEFAULT '' COMMENT '记账人编号',
  `entry_time` datetime NOT NULL COMMENT '入账时间',
  `mark` text COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='奖金历史纪录表';

-- ----------------------------
-- Records of trya_finance_history_bonus
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_finance_history_companyaccount`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_history_companyaccount`;
CREATE TABLE `trya_finance_history_companyaccount` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `transaction_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '交易日期',
  `account_number` varchar(20) NOT NULL COMMENT '帐户号码',
  `account_name` varchar(20) NOT NULL COMMENT '帐户名称',
  `balance` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '当前余额',
  `last_day_balance` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '上日余额',
  `balance_direction` int(11) NOT NULL COMMENT '余额方向:0=借方,1=贷方',
  `time_stamp` bigint(20) NOT NULL COMMENT '时间戳',
  `mark` text COMMENT '备注',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` datetime(5) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司账户历史表';

-- ----------------------------
-- Records of trya_finance_history_companyaccount
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_finance_history_parameter`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_history_parameter`;
CREATE TABLE `trya_finance_history_parameter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `transaction_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '交易日期',
  `group_name` varchar(20) NOT NULL COMMENT '参数分组',
  `param_name` varchar(20) NOT NULL COMMENT '参数名',
  `param_value` decimal(20,2) NOT NULL COMMENT '参数值',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `mark` text COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='历史参数表';

-- ----------------------------
-- Records of trya_finance_history_parameter
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_finance_history_personalaccount`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_history_personalaccount`;
CREATE TABLE `trya_finance_history_personalaccount` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `transaction_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '交易日期',
  `user_code` varchar(50) NOT NULL DEFAULT '' COMMENT '用户编号',
  `type` int(11) NOT NULL COMMENT '帐户种类:0=现金币,1=奖金币,2=积分币',
  `balance` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '当前余额',
  `last_day_balance` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '上日余额',
  `balance_direction` int(11) NOT NULL COMMENT '余额方向:0=借方,1=贷方',
  `time_stamp` bigint(20) NOT NULL COMMENT '时间戳',
  `mark` text COMMENT '备注',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` datetime(5) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员账户历史表';

-- ----------------------------
-- Records of trya_finance_history_personalaccount
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_finance_history_personalaccountflow`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_history_personalaccountflow`;
CREATE TABLE `trya_finance_history_personalaccountflow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `serial_number` varchar(36) NOT NULL COMMENT '流水号',
  `user_code` varchar(10) NOT NULL COMMENT '会员编号',
  `counterparty` varchar(100) NOT NULL DEFAULT '' COMMENT '交易对手',
  `account_type` int(11) NOT NULL COMMENT '账户种类:0=现金币,1=奖金币,2=购物积分币',
  `transaction_amount` decimal(20,2) NOT NULL COMMENT '交易金额',
  `trade_direction` int(11) NOT NULL COMMENT '交易方向:0=借方,1=贷方',
  `before_balance` decimal(20,2) NOT NULL COMMENT '交易前余额',
  `after_balance` decimal(20,2) NOT NULL COMMENT '交易后余额',
  `trading_time` datetime NOT NULL COMMENT '交易时间',
  `time_stamp` mediumtext NOT NULL COMMENT '时间戳',
  `mark` text COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员账户流水';

-- ----------------------------
-- Records of trya_finance_history_personalaccountflow
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_finance_history_personalperformance`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_history_personalperformance`;
CREATE TABLE `trya_finance_history_personalperformance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_code` varchar(10) NOT NULL COMMENT '会员编号',
  `now_day_amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '当天业绩',
  `calculate_amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '计算业绩',
  `surplus_amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '剩余计算金额',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '0=小区业绩，1=血缘业绩',
  `cal_time` datetime NOT NULL COMMENT '计算时间',
  `accounting_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记账时间',
  `mark` text COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员销售业绩计算表';

-- ----------------------------
-- Records of trya_finance_history_personalperformance
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_finance_history_transactionalflow`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_history_transactionalflow`;
CREATE TABLE `trya_finance_history_transactionalflow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `serial_number` varchar(36) NOT NULL COMMENT '流水号',
  `user_code` varchar(10) NOT NULL COMMENT '会员编号',
  `counterparty` varchar(100) NOT NULL DEFAULT '' COMMENT '交易对手',
  `business_code` varchar(20) NOT NULL COMMENT '所办业务编码',
  `transaction_amount` decimal(20,2) NOT NULL COMMENT '交易金额',
  `trading_time` datetime NOT NULL COMMENT '交易时间',
  `time_stamp` mediumtext NOT NULL COMMENT '时间戳',
  `display_type` int(10) NOT NULL DEFAULT '0' COMMENT '显示类型，0：全显示，1：仅会员账户显示，2仅公司账户显示',
  `operation_user_code` varchar(10) NOT NULL COMMENT '操作人编号',
  `mark` text COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务流水表';

-- ----------------------------
-- Records of trya_finance_history_transactionalflow
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_finance_parameter`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_parameter`;
CREATE TABLE `trya_finance_parameter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_name` varchar(20) NOT NULL COMMENT '参数分组',
  `param_name` varchar(20) NOT NULL COMMENT '参数名',
  `param_value` decimal(20,7) NOT NULL COMMENT '参数值',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `mark` text COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='参数表';

-- ----------------------------
-- Records of trya_finance_parameter
-- ----------------------------
INSERT INTO `trya_finance_parameter` VALUES ('2', 'bdfl', 'bdfl', '0.0500000', '1524884318', '1524884318', '报单费率');
INSERT INTO `trya_finance_parameter` VALUES ('3', 'bobi', 'k_value', '1.0000000', '1524884318', '1524884318', '拨比（K值）');
INSERT INTO `trya_finance_parameter` VALUES ('4', 'cfxf', 'bl', '0.0000000', '1524884318', '1524884318', '奖金重复消费比例');
INSERT INTO `trya_finance_parameter` VALUES ('5', 'cxj', 'bl', '0.0100000', '1524884318', '1524884318', '重消奖比例');
INSERT INTO `trya_finance_parameter` VALUES ('6', 'cxj', 'cj', '20.0000000', '1524884318', '1524884318', '重消奖层级');
INSERT INTO `trya_finance_parameter` VALUES ('8', 'glf', 'jj', '0.0500000', '1524884318', '1524884318', '奖金管理费');
INSERT INTO `trya_finance_parameter` VALUES ('9', 'glj', 'child1', '1.0000000', '1524884318', '1524884318', '管理奖一代');
INSERT INTO `trya_finance_parameter` VALUES ('10', 'glj', 'child2', '0.5000000', '1524884318', '1524884318', '管理奖二代');
INSERT INTO `trya_finance_parameter` VALUES ('11', 'glj', 'child3', '0.2000000', '1524884318', '1524884318', '管理奖三代');
INSERT INTO `trya_finance_parameter` VALUES ('12', 'gljfd', 'lv1', '2000.0000000', '1524884318', '1524884318', '管理奖封顶（银卡）');
INSERT INTO `trya_finance_parameter` VALUES ('13', 'gljfd', 'lv2', '6000.0000000', '1524884318', '1524884318', '管理奖封顶（金卡）');
INSERT INTO `trya_finance_parameter` VALUES ('14', 'gljfd', 'lv3', '18000.0000000', '1524884318', '1524884318', '管理奖封顶（钻石卡）');
INSERT INTO `trya_finance_parameter` VALUES ('15', 'gljfd', 'lv4', '18000.0000000', '1524884318', '1524884318', '管理奖封顶（服务中心）');
INSERT INTO `trya_finance_parameter` VALUES ('16', 'hbzh', 'jj2jf', '1.0000000', '1524884318', '1524884318', '奖金兑换积分汇率');
INSERT INTO `trya_finance_parameter` VALUES ('17', 'hbzh', 'jj2xj', '1.0000000', '1524884318', '1524884318', '奖金兑换现金汇率');
INSERT INTO `trya_finance_parameter` VALUES ('18', 'hbzh', 'xj2jf', '1.0000000', '1524884318', '1524884318', '现金兑换积分汇率');
INSERT INTO `trya_finance_parameter` VALUES ('19', 'jdj', 'fl', '0.0015000', '1524884318', '1524884318', '见点奖费率');
INSERT INTO `trya_finance_parameter` VALUES ('20', 'jdjcj', 'lv1', '10.0000000', '1524884318', '1524884318', '见点奖层级（银卡）');
INSERT INTO `trya_finance_parameter` VALUES ('21', 'jdjcj', 'lv2', '20.0000000', '1524884318', '1524884318', '见点奖层级（金卡）');
INSERT INTO `trya_finance_parameter` VALUES ('22', 'jdjcj', 'lv3', '30.0000000', '1524884318', '1524884318', '见点奖层级（钻石卡）');
INSERT INTO `trya_finance_parameter` VALUES ('23', 'jdjcj', 'lv4', '30.0000000', '1524884318', '1524884318', '见点奖层级（服务中心）');
INSERT INTO `trya_finance_parameter` VALUES ('24', 'jjzh', 'jf', '0.1000000', '1524884318', '1524884318', '奖金强制转为积分比例');
INSERT INTO `trya_finance_parameter` VALUES ('25', 'txed', 'high', '10000.0000000', '1524884318', '1524884318', '提现额度（最高）');
INSERT INTO `trya_finance_parameter` VALUES ('26', 'txed', 'low', '100.0000000', '1524884318', '1524884318', '提现额度（最低）');
INSERT INTO `trya_finance_parameter` VALUES ('27', 'txsxf', 'jj', '0.0500000', '1524884318', '1524884318', '提现手续费（奖金）');
INSERT INTO `trya_finance_parameter` VALUES ('28', 'txsxf', 'xj', '0.0500000', '1524884318', '1524884318', '提现手续费（现金）');
INSERT INTO `trya_finance_parameter` VALUES ('29', 'xsbl', 'lv1', '0.0800000', '1524884318', '1524884318', '销售奖比例（银卡）');
INSERT INTO `trya_finance_parameter` VALUES ('30', 'xsbl', 'lv2', '0.0900000', '1524884318', '1524884318', '销售奖比例（金卡）');
INSERT INTO `trya_finance_parameter` VALUES ('31', 'xsbl', 'lv3', '0.1000000', '1524884318', '1524884318', '销售奖比例（钻石卡）');
INSERT INTO `trya_finance_parameter` VALUES ('32', 'xsbl', 'lv4', '0.1000000', '1524884318', '1524884318', '销售奖比例（服务中心）');
INSERT INTO `trya_finance_parameter` VALUES ('33', 'xsfd', 'lv1', '2000.0000000', '1524884318', '1524884318', '销售奖封顶（银卡）');
INSERT INTO `trya_finance_parameter` VALUES ('34', 'xsfd', 'lv2', '6000.0000000', '1524884318', '1524884318', '销售奖封顶（金卡）');
INSERT INTO `trya_finance_parameter` VALUES ('35', 'xsfd', 'lv3', '18000.0000000', '1524884318', '1524884318', '销售奖封顶（钻石卡）');
INSERT INTO `trya_finance_parameter` VALUES ('36', 'xsfd', 'lv4', '18000.0000000', '1524884318', '1524884318', '销售奖封顶（服务中心）');
INSERT INTO `trya_finance_parameter` VALUES ('37', 'zcje', 'lv1', '2000.0000000', '1524884318', '1524884318', '注册金额（银卡）');
INSERT INTO `trya_finance_parameter` VALUES ('38', 'zcje', 'lv2', '6000.0000000', '1524884318', '1524884318', '注册金额（金卡）');
INSERT INTO `trya_finance_parameter` VALUES ('39', 'zcje', 'lv3', '18000.0000000', '1524884318', '1524884318', '注册金额（钻石卡）');
INSERT INTO `trya_finance_parameter` VALUES ('40', 'ztjbl', 'lv1', '0.1000000', '1524884318', '1524884318', '直推奖比例（银卡）');
INSERT INTO `trya_finance_parameter` VALUES ('64', 'ztjbl', 'lv2', '0.1000000', '1524884318', '1524884318', '直推奖比例（金卡）');
INSERT INTO `trya_finance_parameter` VALUES ('65', 'ztjbl', 'lv3', '0.1000000', '1524884318', '1524884318', '直推奖比例（钻石卡）');
INSERT INTO `trya_finance_parameter` VALUES ('66', 'ztjbl', 'lv4', '0.1000000', '1524884318', '1524884318', '直推奖比例（服务中心）');

-- ----------------------------
-- Table structure for `trya_finance_personalaccount`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_personalaccount`;
CREATE TABLE `trya_finance_personalaccount` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_code` varchar(50) NOT NULL DEFAULT '' COMMENT '用户编号',
  `type` int(11) NOT NULL COMMENT '帐户种类 0现金币 1奖金币 2积分币,3注册积分',
  `balance` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '当前余额',
  `last_day_balance` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '上日余额',
  `balance_direction` int(11) NOT NULL DEFAULT '1' COMMENT '余额方向 0借方,1贷方',
  `time_stamp` bigint(20) NOT NULL COMMENT '时间戳',
  `mark` text COMMENT '备注',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` datetime(5) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员账户表';

-- ----------------------------
-- Records of trya_finance_personalaccount
-- ----------------------------
INSERT INTO `trya_finance_personalaccount` VALUES ('1', '1234567', '0', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('2', '1234567', '1', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('3', '1234567', '2', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('4', '1234567', '3', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('5', '0000001', '0', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('6', '0000001', '1', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('7', '0000001', '2', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('8', '0000001', '3', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('9', '0000002', '0', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('10', '0000002', '1', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('11', '0000002', '2', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('12', '0000002', '3', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('13', '0000003', '0', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('14', '0000003', '1', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('15', '0000003', '2', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);
INSERT INTO `trya_finance_personalaccount` VALUES ('16', '0000003', '3', '0.00', '0.00', '1', '1527164666', null, '1527164666', '1527164666', null);

-- ----------------------------
-- Table structure for `trya_finance_temp_bonus_glf`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_temp_bonus_glf`;
CREATE TABLE `trya_finance_temp_bonus_glf` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_code` varchar(20) NOT NULL COMMENT '用户编号',
  `referee_user_code` varchar(20) NOT NULL COMMENT '推荐人编号',
  `param_value` decimal(20,2) NOT NULL COMMENT '管理封顶',
  `xsj_money` decimal(20,2) NOT NULL COMMENT '销售奖金',
  `bonus_value` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '管理奖金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理奖计算临时表';

-- ----------------------------
-- Records of trya_finance_temp_bonus_glf
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_finance_temp_personalperformance`
-- ----------------------------
DROP TABLE IF EXISTS `trya_finance_temp_personalperformance`;
CREATE TABLE `trya_finance_temp_personalperformance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_code` varchar(10) NOT NULL COMMENT '会员编号',
  `now_day_amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '当天业绩',
  `calculate_amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '计算业绩',
  `surplus_amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '剩余计算金额',
  `accounting_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记账时间',
  `mark` text COMMENT '备注',
  `manage_user_code` varchar(10) NOT NULL COMMENT '安置人员编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of trya_finance_temp_personalperformance
-- ----------------------------
INSERT INTO `trya_finance_temp_personalperformance` VALUES ('1', '0000001', '2000.00', '2000.00', '2000.00', '2018-05-24 19:41:41', null, '1234567');
INSERT INTO `trya_finance_temp_personalperformance` VALUES ('2', '0000002', '0.00', '0.00', '0.00', '2018-05-24 19:41:41', null, '1234567');
INSERT INTO `trya_finance_temp_personalperformance` VALUES ('3', '0000003', '0.00', '0.00', '0.00', '2018-05-24 19:41:41', null, '1234567');
INSERT INTO `trya_finance_temp_personalperformance` VALUES ('4', '0000011', '2000.00', '2000.00', '2000.00', '2018-05-24 19:41:41', null, '0000001');

-- ----------------------------
-- Table structure for `trya_message_leave`
-- ----------------------------
DROP TABLE IF EXISTS `trya_message_leave`;
CREATE TABLE `trya_message_leave` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `message_title` varchar(50) NOT NULL DEFAULT '' COMMENT '留言标题',
  `message_content` text COMMENT '留言内容',
  `send_user_code` varchar(10) NOT NULL COMMENT '发件人编号',
  `receive_user_code` varchar(10) NOT NULL COMMENT '收件人编号',
  `send_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `is_read` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否阅读',
  `send_is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发件人是否删除',
  `receive_is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '收件人是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='留言信息表';

-- ----------------------------
-- Records of trya_message_leave
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_message_notice`
-- ----------------------------
DROP TABLE IF EXISTS `trya_message_notice`;
CREATE TABLE `trya_message_notice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '通知标题',
  `content` text NOT NULL COMMENT '通知内容',
  `user_code` varchar(10) NOT NULL DEFAULT '' COMMENT '发布人编号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知表';

-- ----------------------------
-- Records of trya_message_notice
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_message_sql_log`
-- ----------------------------
DROP TABLE IF EXISTS `trya_message_sql_log`;
CREATE TABLE `trya_message_sql_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `procedure_name` varchar(100) NOT NULL DEFAULT '' COMMENT '存储过程',
  `content` text NOT NULL COMMENT '错误内容',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='数据库日志信息表';

-- ----------------------------
-- Records of trya_message_sql_log
-- ----------------------------
INSERT INTO `trya_message_sql_log` VALUES ('1', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-07 15:10:45');
INSERT INTO `trya_message_sql_log` VALUES ('2', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-07 15:16:42');
INSERT INTO `trya_message_sql_log` VALUES ('3', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-07 15:21:40');
INSERT INTO `trya_message_sql_log` VALUES ('4', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-07 15:22:20');
INSERT INTO `trya_message_sql_log` VALUES ('5', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-07 15:22:42');
INSERT INTO `trya_message_sql_log` VALUES ('6', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-07 15:22:55');
INSERT INTO `trya_message_sql_log` VALUES ('7', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-07 15:23:24');
INSERT INTO `trya_message_sql_log` VALUES ('8', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-07 15:24:09');
INSERT INTO `trya_message_sql_log` VALUES ('9', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-07 15:24:45');
INSERT INTO `trya_message_sql_log` VALUES ('10', 'pro_finance_member_transaction', 'Failed, error code is 00000, related message is call pro_finance_member_transaction(\"7598650d-415f-11e8-9a6e-00163e0a66bc\",\"1234567\",\"0000001\",100.00,@res);.', '2018-04-16 18:18:08');
INSERT INTO `trya_message_sql_log` VALUES ('11', 'pro_finance_member_transaction', 'Failed, error code is 00000, related message is call pro_finance_member_transaction(\"d175a93d-417a-11e8-9a6e-00163e0a66bc\",\"1234567\",\"0000001\",10.00,@res);.', '2018-04-16 21:33:59');
INSERT INTO `trya_message_sql_log` VALUES ('12', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-17 21:12:06');
INSERT INTO `trya_message_sql_log` VALUES ('13', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-17 21:17:14');
INSERT INTO `trya_message_sql_log` VALUES ('14', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-17 21:22:54');
INSERT INTO `trya_message_sql_log` VALUES ('15', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-17 21:26:33');
INSERT INTO `trya_message_sql_log` VALUES ('16', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-17 21:28:49');
INSERT INTO `trya_message_sql_log` VALUES ('17', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-17 21:30:47');
INSERT INTO `trya_message_sql_log` VALUES ('18', '', 'Failed, error code is 00000, related message is 会员货币转换错误.', '2018-04-17 21:33:32');
INSERT INTO `trya_message_sql_log` VALUES ('19', 'pro_finance_member_registered_integral', 'Failed, error code is 00000, related message is call pro_finance_member_registered_integral(\"00486f65-477b-11e8-9a6e-00163e0a66bc\",\"1234567\",\"\",20.00,0,@res);.', '2018-04-24 12:50:24');
INSERT INTO `trya_message_sql_log` VALUES ('20', 'pro_finance_company_outcash', 'Failed, error code is 00000, related message is call pro_finance_company_outcash(\"5e284307-590f-11e8-9a6e-00163e0a66bc\",\"0000001\",\"\",100.00,1,@res);.', '2018-05-16 21:45:17');
INSERT INTO `trya_message_sql_log` VALUES ('21', 'pro_finance_company_outcash', 'Failed, error code is 00000, related message is call pro_finance_company_outcash(\"ad19aca7-590f-11e8-9a6e-00163e0a66bc\",\"0000001\",\"\",1000.00,1,@res);.', '2018-05-16 21:47:29');
INSERT INTO `trya_message_sql_log` VALUES ('22', 'pro_finance_company_outcash', 'Failed, error code is 00000, related message is call pro_finance_company_outcash(\"cb2c648b-590f-11e8-9a6e-00163e0a66bc\",\"0000001\",\"\",1000.00,1,@res);.', '2018-05-16 21:48:20');
INSERT INTO `trya_message_sql_log` VALUES ('23', 'pro_finance_company_poundage', 'Failed, error code is 00000, related message is call pro_finance_company_poundage(\"7ea4b430-5910-11e8-9a6e-00163e0a66bc\",\"0000001\",\"\",1023.15,\"jj\",@res);.', '2018-05-16 21:53:21');
INSERT INTO `trya_message_sql_log` VALUES ('24', 'pro_finance_company_poundage', 'Failed, error code is 00000, related message is call pro_finance_company_poundage(\"ebf98636-5910-11e8-9a6e-00163e0a66bc\",\"0000001\",\"\",223.15,\"jj\",@res);.', '2018-05-16 21:56:24');

-- ----------------------------
-- Table structure for `trya_message_upgradeapplication`
-- ----------------------------
DROP TABLE IF EXISTS `trya_message_upgradeapplication`;
CREATE TABLE `trya_message_upgradeapplication` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `application_user_code` varchar(10) NOT NULL COMMENT '申请用户编号',
  `old_grade_code` int(11) NOT NULL COMMENT '原等级',
  `new_grade_code` int(11) NOT NULL COMMENT '新等级',
  `application_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
  `application_mark` text COMMENT '申请备注',
  `hand_user_code` varchar(10) DEFAULT NULL COMMENT '操作用户编号',
  `hand_time` datetime DEFAULT NULL COMMENT '处理时间',
  `hand_mark` text COMMENT '处理备注',
  `state` enum('0','1','2') NOT NULL DEFAULT '0' COMMENT '申请表状态:0=待处理,1=确定,2=拒绝',
  `application_is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '申请人是否删除',
  `hand_is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '处理人是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='升级申请表';

-- ----------------------------
-- Records of trya_message_upgradeapplication
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_product_orderform`
-- ----------------------------
DROP TABLE IF EXISTS `trya_product_orderform`;
CREATE TABLE `trya_product_orderform` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_productinfo_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `order_quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订货量',
  `order_user_code` varchar(10) NOT NULL DEFAULT '' COMMENT '订货人编号',
  `order_time` datetime NOT NULL COMMENT '订货时间',
  `order_phone` varchar(20) NOT NULL DEFAULT '' COMMENT '订货人联系电话',
  `receive_address` varchar(200) NOT NULL DEFAULT '' COMMENT '收货地址',
  `receive_name` varchar(20) NOT NULL DEFAULT '' COMMENT '收件人姓名',
  `product_real_price` float(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '商品价格',
  `order_total_price` float(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单总金额',
  `send_user` varchar(100) DEFAULT '' COMMENT '发货人信息',
  `send_code` varchar(100) DEFAULT NULL COMMENT '发货单号',
  `send_time` datetime DEFAULT NULL COMMENT '发货时间',
  `order_state` enum('1','2','3','4','5') NOT NULL DEFAULT '1' COMMENT '订单状态:1=待确认,2=确认,3=已发货,4=已完成,5=已作废',
  `order_is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '订单人是否删除',
  `manage_is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '管理员是否删除',
  `order_mark` text COMMENT '申请人备注',
  `mark` text COMMENT '操作人备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of trya_product_orderform
-- ----------------------------

-- ----------------------------
-- Table structure for `trya_product_productinfo`
-- ----------------------------
DROP TABLE IF EXISTS `trya_product_productinfo`;
CREATE TABLE `trya_product_productinfo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `product_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '产品分类ID',
  `units` varchar(30) NOT NULL DEFAULT '' COMMENT '产品单位',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '产品价格',
  `inventory` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '产品库存',
  `content` text NOT NULL COMMENT '产品内容',
  `real_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实际价格',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of trya_product_productinfo
-- ----------------------------
INSERT INTO `trya_product_productinfo` VALUES ('3', '产品1', '1', '斤', '3.50', '60', '这是产品', '2.00', '1517895003', '1519779724', null);
INSERT INTO `trya_product_productinfo` VALUES ('4', '手机', '2', '部', '10000.00', '96', '测试产品', '9000.00', '1519623525', '1519623525', null);
INSERT INTO `trya_product_productinfo` VALUES ('5', '水机', '1', '台', '5880.00', '0', 'T400型水机', '0.00', '0', '0', null);
INSERT INTO `trya_product_productinfo` VALUES ('6', '测试', '2', '个', '100.00', '10', '测试产品', '100.00', '0', '0', null);

-- ----------------------------
-- Table structure for `trya_product_type`
-- ----------------------------
DROP TABLE IF EXISTS `trya_product_type`;
CREATE TABLE `trya_product_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(90) NOT NULL DEFAULT '' COMMENT '名称',
  `description` text NOT NULL COMMENT '描述',
  `number` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '顺序号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='产品分类表';

-- ----------------------------
-- Records of trya_product_type
-- ----------------------------
INSERT INTO `trya_product_type` VALUES ('1', '注册资金类产品', '注册资金类产品', '1');
INSERT INTO `trya_product_type` VALUES ('2', '重复消费类产品', '重复消费类产品', '2');

-- ----------------------------
-- Procedure structure for `pro_bonus_calculation_fwj`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_bonus_calculation_fwj`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_bonus_calculation_fwj`(IN param_endtime datetime)
BEGIN
	-- 服务奖计算
	DECLARE pro_err TINYINT DEFAULT 0;  
	DECLARE pro_code CHAR(5) DEFAULT '00000';  
	DECLARE pro_msg TEXT; 
	DECLARE pro_result TEXT;
	DECLARE param_bonus_type int DEFAULT 4;--  奖金类型:0=推荐奖,1=销售奖,2=管理奖,3=重消奖，4=服务奖
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
  BEGIN  
		SET pro_err = 1;  
		GET DIAGNOSTICS CONDITION 1
			pro_code = RETURNED_SQLSTATE, pro_msg = MESSAGE_TEXT;  
	END;
	START TRANSACTION;-- 启动事物

	select @start_time:=system_time from trya_config_system_time where type='fwj_cal';
	-- 更新临时计算时间
	UPDATE trya_config_system_time set system_time=param_endtime,update_time=NOW() where type='fwj_cal_temp';
	select @bdl:=param_value from trya_finance_parameter where group_name='bdfl' and param_name='bdfl';
	delete  from trya_finance_bonustemp where bonus_type=param_bonus_type;
	-- 服务奖金计算
	insert into  trya_finance_bonustemp(user_code,bonus_type,plan_money,reality_money,entry_time,mark)
			select  a2.user_code,param_bonus_type,sum(IFNULL(t.transaction_amount,0))*@bdl,sum(IFNULL(transaction_amount,0))*@bdl,NOW(), group_concat(IFNULL(t.counterparty,''),'')
					from trya_finance_history_transactionalflow t 
					inner join trya_admin  a on t.counterparty=a.user_code and t.business_code='hybd' and t.trading_time>@start_time and t.trading_time<param_endtime 
					RIGHT JOIN (select * from trya_admin where id!=1) a2 on a.declaration_form_code=a2.user_code
					group by a2.user_code;
	update trya_finance_bonustemp set mark=CONCAT('注册会员:',mark) where bonus_type=param_bonus_type and mark!='';

	-- Result
	IF pro_err != 0 THEN
			SET pro_result = CONCAT('Failed, error code is ',pro_code,', related message is ',pro_msg,'.');
			ROLLBACK;
			CALL pro_sql_log_insert('pro_bonus_calculation_glj',pro_result);
	ELSE
			SET pro_result = CONCAT("Succeeded");
			COMMIT;
	END IF;
	SELECT pro_err;

end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_bonus_calculation_glj`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_bonus_calculation_glj`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_bonus_calculation_glj`(IN param_endtime datetime)
BEGIN
	-- 管理奖计算
	
	-- Declare exception handler
	DECLARE pro_err TINYINT DEFAULT 0;  
	DECLARE pro_code CHAR(5) DEFAULT '00000';  
	DECLARE pro_msg TEXT; 
	DECLARE pro_result TEXT;
	DECLARE param_bonus_type int DEFAULT 2;--  奖金类型:0=推荐奖,1=销售奖,2=管理奖,3=重消奖
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
	BEGIN  
		SET pro_err = 1;  
		GET DIAGNOSTICS CONDITION 1
			pro_code = RETURNED_SQLSTATE, pro_msg = MESSAGE_TEXT;  
	END;  
	START TRANSACTION;-- 启动事物
-- 内容部分
	-- 获取一级子子节点费率
	select @glj_child1:=param_value from trya_finance_parameter where group_name='glj' and param_name='child1';
	-- 获取二级子子节点费率
	select @glj_child2:=param_value from trya_finance_parameter where group_name='glj' and param_name='child2';
	-- 获取三级子子节点费率
	select @glj_child3:=param_value from trya_finance_parameter where group_name='glj' and param_name='child3';

	-- 获取销售奖系计算时间
	select @xsj_system_time:=system_time from trya_config_system_time where type='xsj_cal';
	-- 更新销售奖系计算临时时间
	update trya_config_system_time set system_time=param_endtime ,update_time=NOW() where type='glj_cal_temp';
	
	TRUNCATE table trya_finance_temp_bonus_glf;

	-- 获取已经计算的销售奖
	insert into trya_finance_temp_bonus_glf(xsj_money,user_code,referee_user_code,param_value)
	select IFNULL(xsjb.reality_money,0) as money,a.user_code as user_code,a.referee_user_code as referee_user_code,p.param_value as param_value from 
		(select * from trya_finance_bonustemp where bonus_type=1 and entry_time>=@xsj_system_time)as xsjb
		RIGHT JOIN (select * from trya_admin where ISNULL(delete_time) and id!=1) as a on xsjb.user_code=a.user_code
		INNER JOIN trya_finance_parameter as p on a.grade_code=p.param_name and p.group_name='gljfd';
	-- 删除原始数据
	delete from trya_finance_bonustemp where bonus_type=param_bonus_type;
	
	-- 定义临时表，存储管理奖
	DROP TABLE IF EXISTS trya_temp_bouns_glf;
	create temporary table trya_temp_bouns_glf(
		id int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
		user_code VARCHAR(10) not null,
		glf decimal(20,2) not null DEFAULT 0,
		PRIMARY KEY (id)
	);
	-- 计算子一代
	insert into trya_temp_bouns_glf (user_code,glf)
		select b0.user_code,
			SUM(least(b0.param_value,@glj_child1*IFNULL(b1.xsj_money,0)))
			from trya_finance_temp_bonus_glf b0 
			left JOIN trya_finance_temp_bonus_glf b1 on b0.user_code=b1.referee_user_code and b0.user_code!=b1.user_code  -- 一级子子节点
			GROUP BY b0.user_code;
	-- 计算子二代
	insert into trya_temp_bouns_glf (user_code,glf)
		select b0.user_code,
			SUM(least(b0.param_value,@glj_child2*IFNULL(b2.xsj_money,0)))
			from trya_finance_temp_bonus_glf b0 
			left JOIN trya_finance_temp_bonus_glf b1 on b0.user_code=b1.referee_user_code and b0.user_code!=b1.user_code  -- 一级子子节点
			left JOIN trya_finance_temp_bonus_glf b2 on b1.user_code=b2.referee_user_code and b1.user_code!=b2.user_code	-- 二级子子节点
			GROUP BY b0.user_code;
	-- 计算子三代
	insert into trya_temp_bouns_glf (user_code,glf)
		select b0.user_code,
			SUM(least(b0.param_value,@glj_child3*IFNULL(b3.xsj_money,0)))
			from trya_finance_temp_bonus_glf b0 
			left JOIN trya_finance_temp_bonus_glf b1 on b0.user_code=b1.referee_user_code and b0.user_code!=b1.user_code  -- 一级子子节点
			left JOIN trya_finance_temp_bonus_glf b2 on b1.user_code=b2.referee_user_code and b1.user_code!=b2.user_code	-- 二级子子节点
			left JOIN trya_finance_temp_bonus_glf b3 on b2.user_code=b3.referee_user_code and b2.user_code!=b3.user_code	-- 三级子子节点
			GROUP BY b0.user_code;
		
	-- 插入奖金临时表
	insert into trya_finance_bonustemp (user_code,bonus_type,plan_money,reality_money,entry_time)
		select user_code,param_bonus_type,sum(glf),sum(glf),NOW()
			from trya_temp_bouns_glf GROUP BY user_code;

-- 内容结束

	-- Result
	IF pro_err != 0 THEN
			SET pro_result = CONCAT('Failed, error code is ',pro_code,', related message is ',pro_msg,'.');
			ROLLBACK;
			CALL pro_sql_log_insert('pro_bonus_calculation_glj',pro_result);
	ELSE
			SET pro_result = CONCAT("Succeeded");
			COMMIT;
	END IF;
	SELECT pro_err;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_bonus_calculation_tjj`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_bonus_calculation_tjj`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_bonus_calculation_tjj`(IN param_endtime datetime)
BEGIN
	-- 推荐奖计算 param_endtime计算截止时间 
	
	-- Declare exception handler
	DECLARE pro_err TINYINT DEFAULT 0;  
	DECLARE pro_code CHAR(5) DEFAULT '00000';  
	DECLARE pro_msg TEXT; 
	DECLARE pro_result TEXT;
	DECLARE param_bonus_type int DEFAULT 0;--  奖金类型:0=推荐奖,1=销售奖,2=管理奖,3=重消奖
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
	BEGIN  
		SET pro_err = 1;  
  	GET DIAGNOSTICS CONDITION 1
		pro_code = RETURNED_SQLSTATE, pro_msg = MESSAGE_TEXT;  
	END;  
	START TRANSACTION;-- 启动事物
-- 内容部分
	-- 获取推荐奖计算时间
	select @tjj_system_time:=system_time from trya_config_system_time where type='tjj_cal';
	-- 更新推荐奖计算临时时间
	update trya_config_system_time set system_time=param_endtime ,update_time=NOW() where type='tjj_cal_temp';

	-- 删除原有数据
	delete from trya_finance_bonustemp where bonus_type=param_bonus_type;
	-- 插入数据
	-- 推荐奖计算
	insert into  trya_finance_bonustemp(user_code,bonus_type,plan_money,reality_money,entry_time,mark)
			select  a2.user_code,param_bonus_type,sum(IFNULL(t.transaction_amount,0))*p.param_value,sum(IFNULL(transaction_amount,0))*p.param_value,NOW(), group_concat(IFNULL(t.counterparty,''),'')
					from trya_finance_history_transactionalflow t 
					inner join trya_admin  a on t.counterparty=a.user_code and (t.business_code='hybd' or t.business_code='hysj' or t.business_code='ydsj') and t.trading_time>@tjj_system_time and t.trading_time<param_endtime 
					RIGHT JOIN (select * from trya_admin where  ISNULL(delete_time) and  id!=1) a2 on a.referee_user_code=a2.user_code
					inner join trya_finance_parameter p on p.group_name='ztjbl' and p.param_name=a.grade_code
					group by a2.user_code;
	update trya_finance_bonustemp set mark=CONCAT('注册会员:',mark) where bonus_type=param_bonus_type and mark!='';

-- 内容结束

	-- Result
	IF pro_err != 0 THEN
			SET pro_result = CONCAT('Failed, error code is ',pro_code,', related message is ',pro_msg,'.');
			ROLLBACK;
			CALL pro_sql_log_insert('pro_bonus_calculation_glj',pro_result);
	ELSE
			SET pro_result = CONCAT("Succeeded");
			COMMIT;
	END IF;
	SELECT pro_err;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_bonus_calculation_xsj`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_bonus_calculation_xsj`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_bonus_calculation_xsj`(IN param_endtime datetime)
BEGIN
-- 销售奖计算
	-- Declare exception handler
	DECLARE pro_err TINYINT DEFAULT 0;  
	DECLARE pro_code CHAR(5) DEFAULT '00000';  
	DECLARE pro_msg TEXT; 
	DECLARE pro_result TEXT;
	DECLARE param_bonus_type int DEFAULT 1;--  奖金类型:0=推荐奖,1=销售奖,2=管理奖,3=重消奖   
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
	BEGIN  
		SET pro_err = 1;  
		GET DIAGNOSTICS CONDITION 1
			pro_code = RETURNED_SQLSTATE, pro_msg = MESSAGE_TEXT;  
	END;  
	-- 内容部分
	START TRANSACTION;-- 启动事物

	select @system_time:=system_time from trya_config_system_time where type='xsj_cal';-- 获取销售奖系统计算时间
	select @system_time_temp:=system_time from trya_config_system_time where type='xsj_cal_temp';-- 获取销售奖系统计算时间
	update trya_config_system_time set system_time=param_endtime,update_time=NOW() where type='xsj_cal_temp'; -- 更新销售奖计算临时时间
	
	-- 计算各个用户当天的业绩，计算业绩（=上一日剩余业绩+当日业绩）



update trya_finance_temp_personalperformance tp 
			LEFT JOIN (select * from trya_finance_history_personalperformance where accounting_time>=@system_time and type=1)as pp
			on tp.user_code=pp.user_code
			set tp.calculate_amount=IFNULL(pp.surplus_amount,0)+tp.now_day_amount;

	-- 建立业绩最小值表
	DROP TABLE IF EXISTS trya_temp_min;
	create temporary table trya_temp_min(
			id int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
			user_code  varchar(10) NOT NULL COMMENT '会员编号' ,
			min_amount  decimal(20,2) NOT NULL DEFAULT 0.00 COMMENT '最小业绩' ,
			accounting_time  datetime NOT NULL DEFAULT NOW() COMMENT '记账时间' ,
			mark  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注' ,
			PRIMARY KEY (id)
	);

	-- 获取各个子树的业绩最小值
	insert into trya_temp_min (user_code,min_amount)	
			select ad.manage_user_code,MIN(calculate_amount)
				from  trya_finance_temp_personalperformance pp 
				INNER JOIN trya_admin ad on pp.user_code=ad.user_code and ad.id!=1
				GROUP BY ad.manage_user_code;

	-- 如果只有一个区域则将小区业绩设置为0
	update trya_temp_min m set min_amount=0 
		where  user_code in 
		(select manage_user_code from trya_finance_temp_personalperformance GROUP BY manage_user_code HAVING COUNT(id) <=1);

	-- 更新业绩临时表当日剩余金额
	update trya_finance_temp_personalperformance pp
			LEFT JOIN trya_temp_min m on pp.manage_user_code=m.user_code
			set pp.surplus_amount=pp.calculate_amount-IFNULL(m.min_amount,0);

	-- 如果有则删除已有销售奖
	delete from trya_finance_bonustemp where bonus_type=param_bonus_type;
	-- 插入奖金临时表
	insert into trya_finance_bonustemp (user_code,bonus_type,plan_money,reality_money,entry_time)
			select a.user_code,param_bonus_type,least(p.param_value,IFNULL(m.min_amount,0))*p1.param_value,least(p.param_value,IFNULL(m.min_amount,0))*p1.param_value,NOW() 
				from trya_temp_min m 
				RIGHT JOIN (select * from trya_admin where ISNULL(delete_time) and id!=1) a on m.user_code=a.user_code
				INNER JOIN (select * from trya_finance_parameter where group_name='xsfd') p on a.grade_code=p.param_name
				INNER JOIN (select * from trya_finance_parameter where group_name='xsbl') p1 on a.grade_code=p1.param_name;



	-- 插入业绩表
-- 	insert into trya_finance_history_personalperformance(user_code,now_day_amount,calculate_amount,surplus_amount,cal_time,type) 
-- 		select user_code,now_day_amount,calculate_amount,surplus_amount,param_endtime,1 from trya_finance_temp_personalperformance;


	-- 删除临时表
	DROP TABLE trya_temp_min;

	-- Result
	IF pro_err != 0 THEN
			SET pro_result = CONCAT('Failed, error code is ',pro_code,', related message is ',pro_msg,'.');
			ROLLBACK;
			CALL pro_sql_log_insert('pro_bonus_calculation_xsj',pro_result);
	ELSE
			SET pro_result = CONCAT("Succeeded");  
			COMMIT;
	END IF;
	SELECT pro_err;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_bonus_cxj_getdate`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_bonus_cxj_getdate`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_bonus_cxj_getdate`(IN param_endtime datetime)
BEGIN
	-- 获取重消奖计算所需参数
	-- Declare exception handler
	DECLARE pro_err TINYINT DEFAULT 0;  
	DECLARE pro_code CHAR(5) DEFAULT '00000';  
	DECLARE pro_msg TEXT; 
	DECLARE pro_result TEXT;   
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
	BEGIN  
		SET pro_err = 1;  
		GET DIAGNOSTICS CONDITION 1
			pro_code = RETURNED_SQLSTATE, pro_msg = MESSAGE_TEXT;  
	END;  
	-- 内容部分
  
	select @system_time_cxj_cal :=system_time from trya_config_system_time where type='cxj_cal'; -- 销售奖计算时间
	update trya_config_system_time set system_time=param_endtime,update_time=NOW() where type='cxj_cal_temp'; -- 更新销售奖计算临时时间
	select a.user_code as user_code,a.manage_user_code as manage_user_code,SUM(IFNULL(po.order_total_price,0))as price from  
			(select * from trya_product_orderform where order_time>@system_time_cxj_cal and order_time<param_endtime and order_state!=5) as po 
			INNER JOIN trya_product_productinfo as pp on po.product_productinfo_id=pp.id and pp.product_type_id=2
			RIGHT JOIN trya_admin as a on a.user_code=po.order_user_code
			WHERE ISNULL(a.delete_time) and a.id!=1 -- 重复消费类
			GROUP BY a.user_code;
	-- 内容结束

	-- Result
	IF pro_err != 0 THEN
			SET pro_result = CONCAT('Failed, error code is ',pro_code,', related message is ',pro_msg,'.');
			ROLLBACK;
			CALL pro_sql_log_insert('pro_bonus_cxj_getadate',pro_result);
	ELSE
			SET pro_result = CONCAT("Succeeded");  
			COMMIT;
	END IF;
	SELECT pro_err;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_bonus_jdj_getdate`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_bonus_jdj_getdate`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_bonus_jdj_getdate`(IN param_endtime datetime)
BEGIN
	-- 获取见点奖计算所需参数
	-- Declare exception handler
	DECLARE pro_err TINYINT DEFAULT 0;  
	DECLARE pro_code CHAR(5) DEFAULT '00000';  
	DECLARE pro_msg TEXT; 
	DECLARE pro_result TEXT;   
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
	BEGIN  
		SET pro_err = 1;  
		GET DIAGNOSTICS CONDITION 1
			pro_code = RETURNED_SQLSTATE, pro_msg = MESSAGE_TEXT;  
	END;  
	-- 内容部分
  
	select @system_time_cxj_cal :=system_time from trya_config_system_time where type='jdj_cal'; -- 见点奖计算时间
	update trya_config_system_time set system_time=param_endtime,update_time=NOW() where type='jdj_cal_temp'; -- 更新见点奖计算临时时间
	
	select a.user_code as user_code,a.manage_user_code as manage_user_code,IFNULL(t.transaction_amount,0) as transaction_amount,IFNULL(t.counterparty,0) as  counterparty, p.param_value as jdjcj
		from  trya_finance_history_transactionalflow   t
		inner join trya_admin a on t.counterparty=a.user_code and a.id!=1
		inner join trya_finance_parameter p on p.param_name=a.grade_code and p.group_name='jdjcj'
    where ( business_code='hybd' or business_code='hysj' or business_code='ydsj') and trading_time>@system_time_cxj_cal and trading_time<param_endtime;


	-- 内容结束

	-- Result
	IF pro_err != 0 THEN
			SET pro_result = CONCAT('Failed, error code is ',pro_code,', related message is ',pro_msg,'.');
			ROLLBACK;
			CALL pro_sql_log_insert('pro_bonus_cxj_getadate',pro_result);
	ELSE
			SET pro_result = CONCAT("Succeeded");  
			COMMIT;
	END IF;
	SELECT pro_err;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_bonus_out`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_bonus_out`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_bonus_out`(in param_bonus_type int,IN param_operation_user_code varchar(10))
begin
	-- 奖金派发：param_bonus_type奖金类型 0推荐奖,1销售奖,2管理奖,3重消奖；param_operation_user_code：操作人员编号
	DECLARE pro_err TINYINT DEFAULT 0;  
	DECLARE pro_code CHAR(5) DEFAULT '00000';  
  DECLARE pro_err_name varchar(100) DEFAULT '';  
	DECLARE pro_msg TEXT; 
	DECLARE pro_result TEXT; 
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
	BEGIN  
			SET pro_err = 1;  
			GET DIAGNOSTICS CONDITION 1
				pro_code = RETURNED_SQLSTATE, pro_msg = MESSAGE_TEXT;  
	END;  
	
	
	start transaction;
	-- param_bonus_type:奖金类型0推荐奖,1销售奖,2管理奖,3重消奖,4服务奖，5管理奖 ，param_operation_user_code：操作人编号
	if param_bonus_type=0 THEN
			set @param_bonus_type_str='tjj';
	ELSEIF param_bonus_type=1 THEN
			set @param_bonus_type_str='xsj';
	ELSEIF param_bonus_type=2 THEN
			set @param_bonus_type_str='glj';
	ELSEIF param_bonus_type=3 THEN
			set @param_bonus_type_str='cxj';
	ELSEIF param_bonus_type=4 THEN
			set @param_bonus_type_str='fwj';
	ELSEIF param_bonus_type=5 THEN
			set @param_bonus_type_str='jdj';	
	end if;

	select @count:=COUNT(id)	from trya_finance_bonustemp where bonus_type=param_bonus_type;
if @count>0 THEN	
	
	-- 开始事务
	-- 获取管理费率
	select @jjglf:=param_value from trya_finance_parameter where group_name='glf' and param_name='jj';
	-- 获取积分转换率
	select @jfzhl:=param_value from trya_finance_parameter where group_name='jjzh' and param_name='jf';
	-- 获取奖金转换率
	set @jjzhl=1-@jjglf-@jfzhl;
	-- 更新公司推荐奖支出 借
	update trya_finance_companyaccount as ca 
		inner join trya_finance_accountingcode as a on a.account_number=ca.account_number
		set ca.balance=ca.balance-(select IFNULL(SUM(reality_money),0) from trya_finance_bonustemp where bonus_type=param_bonus_type)
		where a.accounting_code=CONCAT(@param_bonus_type_str,'zc');
	-- 公司管理费 贷
	update trya_finance_companyaccount as ca 
		inner join trya_finance_accountingcode as a on a.account_number=ca.account_number
		set ca.balance=ca.balance+(select IFNULL(SUM(reality_money),0)*@jjglf from trya_finance_bonustemp where bonus_type=param_bonus_type)
		where a.accounting_code='glfsr';
	
	-- 公司会员奖金币账户 贷
	update trya_finance_companyaccount as ca 
		inner join trya_finance_accountingcode as a on a.account_number=ca.account_number
		set ca.balance=ca.balance+(select IFNULL(SUM(reality_money),0)*@jjzhl from trya_finance_bonustemp where bonus_type=param_bonus_type)
		where a.accounting_code='hyjjb';

	-- 公司会员积分账户 贷
	update trya_finance_companyaccount as ca 
		inner join trya_finance_accountingcode as a on a.account_number=ca.account_number
		set ca.balance=ca.balance+(select IFNULL(SUM(reality_money),0)*@jfzhl from trya_finance_bonustemp where bonus_type=param_bonus_type)
		where a.accounting_code='hyjfb';

	-- 更新会员奖金，会员购物积分 贷
	update trya_finance_personalaccount as pa_bonus
			inner join  trya_finance_personalaccount as pa_shop on pa_bonus.user_code=pa_shop.user_code
			inner join trya_finance_bonustemp as bt on pa_bonus.user_code=bt.user_code 
		set pa_bonus.balance=pa_bonus.balance+@jjzhl*bt.reality_money,pa_shop.balance=pa_shop.balance+@jfzhl*bt.reality_money 
		where bt.bonus_type=param_bonus_type and pa_bonus.type=1 and pa_shop.type=2 ;

	-- 定义临时表，公司财务分录
	DROP TABLE IF EXISTS trya_temp_company;
	create temporary table trya_temp_company(
		`id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID' ,
		`transaction_date`  datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '交易日期' ,
		`serial_number`  varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流水号' ,
		`account_number`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账户号码' ,
		`account_name`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账户名称' ,
		`trade_direction`  int(11) NOT NULL COMMENT '交易方向:0=借方,1=贷方' ,
		`transaction_amount`  decimal(20,4) NOT NULL COMMENT '交易金额' ,
		`before_balance`  decimal(20,4) NOT NULL COMMENT '交易前余额' ,
		`after_balance`  decimal(20,4) NOT NULL COMMENT '交易后余额' ,
		`trading_time`  datetime NOT NULL COMMENT '交易时间' ,
		`time_stamp`  mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '时间戳' ,
		`mark`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注' ,
		PRIMARY KEY (`id`)
	);

	-- 个人帐户流水临时表
	DROP TABLE IF EXISTS `trya_temp_personalaccountflow`; 
	CREATE temporary TABLE `trya_temp_personalaccountflow` (
		`id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID' ,
		`serial_number`  varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流水号' ,
		`user_code`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '会员编号' ,
		`account_type`  int(11) NOT NULL COMMENT '账户种类:0=现金币,1=奖金币,2=购物积分币' ,
		`transaction_amount`  decimal(20,4) NOT NULL COMMENT '交易金额' ,
		`trade_direction`  int(11) NOT NULL COMMENT '交易方向:0=借方,1=贷方' ,
		`before_balance`  decimal(20,4) NOT NULL COMMENT '交易前余额' ,
		`after_balance`  decimal(20,4) NOT NULL COMMENT '交易后余额' ,
		`trading_time`  datetime NOT NULL COMMENT '交易时间' ,
		`time_stamp`  mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '时间戳' ,
		`mark`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注' ,
		PRIMARY KEY (`id`)
	);
	
	-- 业务流水临时表
	DROP TABLE IF EXISTS `trya_temp_transactionalflow`;
	CREATE temporary TABLE `trya_temp_transactionalflow` (
		`id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID' ,
		`serial_number`  varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流水号' ,
		`user_code`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '会员编号' ,
		`business_code`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所办业务编码' ,
		`transaction_amount`  decimal(20,4) NOT NULL COMMENT '交易金额' ,
		`trading_time`  datetime NOT NULL DEFAULT NOW() COMMENT '交易时间' ,
		`time_stamp`  mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '时间戳' ,
		`operation_user_code`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作人编号' ,
		`display_type` int not null COMMENT '显示类型，0：全显示，1：仅会员账户显示，2仅公司账户显示',
		`mark`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注' ,
		`sum_amount`  decimal(20,4) NOT NULL DEFAULT 0 COMMENT '总金额（计算使用）' ,
		PRIMARY KEY (`id`)
	);
	
	-- 插入用户奖金流水表
	insert into trya_temp_transactionalflow(serial_number,user_code,business_code,transaction_amount,operation_user_code,time_stamp,display_type,sum_amount)
		select uuid(),user_code,CONCAT('pf',@param_bonus_type_str),reality_money*(@jjzhl+@jfzhl),param_operation_user_code,unix_timestamp(now()),1,reality_money
			from trya_finance_bonustemp where bonus_type=param_bonus_type;

	-- 插入用户流水(奖金)
	set @param_account_type=1;-- 奖金
	insert into trya_temp_personalaccountflow 
		(serial_number,user_code,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp)
		select serial_number,pa.user_code,@param_account_type,tt.sum_amount*@jjzhl,1,pa.balance-tt.sum_amount*@jjzhl,pa.balance,tt.trading_time,tt.time_stamp
			from trya_temp_transactionalflow as tt
			INNER JOIN trya_finance_personalaccount as pa on tt.user_code=pa.user_code and pa.type=@param_account_type
			where tt.display_type=1;

	
	-- 插入用户流水(购物积分)
	set @param_account_type=2;-- 类型购物积分
	insert into trya_temp_personalaccountflow 
		(serial_number,user_code,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp)
		select serial_number,pa.user_code,@param_account_type,tt.sum_amount*@jfzhl,1,pa.balance-tt.sum_amount*@jfzhl,pa.balance,tt.trading_time,tt.time_stamp
			from trya_temp_transactionalflow as tt
			INNER JOIN trya_finance_personalaccount as pa on tt.user_code=pa.user_code and pa.type=@param_account_type
			where tt.display_type=1;

-- -----------------公司记录--------------------------

	-- 公司奖金流水号
	set @param_serial_number=uuid(); 
	
	-- 获取操作总金额
	select @sum_money:=SUM(reality_money)from trya_finance_bonustemp where bonus_type=param_bonus_type ;
	
	-- 插入公司奖金流水
	INSERT into trya_temp_transactionalflow(serial_number,user_code,business_code,transaction_amount,operation_user_code,time_stamp,display_type)
			select @param_serial_number,'','jjpf',SUM(reality_money),param_operation_user_code,unix_timestamp(now()),2
			from trya_finance_bonustemp where bonus_type=param_bonus_type;
	
-- 公司流水（奖金支出账户，借）	
	-- 获取公司奖金币账户，公司名称，操作后金额
	select @param_account_number:=ac.account_number,@param_account_name:=ac.account_name,@param_after_balance:=c.balance
		from trya_finance_accountingcode as ac 
		INNER JOIN trya_finance_companyaccount as c on ac.account_number=c.account_number  
		where accounting_code=CONCAT(@param_bonus_type_str,'zc');
	-- 更新
	INSERT INTO trya_temp_company (serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			VALUES(@param_serial_number ,@param_account_number ,@param_account_name,0 ,@sum_money ,@param_after_balance +@sum_money ,@param_after_balance,now(),unix_timestamp(now()));

-- 公司流水（管理费,贷）	
	-- 获取公司奖金币账户，公司名称，操作后金额
	select @param_account_number:=ac.account_number,@param_account_name:=ac.account_name,@param_after_balance:=c.balance
		from trya_finance_accountingcode as ac 
		INNER JOIN trya_finance_companyaccount as c on ac.account_number=c.account_number  
		where accounting_code='glfsr';
	-- 更新
	INSERT INTO trya_temp_company (serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			VALUES(@param_serial_number ,@param_account_number ,@param_account_name,1 ,@sum_money ,@param_after_balance -@sum_money*@jjglf ,@param_after_balance,now(),unix_timestamp(now()));


-- 公司流水（会员奖金币,贷）	
	-- 获取公司奖金币账户，公司名称，操作后金额
	select @param_account_number:=ac.account_number,@param_account_name:=ac.account_name,@param_after_balance:=c.balance
		from trya_finance_accountingcode as ac 
		INNER JOIN trya_finance_companyaccount as c on ac.account_number=c.account_number  
		where accounting_code='hyjjb';
	-- 更新
	INSERT INTO trya_temp_company (serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			VALUES(@param_serial_number ,@param_account_number ,@param_account_name,1 ,@sum_money ,@param_after_balance -@sum_money*@jjzhl ,@param_after_balance,now(),unix_timestamp(now()));

-- 公司流水（会员积分币,贷）	
	-- 获取公司奖金币账户，公司名称，操作后金额
	select @param_account_number:=ac.account_number,@param_account_name:=ac.account_name,@param_after_balance:=c.balance
		from trya_finance_accountingcode as ac 
		INNER JOIN trya_finance_companyaccount as c on ac.account_number=c.account_number  
		where accounting_code='hyjfb';
	-- 更新
	INSERT INTO trya_temp_company (serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			VALUES(@param_serial_number ,@param_account_number ,@param_account_name,1 ,@sum_money ,@param_after_balance -@sum_money*@jfzhl ,@param_after_balance,now(),unix_timestamp(now()));


-- 插入物理表	
	insert into trya_finance_history_transactionalflow (serial_number,user_code,business_code,transaction_amount,operation_user_code,time_stamp,display_type,trading_time)
			select serial_number,user_code,business_code,transaction_amount,operation_user_code,time_stamp,display_type,trading_time from trya_temp_transactionalflow;

	insert into trya_finance_history_accountentries (serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			select serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp from trya_temp_company;

	insert into trya_finance_history_personalaccountflow(serial_number,user_code,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp)
			select serial_number,user_code,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp from trya_temp_personalaccountflow;


-- 更新系统时间
	update trya_config_system_time  set system_time=NOW() where type=CONCAT(@param_bonus_type_str,'_out');
	select @param_system_time:=system_time from trya_config_system_time WHERE type=CONCAT(@param_bonus_type_str,'_cal_temp');
	update trya_config_system_time  set system_time=@param_system_time
			where type=CONCAT(@param_bonus_type_str,'_cal');

-- 奖金进入历史表
	insert into trya_finance_history_bonus (user_code,bonus_type,trade_direction,plan_money,reality_money,adjust_user_code,bookkeeping_user_code,entry_time,pf_bouns,pf_shopping,service_charge)
			select user_code,bonus_type,trade_direction,plan_money,reality_money,adjust_user_code,bookkeeping_user_code,entry_time,reality_money*@jjzhl,reality_money*@jfzhl,reality_money*@jjglf from  trya_finance_bonustemp where bonus_type=param_bonus_type; 
	delete from trya_finance_bonustemp where bonus_type=param_bonus_type; 
	IF param_bonus_type=5 THEN
		CALL pro_history_pigeonhole();	
	end if;

END if;

	-- Result
	IF pro_err != 0 THEN
      ROLLBACK;
			SET pro_result = CONCAT('Failed, error code is ',pro_code,', related message is ',pro_msg,'.');
			CALL pro_sql_log_insert(pro_err_name,pro_result);
	ELSE
			SET pro_result = CONCAT("Succeeded");  
			COMMIT;
	END IF;
-- 删除临时表
	DROP TABLE IF EXISTS trya_temp_company;
	DROP TABLE IF EXISTS trya_temp_transactionalflow;
	DROP TABLE IF EXISTS trya_temp_personalaccountflow;

	SELECT pro_err,pro_result,pro_msg;
 
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_deleteall`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_deleteall`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_deleteall`()
BEGIN
	


-- 清空用户日志
TRUNCATE TABLE trya_admin_log;

-- 清空权限
TRUNCATE TABLE trya_auth_group_access;
BEGIN
INSERT INTO `trya_auth_group_access` VALUES ('1', '1',1),('2', '2',2),('3', '5',3),('4', '6',4);
COMMIT;
end;

-- 清空提现申请
TRUNCATE TABLE trya_finance_application_cash;

-- 清空充值申请
TRUNCATE TABLE trya_finance_application_recharge;


-- 清空充值奖金临时表
TRUNCATE TABLE trya_finance_bonustemp;

-- 公司账户设置为0
update trya_finance_companyaccount set balance=0,last_day_balance=0;

-- 清空分录历史
TRUNCATE TABLE trya_finance_history_accountentries;


-- 清空奖金历史
TRUNCATE TABLE trya_finance_history_bonus;


-- 清空公司账户历史
TRUNCATE TABLE trya_finance_history_companyaccount;

-- 清空参数历史
TRUNCATE TABLE trya_finance_history_parameter;

-- 清空个人账户历史
TRUNCATE TABLE trya_finance_history_personalaccount;

-- 清空个人账户分录历史
TRUNCATE TABLE trya_finance_history_personalaccountflow;

-- 清空业绩历史
TRUNCATE TABLE trya_finance_history_personalperformance;

-- 清空流水
TRUNCATE TABLE trya_finance_history_transactionalflow;


-- 清空用户账户
TRUNCATE TABLE trya_finance_personalaccount;

-- 清空管理费临时表
TRUNCATE TABLE trya_finance_temp_bonus_glf;

-- 清空消息
TRUNCATE TABLE trya_message_leave;

-- 清空留言
TRUNCATE TABLE trya_message_notice;

-- 清空订单
TRUNCATE TABLE trya_product_orderform;



-- 清空用户

TRUNCATE table trya_admin;

INSERT INTO `trya_admin` VALUES ('1', '1234567', '开发管理员', 'c8bd912b78b5aca03b13fad1ad75a0d3', 'hczM6H', '/assets/img/avatar.png', '0', '0', '1524740059', '1524740059', '', 'normal', '0.0000', '1000000', '1000000', '1000000', '0.0000', '1000000', 'A', 'lv4', '513b349472055e49e57dd6664ec38b15', 'C5JU7i', '123456', null, null, null, '12345678912', '0.0000', null, null, null);
INSERT INTO `trya_admin` VALUES ('2', '0000001', '公司管理员', 'c8bd912b78b5aca03b13fad1ad75a0d3', 'hczM6H', '/assets/img/avatar.png', '0', '0', '1524740059', '1524740059', '', 'normal', '0.0000', '1234567', '1234567', '1234567', '0.0000', '1234567', 'A', 'lv4', '513b349472055e49e57dd6664ec38b15', 'C5JU7i', '123456', null, null, null, '12345678912', '0.0000', null, null, null);
INSERT INTO `trya_admin` VALUES ('3', '0000002', '公司会计账户', 'c8bd912b78b5aca03b13fad1ad75a0d3', 'hczM6H', '/assets/img/avatar.png', '0', '0', '1524740059', '1524740059', '', 'normal', '0.0000', '1234567', '1234567', '1234567', '0.0000', '1234567', 'A', 'lv4', '513b349472055e49e57dd6664ec38b15', 'C5JU7i', '123456', null, null, null, '12345678912', '0.0000', null, null, null);
INSERT INTO `trya_admin` VALUES ('4', '0000003', '公司物流账户', 'c8bd912b78b5aca03b13fad1ad75a0d3', 'hczM6H', '/assets/img/avatar.png', '0', '0', '1524740059', '1524740059', '', 'normal', '0.0000', '1234567', '1234567', '1234567', '0.0000', '1234567', 'A', 'lv4', '513b349472055e49e57dd6664ec38b15', 'C5JU7i', '123456', null, null, null, '12345678912', '0.0000', null, null, null);


COMMIT;


END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_bonus_cxj`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_bonus_cxj`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_bonus_cxj`(IN param_serial_number varchar(36),IN param_user_code varchar(10), IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
    DETERMINISTIC
BEGIN
	-- 重消奖发放操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
-- 内容部分
		
	-- 获取操作前公司现金付款帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='csjzc';
	
	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='csjzc';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='csjzc';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;
-- 内容结束

  -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));

	-- 判断是否是只执行了一条数据
	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_bonus_glf`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_bonus_glf`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_bonus_glf`(IN param_serial_number varchar(36),IN param_user_code varchar(10),  IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
	-- 奖金发放管理费操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
	-- 内容部分

	-- 获取管理费率
	select @jjglf:=param_value from trya_finance_parameter where group_name='glf' and param_name='jj';

	-- 获取操作前公司现金付款帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='glfsr';

	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount*@jjglf
			where a.accounting_code='glfsr';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount*@jjglf;
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount*@jjglf
			where a.accounting_code='glfsr';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount*@jjglf;
	END if;
-- 内容结束

  -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount*@jjglf,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));

	-- 判断是否是只执行了一条数据
	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_bonus_glj`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_bonus_glj`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_bonus_glj`(IN param_serial_number varchar(36),IN param_user_code varchar(10),  IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
	-- 管理奖发放操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
-- 内容部分
		
	-- 获取操作前公司现金付款帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='gljzc';
	
	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='gljzc';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='gljzc';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;
-- 内容结束

  -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));

	-- 判断是否是只执行了一条数据
	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_bonus_tjj`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_bonus_tjj`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_bonus_tjj`(IN param_serial_number varchar(36),IN param_user_code varchar(10),  IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
	-- 推荐奖发放操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
-- 内容部分
		
	-- 获取操作前公司现金付款帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='tjjzc';
	
	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='tjjzc';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='tjjzc';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;
-- 内容结束

  -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));

	-- 判断是否是只执行了一条数据
	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_bonus_xsj`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_bonus_xsj`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_bonus_xsj`(IN param_serial_number varchar(36),IN param_user_code varchar(10), IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
	-- 销售奖发放操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
-- 内容部分
		
	-- 获取操作前公司现金付款帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='xsjzc';
	
	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='xsjzc';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='xsjzc';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;
-- 内容结束

  -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));

	-- 判断是否是只执行了一条数据
	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_declaration`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_declaration`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_declaration`(IN param_serial_number varchar(36),IN param_user_code varchar(10),  IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction varchar(20), OUT param_result int)
BEGIN
	-- 报单费操作，参数：param_serial_number:流水号 param_user_code会员编号，param_transaction_amount交易金额，param_trade_direction交易方向，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare rate decimal(20,4) DEFAULT 0;-- 提现费率
-- 	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
-- 内容部分
		
	-- 获取操作前公司报单费支出帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='bdfzc';


	-- 获取报单费率
	select param_value into rate from trya_finance_parameter where group_name='bdfl' and param_name='bdfl';
	
	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount*rate
			where a.accounting_code='bdfzc';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount*rate;
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount*rate
			where a.accounting_code='bdfzc';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount*rate;
	END if;
-- 内容结束

  -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount*rate,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));

	-- 判断是否是只执行了一条数据
	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_incash`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_incash`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_incash`(IN param_serial_number varchar(36),IN param_user_code varchar(10),  IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
-- 公司现金收款帐户操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
-- 内容部分
	
	-- 获取操作前公司现金收款帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='xjsk';
	
	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='xjsk';
		-- 获取操作后公司现金收款帐户信息
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='xjsk';
		-- 获取操作后公司现金收款帐户信息
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;

  -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp,mark)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()),'现金收款');


-- 内容结束


	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_jftc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_jftc`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_jftc`(IN param_serial_number varchar(36),IN param_user_code varchar(10),  IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
-- 公司现金金兑换头寸帐户操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
-- 内容部分
	
	-- 获取操作前公司现金收款帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='jfdhtc';
	
	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='jfdhtc';
		-- 获取操作后公司现金收款帐户信息
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='jfdhtc';
		-- 获取操作后公司现金收款帐户信息
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;

  -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));


-- 内容结束


	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_jjtc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_jjtc`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_jjtc`(IN param_serial_number varchar(36),IN param_user_code varchar(10), IN param_counterparty varchar(100), IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
-- 公司奖金兑换头寸帐户操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
-- 内容部分
	
	-- 获取操作前公司现金收款帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='jjdhtc';
	
	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='jjdhtc';
		-- 获取操作后公司现金收款帐户信息
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='jjdhtc';
		-- 获取操作后公司现金收款帐户信息
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;

  -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));


-- 内容结束


	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_outcash`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_outcash`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_outcash`(IN param_serial_number varchar(36),IN param_user_code varchar(10),  IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
-- (提现时)公司现金付款帐户操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
-- 内容部分
		
	-- 获取操作前公司现金付款帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='xjfk';

	-- 获取提现费率
	select @rate:=param_value  from trya_finance_parameter where group_name='txsxf' and param_name='jj';
	set @rate=1-@rate;
	
	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=convert(c.balance-param_transaction_amount*@rate,decimal)
			where a.accounting_code='xjfk';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=convert(@param_company_before_balance-param_transaction_amount*@rate,decimal);
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=convert(c.balance+param_transaction_amount*@rate,decimal)
			where a.accounting_code='xjfk';
		-- 获取操作后公司现金付款帐户信息
		set @param_company_after_balance=convert(@param_company_before_balance+param_transaction_amount*@rate,decimal);
	END if;
-- 内容结束

  -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,convert(param_transaction_amount*@rate,decimal),@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));

	-- 判断是否是只执行了一条数据
	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_poundage`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_poundage`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_poundage`(IN param_serial_number varchar(36),IN param_user_code varchar(10), IN param_counterparty varchar(100), IN param_transaction_amount decimal(20,2), IN param_type varchar(20), OUT param_result int)
BEGIN
-- 提现手续费操作，参数：param_user_code操作会员编号，param_transaction_amount交易金额，param_trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare param_trade_direction int DEFAULT 0;-- 交易方向借方
	declare rate decimal(20,4) DEFAULT 0;-- 提现费率

	declare CONTINUE handler for  sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
	-- 内容开始
	
	-- 获取操作前公司体现手续费账户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='txsxfsr';

	select @param_company_before_balance;

	-- 获取提现费率
	select param_value into rate from trya_finance_parameter where group_name='txsxf' and param_name='jj';
	
	UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance= convert(c.balance+param_transaction_amount*rate,decimal)
			where a.accounting_code='txsxfsr';-- 提现手续费收入
	-- 获取操作后公司账户奖金币
	set @param_company_after_balance=convert(@param_company_before_balance+param_transaction_amount*rate,decimal);
	
	-- 公司账户为贷/加
	set param_trade_direction=1;
	-- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,convert(param_transaction_amount*rate,decimal),@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));


	-- 内容结束
	if _err=1 then 
		-- 有错
        set param_result=1;  
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_takedelivery_register`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_takedelivery_register`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_takedelivery_register`(IN param_serial_number varchar(36),IN param_user_code varchar(10),  IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
-- 注册类提货收入操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
	-- 内容开始
	-- 获取操作前公司注册类提货收入帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='thxssr';

	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='thxssr';-- 提货销售收入
		-- 获取操作后公司注册类提货收入帐户信息
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='thxssr';-- 提货销售收入
		-- 获取操作后公司注册类提货收入帐户信息
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;
	 -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));


	-- 内容结束
	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_takedelivery_repeat`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_takedelivery_repeat`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_takedelivery_repeat`(IN param_serial_number varchar(36),IN param_user_code varchar(10),  IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
-- 重复消费类提货收入操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
	-- 内容开始
	
	-- 获取操作前公司重复消费类提货收入帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='cxxssr';
	
	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='cxxssr';-- 重消销售收入
		-- 获取操作后公司重复消费类提货收入帐户信息
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='cxxssr';-- 重消销售收入
		-- 获取操作后公司重复消费类提货收入帐户信息
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;
	 -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));
	
	-- 内容结束
	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_company_xjtc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_company_xjtc`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_company_xjtc`(IN param_serial_number varchar(36),IN param_user_code varchar(10),IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
-- 公司现金金兑换头寸帐户操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
-- 内容部分
	
	-- 获取操作前公司现金收款帐户信息
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='xjdhtc';
	
	if param_trade_direction=0 THEN
		-- 借/减
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='xjdhtc';
		-- 获取操作后公司现金收款帐户信息
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='xjdhtc';
		-- 获取操作后公司现金收款帐户信息
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;

  -- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));


-- 内容结束


	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_engine`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_engine`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_engine`(IN param_business_code varchar(20),IN param_user_code varchar(10), IN param_counterparty varchar(100), IN param_transaction_amount decimal(20,2),IN param_operation_user_code varchar(10))
BEGIN  -- 运算引擎，参数：param_business_code执行的业务模块名称，param_user_code交易用户编号，param_counterparty交易对手，param_transaction_amount交易金额，param_operation_user_code操作人编号

	-- Declare exception handler
	DECLARE pro_err TINYINT DEFAULT 0;  
	DECLARE pro_code CHAR(5) DEFAULT '00000';  
	DECLARE pro_err_name varchar(100) DEFAULT '';  
	DECLARE pro_msg TEXT; 
	DECLARE pro_result TEXT;   
	DECLARE param_serial_number varchar(36); 
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
	BEGIN  
		SET pro_err = 1;  
		GET DIAGNOSTICS CONDITION 1
			pro_code = RETURNED_SQLSTATE, pro_msg = MESSAGE_TEXT;  
	END;  
	
	-- 定义临时表，存储业务的配置参数，即业务需要执行哪些存储过程
	DROP TABLE IF EXISTS trya_temp_engin;
	create temporary table trya_temp_engin(
		id int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
		pro_name VARCHAR(100) not null,
		additional_param varchar(255),
		PRIMARY KEY (id)
	);

	-- 获取需要执行的存储过程，并根据权重排序
	insert into trya_temp_engin (pro_name,additional_param)
		select pro_name,additional_param from `trya_finance_businessconfig` 
		where business_code=param_business_code and isdelete=FALSE order by weight desc;
	select @title_count:=COUNT(id) from trya_temp_engin;
	
	-- 开始事务
	start transaction;
		-- 生成流水号
		set param_serial_number=uuid();
		-- 插入业务流水
		insert into trya_finance_history_transactionalflow 
				(user_code,counterparty,serial_number,transaction_amount,business_code,trading_time,time_stamp,operation_user_code)VALUES
				(param_user_code,param_counterparty,param_serial_number,param_transaction_amount ,param_business_code,NOW(),unix_timestamp(now()),param_operation_user_code);
		-- 逐条开始计算
		set @i=1;
		while @i<=@title_count do -- 循环，逐条执行存储过程0为正确，1为错误		
			select @pro_name:=pro_name,@additional_param:=additional_param from trya_temp_engin where id=@i;
			-- 判断是否存在附加参数
			set @sql_str='';
			if  ISNULL(@additional_param) || LENGTH(trim(@additional_param))<1  THEN
				set @sql_str=concat('call ',@pro_name,'("',param_serial_number,'","',param_user_code,'","',param_counterparty,'",',param_transaction_amount,',@res);'); -- 拼接需要执行的存储过程
			else
				set @sql_str=concat('call ',@pro_name,'("',param_serial_number,'","',param_user_code,'","',param_counterparty,'",',param_transaction_amount,',',@additional_param,',@res);'); -- 拼接需要执行的存储过程
			end if;
			select @sql_str;
			prepare stmt from @sql_str; 
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;  

			if @res!=0 then -- 该步错误
				set @i=@title_count+1;
				set pro_err=1;
				set pro_msg=@sql_str;
				set pro_err_name=@pro_name;
			else
				set @i=@i+1;
			end if;
		end while;

	-- Result
	IF pro_err != 0 THEN
      ROLLBACK;
			SET pro_result = CONCAT('Failed, error code is ',pro_code,', related message is ',pro_msg,'.');
			
			CALL pro_sql_log_insert(pro_err_name,pro_result);
	ELSE
			SET pro_result = CONCAT("Succeeded");  
			COMMIT;
	END IF;
	SELECT pro_err,pro_result,pro_msg;

	DROP TABLE IF EXISTS trya_temp_engin; -- 最后清除临时表

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_member_baodan`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_member_baodan`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_member_baodan`(IN param_serial_number varchar(36),IN param_user_code varchar(10), IN param_counterparty varchar(100), IN param_transaction_amount decimal(20,2), OUT param_result int)
BEGIN
	-- 会员转账 参数：param_serial_number流水号，param_user_code操作会员编号，param_counterpart交易对手，param_transaction_amount交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	DECLARE pro_err TINYINT DEFAULT 0;  
	DECLARE pro_code CHAR(5) DEFAULT '00000';  
  DECLARE pro_err_name varchar(100) DEFAULT '';  
	DECLARE pro_msg TEXT; 
	DECLARE pro_result TEXT;   
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
 	BEGIN  
 		SET pro_err = 1;  
 		GET DIAGNOSTICS CONDITION 1
 			pro_code = RETURNED_SQLSTATE, pro_msg = MESSAGE_TEXT;  
 	END;

	set param_result=0;
	-- 查询两个会员的余额并进行计算
	select @user_before_balance:=balance from trya_finance_personalaccount where user_code=param_user_code and type=0;
	UPDATE trya_finance_personalaccount as p
			set p.balance=@user_before_balance-param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_user_code and p.type=0;
	UPDATE trya_finance_personalaccount as p
			set p.balance=param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_counterparty and p.type=3;
	set @user_after_balance:=@user_before_balance-param_transaction_amount;
	-- 插入个人流水
	-- 转出方
	insert into trya_finance_history_personalaccountflow
				(serial_number,user_code,counterparty,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp,mark)
				values(param_serial_number,param_user_code,param_counterparty,0,param_transaction_amount,0,@user_before_balance,@user_after_balance,NOW(),unix_timestamp(now()),'注册报单费用');
	-- 转入方
	insert into trya_finance_history_personalaccountflow
				(serial_number,user_code,counterparty,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp,mark)
				values(param_serial_number,param_counterparty,param_user_code,3,param_transaction_amount,1,0,param_transaction_amount,NOW(),unix_timestamp(now()),'注册用户');
	

-- Result
	IF pro_err != 0 THEN
       set param_result=1;
	   select pro_msg;
	END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_member_bonus`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_member_bonus`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_member_bonus`(IN param_serial_number varchar(36),IN param_user_code varchar(10), IN param_counterparty varchar(100), IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
-- 会员奖金操作，参数：param_serial_number流水号，param_user_code操作会员编号，param_counterpart交易对手，param_transaction_amount交易金额，param_trade_direction交易方向，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
	-- 内容开始

	-- 获取操作前会员奖金余额
	select @param_person_before_balance:=balance from trya_finance_personalaccount where user_code=param_user_code and type=1;
	-- 获取操作前公司账户会员奖金
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='hyjjb';

	if param_trade_direction=0 THEN
		-- 借/减
		-- 更新会员账户奖金币
		UPDATE trya_finance_personalaccount as p 
			set p.balance=p.balance-param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_user_code and p.type=1;
		-- 更新公司账户奖金币
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='hyjjb';
		-- 获取操作后会员奖金币余额
		set @param_person_after_balance=@param_person_before_balance-param_transaction_amount;
		-- 获取操作后公司账户奖金币
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		-- 更新会员账户奖金币
		UPDATE trya_finance_personalaccount as p 
			set p.balance=p.balance+param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_user_code and p.type=1;
		-- 更新公司账户奖金币
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='hyjjb';
		-- 获取操作后会员奖金币余额
		set @param_person_after_balance=@param_person_before_balance+param_transaction_amount;
		-- 获取操作后公司账户奖金币
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;
	-- 记录会员账户流水
	insert into trya_finance_history_personalaccountflow
			(serial_number,user_code,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,param_user_code,1,param_transaction_amount,param_trade_direction,@param_person_before_balance,@param_person_after_balance,NOW(),unix_timestamp(now()));
	
	-- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));

	
	-- 内容结束
	if _err=1 then
		-- 有错
        set param_result=1; 
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_member_bonusout_shopping`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_member_bonusout_shopping`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_member_bonusout_shopping`(IN param_serial_number varchar(36),IN param_user_code varchar(10), IN param_counterparty varchar(100), IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
begin
	-- （奖金发放）会员购物积分操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;	
	set param_result=0;
	-- 内容开始
	
	-- 获取操作前会员购物积分余额
	select @param_person_before_balance:=balance from trya_finance_personalaccount where user_code=param_user_code and type=2;
	-- 获取操作前公司账户会员积分
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='hyjfb';

	if param_trade_direction=0 THEN
		-- 借/减
		-- 更新会员账户积分
		UPDATE trya_finance_personalaccount as p 
			set p.balance=p.balance-param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_user_code and p.type=2;
		-- 更新公司会员积分账户
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='hyjfb';
		-- 获取操作后会员购物积分余额
		set @param_person_after_balance=@param_person_before_balance-param_transaction_amount;
		-- 获取操作后公司账户积分
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		-- 更新会员账户积分
		UPDATE trya_finance_personalaccount as p 
			set p.balance=p.balance+param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_user_code and p.type=2;
		-- 更新公司会员积分账户
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='hyjfb';
		-- 获取操作后会员购物积分余额
		set @param_person_after_balance=@param_person_before_balance+param_transaction_amount;
		-- 获取操作后公司账户积分
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;

	-- 记录会员账户流水
	insert into trya_finance_history_personalaccountflow
			(serial_number,user_code,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,param_user_code,2,param_transaction_amount,param_trade_direction,@param_person_before_balance,@param_person_after_balance,NOW(),unix_timestamp(now()));
	
	-- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));

	-- 内容结束
	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_member_cash`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_member_cash`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_member_cash`(IN param_serial_number varchar(36),IN param_user_code varchar(10),  IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
	-- 会员现金币操作，参数：user_code操作会员编号，transaction_amount交易金额，trade_direction交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
  declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
	-- 内容开始


	
	-- 获取操作前会员现金币余额
	select @param_person_before_balance:=balance from trya_finance_personalaccount where user_code=param_user_code and type=0;
	-- 获取操作前公司账户会员现金币
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='hyxjb';

	if param_trade_direction=0 THEN
		-- 借/减
		-- 更新会员账户现金币
		UPDATE trya_finance_personalaccount as p 
			set p.balance=p.balance-param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_user_code and p.type=0;
		-- 更新公司会员现金币账户
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='hyxjb';
		-- 获取操作后会员现金币余额
		set @param_person_after_balance=@param_person_before_balance-param_transaction_amount;
		-- 获取操作后公司账户现金币
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		-- 更新会员账户现金币
		UPDATE trya_finance_personalaccount as p 
			set p.balance=p.balance+param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_user_code and p.type=0;
		-- 更新公司会员现金币账户
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='hyxjb';
		-- 获取操作后会员现金币余额
		set @param_person_after_balance=@param_person_before_balance+param_transaction_amount;
		-- 获取操作后公司账户现金币
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;
	
	-- 记录会员账户流水
	insert into trya_finance_history_personalaccountflow
			(serial_number,user_code,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,param_user_code,0,param_transaction_amount,param_trade_direction,@param_person_before_balance,@param_person_after_balance,NOW(),unix_timestamp(now()));
	
	-- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));

	-- 内容结束
	if _err=1 then
		-- 有错
        set param_result=1;  
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_member_registered_integral`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_member_registered_integral`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_member_registered_integral`(IN param_serial_number varchar(36),IN param_user_code varchar(10), IN param_counterparty varchar(100), IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
-- 会员注册积分操作，参数：param_user_code操作会员编号，param_trade_direction交易金额，param_transaction_amount交易金额，param_trade_direction交易方向，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
	-- 内容开始

	-- 获取操作前会员奖金余额
	select @param_person_before_balance:=balance from trya_finance_personalaccount where user_code=param_user_code and type=3;
	-- 获取操作前公司账户会员奖金
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='hyxjb';

	if param_trade_direction=0 THEN
		-- 借/减
		-- 更新会员账户奖金币
		UPDATE trya_finance_personalaccount as p 
			set p.balance=p.balance-param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_user_code and p.type=3;
		-- 更新公司账户奖金币
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='hyxjb';
		-- 获取操作后会员奖金币余额
		set @param_person_after_balance=@param_person_before_balance-param_transaction_amount;
		-- 获取操作后公司账户奖金币
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		-- 更新会员账户奖金币
		UPDATE trya_finance_personalaccount as p 
			set p.balance=p.balance+param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_user_code and p.type=3;
		-- 更新公司账户奖金币
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='hyxjb';
		-- 获取操作后会员奖金币余额
		set @param_person_after_balance=@param_person_before_balance+param_transaction_amount;
		-- 获取操作后公司账户奖金币
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;
	-- 记录会员账户流水
	insert into trya_finance_history_personalaccountflow
			(serial_number,user_code,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,param_user_code,3,param_transaction_amount,param_trade_direction,@param_person_before_balance,@param_person_after_balance,NOW(),unix_timestamp(now()));
	
	-- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));

	
	-- 内容结束
	if _err=1 then
		-- 有错
        set param_result=1; 
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_member_shopping`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_member_shopping`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_member_shopping`(IN param_serial_number varchar(36),IN param_user_code varchar(10),IN param_counterparty varchar(100),IN param_transaction_amount decimal(20,2), IN param_trade_direction int, OUT param_result int)
BEGIN
-- 会员购物积分操作，参数：param_user_code操作会员编号，param_trade_direction交易金额，param_transaction_amount交易金额，param_trade_direction交易方向，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	declare CONTINUE handler for sqlexception, sqlwarning, not found set _err=1;
	set param_result=0;
	-- 内容开始

	-- 获取操作前会员购物积分余额
	select @param_person_before_balance:=balance from trya_finance_personalaccount where user_code=param_user_code and type=1;
	-- 获取操作前公司账户会员购物积分
	SELECT @param_company_before_balance:=c.balance,@param_account_number:=c.account_number,@param_account_name:=c.account_name
			from trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			where a.accounting_code='hyjfb';

	if param_trade_direction=0 THEN
		-- 借/减
		-- 更新会员账户购物积分币
		UPDATE trya_finance_personalaccount as p
			set p.balance=p.balance-param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_user_code and p.type=2;
		-- 更新公司账户购物积分币
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance-param_transaction_amount
			where a.accounting_code='hyjfb';
		-- 获取操作后会员购物积分余额
		set @param_person_after_balance=@param_person_before_balance-param_transaction_amount;
		-- 获取操作后公司会员购物积分
		set @param_company_after_balance=@param_company_before_balance-param_transaction_amount;
	ELSE 
		-- 贷/加
		-- 更新会员账户购物积分币
		UPDATE trya_finance_personalaccount as p 
			set p.balance=p.balance+param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_user_code and p.type=2;
		-- 更新公司账户购物积分币
		UPDATE  trya_finance_companyaccount as c 
			INNER JOIN trya_finance_accountingcode as a on c.account_number=a.account_number
			set c.balance=c.balance+param_transaction_amount
			where a.accounting_code='hyjfb';
		-- 获取操作后会员购物积分余额
		set @param_person_after_balance=@param_person_before_balance+param_transaction_amount;
		-- 获取操作后公司账户购物积分币
		set @param_company_after_balance=@param_company_before_balance+param_transaction_amount;
	END if;
	-- 记录会员账户流水
	insert into trya_finance_history_personalaccountflow
			(serial_number,user_code,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,param_user_code,2,param_transaction_amount,param_trade_direction,@param_person_before_balance,@param_person_after_balance,NOW(),unix_timestamp(now()));
	
	-- 记录公司账户流水
	insert into trya_finance_history_accountentries
			(serial_number,account_number,account_name,trade_direction,transaction_amount,before_balance,after_balance,trading_time,time_stamp)
			values(param_serial_number,@param_account_number,@param_account_name,param_trade_direction ,param_transaction_amount,@param_company_before_balance,@param_company_after_balance,NOW(),unix_timestamp(now()));

	
	-- 内容结束
	if _err=1 then
		-- 有错
        set param_result=1; 
    end if; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_member_transaction`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_member_transaction`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_finance_member_transaction`(IN param_serial_number varchar(36),IN param_user_code varchar(10), IN param_counterparty varchar(100), IN param_transaction_amount decimal(20,2), OUT param_result int)
BEGIN
	-- 会员注册报单 参数：param_serial_number流水号，param_user_code操作会员编号，param_counterpart交易对手，param_transaction_amount交易金额，result返回值0为正确，1为错误
	declare _err int DEFAULT 0;
	DECLARE pro_err TINYINT DEFAULT 0;  
	DECLARE pro_code CHAR(5) DEFAULT '00000';  
  DECLARE pro_err_name varchar(100) DEFAULT '';  
	DECLARE pro_msg TEXT; 
	DECLARE pro_result TEXT;   
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
 	BEGIN  
 		SET pro_err = 1;  
 		GET DIAGNOSTICS CONDITION 1
 			pro_code = RETURNED_SQLSTATE, pro_msg = MESSAGE_TEXT;  
 	END;

	set param_result=0;
	-- 查询两个会员的余额并进行计算
	select @user_before_balance:=balance from trya_finance_personalaccount where user_code=param_user_code and type=0;
	select @member_before_balance:=balance from trya_finance_personalaccount where user_code=param_counterparty and type=0;
	-- 服务中心
	UPDATE trya_finance_personalaccount as p
			set p.balance=@user_before_balance-param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_user_code and p.type=0;
	-- 新注册会员
	UPDATE trya_finance_personalaccount as p
			set p.balance=@member_before_balance+param_transaction_amount,p.update_time= unix_timestamp(now()) 
			where p.user_code=param_counterparty and p.type=0;
	set @user_after_balance:=@user_before_balance-param_transaction_amount;
	set @member_after_balance:=@member_before_balance+param_transaction_amount;
	-- 插入个人流水
	-- 服务中心
	insert into trya_finance_history_personalaccountflow
				(serial_number,user_code,counterparty,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp)
				values(param_serial_number,param_user_code,param_counterparty,0,param_transaction_amount,0,@user_before_balance,@user_after_balance,NOW(),unix_timestamp(now()));
	-- 新注册会员
	insert into trya_finance_history_personalaccountflow
				(serial_number,user_code,counterparty,account_type,transaction_amount,trade_direction,before_balance,after_balance,trading_time,time_stamp)
				values(param_serial_number,param_counterparty,param_user_code,0,param_transaction_amount,1,@member_before_balance,@member_after_balance,NOW(),unix_timestamp(now()));
	

-- Result
	IF pro_err != 0 THEN
       set param_result=1;
	   select pro_msg;
	END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_finance_personal_change`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_finance_personal_change`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pro_finance_personal_change`(IN `param_user_code` varchar(10),IN `param_transaction_amount`  decimal(20,2),IN `param_change_type` int(4),IN `param_operation_user_code` varchar(10))
BEGIN
	-- mywallt各币种之间转换
	declare _err int DEFAULT 0;
	DECLARE param_serial_number varchar(36);
	DECLARE param_business_code varchar(36); 
	DECLARE pro_err TINYINT DEFAULT 0;  
	DECLARE pro_code CHAR(5) DEFAULT '00000';  
  DECLARE pro_err_name varchar(100) DEFAULT '';  
	DECLARE pro_msg TEXT; 
	DECLARE pro_result TEXT;   
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
 	BEGIN  
 		SET pro_err = 1;  
 		GET DIAGNOSTICS CONDITION 1
 			pro_code = RETURNED_SQLSTATE, pro_msg = MESSAGE_TEXT;  
 	END;  
	-- 判断转换类型并改变personalaccount
	-- 开始事务
	start transaction;


	-- 生成流水号
	set param_serial_number=uuid();


	-- 第一种：现金币兑换购物积分
	if param_change_type=0 THEN
		set param_business_code='xj2jf';
		-- 获取汇率
		select @rate:=param_value from trya_finance_parameter where group_name='hbzh' and param_name='xj2jf';

		-- 借  会员现金币
		call pro_finance_member_cash(param_serial_number,param_user_code,param_user_code,param_transaction_amount,0,@res1);
		-- 贷  现金币兑换头寸
		call pro_finance_company_xjtc(param_serial_number,param_user_code,param_user_code,param_transaction_amount,1,@res2);
		-- 借  购物积分兑换头寸
		call pro_finance_company_jftc(param_serial_number,param_user_code,param_user_code,param_transaction_amount*@rate,0,@res3);
		-- 贷  会员购物积分
		call pro_finance_member_shopping(param_serial_number,param_user_code,param_user_code,param_transaction_amount*@rate,1,@res4);
  END IF;

	-- 第二种：奖金兑换购物积分
	if param_change_type=1 THEN
		set param_business_code='jj2jf';
		-- 获取汇率
		select @rate:=param_value from trya_finance_parameter where group_name='hbzh' and param_name='jj2jf';
		
		-- 借  会员奖金
		call pro_finance_member_bonus(param_serial_number,param_user_code,param_user_code,param_transaction_amount,0,@res1);
		
		-- 贷  奖金兑换头寸
		call pro_finance_company_jjtc(param_serial_number,param_user_code,param_user_code,param_transaction_amount,1,@res2);
		-- 借  购物积分兑换头寸
		call pro_finance_company_jftc(param_serial_number,param_user_code,param_user_code,param_transaction_amount*@rate,0,@res3);
		-- 贷  会员购物积分
		call pro_finance_member_shopping(param_serial_number,param_user_code,param_user_code,param_transaction_amount*@rate,1,@res4);

  END IF; 
	-- 第三种：奖金兑换现金
	if param_change_type=2 THEN	
		set param_business_code='jj2xj';
		-- 获取汇率
		select @rate:=param_value from trya_finance_parameter where group_name='hbzh' and param_name='jj2xj';
		-- 借  会员奖金
		call pro_finance_member_bonus(param_serial_number,param_user_code,param_user_code,param_transaction_amount,0,@res1);
		-- 贷  奖金兑换头寸
		call pro_finance_company_jjtc(param_serial_number,param_user_code,param_user_code,param_transaction_amount,1,@res2);
		-- 借  现金币兑换头寸
		call pro_finance_company_xjtc(param_serial_number,param_user_code,param_user_code,param_transaction_amount*@rate,0,@res3);
		-- 贷  会员现金币
		call pro_finance_member_cash(param_serial_number,param_user_code,param_user_code,param_transaction_amount*@rate,1,@res4);
  END IF;
	
	
	-- 插入业务流水
	insert into trya_finance_history_transactionalflow 
		(user_code,serial_number,transaction_amount,business_code,trading_time,time_stamp,operation_user_code)VALUES
		(param_user_code,param_serial_number,param_transaction_amount ,param_business_code,NOW(),unix_timestamp(now()),param_operation_user_code);
	if (!(@res1=0 and @res2=0 and @res3=0 and @res4=0)) then 
		set pro_msg='会员货币转换错误';
		set pro_err=1;
	end if;
	select @res1,@res2,@res3,@res4;
-- Result
	IF pro_err != 0 THEN
      ROLLBACK;
			SET pro_result = CONCAT('Failed, error code is ',pro_code,', related message is ',pro_msg,'.');
			
			CALL pro_sql_log_insert(pro_err_name,pro_result);
	ELSE
			SET pro_result = CONCAT("Succeeded");  
			COMMIT;
	END IF;
	SELECT pro_err,pro_result,pro_msg;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_history_pigeonhole`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_history_pigeonhole`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_history_pigeonhole`()
BEGIN
	
-- 当天业绩归档

insert into  trya_finance_history_personalperformance (user_code,now_day_amount,calculate_amount,surplus_amount,cal_time, accounting_time)
	select user_code,now_day_amount,calculate_amount,surplus_amount,accounting_time,NOW()from trya_finance_temp_personalperformance;


-- 清空奖金计算临时表
TRUNCATE TABLE trya_finance_bonustemp;
-- 公司账户归档
insert into trya_finance_history_companyaccount
	(account_number,account_name,balance,last_day_balance,balance_direction,time_stamp,mark)
	select account_number,account_name,balance,last_day_balance,balance_direction,time_stamp,mark from trya_finance_companyaccount;
-- 修改公司账户昨天余额
update trya_finance_companyaccount set last_day_balance=balance;
-- 计算参数归档
INSERT into trya_finance_history_parameter 
	(group_name,param_name,param_value,update_time,mark)
	select group_name,param_name,param_value,update_time,mark from  trya_finance_parameter;
-- 会员账户归档
insert into trya_finance_history_personalaccount
	(user_code,type,balance,last_day_balance,balance_direction,time_stamp,mark)
	select user_code,type,balance,last_day_balance,balance_direction,time_stamp,mark from trya_finance_personalaccount;
-- 更新会员账户昨日余额
update trya_finance_personalaccount set last_day_balance=balance;
	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_order_add`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_order_add`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_order_add`(IN `product_productinfo_id` int,IN `order_quantity` int,IN `order_total_price` float,IN `order_user_code` varchar(10),IN `order_time` datetime,IN `order_phone` varchar(20),IN `receive_address` varchar(20),IN `receive_name` varchar(20),IN `product_real_price` float, IN `order_mark` tinytext)
    DETERMINISTIC
begin
	-- Declare exception handler
	DECLARE pro_err TINYINT DEFAULT 0;  
	DECLARE pro_code CHAR(5) DEFAULT '00000';  
	DECLARE pro_msg TEXT; 
	DECLARE pro_result TEXT;   
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
	BEGIN  
		SET pro_err = 1;  
		GET DIAGNOSTICS CONDITION 1
			pro_code = RETURNED_SQLSTATE, pro_msg = MESSAGE_TEXT;  
	END;  

  -- Process
	START TRANSACTION;
		-- 更改用户余额（用户资金表，用户余额-订单总金额）
		
		-- 生成订单（订单表）
		INSERT INTO trya_product_orderform (
			`product_productinfo_id`,
			`order_quantity`,
			`order_user_code`,
			`order_time`,
			`order_phone`,
			`receive_address`,
			`receive_name`,
			`product_real_price`,
			`order_total_price`,
			`order_mark`
		)
		VALUES
		(
			product_productinfo_id,
			order_quantity,
			order_user_code,
			order_time,
			order_phone,
			receive_address,
			receive_name,
			product_real_price,
			order_total_price,
			order_mark
		);
		
		select @product_type_id:=product_type_id from trya_product_productinfo  where `id`=product_productinfo_id;

		IF @product_type_id=2 then 
				-- 重复消费类				
				call pro_finance_engine('hycfxflth',order_user_code,'',order_total_price,order_user_code);
		ELSE
				-- 注册类
				call pro_finance_engine('hyzclth',order_user_code,'',order_total_price,order_user_code);
		end if;
		
	-- Result
	IF pro_err != 0 THEN
			SET pro_result = CONCAT('Failed, error code is ',pro_code,', related message is ',pro_msg,'.');
			ROLLBACK;
	ELSE
			SET pro_result = CONCAT("Succeeded");  
			COMMIT;
	END IF;
	SELECT pro_err,pro_result;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `pro_sql_log_insert`
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_sql_log_insert`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_sql_log_insert`(in param_procedure_name varchar(100),in param_content  text)
BEGIN
	
	INSERT into trya_message_sql_log (procedure_name,content) VALUES (param_procedure_name,param_content);
	#Routine body goes here...

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `insert_personalaccount`;
DELIMITER ;;
CREATE TRIGGER `insert_personalaccount` AFTER INSERT ON `trya_admin` FOR EACH ROW begin 

insert into trya_finance_personalaccount ( user_code, type,time_stamp,create_time,update_time)
	values(new.user_code,0,unix_timestamp(now()),unix_timestamp(now()),unix_timestamp(now()));

insert into trya_finance_personalaccount ( user_code, type,time_stamp,create_time,update_time)
	values(new.user_code,1,unix_timestamp(now()),unix_timestamp(now()),unix_timestamp(now()));

insert into trya_finance_personalaccount ( user_code, type,time_stamp,create_time,update_time)
	values(new.user_code,2,unix_timestamp(now()),unix_timestamp(now()),unix_timestamp(now()));

insert into trya_finance_personalaccount ( user_code, type,time_stamp,create_time,update_time)
	values(new.user_code,3,unix_timestamp(now()),unix_timestamp(now()),unix_timestamp(now()));
end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `delete_personal`;
DELIMITER ;;
CREATE TRIGGER `delete_personal` AFTER DELETE ON `trya_admin` FOR EACH ROW begin
     delete from trya_finance_personalaccount where user_code=old.user_code;
     delete from trya_finance_history_personalaccountflow where user_code=old.user_code or counterparty=old.user_code;
     delete from trya_finance_history_transactionalflow where user_code=old.user_code or counterparty=old.user_code;
end
;;
DELIMITER ;
