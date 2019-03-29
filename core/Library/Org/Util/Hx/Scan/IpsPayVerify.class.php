<?php
namespace Org\Util\Hx\Scan;
ini_set('date.timezone', 'Asia/Shanghai');
require_once ("IpsPayUtil.function.php");

class IpsPayVerify
{

    var $ipspay_config;

    function __construct($ipspay_config)
    {
        $this->ipspay_config = $ipspay_config;
    }

    function IpsPayVerify($ipspay_config)
    {
        $this->__construct($ipspay_config);
    }

    function verifyReturn($param)
    {
        try {
            
            $xmlResult = new SimpleXMLElement($param);
            $strSignature = $xmlResult->GateWayRsp->head->Signature;
            
            $strBody = subStrXml("<body>", "</body>", $param);
            
            if (md5Verify($strBody, $strSignature, $this->ipspay_config["MerCode"], $this->ipspay_config["MerCert"])) {
                return true;
            } else {
                return false;
            }
        } catch (Exception $e) {
            exit("异常:" . $e);
        }
        return false;
    }
}

?>