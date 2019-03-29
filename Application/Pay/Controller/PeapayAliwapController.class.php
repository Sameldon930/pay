<?php

/**
 * @author zhangjianwei
 * @date   2018-06-01
 */

namespace Pay\Controller;

use Think\Log;
use Think\Think;


/**
 * 豌豆 支付宝wap
 * 官网地址：http://www.hefupal.com
 * @package Pay\Controller
 */
class PeapayAliwapController extends PayController
{

    //支付方式code
    private $code = '';

    private $exchange = 1;

    private $desc = '豌豆 支付宝wap';

    public function __construct()
    {
        parent::__construct();

        $matches = [];
        preg_match('/([\da-zA-Z\_]+)Controller$/', __CLASS__, $matches);
        $this->code = $matches[1];
    }

    public function Pay($channel)
    {
        $exchange = $this->exchange;
        $return   = $this->getParameter($this->desc, $channel, __CLASS__, $exchange);

        list($msec, $sec) = explode(' ', microtime());
        $msectime = (float)sprintf('%.0f', (floatval($msec) + floatval($sec)) * 1000);

        $params = [
            'pay_id'       => $return['mch_id'],
            'out_trade_no' => $return['orderid'],
            'create_time'  => $msectime,
            'notify_url'   => $return['notifyurl'],
            'total_fee'    => $return['amount'],
            'user_account' => '10007',
        ];
header("Content-Type:application/json");
echo json_encode($params); exit;
        $params['sign'] = $this->makeSign($params, $return['signkey']);

        $xml_parmas = $this->xml_encode($params);

        list($returnCode, $returnContent) = $this->makeRequest($return['gateway'], $xml_parmas);

        $response = xmlToArray($returnContent);

        if(empty($returnContent))
        {
            exit('支付服务不可用');
        }
        else if($response['code'] == 200)
        {
            $payUrl = $response['location'];
            echo createForm($payUrl, []);
        }
        else
        {
            exit($response['message']);
        }

    }


    //异步通知地址
    public function notifyurl()
    {
        $this->log();
        $inputXml = file_get_contents("php://input");//接收xml
        $post     = xmlToArray($inputXml);

        // 验签
        $retcode = $post['result_code'];
        $orderId = (string)$post['out_trade_no'];


        $key = getKey($orderId);
        if(empty($key))
        {
            exit('无效的订单');
        }

        $flag = $this->verifySign($post, $key);


        if($flag)
        {
            if($retcode == "200")
            {
                //修改订单信息
                $this->EditMoney($orderId, '', 0);
                Log::record("{$this->desc}异步通知：" . "交易成功！订单号：" . $orderId, Log::INFO);
                exit("OK");
            }
            else
            {
                Log::record("{$this->desc}异步通知：" . "交易失败！订单号：" . $orderId . "，参数：" . json_encode($post), Log::ERR);
                exit("交易失败");
            }
        }
        else
        {
            Log::record("{$this->desc}异步通知：" . "交易失败！订单号：" . $orderId . "，参数：" . json_encode($post), Log::ERR);
            exit('验签失败');
        }
    }

    //无同步回调地址
    public function callbackurl()
    {
    }

    /**
     * 生成签名
     *
     * @param $arr array 表单参数
     * @param $signKey string 秘钥
     *
     * @return string 生成的key
     */
    private function makeSign($arr, $signKey)
    {
        ksort($arr);
        $signSrc = '';
        foreach($arr as $k => $v)
        {
            $signSrc .= $k . "=" . $v . "&";
        }

        $stringA        = substr($signSrc, 0, strlen($signSrc) - 1);
        $stringSignTemp = $stringA . "&key=" . $signKey;
        $signValue      = hash_hmac('sha256', $stringSignTemp, $signKey);
        return strtoupper($signValue);
    }


    /**
     * 校验签名
     *
     * @param $arr 表单参数
     * @param $signKey 秘钥
     *
     * @return bool 校验值
     */
    private function verifySign($arr, $signKey)
    {
        if(!is_array($arr))
        {
            $arr = json_decode($arr, true);
        }

        $sign = $arr['sign'];
        unset($arr['sign']);
        $server_sign = self::makeSign($arr, $signKey);

        if($sign == $server_sign)
        {
            return true;
        }

        return false;
    }

    public function log()
    {
        file_put_contents("./Data/{$this->code}_notify.txt",
            "【" . date('Y-m-d H:i:s') . "】\r\n" . file_get_contents("php://input") . "\r\n\r\n", FILE_APPEND);
//        file_put_contents("./Data/{$this->code}_notify.txt",
//            "【" . date('Y-m-d H:i:s') . "】\r\n" . $_SERVER["QUERY_STRING"] . "\r\n\r\n", FILE_APPEND);
//        file_put_contents("./Data/{$this->code}_notify.txt",
//            "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($_REQUEST) . "\r\n\r\n", FILE_APPEND);
    }

    /**
     * @param $url 执行请求的URL
     * @param $jsonStr 表单参数
     *
     * @return array
     */
    private function makeRequest($url, $jsonStr)
    {
        $header[] = "Content-type: text/xml";
        $ch       = curl_init();
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonStr);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        return array($httpCode, $response);
    }

    /**
     * XML编码
     *
     * @param mixed  $data 数据
     * @param string $encoding 数据编码
     * @param string $root 根节点名
     *
     * @return string
     */
    private function xml_encode($data, $encoding = 'utf-8', $root = 'xml')
    {
        $xml = '<?xml version="1.0" encoding="' . $encoding . '"?>';
        $xml .= '<' . $root . '>';
        $xml .= $this->data_to_xml($data);
        $xml .= '</' . $root . '>';
        return $xml;
    }

    /**
     * 数据XML编码
     *
     * @param mixed $data 数据
     *
     * @return string
     */
    private function data_to_xml($data)
    {
        $xml = '';
        foreach($data as $key => $val)
        {
            is_numeric($key) && $key = "item id=\"$key\"";
            $xml .= "<$key>";
            $xml .= (is_array($val) || is_object($val)) ? $this->data_to_xml($val) : $val;
            list($key,) = explode(' ', $key);
            $xml .= "</$key>";
        }
        return $xml;
    }
}