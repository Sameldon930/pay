<?php
namespace Pay\Controller;

use Think\Log;

class AliFriendPayController extends PayController
{
    private $code = '';

    public function __construct()
    {
        parent::__construct();
        $matches = [];
        preg_match('/([\da-zA-Z\_]+)Controller$/', __CLASS__, $matches);
        $this->code = $matches[1];
    }

    //支付
    public function Pay($array)
    {
        $orderid = I("request.pay_orderid", '');
        $body = I('request.pay_productname', '');
        $memberid = I('request.pay_memberid', '');

        //创建订单
        $return = $this->creatorder($array, $orderid, $body);
        $pay_info = M('order')->where(['out_trade_id' => $orderid])->field('account_id,channel_id,pay_orderid,pay_callbackurl,pay_tongdao')->find();
        
        
        //如果生成错误，自动跳转错误页面
        $return["status"] == "error" && $this->showmessage($return["errorcontent"]);
        //跳转页面，优先取数据库中的跳转页面
        $site = trim($return['unlockdomain']) ? $return['unlockdomain'] . '/' : $this->_site;
        $gateway = "{$site}Pay_{$this->code}_Rpay.html";
        //$return["notifyurl"] || $return["notifyurl"] = "{$site}Pay_{$this->code}_notifyurl.html";
        //$return['callbackurl'] || $return['callbackurl'] = "{$site}Pay_{$this->code}_callbackurl.html";
        $return["notifyurl"]  = $this->_apiSite."Pay_{$this->code}_notifyurl.html";
        $return['callbackurl']  = $this->_apiSite."Pay_{$this->code}_callbackurl.html";

        $native = array(
            "uid" => $return['mch_id'], //商户uid
            "nonceStr" => time(),   //随机字符串
            "price" => intval($return['amount'] * 100), //金额
            "type" => "alipayFriend", //支付渠道
            "notifyUrl" => $return["notifyurl"], //通知回调网址
            "outTradeNo" => $return['orderid'],  //商户自定义订单号
            "orderuid" => $memberid,       //商户自定义客户号
            "state" => 12,       //商户自定义客户号
            "key" => $return['signkey'], //秘钥
        );
        $native['sign'] = $this->ZFBS1Sign($native);                //签名
        //拼装json
        $jsonData = '{
            "uid" : "' . $native['uid'] . '",
            "nonceStr" : "' . $native['nonceStr'] . '",
            "price" : "' . $native['price'] . '",
            "type" : "' . $native['type'] . '",
            "notifyUrl" : "' . $native['notifyUrl'] . '",
            "outTradeNo" : "' . $native['outTradeNo'] . '",
            "state" : "' . $native['state'] . '",
            "sign" : "' . $native['sign'] . '",
        }';
        file_put_contents('./Data/'.$pay_info['pay_tongdao'].'.txt', "【" . date('Y-m-d H:i:s') . "】\r\转账下单返回参数0!" . $jsonData . "\r\n\r\n", FILE_APPEND);
        //$reInfo = json_decode($this->post_json_data('http://biu.haohan168.cn/order/api/pay', $jsonData), true);
        $reInfo = json_decode($this->post_json_data($return["gateway"].'/order/api/pay', $jsonData), true);
        file_put_contents('./Data/'.$pay_info['pay_tongdao'].'.txt', "【" . date('Y-m-d H:i:s') . "】\r\转账下单返回参数1!" . json_encode($reInfo) . "\r\n\r\n", FILE_APPEND);
        if ($reInfo['errCode'] === 0) {
            $result = json_decode($reInfo['data'], true);
            $price= $result['price'] / 100;
            $checkurl     = "{$site}Pay_{$this->code}_Check.html?id=".$return['orderid'];//查单地址
            $callbackUrl = "{$site}Pay_{$this->code}_callbackurl.html?orderid=".$return['orderid'];//回调地址
            $mysign=substr(md5('zf'.$result['outTradeNo'].'zf'),-4);
            $second_url="{$site}Pay_{$this->code}_secondCheck.html?id=".$result['outTradeNo'].'&sign='.$mysign;
            //添加到订单的qrcode
            //$url= "{$site}Pay_{$this->code}_thirdCheck.html?outTradeNo=".$return['orderid']."&userId=".$result['alipayUserId']."&price=".$price."&loginId=".$result['alipayUserAccount']."&gumaSign={$this->code}";
            $url= "{$site}Pay_{$this->code}_thirdCheck.html?outTradeNo=".$return['orderid']."&userId=".$result['alipayUserId']."&price=".$price."&loginId=".$result['alipayUserAccount'];
            $up_result=M('Order')->where(['pay_orderid' => $result['outTradeNo']])->save(array('attach'=>$url));
            file_put_contents('./Data/'.$pay_info['pay_tongdao'].'.txt', "【" . date('Y-m-d H:i:s') . "】\r\url!" . $url . "\r\n\r\n", FILE_APPEND);
            //$return['amount']= $result['price'] / 100;
            /*
             * alipayUserId 支付宝用户编号
             *alipayUserAccount 支付宝账号
             *alipayUserName 支付宝用户名
             *
             * */
            ;
            $btnUrl="alipayqr://platformapi/startapp?saId=10000007&qrcode=".urlencode($second_url);
            $deskur="{$site}Pay_{$this->code}_cashierDesk.html?id=".$return['orderid'];
            //echo $second_url;
            $returnPara = array(
                "url" => $deskur, //商户uid
            );
            $this->showSuccess("成功",$returnPara);

            /*if(strpos($_SERVER['HTTP_USER_AGENT'], 'ReadData')!==false){

                //header('Location:' . $aliurl);
                echo $btnUrl;
            }else{
                $this->assign([
                    'callbackUrl' => $callbackUrl,//成功跳转页面
                    'checkurl' => $checkurl,//查单
                    'orderid' => $return['orderid'],
                    'body' => $body,
                    'price' => $price,//实际金额
                    'money' => $return['amount'],//金额
                    'url' => urlencode($second_url),//二维码
                    'btnUrl'       => $btnUrl,//点击
                ]);
                file_put_contents('./Data/'.$pay_info['pay_tongdao'].'.txt', "【" . date('Y-m-d H:i:s') . "】\r\返回页面参数!" . json_encode($this) . "\r\n\r\n", FILE_APPEND);
                $this->display('AliNewpay/aliFriend');
            }*/
        } else {
            $this->showmessage("系统繁忙，请联系客服!");
        }
    }


    /**
     * 发起支付操作
     */
    public function Rpay()
    {
        //接收传输的数据
        $postData = I('post.', '');
        //将数据解密并反序列化
        $formData = unserialize(encryptDecrypt($postData['data'], md5(md5(C('DB_PWD'))), 1));
        $this->showQRcode($formData['url'], $formData['return'], $formData['view']);
    }

    //同步通知
    public function callbackurl()
    {
        $out_trade_no = I('get.orderid', '', 'string,strip_tags,htmlspecialchars');
        $pay_info = M('order')->where(['pay_orderid' => $out_trade_no])->field('account_id,channel_id,pay_orderid,pay_callbackurl,pay_tongdao,pay_status')->find();
        $pay_status = $pay_info['pay_status'];

        file_put_contents('./Data/'.$pay_info['pay_tongdao'].'.txt', "【" . date('Y-m-d H:i:s') . "】\r\n-----" . $pay_status . "\r\n\r\n", FILE_APPEND);
        if ($pay_status <> 0) {
            //业务逻辑开始、并下发通知.
            $this->EditMoney($out_trade_no, '', 1);
        } else {
            exit('error');
        }
    }

    //异步通知
    public function notifyurl()
    {
        $res = file_get_contents("php://input");
        $result = json_decode($res, true);
        if (!$result['outTradeNo']) return;
        $pay_info = $orderList = M('Order')->where(['pay_orderid' => $result['outTradeNo']])->find();

        if (!$orderList) return;
        $res_str = "nonceStr=" . $result["nonceStr"] . "&outTradeNo=" . $result['outTradeNo'] . "&payState=" . $result["payState"] . "&payTime=" . $result["payTime"] . "&price=" . $result["price"] . "&type=" . $result["type"] . "&uid=" . $result["uid"] . "&key=" . $orderList['key'];

        $sign = md5($res_str);
        if ($sign == $result["sign"]) {
            if ($result['payState'] == "SUCCESS") {
                //$this->edit_order($result['outTradeNo'], $result['price'] / 100);
                $this->EditMoney($result['outTradeNo'], $pay_info['pay_tongdao'], 0);
                echo "SUCCESS";
                return;
            }
        } else {
            echo "签名错误！  " . $res;
        }

    }


    /**
     * 创建订单
     * @param $array
     * @param $orderid
     * @param $body
     * @return array
     */
    private function creatorder($array, $orderid, $body)
    {
        $parameter = [
            'code' => $this->code,
            'title' => 'Ar好友收款',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => $orderid, //外部订单号
            'channel' => $array,
            'body' => $body,
        ];
        // 订单号，可以为空，如果为空，由系统统一的生成
        return $this->orderadd($parameter);
    }

    /**
     * post提交
     * @param $url
     * @param $data
     * @return string
     */
    function post_json_data($url, $data_string)
    {
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json; charset=utf-8',
                'Content-Length: ' . strlen($data_string))
        );
        ob_start();
        curl_exec($ch);
        $return_content = ob_get_contents();
        ob_end_clean();
        $return_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        return $return_content;
    }

    //下单签名
    function ZFBS1Sign($dat)
    {

        $str = 'nonceStr=' . $dat['nonceStr'] . '&notifyUrl=' . $dat['notifyUrl'] . '&outTradeNo=' . $dat['outTradeNo'] . '&price=' . $dat['price'] .'&state=' . $dat['state'] . '&type=' . $dat['type'] . '&uid=' . $dat['uid'] . '&key=' . $dat['key'];
        return md5($str);
    }


    /**
     *  过滤敏感信息
     */
    private function filterData($return)
    {
        unset($return['mch_id']);//商户id
        unset($return['signkey']);
        unset($return['appid']);
        unset($return['appsecret']);
        return $return;
    }


    /**
     * 订单支付状态查询
     */
    public function check()
    {
        //接收传输的数据
        $getData = I('get.', '');
        //将数据解密并反序列化
        /*$mysing=md5('wmzf'.$getData['id'].'wmzf');
        if ($getData['sign'] !=  $mysing) {
          $this->ajaxreturn(array('code' =>00, 'msg'=>'签名错误!'));
          exit();
        }*/

        $pay_info = M("Order")->where(array('pay_orderid' =>$getData['id']))->field("pay_status,pay_tongdao")->find();
        
        //file_put_contents('./Data/'.$pay_info['pay_tongdao'].'.txt', "【" . date('Y-m-d H:i:s') . "】\r\转账下单返回参数!" . json_encode($pay_info) . "\r\n\r\n", FILE_APPEND);
        if ( $pay_info['pay_status'] == 0) {
            $this->ajaxreturn(array('code' =>100, 'msg'=>'等待支付'));
        } else {
            $this->ajaxreturn(array('code' =>200, 'msg'=>'订单已经支付过了'));
        }
    }


    function secondCheck(){
        //接收传输的数据
        $getData = I('get.', '');
        //将数据解密并反序列化
        $mysing=substr(md5('zf'.$getData['id'].'zf'),-4);
        if ($getData['sign'] !=  $mysing) {
            $this->ajaxreturn(array('code' =>00, 'msg'=>'签名错误!'));
            exit();
        }
        $pay_info = M("Order")->where(array('pay_orderid' =>$getData['id']))->field('attach,pay_tongdao')->find();
        
        file_put_contents('./Data/'.$pay_info['pay_tongdao'].'.txt', "【" . date('Y-m-d H:i:s') . "】\r\进入二次跳转！".$pay_info['attach']. "\r\n\r\n", FILE_APPEND);
        $gumaUrl="http://route.haohan168.cn:8888/?returnUrl=".urlencode($pay_info['attach']);
        if ($pay_info['attach']) {
            //$url=$pay_info['qrurl'];
            header('Location: '.$gumaUrl);
        }else{
            exit('下单失败！请重试！');
        }
    }

    function thirdCheck(){

        //接收传输的数据
        $getData = I('get.', '');
        $site = $this->_site;
        $checkurl     = "{$site}Pay_{$this->code}_Check.html?id=".$getData['outTradeNo'];//查单地址
        $pay_info = M("Order")->where(array('pay_orderid' =>$getData['outTradeNo']))->field('attach,pay_tongdao,channel_id')->find();
        
        if ($getData['loginId']!=null){
            //file_put_contents('./Data/'.$pay_info['pay_tongdao'].'.txt', "【" . date('Y-m-d H:i:s') . "】\r\loginID已存在！".json_encode($getData) ."\r\n\r\n", FILE_APPEND);
            if(strpos($pay_info['attach'],'alipayUserId') ==false){
                $up_result_u=M('Order')->where(['pay_orderid' => $getData['outTradeNo']])->save(array('attach'=>$pay_info['attach'].'&alipayUserId='.$getData['aUserId']));
            }

            $this->assign([
                'userId' => $getData['userId'],
                'checkurl' => $checkurl,
                'remarks' => $getData['loginId'],
                'tradeMemo' => $_GET['outTradeNo'],
                'price' => $getData['price'],//实际金额
                'isReload' => 0//实际金额
            ]);
            $this->display('AliNewpay/friendAI');
        }else{
            //file_put_contents('./Data/'.$pay_info['pay_tongdao'].'.txt', "【" . date('Y-m-d H:i:s') . "】\r\loginID不存在！".json_encode($getData) ."\r\n\r\n", FILE_APPEND);
            $param=explode("?",$pay_info['attach']);
            $aiUrl= "{$site}Application/Pay/View/AliNewpay/searchOrder.html?".$param[1];

            $channel = M('Channel')->where(['id' => $pay_info['channel_id']])->field("gateway,code")->find();

            $getQrUrl= $channel['gateway']."/friend/getQrCode?outTradeNo=".$getData['outTradeNo'];
            $arr_query = explode('&', $param[1]);

            $outTradeNo=explode('=',  $arr_query[0]);
            $alipayUserId=explode('=',  $arr_query[4]);
            //拼装json
            $jsonData = '{
                 "alipayUserId" : "' . $alipayUserId[1]. '",
                 "outTradeNo" : "' . $outTradeNo[1] . '"
			}';
            //file_put_contents('./Data/'.$pay_info['pay_tongdao'].'.txt', "【" . date('Y-m-d H:i:s') . "】\r\-URL参数：" . $jsonData. "\r\n\r\n", FILE_APPEND);
            $gmInfo = json_decode($this->post_json_data($channel['gateway'].'/friend/noticeClient', $jsonData), true);
            //file_put_contents('./Data/'.$pay_info['pay_tongdao'].'.txt', "【" . date('Y-m-d H:i:s') . "】\r\-*****!" . $gmInfo. "\r\n\r\n", FILE_APPEND);
            $callbackUrl = "{$site}Pay_{$this->code}_callbackurl.html?orderid=".$getData['outTradeNo'];//回调地址
            //file_put_contents('./Data/'.$pay_info['pay_tongdao'].'.txt', "【" . date('Y-m-d H:i:s') . "】\r\---+++-!" . $aiUrl."&checkurl=".urlencode($checkurl)."&callbackUrl=".urlencode($callbackUrl). "\r\n\r\n", FILE_APPEND);
            header('Location: '.$aiUrl."&checkurl=".urlencode($checkurl)."&callbackUrl=".urlencode($callbackUrl)."&getQrUrl=".urlencode($getQrUrl));
        }

    }



}
