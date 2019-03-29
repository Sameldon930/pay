
ALTER TABLE `pay_member` ADD `df_domain` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '代付域名报备';
ALTER TABLE `pay_member` CHANGE `df_domain` `df_domain` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '代付域名报备';
ALTER TABLE `pay_member` ADD `df_auto_check` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '代付API自动审核';
ALTER TABLE `pay_member` ADD `google_secret_key` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '谷歌密钥';
ALTER TABLE `pay_member` ADD `df_ip` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '代付域名报备IP';
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '绑定管理员手机号码', 'SMS_119087905', 'adminbindMobile', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '修改管理员手机号码', 'SMS_119087905', 'admineditMobile', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '批量删除订单', 'SMS_119087905', 'delOrderSend', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '解绑谷歌身份验证器', 'SMS_119087905', 'unbindGoogle', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');

ALTER TABLE `pay_tikuanconfig` ADD `daycardzdmoney` DECIMAL(10,2) NOT NULL DEFAULT '0' COMMENT '单人单卡单日最高提现额' AFTER `allowend`;
ALTER TABLE `pay_article` ADD `groupid` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '分组 0：所有 1：商户 2：代理' AFTER `catid`;
ALTER TABLE `pay_admin` ADD `mobile` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '手机号码' AFTER `google_secret_key`;
ALTER TABLE `pay_sms` ADD `sms_channel` VARCHAR(20) NOT NULL DEFAULT 'aliyun' COMMENT '短信通道' AFTER `is_receive`, ADD `smsbao_user` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '短信宝账号' AFTER `sms_channel`, ADD `smsbao_pass` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '短信宝密码' AFTER `smsbao_user`;

INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '绑定管理员手机号码', 'SMS_119087905', 'adminbindMobile', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '修改管理员手机号码', 'SMS_119087905', 'admineditMobile', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '批量删除订单', 'SMS_119087905', 'delOrderSend', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
ALTER TABLE `pay_member` ADD `open_charge` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否开启充值功能';
ALTER TABLE `pay_tikuanconfig` CHANGE `t1zt` `t1zt` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'T+1 ：1开启 0 关闭';

CREATE TABLE `pay_complaints_deposit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `pay_orderid` varchar(100) NOT NULL DEFAULT '0' COMMENT '系统订单号',
  `freeze_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '冻结保证金额',
  `unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '计划解冻时间',
  `real_unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '实际解冻时间',
  `is_pause` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否暂停解冻 0正常解冻 1暂停解冻',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '解冻状态 0未解冻 1已解冻',
  `create_at` int(11) NOT NULL COMMENT '记录创建时间',
  `update_at` int(11) NOT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_unfreezeing` (`status`,`is_pause`,`unfreeze_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投诉保证金余额';
