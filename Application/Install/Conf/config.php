<?php
/**
 * 安装程序配置文件
 */
return array(
    //产品配置
    'INSTALL_PRODUCT_NAME'   => '聚合API支付系统', //产品名称
    'INSTALL_WEBSITE_DOMAIN' => 'http://www.baidu.com', //官方网址
    'INSTALL_COMPANY_NAME'   => '聚合支付', //公司名称
    'ORIGINAL_TABLE_PREFIX'  => 'pay_', //默认表前缀

    //模板相关配置
    'URL_MODEL' => 2,
    'URL_PATHINFO_DEPR' => '_',
    'TMPL_TEMPLATE_SUFFIX' => '.html',
    'TMPL_L_DELIM' => '{', // 模板引擎普通标签开始标记
    'TMPL_R_DELIM' => '}', // 模板引擎普通标签结束标记
    'TMPL_PARSE_STRING'      => array(
        '__PUBLIC__' => __ROOT__ . '/Public',
        '__IMG__'    => __ROOT__ . '/Application/' . MODULE_NAME . '/View/Public/img',
        '__CSS__'    => __ROOT__ . '/Application/' . MODULE_NAME . '/View/Public/css',
        '__JS__'     => __ROOT__ . '/Application/' . MODULE_NAME . '/View/Public/js',
    ),

    //是否开启模板编译缓存,设为false则每次都会重新编译
    'TMPL_CACHE_ON'          => false,

    // 默认模块
    'DEFAULT_MODULE'         => 'Install',
);
