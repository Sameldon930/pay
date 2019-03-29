<?php
namespace Payment\Controller;
//首信易支付代付

class PayeaseController extends PaymentController
{
    //提交代付接口地址
    private $gateway = 'http://pay.yizhifubj.com/merchant/virement/mer_payment_submit_utf8.jsp';
    //查询代付接口地址
    private $queryUrl = 'https://pay.yizhifubj.com/merchant/virement/mer_payment_status_utf8.jsp';
    //查询余额接口地址
    private $balanceUrl = 'https://pay.yizhifubj.com/merchant/virement/mer_payment_balance_check.jsp';

    public function PaymentExec($data, $config)
    {
		if($data['extends']) {
			$extends = json_decode($data['extends'], true);
            if(!isset($extends['bankNo']) || !$extends['bankNo']) {
                $return = ['status' => 0, 'msg' => '缺少联行号!'];
                return $return;
            }
		} else {
			if(!isset($data['additional'][0]) || !$data['additional'][0]){
				$return = ['status' => 0, 'msg' => '缺少联行号!'];
				return $return;
			}
			$extends['bankNo'] = $data['additional'][0];
		}
        $v_mid = $config['mch_id'];
        $v_version = '1.0';
        //$v_data="行数|代付总金额|商户号-时间-流水号$卡号|姓名|银行名称|省份|城市|金额|客户标示|联行号";
        $v_data = "1|".number_format($data['money'],2,'.','')."|";
        $v_data .= $v_mid.'-'.date('Ymd')."-".$data['id'].'$'.$data['banknumber']."|";
        $v_data .= $data['bankfullname']."|".$data['bankname']."|".$data['sheng']."|".$data['shi']."|";
        $v_data .= $data['bankfullname']."|".number_format($data['money'],2,'.','')."|";
        $v_data .= $data['orderid']."|".$extends['bankNo'];

        $data = $v_mid.$v_data;//两个参数的拼串
        $data = urlencode($data);
        $pubKey = file_get_contents('./cert/payease/'.$config['mch_id'].'/cfca_privatekey.pfx');
        $results = [];
        openssl_pkcs12_read($pubKey, $results, $config['appsecret']);
        openssl_sign($data, $v_md5info, $results['pkey']);
        $v_mac = bin2hex($v_md5info);

        $curlPost ="v_mid=".$v_mid;

        $curlPost.="&v_version=".$v_version;

        $curlPost.="&v_data=".$v_data;

        $curlPost.="&v_mac=".$v_mac;
        file_put_contents('./Data/payease.txt', "【".date('Y-m-d H:i:s')."】\r\n代付提交参数：".$curlPost."\r\n\r\n",FILE_APPEND);
        $result = curlPost($this->gateway,$curlPost);
        file_put_contents('./Data/payease.txt', "【".date('Y-m-d H:i:s')."】\r\n代付返回参数：".$result."\r\n\r\n",FILE_APPEND);
        if($result) {
            $result = simplexml_load_string($result);
            if($result->status === 0) {
                $return = ['status' => 1, 'msg' => '处理中'];
            } else {
                $return = ['status' => 3, 'msg' => $result->statusdesc];
            }
        } else {
            $return = ['status' => 3, 'msg' => '请求接口失败'];
        }
        return $return;
    }

    //查询代付订单状态
    public function PaymentQuery($data, $config)
    {
        $v_mid = $config['mch_id'];
        $v_version = '1.0';
        $v_data = $data['orderid'];

        $data = $v_mid.$v_data;//两个参数的拼串
        $data = urlencode($data);
        $pubKey = file_get_contents('./cert/payease/'.$config['mch_id'].'/cfca_privatekey.pfx');
        $results = [];
        openssl_pkcs12_read($pubKey, $results, $config['appsecret']);
        openssl_sign($data, $v_md5info, $results['pkey']);
        $v_mac = bin2hex($v_md5info);

        $curlPost ="v_mid=".$v_mid;

        $curlPost.="&v_version=".$v_version;

        $curlPost.="&v_data=".$v_data;

        $curlPost.="&v_mac=".$v_mac;
        file_put_contents('./Data/payease.txt', "【".date('Y-m-d H:i:s')."】\r\n代付查询提交参数：".$curlPost."\r\n\r\n",FILE_APPEND);
        $result = curlPost($this->queryUrl,$curlPost);
        file_put_contents('./Data/payease.txt', "【".date('Y-m-d H:i:s')."】\r\n代付查询返回参数：".$curlPost."\r\n\r\n",FILE_APPEND);
        if($result) {
            $result = simplexml_load_string($result);
            switch ($result->status) {
                case '0':
                    $return = ['status' => 1, 'msg' => '未处理'];
                    break;
                case '1':
                    $return = ['status' => 2, 'msg' => '已成功'];
                    break;
                case '2':
                    $return = ['status' => 1, 'msg' => '处理中'];
                    break;
                case '3':
                    $return = ['status' => 3, 'msg' => '已失败'];
                    break;
                case '4':
                    $return = ['status' => 1, 'msg' => '待处理'];
                    break;
                case '8':
                    $return = ['status' => 3, 'msg' => '没有该用户标识对应的代付记录'];
                    break;
                case '9':
                    $return = ['status' => 3, 'msg' => '查询失败'];
                    break;
                default:
                    $return = ['status' => 3, 'msg' => $result->statusdesc];
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
            $config = M('PayForAnother')->where(['code' => 'Payease'])->find();
            if(empty($config)) {
                $this->ajaxReturn(['status' => 0, 'msg' => '代付渠道不存在']);
            }
            $v_mid = $config['mch_id'];
            $v_version = '1.0';

            $data = $v_mid;
            $data = urlencode($data);
            $pubKey = file_get_contents('./cert/payease/'.$config['mch_id'].'/cfca_privatekey.pfx');
            $results = [];
            openssl_pkcs12_read($pubKey, $results, $config['appsecret']);
            openssl_sign($data, $v_md5info, $results['pkey']);
            $v_mac = bin2hex($v_md5info);

            $curlPost ="v_mid=".$v_mid;

            $curlPost.="&v_version=".$v_version;

            $curlPost.="&v_mac=".$v_mac;

            $result = curlPost($this->balanceUrl, $curlPost);
            if($result) {
                $result = simplexml_load_string($result);
                if($result->messagehead->status === 0) {
                    $data = [
                                [
                                    'key'   => '代付余额',
                                    'value' => $result->body->v_balance,
                                ]
                            ];
                    $this->assign('data', $data);
                    $html = $this->fetch('Public/queryBalance');
                    $this->ajaxReturn(['status' => 1, 'msg' => '成功', 'data' => $html]);
                } else {
                    $this->ajaxReturn(['status' => 0, 'msg' => (string)$result->messagehead->statusdesc]);
                }
            } else {
                $this->ajaxReturn(['status' => 0, 'msg' => '请求接口失败']);
            }
        }
    }

    //异步通知
    public function notifyurl()
    {

    }
}
