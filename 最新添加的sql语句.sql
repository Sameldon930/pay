 
/*
author	:马培坚   
date	:2018/6/1
version	:6.0.0

ALTER TABLE `pay_member` ADD `df_domain` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '代付域名报备';
ALTER TABLE `pay_member` CHANGE `df_domain` `df_domain` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '代付域名报备';
ALTER TABLE `pay_member` ADD `df_auto_check` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '代付API自动审核';
ALTER TABLE `pay_member` ADD `google_secret_key` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '谷歌密钥';
ALTER TABLE `pay_member` ADD `df_ip` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '代付域名报备IP';
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '绑定管理员手机号码', 'SMS_119087905', 'adminbindMobile', '您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '修改管理员手机号码', 'SMS_119087905', 'admineditMobile', '您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '批量删除订单', 'SMS_119087905', 'delOrderSend', '您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` (`id`, `title`, `template_code`, `call_index`, `template_content`, `ctime`) VALUES (NULL, '解绑谷歌身份验证器', 'SMS_119087905', 'unbindGoogle', '您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
*/
/* 老版菜单
INSERT INTO `pay_auth_rule` (`id`, `icon`, `menu_name`, `title`, `pid`, `is_menu`, `is_race_menu`, `type`, `status`, `condition`) VALUES(NULL, 'fa fa-mobile', 'System/mobile', '手机设置', 3, 1, 0, 1, 1, '');
 */

/*移除上面的sql语句，合并到install.sql里面  
author	:韦小宝
date	:2018/6/1  
version	:5.8
*/
-- ALTER TABLE `pay_websiteconfig` ADD `register_need_activate` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '用户注册是否需激活'

/*
author	:陈嘉杰
date	:2018/7/19  
version	:5.8.6
*/
-- ----------------------------
-- Table structure for `pay_user_channel_account`
-- ----------------------------
DROP TABLE IF EXISTS `pay_user_channel_account`;
CREATE TABLE `pay_user_channel_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `account_ids` varchar(255) NOT NULL DEFAULT '' COMMENT '子账号id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否开启指定账号',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户指定指账号';

-- ----------------------------
-- Records of pay_user_channel_account
-- ----------------------------