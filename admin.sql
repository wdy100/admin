--admin system CREATE TABLE sql
--2017-11-16

-- system begin--
-- DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code`	varchar(20) NOT NULL COMMENT '编码',
  `name`	varchar(50) NOT NULL COMMENT '名称',
  `description`	varchar(200) DEFAULT NULL COMMENT '描述',
  `parent_id`   int(11) NOT NULL COMMENT '上级部门id',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='部门表';

-- DROP TABLE IF EXISTS `resource_info`;
CREATE TABLE `resource_info`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code`	varchar(20) NOT NULL COMMENT '编码',
  `name`	varchar(50) NOT NULL COMMENT '名称',
  `description`	varchar(200) NOT NULL COMMENT '描述',
  `url`	varchar(200) NOT NULL COMMENT '访问路径',
  `type` tinyint(1) DEFAULT '0' COMMENT '类别 0:模块 1:页面  2:按钮',
  `order_index` int(4) DEFAULT '0' COMMENT '顺序',
  `parent_id`   int(11) NOT NULL COMMENT '上级资源id',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='资源表';

-- DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code`	varchar(20) NOT NULL COMMENT '编码',
  `name`	varchar(50) NOT NULL COMMENT '名称',
  `description`	varchar(200) NOT NULL COMMENT '描述',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- DROP TABLE IF EXISTS `role_resource`;
CREATE TABLE `role_resource`
(
  role_id   int(11) NOT NULL,
  resource_id  int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色资源表';

-- DROP TABLE IF EXISTS `user_department`;
CREATE TABLE `user_department`
(
  user_id   int(11) NOT NULL,
  department_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户部门表';

-- DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name`	varchar(50) NOT NULL COMMENT '用户名',
  `password`	varchar(50) NOT NULL COMMENT '密码',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态 0:申请中  1:正常  -1:冻结',
  `sex` varchar(4) DEFAULT '男' COMMENT '性别 男  女  其他',
  `mobile`	varchar(20) DEFAULT NULL COMMENT '手机',
  `email`	varchar(50) DEFAULT NULL COMMENT '邮箱',
  `nick_name`	varchar(50) DEFAULT NULL COMMENT '昵称',
  `birthday` datetime NOT NULL COMMENT '生日',
  `identity_no`	varchar(25) DEFAULT NULL COMMENT '身份证号',
  `address`	varchar(200) DEFAULT NULL COMMENT '家庭住址',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`
(
  user_id int(11) NOT NULL,
  role_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name`	varchar(50) NOT NULL COMMENT '用户名',
  `ip`	varchar(20) DEFAULT NULL COMMENT 'ip',
  `page_name`	varchar(50) NOT NULL COMMENT '页面名称',
  `event_name`	varchar(50) NOT NULL COMMENT '事件名称',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='系统日志表';

-- DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_code`	varchar(20) NOT NULL COMMENT '文件编码',
  `file_name`	varchar(50) NOT NULL COMMENT '文件名称',
  `file_type` tinyint(1) DEFAULT '1' COMMENT '文件类别 1:合同  2:勘察报告  3:安装验收报告',
  `url`	varchar(200) NOT NULL COMMENT '访问路径',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='系统附件表';

-- DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_at` datetime NOT NULL COMMENT '开始时间',
  `end_at` datetime NOT NULL COMMENT '结束时间',
  `title`	varchar(50) NOT NULL COMMENT '标题',
  `content` varchar(512) DEFAULT NULL COMMENT '内容',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='公告表';
-- system end--

--admin系统业务表 begin--
--客户主数据
-- DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_code`	varchar(20) DEFAULT NULL COMMENT '客户编码',
  `customer_name`	varchar(50) NOT NULL COMMENT '客户名称',
  `type_code`	varchar(20) DEFAULT NULL COMMENT '所属行业编码',
  `type_name`	varchar(50) DEFAULT NULL COMMENT '所属行业名称',
  `phone`	varchar(50) DEFAULT NULL COMMENT '电话',
  `fax`	varchar(50) DEFAULT NULL COMMENT '传真',
  `address`	varchar(100) DEFAULT NULL COMMENT '地址',
  `url`	varchar(50) DEFAULT NULL COMMENT '网址',
  `corporate`	varchar(50) DEFAULT NULL COMMENT '公司法人',
  `manager`	varchar(50) DEFAULT NULL COMMENT '总经理',
  `contact`	varchar(50) DEFAULT NULL COMMENT '联系方式',
  `dock_department`	varchar(50) DEFAULT NULL COMMENT '对接部门',
  `dock_person`	varchar(50) DEFAULT NULL COMMENT '对接部门联系人',
  `dock_contact`	varchar(50) DEFAULT NULL COMMENT '对接部门联系方式',
  `relate_department`	varchar(50) DEFAULT NULL COMMENT '关联部门',
  `relate_person`	varchar(50) DEFAULT NULL COMMENT '关联部门联系人',
  `relate_contact`	varchar(50) DEFAULT NULL COMMENT '关联部门联系方式',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  `responsible_person`	varchar(50) DEFAULT NULL COMMENT '负责人',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='客户表';

--客户反馈
-- DROP TABLE IF EXISTS `customer_feedback`;
CREATE TABLE `customer_feedback`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_code`	varchar(20) DEFAULT NULL COMMENT '客户编码',
  `customer_name`	varchar(50) NOT NULL COMMENT '客户名称',
  `responsible_person`	varchar(50) DEFAULT NULL COMMENT '负责人',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='客户反馈表';
--admin系统业务表 end--

