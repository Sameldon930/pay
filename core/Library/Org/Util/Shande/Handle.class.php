<?php
namespace Org\Util\Shande;

use Org\Util\Shande\CryptUtil;
use Org\Util\Shande\ErrorHandle;
use Org\Util\Shande\HttpClient;
use Org\Util\Shande\RandomStr;
use Org\Util\Shande\CertUtil;

class Handle
{
    private $AESKey;
    private $cert;
    private $crypt;

    public function __construct($config)
    {

        if (empty($config['pubPath']) || empty($config['priPath']) || empty($config['certPwd'])) {
            ErrorHandle::throwException(new \Exception('证书配置有误'));
        }
        //生成AESKey
        $this->AESKey = RandomStr::generate(16);
        //加载公私钥
        $this->cert = new CertUtil($config['pubPath'], $config['priPath'], $config['certPwd']);
        //初始化加解密辅助类
        $this->crypt = new CryptUtil($this->cert->getPublicKey(), $this->cert->getPrivateKey());
    }

    public function execute($params)
    {
        try {
            //发送加密数据
            $res = HttpClient::request_post($params['url'], $this->pre($params));

            //解密返回数据并验签
            return $this->after($res);
        } catch (\Exception $e) {
            ErrorHandle::throwException($e);
        }
    }

    private function pre($params)
    {
        if (empty($params['pt']) || empty($params['transCode']) || empty($params['merId'])) {
            throw new \Exception('入参配置有误');
        }

        //入参json格式化
        $params['pt'] = json_encode($params['pt'],JSON_UNESCAPED_UNICODE);

        //AESKey 加密
        $encryptKey = $this->crypt->RSAEncryptByPub($this->AESKey);
        //报文加密
        $encryptData = $this->crypt->AESEncrypt($params['pt'], $this->AESKey);
        //签名
        $sign = $this->crypt->sign($params['pt']);


        //post数据
        $returnData['transCode']   = $params['transCode'];
        $returnData['merId']       = $params['merId'];
        $returnData['encryptKey']  = $encryptKey;
        $returnData['encryptData'] = $encryptData;
        $returnData['sign']        = $sign;
        $returnData                = http_build_query($returnData);
        return $returnData;
    }

    private function after($res)
    { 
        parse_str($res, $arr);

        if (empty($arr['encryptKey']) || empty($arr['encryptData']) || empty($arr['sign'])) {
            throw new \Exception('数据返回格式有误');
        }

        //AESKey 解密
        $decryptAESKey = $this->crypt->RSADecryptByPri($arr['encryptKey']);

        //报文解密
        $decryptPlainText = $this->crypt->AESDecrypt($arr['encryptData'], $decryptAESKey);

       
        //验签
        $verify = $this->crypt->verify($decryptPlainText, $arr['sign']);
        if ($verify) {
           
            return $decryptPlainText;
        }
    }
}
