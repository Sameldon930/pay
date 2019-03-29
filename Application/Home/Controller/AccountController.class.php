<?php
/**
 * Created by PhpStorm.
 * User: zhangzeshan
 * Date: 2019-01-08
 * Time: 10:00
 */
namespace Home\Controller;

class AccountController extends BaseController
{

    public function __construct()
    {
        parent::__construct();
        $res = file_get_contents("php://input");
        $result = json_decode($res, true);//转换成数组
        file_put_contents( './Data/account.txt', "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($result) . "\r\n\r\n", FILE_APPEND);


        $channel_id = $result['channel_id'];
        file_put_contents( './Data/account.txt',$channel_id , FILE_APPEND);


        $fans = M('channel')->where(['id'=>$channel_id])->find();
        if(!$fans ){
            $this->showmessage('通道不存在');
        }
    }

    //子账户添加
    public function query()
    {


        if (IS_POST) {
            $res = file_get_contents("php://input");
            $result = json_decode($res, true);//转换成数组
            $channel_id = $result['channel_id'];//供应商id
            $title = $result['title'];//子账户名称
            $mch_id = $result['mch_id'];//商户号
            $sign_key = $result['signkey'];//密钥
            $status = $result['status'];//账户状态//由于需要默认启用状态，故此现将其写死，'status'=>$status,
            $unlock = $result['unlock'];//防封域名;
            $weight = $result['weight'];//轮询权重
			
            $request = [
                'channel_id'=>$channel_id,
                'title'=>$title,
                'mch_id'=>$mch_id,
                'signkey'=>$sign_key,
                'status'=>$status,
                'unlockdomain'=>$unlock == ''?'':$unlock,
                'weight'=>$weight == ''? 1:$weight

            ];
            file_put_contents( './Data/account.txt', "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($request) . "\r\n\r\n", FILE_APPEND);


            //进行插入
            $res = M('channel_account')->add($request);

            //如果插入成功 返回信息
            if($res){
                //返回结果
                $this->showsuccess('1','添加成功',$request
                );

            }else{
                $this->showmessage('添加失败，请联系管理员');
            }


        }

    }
}