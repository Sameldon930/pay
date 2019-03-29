<?php
/**
 * Created by PhpStorm.
 * User: win 10
 * Date: 2018/6/11
 * Time: 11:41
 */

namespace Payment\Controller;

use think\Log;

/**
 * 迅捷付
 *
 * Class XunjiefuController
 * @package Payment\Controller
 */
class XunjiefuController extends PaymentController
{
    const PRIVATE_KEY_PATH = '/home/wwwroot/pay/cert/xjf/1005227_prv.pem';
//    const PRIVATE_KEY_PATH = 'C:\Users\jianzhiyao\Downloads\1005227\1005227_prv.pem';
    const PUBLIC_KEY_PATH = '/home/wwwroot/pay/cert/xjf/1005227_pub.pem';
//    const PUBLIC_KEY_PATH = 'C:\Users\jianzhiyao\Downloads\1005227\1005227_pub.pem';

    //代付状态
    const PAYMENT_SUBMIT_SUCCESS = 1; //处理中
    const PAYMENT_PAY_SUCCESS    = 2; //已打款
    const PAYMENT_PAY_FAILED     = 3; //已驳回
    const PAYMENT_PAY_UNKNOWN    = 4; //待确认


    public function __construct()
    {
        parent::__construct();
    }

    public function test()
    {
//        $config = M('pay_for_another')->where([
//            'id' => 2
//        ])->find();
//
//
//        $data = M('wttklist')->where([
//            'id' => 12,
//        ])->find();

//        $this->PaymentQuery($data, $config);
//        $this->PaymentExec($data, $config);
    }

    public function PaymentExec($data, $config)
    {
        $mchId = $config['mch_id'];//代理商商户号

        $postData = [
            'version'       => '1.0.0',
            'transType'     => 'PROXY_PAY',
            'productId'     => 0 ? '8001' : '8002',//T1 T0,
            'merNo'         => $mchId,
            'orderDate'     => date('Ymd'),
            'orderNo'       => $data['orderid'],
            'transAmt'      => intval(round($data['money'], 2) * 100),
            'commodityName' => '代付提现',
            //            'phoneNo'       => '',
            'cardNo'        => $data['banknumber'],
            'cardName'      => $data['bankfullname'],
            //            'cerdId'        => '',
            'notifyUrl'     => sprintf(
                '%s://%s:%d/Payment_Xxunjiefu_notifyurl.html',
                is_https() ? 'https' : 'http',
                $_SERVER['SERVER_NAME'],
                $_SERVER["SERVER_PORT"]
            ),
        ];


        $response = $this->requestOrder($postData);

        if(empty($response))
        {
            $return = ['status' => self::PAYMENT_PAY_FAILED, 'msg' => "错误：服务不可用"];
        }
        else
        {
            if($response['respCode'] == '0000')
            {
                $return = ['status' => self::PAYMENT_SUBMIT_SUCCESS, 'msg' => '提交成功'];
            }
            else if($response['respCode'] == 'P000')
            {
                $return = ['status' => self::PAYMENT_SUBMIT_SUCCESS, 'msg' => '处理中'];
            }
            else
            {
                $return = [
                    'status' => self::PAYMENT_PAY_FAILED,
                    'msg'    => "错误：{$response['respCode']}：{$response['respDesc']}"
                ];
            }
        }

        return $return;
    }

    public function PaymentQuery($data, $config)
    {
        $mchId = $config['mch_id'];//代理商商户号

        $postData = [
            'version'   => '1.0.0',
            'transType' => 'TRANS_QUERY',
            'productId' => '0000',
            'merNo'     => $mchId,
            'orderId'   => $data['orderid'],
        ];


        $response = $this->queryOrder($postData);

        if(empty($response))
        {
            $return = ['status' => self::PAYMENT_PAY_FAILED, 'msg' => "错误：服务不可用"];
        }
        else
        {
            if($response['oRespCode'] == '0000')
            {
                $return = ['status' => self::PAYMENT_PAY_SUCCESS, 'msg' => "交易成功"];
            }
            else if($response['respCode'] == 'P000')
            {
                $return = ['status' => self::PAYMENT_SUBMIT_SUCCESS, 'msg' => '处理中'];
            }
            else
            {
                $return = [
                    'status' => self::PAYMENT_PAY_FAILED,
                    'msg'    => "错误：{$response['oRespCode']}：{$response['oRespDesc']}"
                ];
            }
        }

        return $return;
    }

    public function notifyurl()
    {
        exit('ok');
    }

    protected function requestOrder($postData)
    {
        $this->sign($postData, file_get_contents(self::PRIVATE_KEY_PATH));//demo
        $postdata = http_build_query($postData);
        $options  = array(
            'http' => array(
                'method'  => 'POST',
                'header'  => 'Content-type:application/x-www-form-urlencoded',
                'content' => $postdata,
                'timeout' => 15 * 60 // 超时时间（单位:s）
            )
        );
        $context  = stream_context_create($options);
        $result   = file_get_contents("http://pay88.cat39.com/transck/trans/api/back.json", false, $context);

        return json_decode($result, true) ?: [];
    }

    protected function queryOrder($postData)
    {
        $this->sign($postData, file_get_contents(self::PRIVATE_KEY_PATH));//demo
        $postdata = http_build_query($postData);
        $options  = array(
            'http' => array(
                'method'  => 'POST',
                'header'  => 'Content-type:application/x-www-form-urlencoded',
                'content' => $postdata,
                'timeout' => 15 * 60 // 超时时间（单位:s）
            )
        );
        $context  = stream_context_create($options);
        $result   = file_get_contents("http://pay88.cat39.com/trans/trans/api/back.json", false, $context);

        return json_decode($result, true) ?: [];
    }


    protected function sign(&$post_data, $pkString = '')
    {
        ksort($post_data);

        $temp = '';
        foreach($post_data as $key => $value)
        {
            $temp = $temp . $key . '=' . $value . '&';
        }

        $privateKey = openssl_pkey_get_private($pkString);

        $temp = substr($temp, 0, strlen($temp) - 1);

        openssl_sign($temp, $sign, $privateKey, OPENSSL_ALGO_SHA1);

        $sign = base64_encode($sign);

        $post_data['signature'] = $sign;
    }

    /**
     * 验签
     *
     * @param $notifyResult
     *
     * @return bool
     */
    public function verify($notifyResult)
    {
        //获取签名数据并从返回数据中移除
        $sign = $notifyResult['signature'];
        unset($notifyResult['signature']);

        //对返回数据按 ascii 方式排序   注意：如果值为空  不参与签名
        ksort($notifyResult);
        $temp = '';
        foreach($notifyResult as $key => $value)
        {
            $temp = $temp . $key . '=' . $value . '&';
        }
        $temp = substr($temp, 0, strlen($temp) - 1);


        $publicKey =
            openssl_pkey_get_public(file_get_contents(self::PUBLIC_KEY_PATH));
        if(openssl_verify($temp, base64_decode($sign), $publicKey, OPENSSL_ALGO_SHA1))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}