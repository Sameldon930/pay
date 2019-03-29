<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/3/19
 * Time: 13:46
 */
namespace Cron\Controller;

use Think\Controller;

class IndexController extends Controller{

    public function index()
    {
        //差额、单元分
        /**
         * 例如 设置差额大于1元  $money = X（元） * 100; X修改成 1 如下
         * $money = 1 * 100;
         * 默认 1000元
         */
        $money = 1000 * 100;
        //一天内的交易金额
        $todayBegin = date('Y-m-d').' 00:00:00';
        $todyEnd = date('Y-m-d').' 23:59:59';
        //获取四方当天订单数据
        $sfData = M('Order')
            ->where(['pay_successdate'=>['between', [strtotime($todayBegin), strtotime($todyEnd)]], 'pay_status'=>['in', '1,2'],'isReset'=> 1])
            ->field('memberid as uid, sum(pay_amount) as price ')
            ->group('memberid')
            ->select();
        //固码数据接口地址
        $api = [
            "http://adasdsadq.natapp1.cc/check/checkUidSettlement",
        ];
        //固码数据处理
        $gmData = [];
        foreach ($api as $k){
            $gmOB = json_decode($this->post_json_data($k,"{}"),true);
            array_push( $gmData,$gmOB['checkUidSettlements']);
        }
        $gmData =  array_unique($gmData);
        foreach ($gmData as  $v){
            $gmDatas = $v;
        }
        $temp = [];
        // 比对双方金额
        foreach ($sfData as $k => $v){
            foreach ($gmDatas as $m => $n){
                if ($v['uid'] == $n['uid']){
                    if ((($v['price']*100) - $n['price']) > $money){
                        $tem = M('order')->where(['memberid'=>$v['uid']])->group('pay_tongdao')->getField('pay_tongdao',true);
                        array_push($temp,implode('/',$tem));
                    }
                }
            }
        }
        $errStr = implode('/',$temp);
        $errArry = array_unique(explode('/',$errStr));
        // 要发送的手机号
        $mobile = M('admin')->where("mobile != ''")->getField('mobile',true);
        $mobiles = implode(',',array_unique($mobile));
        //要发送的信息
        foreach ($errArry as $k ){
            $res = M('channel')->where(['code'=>$k])->setField('status',0);
            if ($res == true){
                $msg = '您好,由于'.$k.'渠道存在异常！现将其进行关闭，请知悉！【后台小助手】';
                $return = $this->sendSMS($mobiles,$msg);
                file_put_contents('./Data/CronLog.txt', "【" . date('Y-m-d H:i:s') . "】\r\n 匹配四方固码金额, 入金渠道!" .$k ."存在金额差异过大，进行关闭渠道！". "\r\n\r\n", FILE_APPEND);
                file_put_contents('./Data/CronLog.txt', "【" . date('Y-m-d H:i:s') . "】\r\n -------------------------------------------------------". "\r\n\r\n", FILE_APPEND);
            }else{
                file_put_contents('./Data/CronLog.txt', "【" . date('Y-m-d H:i:s') . "】\r\n 四方数据：".json_encode($sfData). "\r\n\r\n", FILE_APPEND);
                file_put_contents('./Data/CronLog.txt', "【" . date('Y-m-d H:i:s') . "】\r\n 固码数据：".json_encode($gmDatas). "\r\n\r\n", FILE_APPEND);
                file_put_contents('./Data/CronLog.txt', "【" . date('Y-m-d H:i:s') . "】\r\n 匹配四方固码金额, 入金渠道!" .$k."无明显刷单、金额不匹配问题". "\r\n\r\n", FILE_APPEND);
                file_put_contents('./Data/CronLog.txt', "【" . date('Y-m-d H:i:s') . "】\r\n -------------------------------------------------------". "\r\n\r\n", FILE_APPEND);
            }
        }
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


    //短信内容HEX编码,dataCoding 为编码方式，realStr 为短信内容
    // dataCoding = 8 ,支持所有国家的语言，建议直接使用 8
    function encodeHexStr($dataCoding, $realStr) {

        if ($dataCoding == 15)
        {
            return strtoupper(bin2hex(iconv('UTF-8', 'GBK', $realStr)));
        }
        else if ($dataCoding == 3)
        {
            return strtoupper(bin2hex(iconv('UTF-8', 'ISO-8859-1', $realStr)));
        }
        else if ($dataCoding == 8)
        {
            return strtoupper(bin2hex(iconv('UTF-8', 'UCS-2BE', $realStr)));
        }
        else
        {
            return strtoupper(bin2hex(iconv('UTF-8', 'ASCII', $realStr)));
        }
    }

    function sendSMS($dest,$msg){
        $uri = "http://210.51.190.233:8085/mt/mt3.ashx"; // 接口地址
        $data = array (
            'src' => 'gcnysys', // 你的用户名, 必须有值
            'pwd' => 'zhoan10086', // 你的密码, 必须有值
            'ServiceID' => 'SEND', //固定，不需要改变
            'dest' => $dest, // 你的目的号码【收短信的电话号码】, 必须有值
            'sender' => '', // 你的原号码,可空【大部分国家原号码带不过去，只有少数国家支持透传，所有一般为空】
            'codec' => '8', // 编码方式， 与msg中encodeHexStr 对应
            // codec=8 Unicode 编码,  3 ISO-8859-1, 0 ASCII
            'msg' => $this->encodeHexStr(8,$msg) // 编码短信内容
        );
        $ch = curl_init();
        print_r($ch);
        curl_setopt ( $ch, CURLOPT_URL, $uri );
        curl_setopt ( $ch, CURLOPT_POST, 1 );
        curl_setopt ( $ch, CURLOPT_HEADER, 0 );
        curl_setopt ( $ch, CURLOPT_RETURNTRANSFER, 1 );
        curl_setopt ( $ch, CURLOPT_POSTFIELDS, $data );
        $return = curl_exec ( $ch ); //$return  返回结果，如果是以 “-” 开头的为发送失败，请查看错误代码，否则为MSGID
        curl_close ( $ch );
        print_r($return);
    }

    /**
     * 凌晨更新用户昨日为下发金额
     */
    function updateBalance(){
        $Model = new \Think\Model(); // 实例化一个model对象 没有对应任何数据表
        $Model->execute("UPDATE pay_member set yesterday_balance = balance");
    }


}