CREATE TABLE `pay_complaints_deposit_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `is_system` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否系统规则 1是 0否',
  `ratio` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '投诉保证金比例（百分比）',
  `freeze_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '冻结时间（秒）',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '规则是否开启 1开启 0关闭',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='投诉保证金规则表';
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`)
VALUES
	(NULL, 'fa fa-first-order', 'Deposit/index', '投诉保证金设置', 5, 1, 0, 1, 1, '');
ALTER TABLE `pay_websiteconfig` ADD `random_mchno` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否开启随机商户号';
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-asterisk', 'Statistics/complaintsDeposit', '投诉保证金统计', '38', '1', '0', '1', '1', '');



ALTER TABLE `pay_wttklist` ADD `auto_submit_try` INT(10) NOT NULL DEFAULT '0' COMMENT '自动代付尝试提交次数';
ALTER TABLE `pay_wttklist` ADD `is_auto` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否自动提交';
ALTER TABLE `pay_wttklist` ADD `last_submit_time` INT(11) NOT NULL DEFAULT '0' COMMENT '最后提交时间';
ALTER TABLE `pay_wttklist` ADD `df_lock` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '代付锁，防止重复提交';
ALTER TABLE `pay_wttklist` ADD `auto_query_num` INT(10) NOT NULL DEFAULT '0' COMMENT '自动查询次数';
ALTER TABLE `pay_tikuanconfig` ADD `auto_df_switch` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '自动代付开关';
ALTER TABLE `pay_tikuanconfig` ADD `auto_df_maxmoney` DECIMAL(10,2) NOT NULL DEFAULT '0' COMMENT '单笔代付最大金额限制';
ALTER TABLE `pay_tikuanconfig` ADD `auto_df_stime` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '自动代付开始时间' AFTER `auto_df_maxmoney`, ADD `auto_df_etime` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '自动代付结束时间' AFTER `auto_df_stime`;
CREATE TABLE `pay_auto_df_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `df_id` int(11) NOT NULL DEFAULT '0' COMMENT '代付ID',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型：1提交 2查询',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '结果 0：提交失败 1：提交成功 2：代付成功 3：代付失败',
  `msg` varchar(255) DEFAULT '' COMMENT '描述',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '提交时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '设置订单为已支付', 'SMS_119087905', 'setOrderPaidSend', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');


ALTER TABLE `pay_complaints_deposit` ADD `out_trade_id` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '下游订单号' AFTER `pay_orderid`;
ALTER TABLE `pay_wttklist` ADD `channel_mch_id` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通道商户号';
CREATE TABLE `pay_auto_unfrozen_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `freeze_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '冻结保证金额',
  `unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '计划解冻时间',
  `real_unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '实际解冻时间',
  `is_pause` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否暂停解冻 0正常解冻 1暂停解冻',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '解冻状态 0未解冻 1已解冻',
  `create_at` int(11) NOT NULL COMMENT '记录创建时间',
  `update_at` int(11) NOT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_unfreezeing` (`status`,`is_pause`,`unfreeze_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='手动冻结订单';
INSERT INTO `pay_sms_template` VALUES (NULL, '清理数据', 'SMS_119087905', 'clearDataSend', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_auth_rule` VALUES (NULL, 'fa fa-database', 'System/clearData', '数据清理', '2', '1', '0', '1', '1', '');

ALTER TABLE `pay_moneychange` ADD `t` INT(4) NOT NULL DEFAULT '0' COMMENT '结算方式';

CREATE TABLE `pay_redo_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作管理员',
  `money` decimal(11,2) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1：增加 2：减少',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '冲正备注',
  `date` datetime NOT NULL COMMENT '冲正周期',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, '', 'Index/main', 'Dashboard', '1', '1', '0', '1', '1', '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-area-chart', 'Statistics/platformReport', '平台报表', '38', '1', '0', '1', '1', '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-area-chart', 'Statistics/merchantReport', '商户报表', '38', '1', '0', '1', '1', '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-area-chart', 'Statistics/agentReport', '代理报表', '38', '1', '0', '1', '1', '');




#老版菜单
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-mobile', 'System/mobile', '手机设置', '2', '1', '0', '1', '1', '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-signal', 'Statistics/chargeRank', '充值排行榜', '102', '1', '0', '1', '1', '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-first-order', 'Deposit/index', '投诉保证金设置', '5', '1', '0', '1', '1', '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-asterisk', 'Statistics/complaintsDeposit', '投诉保证金统计', '102', '1', '0', '1', '1', '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-database', 'System/clearData', '数据清理', '2', '1', '0', '1', '1', '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-area-chart', 'Statistics/platformReport', '平台报表', '102', '1', '0', '1', '1', '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-area-chart', 'Statistics/merchantReport', '商户报表', '102', '1', '0', '1', '1', '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-area-chart', 'Statistics/agentReport', '代理报表', '102', '1', '0', '1', '1', '');

UPDATE `pay_auth_rule` SET `title` = '资金流水' WHERE `title` = '交易列表';



