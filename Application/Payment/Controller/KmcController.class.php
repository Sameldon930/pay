<?php
/**
 * Created by PhpStorm.
 * User: mapeijian
 * Date: 2018-08-15
 * Time: 17:33
 */
/** 凯美晨代付 **/
namespace Payment\Controller;
use Org\Util\Kmc\pkg8583;

class KmcController extends PaymentController
{
    public $gateway = 'http://online.lhsjsz.com:11088/webservice/order';

    public function PaymentExec($data, $config)
    {
        if($data['extends']) {
            $extends = json_decode($data['extends'], true);
            if(!isset($extends['mobile']) || !$extends['mobile']) {
                $return = ['status' => 0, 'msg' => '缺少银行预留手机号!'];
                return $return;
            }
            if(!isset($extends['bankNo']) || !$extends['bankNo']) {
                $return = ['status' => 0, 'msg' => '缺少收款银行联行号!'];
                return $return;
            }
        } else {
            if(!isset($data['additional'][0]) || !$data['additional'][0]){
                $return = ['status' => 0, 'msg' => '缺少银行预留手机号!'];
                return $return;
            }
            if(!isset($data['additional'][1]) || !$data['additional'][1]){
                $return = ['status' => 0, 'msg' => '缺少收款银行联行号!'];
                return $return;
            }
            $extends['mobile'] = $data['additional'][0];
            $extends['bankNo'] = $data['additional'][1];
        }
        $info = $data['bankfullname'].'|'.$data['banknumber'].'|'.$data['bankname'].'|'.$extends['bankNo'].'|'.$extends['mobile'].'|';
        $pkg8583 = new pkg8583();
        $pkg8583->setTxcode("F60007");
        $pkg8583->setTxdate(date('Ymd'));
        $pkg8583->setTxtime(date('His'));
        $pkg8583->setVersion("2.0.0");
        $pkg8583->setField003("000000");
        $pkg8583->setField004((string)($data['money']*100));
        $pkg8583->setField011("000000");
        $pkg8583->setField031("0");
        $pkg8583->setField041($config['mch_id']);//客户号
        $pkg8583->setField042($config['appid']);//商户号
        $pkg8583->setField048($data['orderid']);
        $pkg8583->setField055($info);//收款方信息
        $pkg8583->setField125($config['mch_id'] . date('mdHis') . rand(10, 99));
        $signStr = $pkg8583->getSignData() . $config['signkey'];
        $signStr = mb_convert_encoding($signStr, "GBK", "utf-8");
        $signStr = strtoupper(md5($signStr));
        $signStr = substr($signStr, 0, 16);
        $pkg8583->setField128($signStr);
        $jsonStr = $pkg8583->getJsonStr();
        file_put_contents('./Data/KmcDf.txt', "【" . date('Y-m-d H:i:s') . "】\r\n代付提交:" . $jsonStr . "\r\n\r\n", FILE_APPEND);
        list($returnCode, $returnContent) = $this->http_post_json($this->gateway, $jsonStr);
        file_put_contents('./Data/KmcDf.txt', "【" . date('Y-m-d H:i:s') . "】\r\n代付返回:" . $returnContent . "\r\n\r\n", FILE_APPEND);
        $result = json_decode($returnContent, true);
        if ($result['field039'] == '00') {
            $return = ['status' => 1, 'msg' => $result['field124']];
        } else {
            $return = ['status' => 3, 'msg' => $result['field124']];
        }
        return $return;
    }

