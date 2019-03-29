<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-08-22
 * Time: 14:34
 */
namespace User\Controller;

use Think\Page;
use Org\Net\UserLogService;

/**
 * 订单管理控制器
 * Class OrderController
 * @package User\Controller
 */
class OrderController extends UserController
{

    public function __construct()
    {
        parent::__construct();
        $this->assign("Public", MODULE_NAME); // 模块名称
    }

    public function index()
    {
        $status = I("request.status",'');
        if($status != '') {
            $status = intval($status);
        }
        switch ($status) {
            case '0':
                $title = '未支付订单';
                break;
            case '1':
                $title = '手工补发订单';
                break;
            case '2':
                $title = '成功订单';
                break;
            default:
                $title = '所有订单';
                break;
        }
        UserLogService::write(1, '访问'.$title.'列表页面', '访问'.$title.'订单列表页面');
        //通道
        $products = M('ProductUser')
            ->join('LEFT JOIN __PRODUCT__ ON __PRODUCT__.id = __PRODUCT_USER__.pid')
            ->where(['pay_product_user.status'=>1,'pay_product_user.userid'=>$this->fans['uid']])
            ->field('pay_product.name,pay_product.id,pay_product.code')
            ->select();
        $this->assign("banklist", $products);

        $where = array();
        $orderid = I("request.orderid", '', 'string,strip_tags,htmlspecialchars');
        if ($orderid) {
            $where['out_trade_id'] = $orderid;
        }
        $this->assign("orderid", $orderid);
        $ddlx = I("request.ddlx", '', 'string,strip_tags,htmlspecialchars');
        if($ddlx != ""){
            $where['ddlx'] = array('eq',$ddlx);
        }
        $this->assign("ddlx", $ddlx);
        $bankcode = I("request.bankcode", '', 'string,strip_tags,htmlspecialchars');
        if ($bankcode) {
            $where['pay_bankcode'] = array('eq', $bankcode);
        }
        $this->assign("bankcode", $bankcode);
		$body = I("request.body", '', 'string,strip_tags,htmlspecialchars');
        if ($body) {
            $where['pay_productname'] = array('like', '%'.$body.'%');
        }
        $this->assign("body", $body);
        if ($status != '') {
            $where['pay_status'] = array('eq',$status);
        }
        $this->assign("status", $status);
        $createtime = urldecode(I("request.createtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime,$cetime) = explode('|',$createtime);
            $where['pay_applydate'] = $sumMap['pay_applydate'] = $failMap['pay_applydate'] = $map['create_at'] = ['between',[strtotime($cstime),strtotime($cetime)?strtotime($cetime):time()]];
        }
        $this->assign("createtime", $createtime);
        $successtime = urldecode(I("request.successtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($successtime) {
            list($sstime,$setime) = explode('|',$successtime);
            $where['pay_successdate'] = $sumMap['pay_successdate'] = $failMap['pay_successdate'] = $map['create_at'] = ['between',[strtotime($sstime),strtotime($setime)?strtotime($setime):time()]];
        }
        $this->assign("successtime", $successtime);
        $where['isdel'] = 0;
        $where['pay_memberid'] = $this->fans['memberid'];
        $count = M('Order')->where($where)->count();
        $size = 15;
        $rows  = I('get.rows', $size, 'intval');
        if(!$rows){
            $rows = $size;
        }
        //统计今日交易数据
        if ($status == '2') {
            //今日成功交易总额
            $todayBegin = date('Y-m-d').' 00:00:00';
            $todyEnd = date('Y-m-d').' 23:59:59';
            $stat['todaysum'] = M('Order')->where(['pay_memberid'=>10000+$this->fans['uid'],'pay_successdate'=>['between', [strtotime($todayBegin), strtotime($todyEnd)]], 'pay_status'=>['in', '1,2']])->sum('pay_amount');
            //今日实际到账总额
            $stat['taodayactualamount'] = M('Order')->where(['pay_memberid'=>10000+$this->fans['uid'],'pay_successdate'=>['between', [strtotime($todayBegin), strtotime($todyEnd)]], 'pay_status'=>['in', '1,2']])->sum('pay_actualamount');
            //今日成功笔数
            $stat['todaysuccesscount'] = M('Order')->where(['pay_memberid'=>10000+$this->fans['uid'],'pay_successdate'=>['between', [strtotime($todayBegin), strtotime($todyEnd)]], 'pay_status'=>['in', '1,2']])->count();
            //今日失败笔数
            $stat['todayfailcount'] = M('Order')->where(['pay_memberid'=>10000+$this->fans['uid'],'pay_applydate'=>['between', [strtotime($todayBegin), strtotime($todyEnd)]], 'pay_status'=>0])->count();
            foreach($stat as $k => $v) {
                $stat[$k] = $v+0;
            }
            $this->assign('stat', $stat);
        }

        //如果指定时间范围则按搜索条件做统计
        if ($createtime || $successtime) {
            $sumMap = $failMap = $where;
            $field                    = ['sum(`pay_amount`) pay_amount', 'sum(`pay_actualamount`) pay_actualamount', 'count(`id`) success_count'];
            $sumMap['pay_status'] = ['in', '1, 2'];
            $sum                      = M('Order')->field($field)->where($sumMap)->find();
            foreach ($sum as $k => $v) {
                $sum[$k] += 0;
            }
            //失败笔数
            $failMap['pay_status'] = 0;
            $sum['fail_count'] =  M('Order')->where($failMap)->count();
            //投诉保证金冻结金额
            $map['C.user_id'] = $this->fans['uid'];
            $map['C.status'] = 0;
            $sum['complaints_deposit_freezed'] = M('complaints_deposit')->alias('as C')->join('LEFT JOIN __ORDER__ AS O ON C.pay_orderid=O.pay_orderid')
                ->where($map)
                ->sum('freeze_money');
            $sum['complaints_deposit_freezed'] += 0;
            $map['C.status'] = 1;
            $sum['complaints_deposit_unfreezed'] = M('complaints_deposit')->alias('as C')->join('LEFT JOIN __ORDER__ AS O ON C.pay_orderid=O.pay_orderid')
                ->where($map)
                ->sum('freeze_money');
            $sum['complaints_deposit_unfreezed'] += 0;
            $this->assign('sum', $sum);
        }
        $page            = new Page($count, $rows);
        $list = M('Order')
            ->where($where)
            ->limit($page->firstRow.','.$page->listRows)
            ->order('id desc')
            ->select();
        $this->assign('rows', $rows);
        $this->assign("list", $list);
        $this->assign('page',$page->show());
        C('TOKEN_ON',false);
        $this->display();
    }

    /**
     * 导出交易订单
     * */
    public function exportorder()
    {
        UserLogService::write(5, '导出交易订单', '导出交易订单');
        $orderid = I("request.orderid", '', 'string,strip_tags,htmlspecialchars');
        if ($orderid) {
            $where['out_trade_id'] = $orderid;
        }
        $ddlx = I("request.ddlx", '', 'string,strip_tags,htmlspecialchars');
        if($ddlx != ""){
            $where['ddlx'] = array('eq',$ddlx);
        }
        $bankcode = I("request.bankcode", '', 'string,strip_tags,htmlspecialchars');
        if ($bankcode) {
            $where['pay_bankcode'] = array('eq',$bankcode);
        }
        $bank = I("request.bank", '', 'string,strip_tags,htmlspecialchars');
        if ($bank) {
            $where['pay_bankname'] = array('eq',$bank);
        }

        $status = I("request.status", 0, 'intval');
        if ($status) {
            $where['pay_status'] = array('eq',$status);
        }
        $createtime = urldecode(I("request.createtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime,$cetime) = explode('|',$createtime);
            $where['pay_applydate'] = ['between',[strtotime($cstime),strtotime($cetime)?strtotime($cetime):time()]];
        }
        $successtime = urldecode(I("request.successtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($successtime) {
            list($sstime,$setime) = explode('|',$successtime);
            $where['pay_successdate'] = ['between',[strtotime($sstime),strtotime($setime)?strtotime($setime):time()]];
        }
        $where['isdel'] = 0;
        $where['pay_memberid'] = $this->fans['memberid'];

        $title = array('订单号','商户编号','交易金额','手续费','实际金额','提交时间','成功时间','通道','状态');
        $data = M('Order')->where($where)->select();
        foreach ($data as $item){

            switch ($item['pay_status']){
                case 0:
                    $status = '未处理';
                    break;
                case 1:
                    $status = '成功，未返回';
                    break;
                case 2:
                    $status = '成功，已返回';
                    break;
            }
            $list[] = array(
                'pay_orderid'=>$item['out_trade_id'] ? $item['out_trade_id']:$item['pay_orderid'],
                'pay_memberid'=>$item['pay_memberid'],
                'pay_amount'=>$item['pay_amount'],
                'pay_poundage'=>$item['pay_poundage'],
                'pay_actualamount'=>$item['pay_actualamount'],
                'pay_applydate'=>date('Y-m-d H:i:s',$item['pay_applydate']),
                'pay_successdate'=>date('Y-m-d H:i:s',$item['pay_successdate']),
                'pay_zh_tongdao'=>$item['pay_zh_tongdao'],
                'pay_status'=>$status,
            );
        }
        $numberField = ['pay_amount', 'pay_poundage', 'pay_actualamount'];
        exportexcel($list, $title, $numberField);
    }

    /**
     * 查看订单
     */
    public function show()
    {
        $id = I("get.oid",0,'intval');
        if($id){
            $order = M('Order')
                ->where(['id'=>$id])
                ->find();
        }

        if($order['pay_memberid'] != $this->fans['memberid']) {
            $parentId = M('Member')->where(['id'=>$order['pay_memberid']-10000])->getField('parentid');
            if($parentId != $this->fans['uid']) {
                $this->error('没有权限查看该订单');
            }
        }
        UserLogService::write(1, '查看订单', '查看订单，ID：'.$id);
        $this->assign('order',$order);
        $this->display();
    }

    /**
     *  伪删除订单
     */
    /*
    public function delOrder()
    {
        if(IS_POST){
            $id = I('post.id',0,'intval');
            if($id){
                $res = M('Order')->where(['id'=>$id,'pay_memberid'=>$this->fans['memberid']])->setField('isdel',1);
            }
            $this->ajaxReturn(['status'=>$res]);
        }
    }
    */
}
?>
