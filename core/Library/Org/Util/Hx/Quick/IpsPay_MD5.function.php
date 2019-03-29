<?php
namespace Org\Util\Hx\Quick;
/*
 * MD5
 * 详细：MD5加密
 * 日期：2016-12-15
 * 说明：
 * 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 */
require_once 'log.php';

// 初始化日志
$logHandler = new CLogFileHandler("./logs/" . date('Y-m-d') . '.log');
$log = Log::Init($logHandler, 15);

/**
 * 签名字符串
 *
 * @param $prestr 需要签名的字符串            
 * @param $key 私钥            
 * @param $merCode 商戶號
 *            return 签名结果
 */
function md5Sign($prestr, $merCode, $key)
{
    $prestr = $prestr . $merCode . $key;
    return md5($prestr);
}

/**
 * 验证签名
 *
 * @param $prestr 需要签名的字符串            
 * @param $sign 签名结果            
 * @param $merCode 商戶號            
 * @param $key 私钥
 *            return 签名结果
 */
function md5Verify($prestr, $sign, $merCode, $key)
{
    $prestr = $prestr . $merCode . $key;
    $mysgin = md5($prestr);
    
    if ($mysgin == $sign) {
        return true;
    } else {
        return false;
    }
}
?>