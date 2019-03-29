<?php

$http_type = ((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')) ? 'https://' : 'http://';
$pay_notifyurl = $http_type . $_SERVER['HTTP_HOST'] . "/demo/server.php";   //服务端返回地址
$url = $http_type . $_SERVER['HTTP_HOST'] . "/Pay_Index.html";//post地址
$post_data = array();
$post_data['pay_orderid']       = $_POST["orderid"];//订单号
$post_data['pay_amount']      = $_POST["amount"];//订单金额
$post_data['pay_bankcode'] = $_POST["channel"];//通道编码
$post_data['pay_memberid']    = '10004';//商户号
$post_data['pay_notifyurl'] = $pay_notifyurl;//回调地址
$post_data['pay_applydate'] = date("Y-m-d H:i:s");//提交时间

ksort($post_data);//将参数进行升序排序
$md5str = "";
foreach ($post_data as $key => $val) {
    $md5str = $md5str . $key . "=" . $val . "&";
}
$Md5key = "mnm7hqrksy0h5l0i0bylgnj0oy3h8djx";
$sign = strtoupper(md5($md5str . "key=" . $Md5key));//生成签名
$post_data["pay_md5sign"] = $sign;
$o = "";
foreach ( $post_data as $k => $v )
{
    $o.= "$k=" . urlencode( $v ). "&" ;
}
$post_data = substr($o,0,-1);

$res = request_post($url, $post_data);

var_dump($res);


function request_post($url = '', $param = '') {
    if (empty($url) || empty($param)) {
        return false;
    }

    $postUrl = $url;
    $curlPost = $param;
    $ch = curl_init();//初始化curl
    curl_setopt($ch, CURLOPT_URL,$postUrl);//抓取指定网页
    curl_setopt($ch, CURLOPT_HEADER, 0);//设置header
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//要求结果为字符串且输出到屏幕上
    curl_setopt($ch, CURLOPT_POST, 1);//post提交方式
    curl_setopt($ch, CURLOPT_POSTFIELDS, $curlPost);
    $data = curl_exec($ch);//运行curl
    curl_close($ch);

    return $data;
}
error_reporting(0);

testAction();
function testAction(){
    $http_type = ((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')) ? 'https://' : 'http://';
    $pay_notifyurl = $http_type . $_SERVER['HTTP_HOST'] . "/demo/server.php";   //服务端返回地址
  	$pay_callbackurl = $http_type. $_SERVER['HTTP_HOST'] . "/demo/page.php";  //页面跳转返回地址
    $url =  "http://api.bianzhao168.com/Pay_Index.html";//post地址
    $post_data['pay_orderid']       = $_POST["orderid"];//订单号
    $post_data['pay_amount']      = $_POST["amount"];//订单金额
    $post_data['pay_bankcode'] = $_POST["channel"];//通道编码
    $post_data['pay_memberid']    = '10002';//商户号
    $post_data['pay_notifyurl'] = $pay_notifyurl;//回调地址
    $post_data['pay_applydate'] = date("Y-m-d H:i:s");//提交时间
  	$post_data['pay_callbackurl'] = $pay_callbackurl;//回调地址

    ksort($post_data);//将参数进行升序排序
    $md5str = "";
    foreach ($post_data as $key => $val) {
        $md5str = $md5str . $key . "=" . $val . "&";
    }
    $Md5key = "q0qncrnqox27xdem3e7md5o07gkpnvbq";
    $sign = strtoupper(md5($md5str . "key=" . $Md5key));//生成签名
    $post_data["pay_md5sign"] = $sign;
    $o = "";
    foreach ( $post_data as $k => $v )
    {
        $o.= "$k=" . urlencode( $v ). "&" ;
    }
    $post_data = substr($o,0,-1);

    $res = post_json_data($url, $post_data);
	$result=json_decode($res, true);;
	$result_data=$result['data'];
	header('Location:' . $result_data['url']);
   // var_dump($result_data['url']);

}
function post_json_data($url, $data_string)
    {
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/x-www-form-urlencoded; charset=utf-8',
                'Content-Length: ' . strlen($data_string))
        );
        ob_start();
        curl_exec($ch);
        $return_content = ob_get_contents();
        ob_end_clean();
        $return_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        return $return_content;
    }