ALTER TABLE `pay_loginrecord` ADD `type` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '类型：0：前台用户 1：后台用户';
ALTER TABLE `pay_member` ADD `session_random` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'session随机字符串' ;
ALTER TABLE `pay_admin` ADD `session_random` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'session随机字符串';

ALTER TABLE `pay_member` CHANGE `balance` `balance` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '可用余额';
ALTER TABLE `pay_member` CHANGE `blockedbalance` `blockedbalance` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '冻结可用余额';
ALTER TABLE `pay_member` CHANGE `paying_money` `paying_money` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '当天已交易金额';
ALTER TABLE `pay_member` CHANGE `unit_paying_amount` `unit_paying_amount` DECIMAL(11,4) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '单位时间已交易金额';
ALTER TABLE `pay_order` CHANGE `pay_amount` `pay_amount` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00';
ALTER TABLE `pay_order` CHANGE `pay_poundage` `pay_poundage` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00';
ALTER TABLE `pay_order` CHANGE `pay_actualamount` `pay_actualamount` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00';
ALTER TABLE `pay_moneychange` CHANGE `ymoney` `ymoney` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '原金额';
ALTER TABLE `pay_moneychange` CHANGE `money` `money` DECIMAL(15,4) NOT NULL DEFAULT '0.000' COMMENT '变动金额';
ALTER TABLE `pay_moneychange` CHANGE `gmoney` `gmoney` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '变动后金额';
ALTER TABLE `pay_redo_order` CHANGE `money` `money` DECIMAL(15,4) NOT NULL;
ALTER TABLE `pay_df_api_order` CHANGE `money` `money` DECIMAL(15,4) NOT NULL DEFAULT '0.00' COMMENT '金额';
ALTER TABLE `pay_blockedlog` CHANGE `amount` `amount` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '冻结金额';
ALTER TABLE `pay_tklist` CHANGE `tkmoney` `tkmoney` DECIMAL(15,4) NOT NULL DEFAULT '0.0000';
ALTER TABLE `pay_tklist` CHANGE `sxfmoney` `sxfmoney` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00';
ALTER TABLE `pay_tklist` CHANGE `money` `money` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00';
ALTER TABLE `pay_complaints_deposit` CHANGE `freeze_money` `freeze_money` DECIMAL(15,4) NOT NULL DEFAULT '0.00' COMMENT '冻结保证金额';
ALTER TABLE `pay_auto_unfrozen_order` CHANGE `freeze_money` `freeze_money` DECIMAL(15,4) NOT NULL DEFAULT '0.00' COMMENT '冻结金额';
ALTER TABLE `pay_wttklist` CHANGE `tkmoney` `tkmoney` DECIMAL(15,4) NOT NULL DEFAULT '0.0000';
ALTER TABLE `pay_wttklist` CHANGE `sxfmoney` `sxfmoney` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '手续费';
ALTER TABLE `pay_wttklist` CHANGE `money` `money` DECIMAL(15,4) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '实际到账';
ALTER TABLE `pay_apimoney` CHANGE `money` `money` DECIMAL(15,4) NOT NULL DEFAULT '0.000';

INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '增加/减少余额（冲正）', 'SMS_119087905', 'adjustUserMoneySend', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '提交代付', 'SMS_119087905', 'submitDfSend', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
CREATE TABLE `pay_reconciliation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT '0' COMMENT '用户ID',
  `order_total_count` int(11) DEFAULT '0' COMMENT '总订单数',
  `order_success_count` int(11) DEFAULT '0' COMMENT '成功订单数',
  `order_fail_count` int(11) DEFAULT '0' COMMENT '未支付订单数',
  `order_total_amount` decimal(15,4) DEFAULT '0.0000' COMMENT '订单总额',
  `order_success_amount` decimal(15,4) DEFAULT '0.0000' COMMENT '订单实付总额',
  `date` date DEFAULT NULL COMMENT '日期',
  `ctime` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `pay_channel` ADD `t0defaultrate` DECIMAL(10,4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'T0运营费率';
ALTER TABLE `pay_channel` ADD `t0fengding` DECIMAL(10,4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'T0封顶手续费';
ALTER TABLE `pay_channel` ADD `t0rate` DECIMAL(10,4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'T0成本费率';
ALTER TABLE `pay_channel_account` ADD `t0defaultrate` DECIMAL(10,4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'T0运营费率';
ALTER TABLE `pay_channel_account` ADD `t0fengding` DECIMAL(10,4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'T0封顶手续费';
ALTER TABLE `pay_channel_account` ADD `t0rate` DECIMAL(10,4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'T0成本费率';
ALTER TABLE `pay_userrate` ADD `t0feilv` DECIMAL(10,4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'T0运营费率';
ALTER TABLE `pay_userrate` ADD `t0fengding` DECIMAL(10,4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'T0封顶费率';


ALTER TABLE `pay_websiteconfig` ADD `admin_alone_login` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '管理员是否只允许同时一次登录';
ALTER TABLE `pay_order` ADD `t` TINYINT(2) NOT NULL DEFAULT '1' COMMENT '结算周期（计算费率）';
ALTER TABLE `pay_member` ADD `df_charge_type` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '代付API扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣';
ALTER TABLE `pay_df_api_order` ADD `df_charge_type` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '代付API扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣';
ALTER TABLE `pay_wttklist` ADD `df_charge_type` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '代付API扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣';

ALTER TABLE `pay_tikuanconfig` ADD `auto_df_max_count` INT(11) NOT NULL DEFAULT '0' COMMENT '商户每天自动代付笔数限制';
ALTER TABLE `pay_tikuanconfig` ADD `auto_df_max_sum` INT(11) NOT NULL DEFAULT '0' COMMENT '商户每天自动代付最大总金额限制';
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-wrench', 'Transaction/index', '风控设置', '11', '1', '0', '1', '1', '');
ALTER TABLE `pay_user_riskcontrol_config` ADD `systemxz` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0 系统规则 1 用户规则' ;
UPDATE `pay_user_riskcontrol_config` SET `systemxz` = '1' WHERE `is_system` <> 1;


INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, '', 'Statistics/exportPlatform', '导出平台报表', '116', '0', '0', '1', '1', '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, '', 'Statistics/exportMerchant', '导出商户报表', '117', '0', '0', '1', '1', '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, '', 'Statistics/exportAgent', '导出代理报表', '118', '0', '0', '1', '1', '');

ALTER TABLE `pay_channel_account` ADD `unlockdomain` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '防封域名';
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, '', 'Order/show', '查看订单', 22, 0, 0, 1, 1, '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-cog', 'Withdrawal/checkNotice', '提现申请声音提示', 2, 0, 0, 1, 1, '');
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, '', 'Order/index', '全部订单', 22, 0, 0, 1, 1, '');

UPDATE `pay_auth_rule` SET `status` = '0' WHERE `pay_auth_rule`.`id` = 43;
UPDATE `pay_auth_rule` SET `icon` = 'fa fa-lock' WHERE `pay_auth_rule`.`id` = 54;
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '测试短信', 'SMS_119087905', 'test', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');

ALTER TABLE `pay_member` ADD `last_login_time` INT(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间';
ALTER TABLE `pay_order` ADD `last_reissue_time` INT(11) NOT NULL DEFAULT '11' COMMENT '最后补发时间';

ALTER TABLE `pay_member` CHANGE `birthday` `birthday` INT(11) NOT NULL DEFAULT '0';

INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, '', 'Withdrawal/rejectAllDf', '批量驳回代付', '27', '0', '0', '1', '1', '');

ALTER TABLE `pay_tikuanconfig` ADD `tk_charge_type` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣';
ALTER TABLE `pay_tklist` ADD `tk_charge_type` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣';

INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, '', 'User/saveWithdrawal', '保存用户提款设置', '28', '0', '0', '1', '1', '');

INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '商户登录', 'SMS_119087905', 'userLogin', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '管理员登录', 'SMS_119087905', 'adminLogin', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
ALTER TABLE `pay_websiteconfig` ADD `admin_login_sms` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '管理员登录是否需要短信验证 0：不需要 1：需要';


INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '系统配置', 'SMS_119087905', 'sysconfig', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');

ALTER TABLE `pay_order` ADD `lock_status` TINYINT(1) NULL DEFAULT '0' COMMENT '是否冻结订单，1冻结，2解冻';

ALTER TABLE `pay_websiteconfig` ADD `max_auth_error_times` INT(10) NOT NULL DEFAULT '5' COMMENT '验证错误最大次数';
ALTER TABLE `pay_websiteconfig` ADD `auth_error_ban_time` INT(10) NOT NULL DEFAULT '10' COMMENT '验证错误超限冻结时间（分钟）';

CREATE TABLE `pay_auth_error_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `auth_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：商户登录 1：后台登录 2：商户短信验证 3：后台短信验证 4：谷歌令牌验证 5：支付密码验证 ',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `pay_user_channel_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `account_ids` varchar(255) NOT NULL DEFAULT '' COMMENT '子账号id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否开启指定账号',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户指定指账号';

