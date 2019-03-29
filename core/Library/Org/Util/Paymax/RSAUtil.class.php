<?php
/**
 * Created by xiaowei.wang
 * CreateTime: 16/7/6 下午5:37
 * Description:对数据进行签名和验签
 */
namespace Org\Util\Paymax;
use Org\Util\Paymax\SignConfig;

class RSAUtil
{
    /**
     * 签名数据
     *
     * @param $data 待签名数据
     * @return string 签名后的数据
     */
    public static function sign($data)
    {
        //读取私钥文件
        $priKey = file_get_contents(SignConfig::getPrivateKeyPath());

        //转换为openssl密钥，必须是没有经过pkcs8转换的私钥
        $res = openssl_get_privatekey($priKey);

        //调用openssl内置签名方法，生成签名$sign
        openssl_sign($data, $sign, $res);

        //释放资源
        openssl_free_key($res);

        //base64编码
        $sign = base64_encode($sign);

        return $sign;
    }

    /**
     * 验签数据
     *
     * @param $data 原始数据
     * @param $sign 签名数据
     * @return bool 验签结果
     */
    public static function verify($data, $sign)  {

        //读取支付宝公钥文件
        $pubKey = file_get_contents(SignConfig::getPaymaxPublicKeyPath());

        //转换为openssl格式密钥
        $res = openssl_get_publickey($pubKey);

        //调用openssl内置方法验签，返回bool值
        $result = (bool)openssl_verify($data, base64_decode($sign), $res);

        //释放资源
        openssl_free_key($res);

        //返回资源是否成功
        return $result;

    }
}