    public function PaymentQuery($data, $config)
    {
        $pkg8583 = new pkg8583();
        $pkg8583->setTxcode("F60008");
        $pkg8583->setTxdate(date('Ymd'));
        $pkg8583->setTxtime(date('His'));
        $pkg8583->setVersion("2.0.0");
        $pkg8583->setField003("000000");
        $pkg8583->setField011("000000");
        $pkg8583->setField041($config['mch_id']);//客户号
        $pkg8583->setField042($config['appid']);//商户号
        $pkg8583->setField048($data['orderid']);
        $pkg8583->setField125($config['mch_id'] . date('mdHis') . rand(10, 99));
        $signStr = $pkg8583->getSignData() . $config['signkey'];
        $signStr = mb_convert_encoding($signStr, "GBK", "utf-8");
        $signStr = strtoupper(md5($signStr));
        $signStr = substr($signStr, 0, 16);
        $pkg8583->setField128($signStr);
        $jsonStr = $pkg8583->getJsonStr();
        file_put_contents('./Data/KmcDf.txt', "【" . date('Y-m-d H:i:s') . "】\r\n代付查询提交:" . $jsonStr . "\r\n\r\n", FILE_APPEND);
        list($returnCode, $returnContent) = $this->http_post_json($this->gateway, $jsonStr);
        file_put_contents('./Data/KmcDf.txt', "【" . date('Y-m-d H:i:s') . "】\r\n代付查询返回:" . $returnContent . "\r\n\r\n", FILE_APPEND);
        if($returnContent) {
            $result = json_decode($returnContent, true);
            switch ($result['field039']) {
                case '00':
                    $return = ['status' => 2, 'msg' => '代付成功'];
                    break;
                case '01':
                    $return = ['status' => 1, 'msg' => '未代付'];
                    break;
                case '02':
                    $return = ['status' => 1, 'msg' => '代付中'];
                    break;
                case '03':
                    $return = ['status' => 1, 'msg' => '代付失败'];
                    break;
                default:
                    $return = ['status' => 3, 'msg' => $result['field124']];
                    # code...
                    break;
            }
        } else {
            $return = ['status' => 3, 'msg' => '请求接口失败'];
        }
        return $return;
    }

    //查询余额
    public function queryBalance()
    {
        if (IS_AJAX) {
            $config = M('PayForAnother')->where(['code' => 'Kmc'])->find();
            if(empty($config)) {
                $this->ajaxReturn(['status' => 0, 'msg' => '代付渠道不存在']);
            }
            $pkg8583 = new pkg8583();
            $pkg8583->setTxcode("F60012");
            $pkg8583->setTxdate(date('Ymd'));
            $pkg8583->setTxtime(date('His'));
            $pkg8583->setVersion("2.0.0");
            $pkg8583->setField003("000000");
            $pkg8583->setField011("000000");
            $pkg8583->setField041($config['mch_id']);//客户号
            $pkg8583->setField042($config['appid']);//商户号
            $pkg8583->setField125($config['mch_id'] . date('mdHis') . rand(10, 99));
            $signStr = $pkg8583->getSignData() . $config['signkey'];
            $signStr = mb_convert_encoding($signStr, "GBK", "utf-8");
            $signStr = strtoupper(md5($signStr));
            $signStr = substr($signStr, 0, 16);
            $pkg8583->setField128($signStr);
            $jsonStr = $pkg8583->getJsonStr();
            list($returnCode, $returnContent) = $this->http_post_json($this->gateway, $jsonStr);
            if($returnContent) {
                $result = json_decode($returnContent, true);
                if($result['field039'] == '00') {
                    $result['balance'] = $result['field055']/100;
                    $data = [
                        [
                            'key'   => '账户余额',
                            'value' => $result['balance'] . '元',
                        ],
                    ];
                    $this->assign('data', $data);
                    $html = $this->fetch('Public/queryBalance');
                    $this->ajaxReturn(['status' => 1, 'msg' => '成功', 'data' => $html]);
                } else {
                    $this->ajaxReturn(['status' => 0, 'msg' => $result['field124']]);
                }
            } else {
                $this->ajaxReturn(['status' => 0, 'msg' => '请求接口失败']);
            }
        }
    }

    //发送post请求，提交json字符串
    private function http_post_json($url, $jsonStr)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonStr);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json; charset=utf-8',
                'Content-Length: ' . strlen($jsonStr)
            )
        );
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        return array($httpCode, $response);
    }
}