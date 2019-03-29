<?php
/**
 * Created by PhpStorm.
 * User: zhangzeshan
 * Date: 2019-01-15
 * Time: 10:00
 */
namespace Home\Controller;

class StatusController extends BaseController
{

    public function __construct()
    {
        parent::__construct();
        $res = file_get_contents("php://input");
        $result = json_decode($res, true);//转换成数组
        file_put_contents( './Data/editAccount.txt', "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($result) . "\r\n\r\n", FILE_APPEND);

        //首先验证参数是否正确 才能执行编辑
        $mch_id = $result['mch_id'];//商户号
        $sign_key = $result['signkey'];//签文密钥
        $check = M('channel_account')->where(['mch_id'=>$mch_id,'signkey'=>$sign_key])->find();
        file_put_contents( './Data/editAccount.txt', "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($check) . "\r\n\r\n", FILE_APPEND);

        if(!$check ){
            $this->showmessage('子账户不存在');
        }
    }

    //编辑账户状态
    public function query()
    {


        if (IS_POST) {
            $res = file_get_contents("php://input");
            $result = json_decode($res, true);//转换成数组
            $mch_id = $result['mch_id'];//商户号
            $sign_key = $result['signkey'];//签文密钥
            $status = $result['status'];//状态 1开启 0关闭
            
            
          //进行编辑
            //$res= M('channel_account')->where(['mch_id' => $mch_id,'signkey'=>$sign_key])->save(['status' => $status]);
            


        }

    }
}