ALTER TABLE `pay_wttklist` ADD `transaction_id` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '上游订单号' ;
ALTER TABLE `pay_wttklist` ADD `billno` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '上游交易流水号';

INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES (NULL, 'fa fa-snowflake-o', 'Order/frozenOrder', '冻结订单', '22', '1', '0', '1', '1', '');

ALTER TABLE `pay_member` CHANGE `unit_paying_number` `unit_paying_number` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '单位时间已交易次数';
ALTER TABLE `pay_member` CHANGE `unit_paying_amount` `unit_paying_amount` DECIMAL(15,2) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '单位时间已交易金额';

UPDATE `pay_auth_rule` SET `icon`='fa fa-snowflake-o',`is_menu`= '1' WHERE `title`='全部订单';

ALTER TABLE `pay_df_api_order` ADD INDEX(`df_id`);
ALTER TABLE `pay_wttklist` ADD INDEX(`df_api_id`);

ALTER TABLE `pay_product_user` ADD INDEX(`pid`);
ALTER TABLE `pay_complaints_deposit` ADD INDEX(`pay_orderid`);

DELETE FROM `pay_auth_rule` WHERE `title`='交易统计';

ALTER TABLE `pay_bankcard` ADD `province_code` INT(10) NOT NULL DEFAULT '0' COMMENT '省份代码' AFTER `cardnumber`;
ALTER TABLE `pay_bankcard` ADD `city_code` INT(10) NOT NULL DEFAULT '0' COMMENT '城市代码' AFTER `province`;

ALTER TABLE `pay_websiteconfig` ADD `document_url` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '对接文档链接';

ALTER TABLE `pay_product` ADD `t0defaultrate` DECIMAL(10,4) NOT NULL DEFAULT '0' COMMENT 'T0运营费率';
ALTER TABLE `pay_product` ADD `t0fengding` DECIMAL(10,4) NOT NULL DEFAULT '0' COMMENT 'T0封顶手续费';
ALTER TABLE `pay_product` ADD `defaultrate` DECIMAL(10,4) NOT NULL DEFAULT '0' COMMENT 'T1运营费率';
ALTER TABLE `pay_product` ADD `fengding` DECIMAL(10,4) NOT NULL DEFAULT '0' COMMENT 'T1封顶手续费';

ALTER TABLE `pay_wttklist` ADD `lock_time` INT(11) NOT NULL DEFAULT '0' COMMENT '锁定时间' AFTER `df_lock`;
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '提款设置', 'SMS_119087905', 'tkconfig', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
