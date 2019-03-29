<?php
/**
 * Created by PhpStorm.
 * User: zhangzeshan
 * Date: 2019-01-08
 * Time: 10:00
 */
namespace Home\Controller;

class ChannelListController extends BaseController
{

    public function __construct()
    {
        parent::__construct();
//        $res = file_get_contents("php://input");
//        $result = json_decode($res, true);//转换成数组
//        file_put_contents( './Data/list.txt', "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($result) . "\r\n\r\n", FILE_APPEND);
//
//
//        $title = $result['title'];
        $title = I('title');
        file_put_contents( './Data/list.txt',$title , FILE_APPEND);



    }

    //子账户添加
    public function query()
    {
        $title = I('title');
//        $res = file_get_contents("php://input");
//        $result = json_decode($res, true);//转换成数组
//        $title = $result['title'];
        $sql = '%' . $title . '%';
        $channelList = M('channel')
            ->where("`title` LIKE '{$sql}'")
            ->field('id as type,title as name')->select();
        $res = json_encode($channelList,JSON_UNESCAPED_UNICODE );
        print_r($res);
    }
}