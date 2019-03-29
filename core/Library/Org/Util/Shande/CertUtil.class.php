<?php
namespace Org\Util\Shande;

class CertUtil {
    private $puk = null;
    private $prk = null;

    public function __construct($pubPath, $priPath, $certPwd) {
        $this->puk = $this->loadX509Cert($pubPath);
        $this->prk = $this->loadPk12Cert($priPath, $certPwd);
    }

    public function getPublicKey() {
        return $this->puk;
    }

    public function getPrivateKey() {
        return $this->prk;
    }

    /**
     * 获取公钥
     * @param $path
     * @return mixed
     * @throws \Exception
     */
    private function loadX509Cert($path) {
        try {
            $file = file_get_contents($path);
            if (!$file) {
                throw new \Exception('loadX509Cert::file_get_contents ERROR');
            }

            $cert = chunk_split(base64_encode($file), 64, "\n");
            $cert = "-----BEGIN CERTIFICATE-----\n" . $cert . "-----END CERTIFICATE-----\n";

            $res = openssl_pkey_get_public($cert);
            $detail = openssl_pkey_get_details($res);
            openssl_free_key($res);

            if (!$detail) {
                throw new \Exception('loadX509Cert::openssl_pkey_get_details ERROR');
            }

            return $detail['key'];
        } catch (\Exception $e) {
            ErrorHandle::log($e);
            throw $e;
        }
    }

    /**
     * 获取私钥
     * @param $path
     * @param $pwd
     * @return mixed
     * @throws \Exception
     */
    private function loadPk12Cert($path, $pwd) {
        try {
     
            $file = file_get_contents($path);
            if (!$file) {
                throw new \Exception('loadPk12Cert::file_get_contents ERROR');
            }

            if (!openssl_pkcs12_read($file, $cert, $pwd)) {
                throw new \Exception('loadPk12Cert::openssl_pkcs12_read ERROR');
            }

            return $cert['pkey'];
        } catch (\Exception $e) {
            ErrorHandle::log($e);
            throw $e;
        }
    }
}