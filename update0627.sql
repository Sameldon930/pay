ALTER TABLE `pay_order` ADD `lock_status` TINYINT(1) NULL DEFAULT '0' COMMENT '是否冻结订单，1冻结，2解冻';
