<?php
namespace Org\Util\Shande;

class CryptUtil {
    private $puk;
    private $prk;

    function __construct($puk, $prk) {
        $this->puk = $puk;
        $this->prk = $prk;
    }

    /**
     * RSA公钥加密
     * @param $plainText
     * @return string
     * @throws \Exception
     */
    public function RSAEncryptByPub($plainText) {
        try {
            if (!openssl_public_encrypt($plainText, $cipherText, $this->puk, OPENSSL_PKCS1_PADDING)) {
                throw new \Exception('AESKey 加密错误');
            }

            return base64_encode($cipherText);
        } catch (\Exception $e) {
            errorHandle::log($e);
            throw $e;
        }
    }

    /**
     * RSA私钥解密
     * @param $cipherText
     * @return string
     * @throws \Exception
     */
    public function RSADecryptByPri($cipherText) {
        if (!openssl_private_decrypt(base64_decode($cipherText), $plainText, $this->prk, OPENSSL_PKCS1_PADDING)) {
            throw new \Exception('AESKey 解密错误');
        }

        return (string)$plainText;
    }

    /**
     * 私钥签名
     * @param $plainText
     * @return string
     * @throws \Exception
     */
    public function sign($plainText) {
        try {
            $resource = openssl_pkey_get_private($this->prk);
            $result = openssl_sign($plainText, $sign, $resource);
            openssl_free_key($resource);

            if (!$result) {
                throw new \Exception('签名出错');
            }

            return base64_encode($sign);
        } catch (\Exception $e) {
            errorHandle::log($e);
            throw $e;
        }
    }

    /**
     * 公钥验签
     * @param $plainText
     * @param $sign
     * @return int
     * @throws \Exception
     */
    public function verify($plainText, $sign) {
        $resource = openssl_pkey_get_public($this->puk);
        $result = openssl_verify($plainText, base64_decode($sign), $resource);
        openssl_free_key($resource);

        if (!$result) {
            throw new \Exception('签名验证未通过', 2002);
        }

        return $result;
    }

    /**
     * AES加密
     * @param $plainText
     * @param $key
     * @return string
     * @throws \Exception
     */
    public function AESEncrypt($plainText, $key) {
        try {
            $result = openssl_encrypt($plainText, 'AES-128-ECB', $key, 1);

            if (!$result) {
                throw new \Exception('报文加密错误');
            }

            return base64_encode($result);
        } catch (\Exception $e) {
            errorHandle::log($e);
            throw $e;
        }
    }

    /**
     * AES解密
     * @param $cipherText
     * @param $key
     * @return string
     * @throws \Exception
     */
    public function AESDecrypt($cipherText, $key) {
        $result = openssl_decrypt(base64_decode($cipherText), 'AES-128-ECB', $key, 1);

        if (!$result) {
            throw new \Exception('报文解密错误', 2003);
        }

        return $result;
    }
}