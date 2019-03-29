<?php
namespace Org\Util\Hx\Scan;
ini_set('date.timezone','Asia/Shanghai');
require_once ("IpsPayUtil.function.php");

class IpsPayNotify
{
    var $ipspay_config;
    
    function __construct($ipspay_config){
        $this->ipspay_config = $ipspay_config;
    }
    function IpsPayNotify($ipspay_config) {
        $this->__construct($ipspay_config);
    }
    
    function verifyReturn(){
        try {
            if(empty($_REQUEST)) {
                return false;
            }
            else {
                $paymentResult = $_REQUEST['paymentResult'];
                
                $xmlResult = new SimpleXMLElement($paymentResult);
                $strSignature = $xmlResult->GateWayRsp->head->Signature;
                
                $strRspCode = $xmlResult->GateWayRsp->head->RspCode;
                
                if($strRspCode == "000000"){
                    $strStatus = $xmlResult->GateWayRsp->body->Status;
                    if($strStatus == "Y"){
                        $strBody = subStrXml("<body>","</body>",$paymentResult);
                        if(md5Verify($strBody,$strSignature,$this->ipspay_config["MerCode"],$this->ipspay_config["MerCert"])){
                            return true;
                        }else{
                            return false;
                        }
                    }else{
                        $strRspMsg = $xmlResult->GateWayRsp->head->RspMsg;
                        return false;
                    }
                }else{
                    return false;
                }
            }
        } catch (Exception $e) {
            exit("异常:" . $e);
        }
        return false;
    }
}

?>