<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-04-02
 * Time: 23:01
 */

namespace Admin\Controller;

use Think\Page;
//ini_set('memory_limit','256M');
/**
 * 统计控制器
 * Class StatisticsController
 * @package Admin\Controller
 */
class StatisticsController extends BaseController
{
    const TMT = 7776000; //三个月的总秒数
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 订单列表
     */
    public function index()
    {
        //通道
        $tongdaolist = M("Channel")->field('id,code,title')->select();
        $this->assign("tongdaolist", $tongdaolist);

        $where = array(
            'pay_status' => ['gt', 1],
        );
        $memberid = I("request.memberid");
        if ($memberid) {
            $where['O.pay_memberid'] = array('eq', $memberid);
            $profitMap['userid'] = $profitSumMap['userid'] = $cjsxfMap['userid'] = $cjlrMap['userid'] = $memberid-10000;
        }
        $this->assign("memberid", $memberid);
        $orderid = I("request.orderid");
        if ($orderid) {
            $where['O.pay_orderid'] = $orderid;
            $profitMap['transid'] = $orderid;
        }
        $this->assign("orderid", $orderid);
        $tongdao = I("request.tongdao");
        if ($tongdao) {
            $where['O.pay_tongdao'] = array('eq', $tongdao);
        }
        $this->assign("tongdao", $tongdao);
        $createtime = urldecode(I("request.createtime"));
        if ($createtime) {
            list($cstime, $cetime)  = explode('|', $createtime);
            $where['O.pay_applydate'] = ['between', [strtotime($cstime), strtotime($cetime) ? strtotime($cetime) : time()]];
            $profitMap['datetime'] = $cjsxfMap['datetime'] = $cjlrMap['cldatetime'] = ['between', [$cstime, $cetime ? $cetime : date('Y-m-d H:i:s')]];
        }
        $this->assign("createtime", $createtime);
        $successtime = urldecode(I("request.successtime"));
        if ($successtime) {
            list($sstime, $setime)    = explode('|', $successtime);
            $where['O.pay_successdate'] = ['between', [strtotime($sstime), strtotime($setime) ? strtotime($setime) : time()]];
            $profitMap['datetime'] = $cjsxfMap['datetime'] = $cjlrMap['cldatetime'] = ['between', [$cstime, $cetime ? $cetime : date('Y-m-d H:i:s')]];
        } elseif (!$successtime && !$createtime) {
            $successtime = date('Y-m-d H:i:s', strtotime(date('Y-m', time()))) . " | " . date('Y-m-d H:i:s', time());
            $where['O.pay_successdate'] = ['between', [strtotime(date('Y-m', time())), time()]];
            $profitMap['datetime'] = $cjsxfMap['datetime'] = $cjlrMap['cldatetime'] = ['between', [strtotime(date('Y-m', time())), time()]];
        }
        $this->assign("successtime", $successtime);
        $count = M('Order')->alias('as O')->where($where)->count();
        $page  = new Page($count, 15);
        $list  = M('Order')
            ->alias('as O')
            ->where($where)
            ->limit($page->firstRow . ',' . $page->listRows)
            ->order('id desc')
            ->select();

        $amount = $rate = $realmoney = 0;
        foreach ($list as $item) {
            if ($item['pay_status'] >= 1) {
                $amount += $item['pay_amount'];
                $rate += $item['pay_poundage'];
                $realmoney += $item['pay_actualamount'];
            }
        }
        //查询支付成功的订单的手续费，入金费，总额总和
        $countWhere               = $where;
        $countWhere['O.pay_status'] = ['between', [1, 2]];
        $field                    = ['sum(`pay_amount`) pay_amount','sum(`cost`) cost', 'sum(`pay_poundage`) pay_poundage', 'sum(`pay_actualamount`) pay_actualamount', 'count(`id`) success_count'];
        $sum                      = M('Order')->alias('as O')->field($field)->where($countWhere)->find();
        foreach ($sum as $k => $v) {
            $sum[$k] += 0;
        }
        $countWhere['O.pay_status'] = 0;
        //失败笔数
        $sum['fail_count'] =  M('Order')->alias('as O')->where($countWhere)->count();
        //投诉保证金冻结金额
        $map = $where;
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
        $profitMap['lx'] = 9;
        $sum['memberprofit'] = M('moneychange')->where($profitMap)->sum('money');

        //出金利润
        $cjlrMap['status'] = 2;
        $tkmoney1 = M('tklist')->where($cjlrMap)->sum('tkmoney');
        $tkmoney2 = M('wttklist')->where($cjlrMap)->sum('tkmoney');
        $money1 = M('tklist')->where($cjlrMap)->sum('money');
        $money2 = M('wttklist')->where($cjlrMap)->sum('money');
        //代付成本
        $cjcost = M('wttklist')->where($cjlrMap)->sum('cost');
        $sum['cjlr'] = $tkmoney1 + $tkmoney2 - $money1 - $money2 - $cjcost;
        //出金手续费
        $cjsxfMap['lx'] = 14;
        $sxf1 = M('moneychange')->where($cjsxfMap)->sum('money');
        $cjsxfMap['lx'] = 16;
        $sxf2 = M('moneychange')->where($cjsxfMap)->sum('money');
        //退回出金手续费
        $cjsxfMap['lx'] = 15;
        $qxsxf1 = M('moneychange')->where($cjsxfMap)->sum('money');
        $cjsxfMap['lx'] = 17;
        $qxsxf2 = M('moneychange')->where($cjsxfMap)->sum('money');
        //出金实际手续费
        $sum['cjsxf'] = $sxf1 + $sxf2 - $qxsxf1 - $qxsxf2;
        $sum['pay_poundage'] = $sum['pay_poundage'] + $sum['cjlr'] - $sum['cost'] - $sum['memberprofit'] - $sum['cjsxf'];
        foreach($sum as $k => $v) {
            $sum[$k] +=0;
        }
        //统计订单信息
        $is_month = true;
        //下单时间
        if ($createtime) {
            $cstartTime = strtotime($cstime);
            $cendTime   = strtotime($cetime) ? strtotime($cetime) : time();
            $is_month   = $cendTime - $cstartTime > self::TMT ? true : false;
        }
        //支付时间
        $pstartTime = strtotime($sstime);
        $pendTime   = strtotime($setime) ? strtotime($setime) : time();
        $is_month   = $pendTime - $pstartTime > self::TMT ? true : false;

        $time       = $successtime ? 'pay_successdate' : 'pay_applydate';
        $dateFormat = $is_month ? '%Y年-%m月' : '%Y年-%m月-%d日';
        $field      = "FROM_UNIXTIME(" . $time . ",'" . $dateFormat . "') AS date,SUM(pay_amount) AS amount,SUM(pay_poundage) AS rate,SUM(pay_actualamount) AS total";
        $_mdata     = M('Order')->alias('as O')->field($field)->where($where)->group('date')->select();
        $mdata      = [];
        foreach ($_mdata as $item) {
            $mdata['amount'][] = $item['amount'] ? $item['amount'] : 0;
            $mdata['mdate'][]  = "'" . $item['date'] . "'";
            $mdata['total'][]  = $item['total'] ? $item['total'] : 0;
            $mdata['rate'][]   = $item['rate'] ? $item['rate'] : 0;
        }

        $this->assign("list", $list);
        $this->assign("mdata", $mdata);
        $this->assign('page', $page->show());
        $this->assign('stamount', $sum['pay_amount']);
        $this->assign('strate', $sum['pay_poundage']);
        $this->assign('strealmoney', $sum['pay_actualamount']);
        $this->assign('success_count', $sum['success_count']);
        $this->assign('fail_count', $sum['fail_count']);
        $this->assign('memberprofit', $sum['memberprofit']);
        $this->assign('complaints_deposit_freezed', $sum['complaints_deposit_freezed']);
        $this->assign('complaints_deposit_unfreezed', $sum['complaints_deposit_unfreezed']);
        $this->assign("isrootadmin", is_rootAdministrator());
        C('TOKEN_ON', false);
        $this->display();
    }
    /**
     * 导出交易订单
     * */
    public function exportorder()
    {

        //通道
        $tongdaolist = M("Channel")->field('id,code,title')->select();
        $this->assign("tongdaolist", $tongdaolist);

        $where = array(
            'pay_status' => ['eq', 2],
        );
        $memberid = I("request.memberid");
        if ($memberid) {
            $where['pay_memberid'] = array('eq', $memberid);
        }
        $orderid = I("request.orderid");
        if ($orderid) {
            $where['out_trade_id'] = $orderid;
        }
        $tongdao = I("request.tongdao");
        if ($tongdao) {
            $where['pay_tongdao'] = array('eq', $tongdao);
        }

        $createtime = urldecode(I("request.createtime"));
        if ($createtime) {
            list($cstime, $cetime)  = explode('|', $createtime);
            $where['pay_applydate'] = ['between', [strtotime($cstime), strtotime($cetime) ? strtotime($cetime) : time()]];
        }
        $successtime = urldecode(I("request.successtime"));
        if ($successtime) {
            list($sstime, $setime)    = explode('|', $successtime);
            $where['pay_successdate'] = ['between', [strtotime($sstime), strtotime($setime) ? strtotime($setime) : time()]];
        }

        $title = array('订单号', '商户编号', '交易金额', '手续费', '实际金额', '提交时间', '成功时间', '通道', '状态');
        $data  = M('Order')->where($where)->select();

        foreach ($data as $item) {
            $list[] = array(
                'pay_orderid'      => $item['pay_orderid'],
                'pay_memberid'     => $item['pay_memberid'],
                'pay_amount'       => $item['pay_amount'],
                'pay_poundage'     => $item['pay_poundage'],
                'pay_actualamount' => $item['pay_actualamount'],
                'pay_applydate'    => date('Y-m-d H:i:s', $item['pay_applydate']),
                'pay_successdate'  => date('Y-m-d H:i:s', $item['pay_successdate']),
                'pay_zh_tongdao'   => $item['pay_zh_tongdao'],
                'pay_status'       => '成功，已返回',
            );
        }

        exportCsv($list, $title);
    }

    public function userFinance()
    {
        $groupid          = I('get.groupid', 'member');
        $where['groupid'] = $groupid == 'agent' ? ['gt', '4'] : ['eq', '4'];
        if ($memberid = I('get.memberid', 0, 'invtal')) {
            $where['id'] = $memberid - 10000;
        }
        $this->assign('groupid', $groupid);
        $this->assign('memberid', $memberid);
        $size = 15;
        $rows = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $Member     = M('Member');
        $count      = $Member->where($where)->count();
        $Page       = new Page($count, $rows);
        $show       = $Page->show();
        $memberList = $Member
            ->field(['id', 'username','balance', 'blockedbalance'])
            ->where($where)
            ->limit($Page->firstRow . ',' . $Page->listRows)
            ->select();
        if ($memberList) {
            $Order    = M('Order');
            $Wttklist = M('Wttklist');
            $Tklist   = M('Tklist');
            foreach ($memberList as $k => $v) {
                $payMemberid = $v['id'] + 10000;

                $orderList = $Order
                    ->field(['sum(pay_amount) pay_amount', 'sum(pay_poundage) pay_poundage', 'sum(pay_actualamount) pay_actualamount'])
                    ->where(['pay_memberid' => $payMemberid, 'pay_status' => ['neq', 0]])
                    ->find();
                if (empty($orderList)) {
                    $orderList = ['pay_amount' => 0.00, 'pay_poundage' => 0.00, 'pay_actualamount' => 0.00];
                } else {
                    $orderList['pay_amount']+=0;
                    $orderList['pay_poundage']+=0;
                    $orderList['pay_actualamount']+=0;
                }

                $wttklistList = $Wttklist
                    ->field(['sum(tkmoney) tkmoney', 'sum(sxfmoney) sxfmoney', 'sum(money) money'])
                    ->where(['userid' => $v['id'], 'status' => 2])
                    ->find();

                $tklistList = $Tklist
                    ->field(['sum(tkmoney) tkmoney', 'sum(sxfmoney) sxfmoney', 'sum(money) money'])
                    ->where(['userid' => $v['id'], 'status' => 2])
                    ->find();

                //计算出金的总金额
                $tempCounts = ['tkmoney' => 0, 'sxfmoney' => 0, 'money' => 0];
                foreach ($tempCounts as $k1 => $v1) {
                    $tempCounts[$k1] = (float) ($tklistList[$k1] + $wttklistList[$k1]);
                }
                $memberList[$k]                 = array_merge($tempCounts, $orderList, $v);
                $memberList[$k]['pay_memberid'] = $payMemberid;
                //提交订单数
                $memberList[$k]['all_order_count'] =  $Order->where(['pay_memberid' => $payMemberid])->count();
                $memberList[$k]['all_order_count'] +=0;
                //已付订单数
                $memberList[$k]['paid_order_count'] =  $Order->where(['pay_memberid' => $payMemberid, 'pay_status'=>['in', '1,2']])->count();
                $memberList[$k]['paid_order_count'] +=0;
                //未付订单数
                $memberList[$k]['nopaid_order_count'] = $Order->where(['pay_memberid' => $payMemberid, 'pay_status'=>0])->count();
                $memberList[$k]['nopaid_order_count'] +=0;
                //提交金额
                $memberList[$k]['all_order_amount'] = $Order->where(['pay_memberid' => $payMemberid])->sum('pay_amount');
                $memberList[$k]['all_order_amount'] +=0;
            }
        }
        $stat['member_count'] = count($memberList);
        $fields = ['all_order_count', 'paid_order_count', 'nopaid_order_count' , 'all_order_amount', 'pay_amount', 'pay_poundage', 'balance','blockedbalance', 'tkmoney','sxfmoney','money'];
        foreach($fields as $field ) {
            foreach($memberList as $k => $v) {
                $stat[$field] += $v[$field];
            }
        }
        $this->assign('stat', $stat);
        $this->assign('page', $show);
        $this->assign('list', $memberList);
        $this->assign('rows',$rows);
        $this->display();

    }

    //导出商户交易统计
    public function exportUserFinance(){
        $groupid          = I('get.groupid', 'member');
        $where['groupid'] = $groupid == 'agent' ? ['gt', '4'] : ['eq', '4'];
        if ($memberid = I('get.memberid', '')) {
            $where['id'] = $memberid - 10000;
        }
        $Member     = M('Member');
        $memberList = $Member
            ->field(['id', 'username','balance', 'blockedbalance'])
            ->where($where)
            ->select();
        if ($memberList) {
            $Order    = M('Order');
            $Wttklist = M('Wttklist');
            $Tklist   = M('Tklist');
            foreach ($memberList as $k => $v) {
                $payMemberid = $v['id'] + 10000;

                $orderList = $Order
                    ->field(['sum(pay_amount) pay_amount', 'sum(pay_poundage) pay_poundage', 'sum(pay_actualamount) pay_actualamount'])
                    ->where(['pay_memberid' => $payMemberid, 'pay_status' => ['neq', 0]])
                    ->find();
                if (empty($orderList)) {
                    $orderList = ['pay_amount' => 0.00, 'pay_poundage' => 0.00, 'pay_actualamount' => 0.00];
                } else {
                    $orderList['pay_amount']+=0;
                    $orderList['pay_poundage']+=0;
                    $orderList['pay_actualamount']+=0;
                }

                $wttklistList = $Wttklist
                    ->field(['sum(tkmoney) tkmoney', 'sum(sxfmoney) sxfmoney', 'sum(money) money'])
                    ->where(['userid' => $v['id'], 'status' => 2])
                    ->find();

                $tklistList = $Tklist
                    ->field(['sum(tkmoney) tkmoney', 'sum(sxfmoney) sxfmoney', 'sum(money) money'])
                    ->where(['userid' => $v['id'], 'status' => 2])
                    ->find();

                //计算出金的总金额
                $tempCounts = ['tkmoney' => 0, 'sxfmoney' => 0, 'money' => 0];
                foreach ($tempCounts as $k1 => $v1) {
                    $tempCounts[$k1] = (float) ($tklistList[$k1] + $wttklistList[$k1]);
                }
                $memberList[$k]                 = array_merge($tempCounts, $orderList, $v);
                $memberList[$k]['pay_memberid'] = $payMemberid;
                //提交订单数
                $memberList[$k]['all_order_count'] =  $Order->where(['pay_memberid' => $payMemberid])->count();
                $memberList[$k]['all_order_count'] +=0;
                //已付订单数
                $memberList[$k]['paid_order_count'] =  $Order->where(['pay_memberid' => $payMemberid, 'pay_status'=>['in', '1,2']])->count();
                $memberList[$k]['paid_order_count'] +=0;
                //未付订单数
                $memberList[$k]['nopaid_order_count'] = $Order->where(['pay_memberid' => $payMemberid, 'pay_status'=>0])->count();
                $memberList[$k]['nopaid_order_count'] +=0;
                //提交金额
                $memberList[$k]['all_order_amount'] = $Order->where(['pay_memberid' => $payMemberid])->sum('pay_amount');
                $memberList[$k]['all_order_amount'] +=0;
                //实付金额
                $memberList[$k]['paid_order_amount'] = $Order->where(['pay_memberid' => $payMemberid, 'pay_status'=>['in', '1,2']])->sum('pay_amount');
                $memberList[$k]['paid_order_amount'] +=0;
                //入金手续费
                $memberList[$k]['pay_amount'] = $Order->where(['pay_memberid' => $payMemberid, 'pay_status'=>['in', '1,2']])->sum('pay_poundage');
                $memberList[$k]['pay_amount'] +=0;
                //商户收入
                $actualamount = M('Order')->where(['pay_memberid'=>$payMemberid, 'status' => ['in', '1,2']])->sum('pay_actualamount');
                $profitSum = M('moneychange')->where(['userid'=>$v['id'],'lx'=>9])->sum('money');
                $redoAddSum = M('redo_order')->where(['type'=>1,'user_id'=>$v['id']])->sum('money');
                $redoReduceSum = M('redo_order')->where(['type'=>2,'user_id'=>$v['id']])->sum('money');
                $orderSum = $actualamount + $profitSum + $redoAddSum - $redoReduceSum;
                $memberList[$k]['member_income'] = $orderSum;
                $memberList[$k]['member_income'] +=0;
                //平台收入
                $income_profit = M('Order')->where(['pay_memberid'=>$payMemberid, 'status' => ['in', '1,2']])->sum('pay_poundage');
                $order_cost = M('Order')->where(['pay_memberid'=>$payMemberid, 'status' => ['in', '1,2']])->sum('cost');
                $pay_cost = M('wttklist')->where(['userid'=>$v['id'], 'status' => 2])->sum('cost');
                $agent_profit_cost = M('moneychange')->where(['tcuserid'=>$v['id'],'lx'=>9])->sum('money');
                $memberList[$k]['platform_income'] = $income_profit - $order_cost - $pay_cost - $agent_profit_cost;
                $memberList[$k]['platform_income'] += 0;
            }
        }
        $stat['member_count'] = count($memberList);
        $fields = ['tkmoney', 'sxfmoney', 'money' , 'all_order_count', 'paid_order_count', 'nopaid_order_count', 'all_order_amount', 'paid_order_amount', 'member_income', 'platform_income','balance','blockedbalance','pay_amount','tkmoney','sxfmoney'];
        foreach($fields as $field ) {
            foreach($memberList as $k => $v) {
                $stat[$field] += $v[$field];
            }
        }
        foreach ($memberList as $m => $n){

            $list[] = array(
                'pay_memberid'=>$n['pay_memberid'],
                'username'=>$n['username'],
                'all_order_count'=>$n['all_order_count'],
                'paid_order_count'=>$n['paid_order_count'],
                'nopaid_order_count'=>$n['nopaid_order_count'],
                'all_order_amount'=>$n['all_order_amount'],
                'pay_amount'=>$n['pay_amount'],
                'pay_poundage'=>$n['pay_poundage'],
                'balance'=>$n['balance'],
                'blockedbalance'=>$n['blockedbalance'],
                'tkmoney'=>$n['tkmoney'],
                'sxfmoney'=>$n['sxfmoney'],
                'money'=>$n['money'],
            );
        }
        $list[] = array(
            'pay_memberid'=>'统计：',
            'username'=>$stat['member_count'].'个商户',
            'paid_order_count'=>$stat['all_order_count'].'条订单',
            'nopaid_order_count'=>$stat['paid_order_count'].'条订单',
            'all_order_amount'=>$stat['nopaid_order_count'].'条订单',
            'paid_order_amount'=>$stat['all_order_amount'].'元',
            'pay_amount'=>$stat['pay_amount'].'元',
            'pay_poundage'=>$stat['pay_poundage'].'元',
            'balance'=>$stat['balance'].'元',
            'blockedbalance'=>$stat['blockedbalance'].'元',
            'tkmoney'=>$stat['tkmoney'].'元',
            'sxfmoney'=>$stat['sxfmoney'].'元',
            'money'=>$stat['money'].'元',
        );
        $title = array(
            '商户编号',
            '商户名称',
            '提交订单',
            '已付订单',
            '未付订单',
            '提交金额',
            '实付金额',
            '入金手续费',
            '可用资金',
            '冻结金额',
            '出金总额',
            '出金手续费',
            '实际出金金额',
        );
        exportCsv($list, $title);
    }

    /*public function channelFinance()
    {
        $where = [];
        $createtime = urldecode(I("request.createtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime,$cetime) = explode('|',$createtime);
            $where['pay_applydate'] = ['between',[strtotime($cstime),strtotime($cetime)?strtotime($cetime):time()]];
        }
        $this->assign('createtime', $createtime);
        $Product = M('Product');
        $size = 6;
        $rows = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $count = $Product->count();
        $Page  = new Page($count, $rows);

        $productList = $Product
            ->field(['id', 'name', 'code'])
            ->limit($Page->firstRow . ',' . $Page->listRows)
            ->select();

        $Order      = M('Order');
        $orderCount = $Order->where($where)->count();
        $orderList  = [];
        $limit      = 100000;
        for ($i = 0; $i < $orderCount; $i += $limit) {

            $tempList = $Order
                ->where($where)
                ->field(['pay_bankcode', 'pay_amount', 'pay_poundage', 'pay_actualamount', 'pay_status'])
                ->limit($i, $limit)
                ->select();

            $orderList = array_merge($orderList, $tempList);
        }

        //处理查询的数据
        foreach ($productList as $k => $v) {

            $productList[$k]['count']            = 0;
            $productList[$k]['fail_count']       = 0;
            $productList[$k]['success_count']    = 0;
            $productList[$k]['success_rate']     = 0;
            $productList[$k]['pay_amount']       = 0.00;
            $productList[$k]['pay_poundage']     = 0.00;
            $productList[$k]['pay_actualamount'] = 0.00;

            foreach ($orderList as $k1 => $v1) {
                if ($v['id'] == $v1['pay_bankcode']) {
                    $productList[$k]['count']++;
                    if ($v1['pay_status'] != 0) {
                        $productList[$k]['success_count']++;
                        $productList[$k]['pay_amount']       = bcadd($productList[$k]['pay_amount'], $v1['pay_amount'], 4);
                        $productList[$k]['pay_poundage']     = bcadd($productList[$k]['pay_poundage'], $v1['pay_poundage'], 4);
                        $productList[$k]['pay_actualamount'] = bcadd($productList[$k]['pay_actualamount'], $v1['pay_actualamount'], 4);
                    }
                }
            }
            $productList[$k]['fail_count']   = $productList[$k]['count'] - $productList[$k]['success_count'];
            $productList[$k]['success_rate'] = bcdiv($productList[$k]['success_count'], $productList[$k]['count'], 4) * 100;
        }
		//unset($orderList);
        $this->assign('list', $productList);
        $this->assign('rows', $rows);
        $this->assign('page', $Page->show());
        $this->display();
    }*/

  public function channelFinance()
    {
        //时间范围  放入表查询中进行
        $where = [];
        $createtime = urldecode(I("request.createtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime,$cetime) = explode('|',$createtime);

            $where['pay_applydate'] = ['between',[strtotime($cstime),strtotime($cetime)?strtotime($cetime):time()]];
        }
        $this->assign('createtime', $createtime);

        //查询产品表 分页  产品列表
        $Product = M('Product');
        $size = 6;
        $rows = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $count = $Product->count();
        $Page  = new Page($count, $rows);

        //产品列表 所有产品的名字 和编号
        $productList = $Product
            ->field(['id', 'name'])
            ->limit($Page->firstRow . ',' . $Page->listRows)
            ->select();

        //处理查询的数据  遍历产品列表
        foreach ($productList as $k => $v) {
            $Order      = M('Order');
            // 符合时间段内的订单数量
            $where['pay_bankcode'] = $v['id'];
            $orderCount = $Order->where($where)->count();
            // 交易失败的数量
            $fail_count = $Order->where($where)->where('pay_status = 0')->count();
            // 成功的数量
            $success_count = $orderCount - $fail_count;

            // 交易金额
            $pay_amount = $Order->where($where)->where('pay_status <> 0')->sum('pay_amount');
            //手续费=产品的手续费+订单的手续费
            $pay_poundage = $Order->where($where)->where('pay_status <> 0')->sum('pay_poundage');
            //入金总额=产品的入金金额+订单的入金金额
            $pay_actualamount = $Order->where($where)->where('pay_status <> 0')->sum('pay_actualamount');

            //计算交易笔数、成功率、成功笔数、失败笔数
            $productList[$k]['count']            = $orderCount;//交易笔数
            $productList[$k]['fail_count']       = $fail_count;//失败笔数
            $productList[$k]['success_count']    = $success_count;//成功笔数
            $productList[$k]['success_rate']     = bcdiv($success_count, $orderCount, 4) * 100;//成功率=成功笔数/交易笔数
            $productList[$k]['pay_amount']       = bcadd(0.00, $pay_amount, 4);//金额
            $productList[$k]['pay_poundage']     = bcadd(0.00, $pay_poundage, 4);//手续费
            $productList[$k]['pay_actualamount'] = bcadd($pay_actualamount, 0.00, 4);//入金总额
            unset($Order);
        }

        $this->assign('list', $productList);
        $this->assign('rows', $rows);
        $this->assign('page', $Page->show());
        $this->display();
    }
  
    public function productChannelFinance()
    {
        $where = [];
        $createtime = urldecode(I("request.createtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime,$cetime) = explode('|',$createtime);
            $where['pay_applydate'] = ['between',[strtotime($cstime),strtotime($cetime)?strtotime($cetime):time()]];
        }
        $this->assign('createtime', $createtime);
        $id = I('id', 0, 'intval');
        if(!$id) {
            $this->error('缺少参数');
        }
        $product = M('Product')->where(['id' => $id])->find();
        if(empty($product)) {
            $this->error('支付产品不存在');
        }
        $list = M('channel')->where(['product_id' => $product['id']])->select();
        foreach($list as $k => $v) {
            $where['channel_id'] = $v['id'];
            $where['pay_status'] = ['in', '1,2'];
            $sum = M('Order')->field(['sum(`pay_amount`) pay_amount','sum(`cost`) cost', 'sum(`pay_poundage`) pay_poundage', 'sum(`pay_actualamount`) pay_actualamount', 'count(`id`) success_count'])
                ->where($where)->find();
            $list[$k]['pay_amount'] = $sum['pay_amount'];//交易笔数
            $list[$k]['pay_amount'] += 0;
            $list[$k]['pay_poundage'] = $sum['pay_poundage'];//手续费
            $list[$k]['pay_poundage'] += 0;
            $list[$k]['pay_actualamount'] = $sum['pay_actualamount'];//入金总额
            $list[$k]['pay_actualamount'] += 0;
            unset($where['pay_status']);
            $list[$k]['count'] = M('Order')->where($where)->count();//交易笔数
            $list[$k]['count'] += 0;
            $list[$k]['success_count'] = $sum['success_count'];//成功笔数
            $list[$k]['success_count'] += 0;
            $list[$k]['fail_count'] = $list[$k]['count'] - $list[$k]['success_count'];//失败笔数

            $list[$k]['success_rate'] = $list[$k]['count']>0?bcdiv($list[$k]['success_count'],$list[$k]['count'], 4) * 100 : 0;//成功率
        }
        $this->assign('list', $list);
        $this->assign('data', $product);
        $this->display();
    }

    public function channelAccountFinance()
    {
        $where = [];
        $createtime = urldecode(I("request.createtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime,$cetime) = explode('|',$createtime);
            $where['pay_applydate'] = ['between',[strtotime($cstime),strtotime($cetime)?strtotime($cetime):time()]];
        }
        $this->assign('createtime', $createtime);
        $id = I('id', 0, 'intval');
        if(!$id) {
            $this->error('缺少参数');
        }
        $channel = M('Channel')->where(['id' => $id])->find();
        if(empty($channel)) {
            $this->error('支付通道不存在');
        }
        $list = M('channelAccount')->where(['channel_id' => $id])->select();
        foreach($list as $k => $v) {
            $where['account_id'] = $v['id'];
            $where['pay_status'] = ['in', '1,2'];
            $sum = M('Order')->field(['sum(`pay_amount`) pay_amount','sum(`cost`) cost', 'sum(`pay_poundage`) pay_poundage', 'sum(`pay_actualamount`) pay_actualamount', 'count(`id`) success_count'])
                ->where($where)->find();
            $list[$k]['pay_amount'] = $sum['pay_amount'];//交易笔数
            $list[$k]['pay_amount'] += 0;
            $list[$k]['pay_poundage'] = $sum['pay_poundage'];//手续费
            $list[$k]['pay_poundage'] += 0;
            $list[$k]['pay_actualamount'] = $sum['pay_actualamount'];//入金总额
            $list[$k]['pay_actualamount'] += 0;
            unset($where['pay_status']);
            $list[$k]['count'] = M('Order')->where($where)->count();//交易笔数
            $list[$k]['count'] += 0;
            $list[$k]['success_count'] = $sum['success_count'];//成功笔数
            $list[$k]['success_count'] += 0;
            $list[$k]['fail_count'] = $list[$k]['count'] - $list[$k]['success_count'];//失败笔数
            $list[$k]['success_rate'] = $list[$k]['count']>0?bcdiv($list[$k]['success_count'],$list[$k]['count'], 4) * 100 : 0;//成功率
        }
        $this->assign('list', $list);
        $this->assign('data', $channel);
        $this->display();
    }

    //充值排名
    public function chargeRank() {

        $successtime = urldecode(I("request.successtime", ''));
        if(!$successtime) {//默认今日
            $beginToday = mktime(0, 0, 0, date('m'), date('d'), date('Y'));
            $endToday = mktime(0, 0, 0, date('m'), date('d') + 1, date('Y')) - 1;
            $successtime = $_GET['successtime'] = date('Y-m-d H:i:s', $beginToday). ' | '.date('Y-m-d H:i:s', $endToday);
        }
        list($cstime, $cetime)  = explode('|', $successtime);
        $count = M()->query("SELECT count('a.*') as count FROM(SELECT pay_member.id as userid FROM `pay_order` LEFT JOIN pay_member ON (pay_member.id + 10000) = pay_order.pay_memberid WHERE `pay_successdate` BETWEEN ".strtotime($cstime)." AND ".strtotime($cetime)." AND `pay_status` > 0 AND `ddlx` = 1 GROUP BY pay_memberid)  a");
        $count = $count[0]['count'];
        $size = 50;
        $rows = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $where['pay_successdate'] = ['between', [strtotime($cstime), strtotime($cetime) ? strtotime($cetime) : time()]];
        $where['pay_status'] = ['gt',0];
        //$where['ddlx'] = 1;
        $page = new Page($count, $rows);
        $list = M('Order')
            ->join('LEFT JOIN __MEMBER__ ON (__MEMBER__.id + 10000) = __ORDER__.pay_memberid')
            ->field('pay_member.id as userid,pay_member.username,pay_member.realname,sum(pay_amount) as total_charge')
            ->where($where)
            ->limit($page->firstRow . ',' . $page->listRows)
            ->group('pay_memberid')
            ->order('total_charge desc')
            ->select();
        if(!$_GET['p']) {
            $_GET['p'] = 1;
        }
        foreach($list as $k => $v) {
            $list[$k]['rank'] = $rows*($_GET['p']-1)+$k+1;
        }
        $this->assign('rows', $rows);
        $this->assign("list", $list);
        $this->assign('page', $page->show());
        C('TOKEN_ON', false);
        $this->display();
    }

    /*
     * 投诉保证金统计
     */
    public function complaintsDeposit()
    {
        $groupid          = I('get.groupid', 'member');
        $where['groupid'] = $groupid == 'agent' ? ['gt', '4'] : ['eq', '4'];
        if ($memberid = I('get.memberid', '')) {
            $where['id'] = $memberid - 10000;
        }
        $this->assign('memberid', $memberid);
        $createtime = urldecode(I("request.createtime"));
        if ($createtime) {
            list($cstime, $cetime)  = explode('|', $createtime);
            $map['create_at'] = ['between', [strtotime($cstime), strtotime($cetime) ? strtotime($cetime) : time()]];
        }
        $this->assign('createtime', $createtime);
        $size = 15;
        $rows = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $Member     = M('Member');
        $count      = $Member->where($where)->count();
        $Page       = new Page($count, $rows);
        $show       = $Page->show();
        $memberList = $Member
            ->field(['id,username'])
            ->where($where)
            ->limit($Page->firstRow . ',' . $Page->listRows)
            ->select();
        if ($memberList) {
            foreach ($memberList as $k => $v) {
                if(isset($map['status'])) {
                    unset($map['status']);
                }
                $payMemberid = $v['id'] + 10000;
                $map['user_id'] = $v['id'];
                $memberList[$k]['total'] = round(M('complaints_deposit')->where($map)->sum('freeze_money'),4);
                $map['status'] = 0;
                $memberList[$k]['freeze_money'] = round(M('complaints_deposit')->where($map)->sum('freeze_money'),4);
                $map['status'] = 1;
                $memberList[$k]['unfreeze_money'] = round(M('complaints_deposit')->where($map)->sum('freeze_money'),4);
                $memberList[$k]['pay_memberid'] = $payMemberid;
            }
        }
        $this->assign('rows', $rows);
        $this->assign('show', $show);
        $this->assign('list', $memberList);
        $this->display();

    }

    /*
    * 投诉保证金统计
    */
    public function exportComplaintsDeposit() {
        $groupid          = I('get.groupid', 'member');
        $where['groupid'] = $groupid == 'agent' ? ['gt', '4'] : ['eq', '4'];
        if ($memberid = I('get.memberid', '')) {
            $where['id'] = $memberid - 10000;
        }
        $createtime = urldecode(I("request.createtime"));
        if ($createtime) {
            list($cstime, $cetime)  = explode('|', $createtime);
            $map['create_at'] = ['between', [strtotime($cstime), strtotime($cetime) ? strtotime($cetime) : time()]];
        }
        $Member     = M('Member');
        $memberList = $Member
            ->field(['id,username'])
            ->where($where)
            ->select();
        if ($memberList) {
            foreach ($memberList as $k => $v) {
                if(isset($map['status'])) {
                    unset($map['status']);
                }
                $payMemberid = $v['id'] + 10000;
                $map['user_id'] = $v['id'];
                $total = round(M('complaints_deposit')->where($map)->sum('freeze_money'),4);
                $map['status'] = 0;
                $freeze_money = round(M('complaints_deposit')->where($map)->sum('freeze_money'),4);
                $map['status'] = 1;
                $unfreeze_money = round(M('complaints_deposit')->where($map)->sum('freeze_money'),4);
                $list[] = array(
                    'payMemberid' => $payMemberid,
                    'total' => $total,
                    'freeze_money' => $freeze_money,
                    'unfreeze_money' => $unfreeze_money
                );
            }
        }
        $title = array(
            '商户号',
            '总保证金',
            '待解冻保证金',
            '已解冻保证金',
        );
        exportCsv($list, $title);
    }

    /*
     * 平台报表
     */
    public function platformReport() {


        $date = urldecode(I("request.date", ''));
        if(!$date) {//默认今日
            $date = date('Y-m-d');
        }
        $this->assign('date', $date);
        if ($memberid = I('get.memberid', '')) {
            $where['id'] = $memberid - 10000;
        }
        $this->assign('memberid', $memberid);
        if($date>date('Y-m-d')) {
            $this->error('日期错误');
        }
        $timestamp = strtotime($date);
        //开始时间戳
        $begin = mktime(0, 0, 0, date('m',$timestamp), date('d',$timestamp), date('Y',$timestamp));
        //结束时间戳
        $end = mktime(0, 0, 0, date('m',$timestamp), date('d',$timestamp) + 1, date('Y',$timestamp)) - 1;
        $beginDate = date('Y-m-d H:i:s', $begin);
        $endDate = date('Y-m-d H:i:s', $end);
        $Member     = M('Member');
        $count      = $Member->where($where)->count();
        $size = 15;
        $rows = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $Page       = new Page($count, $rows);
        $show       = $Page->show();
        $data = $Member
            ->field(['id,username,balance'])
            ->where($where)
            ->limit($Page->firstRow . ',' . $Page->listRows)
            ->select();
        if ($data) {
            foreach ($data as $k => $v) {
                $data[$k]['memberid'] = $v['id'] +10000;
                $data[$k]['username'] = $v['username'];
                //冲正金额
                $redoAddSum = M('redo_order')->where(['type'=>1,'user_id'=>$v['id'],'date'=>['between', [$beginDate, $endDate]]])->sum('money');
                $redoReduceSum = M('redo_order')->where(['type'=>2,'user_id'=>$v['id'],'date'=>['between', [$beginDate, $endDate]]])->sum('money');
                //期初余额
                $data[$k]['initial_money'] = $this->getDateBalance($v['id'],$beginDate);
                //入金金额
                $orderSum = M('Order')->where(['pay_memberid'=>10000+$v['id'],'pay_successdate' => ['between', [$begin, $end]], 'pay_status' => ['in', '1,2']])->sum('pay_amount');
                $data[$k]['income_money'] = $orderSum + $redoAddSum - $redoReduceSum;
                //出金待审核金额
                $payWaitCheckedSum1 = M('tklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','0,1']])->sum('tkmoney');
                $payWaitCheckedSum2 = M('wttklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','0,1']])->sum('tkmoney');
                $data[$k]['pay_wait_checked'] = $payWaitCheckedSum1 + $payWaitCheckedSum2;
                //出金成功金额
                $payCheckedSum1 = M('tklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $payCheckedSum2 = M('wttklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $data[$k]['pay_success'] = $payCheckedSum1 + $payCheckedSum2;
                //出金失败金额
                $payFailSum1 = M('tklist')->where(['userid'=>$v['id'],'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','3,4']])->sum('tkmoney');
                $payFailSum2 = M('wttklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','3,4']])->sum('tkmoney');
                $data[$k]['pay_fail'] = $payFailSum1 + $payFailSum2;
                //入金利润
                $actualamount = M('Order')->where(['pay_memberid'=>10000+$v['id'],'pay_successdate' => ['between', [$begin, $end]], 'pay_status' => ['in', '1,2']])->sum('pay_actualamount');
                //$profitSum = M('moneychange')->where(['tcuserid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>9])->sum('money');
                $data[$k]['income_profit'] = $data[$k]['income_money'] - $actualamount - $redoAddSum + $redoReduceSum;
                //出金利润
                $tkmoney1 = M('tklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $tkmoney2 = M('wttklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $money1 = M('tklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('money');
                $money2 = M('wttklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('money');
                $cjcost = M('wttklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('cost');//出金成本
                //出金手续费
                $sxf1 = M('moneychange')->where(['userid'=>$v['id'],'lx'=>14, 'datetime'=>['between', [$beginDate, $endDate]]])->sum('money');
                $sxf2 = M('moneychange')->where(['userid'=>$v['id'],'lx'=>16, 'datetime'=>['between', [$beginDate, $endDate]]])->sum('money');
                //退回出金手续费
                $qxsxf1 = M('moneychange')->where(['userid'=>$v['id'],'lx'=>15, 'datetime'=>['between', [$beginDate, $endDate]]])->sum('money');
                $qxsxf2 = M('moneychange')->where(['userid'=>$v['id'],'lx'=>17, 'datetime'=>['between', [$beginDate, $endDate]]])->sum('money');
                //出金实际手续费
                $data[$k]['cjsxf'] = $sxf1 + $sxf2 - $qxsxf1 - $qxsxf2;
                $data[$k]['pay_profit'] = $tkmoney1 + $tkmoney2 - $money1 - $money2 - $cjcost + $data[$k]['cjsxf'];
                //冻结金额
                $frozen_money1 = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>1, 't'=>1])->sum('money');
                $frozen_money2 = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>7])->sum('money');
                $frozen_money3= M('complaints_deposit')->where(['user_id'=>$v['id'],'create_at'=>['between', [$begin, $end]]])->sum('freeze_money');
                $data[$k]['frozen_money'] = $frozen_money1 + $frozen_money2 + $frozen_money3;
                //商户实际到账金额
                $merchantProfitSum = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>9])->sum('money');
                $data[$k]['merchant_money'] = $actualamount + $merchantProfitSum + $redoAddSum - $redoReduceSum;
                //平台成本
                $cost1 = M('Order')->where(['pay_memberid'=>10000+$v['id'],'pay_successdate' => ['between', [$begin, $end]], 'pay_status' => ['in', '1,2']])->sum('cost');
                $cost2 = M('wttklist')->where(['userid'=>$v['id'],'cldatetime' => ['between', [$begin, $end]], 'status' => 2])->sum('cost');
                $cost3 = M('moneychange')->where(['tcuserid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>9])->sum('money');
                $data[$k]['platform_cost'] = $cost1 + $cost2 + $cost3;
                //平台利润
                $data[$k]['platform_profit'] = $data[$k]['income_profit'] +  $data[$k]['pay_profit'] - $data[$k]['platform_cost'] + $data['cjsxf'];
                //期末余额
                $data[$k]['end_profit'] = $this->getDateBalance($v['id'],$endDate);
                //当前余额
                $data[$k]['current_money'] = $v['balance'];
                foreach($data[$k] as $kk => $vv) {
                    if($kk !='memberid' && $kk != 'username' ) {
                        $data[$k][$kk] = number_format($vv, 4, '.', ',');
                    }
                }
            }
        }
        $platform_profit_all = $this->getPlatformProfit();
        $this->assign('platform_profit_all', $platform_profit_all);
        $this->assign('rows', $rows);
        $this->assign('page', $show);
        $this->assign('list', $data);
        $this->display();
    }

    /*
     * 商户报表
     */
    public function merchantReport() {

        $date = urldecode(I("request.date", ''));
        if(!$date) {//默认今日
            $date = date('Y-m-d');
        }
        $this->assign('date', $date);
        if ($memberid = I('get.memberid', '')) {
            $where['id'] = $memberid - 10000;
        }
        $this->assign('memberid', $memberid);
        if($date>date('Y-m-d')) {
            $this->error('日期错误');
        }
        $timestamp = strtotime($date);
        //开始时间戳
        $begin = mktime(0, 0, 0, date('m',$timestamp), date('d',$timestamp), date('Y',$timestamp));
        //结束时间戳
        $end = mktime(0, 0, 0, date('m',$timestamp), date('d',$timestamp) + 1, date('Y',$timestamp)) - 1;
        $beginDate = date('Y-m-d H:i:s', $begin);
        $endDate = date('Y-m-d H:i:s', $end);
        $Member     = M('Member');
        $where['groupid'] = 4;
        $count      = $Member->where($where)->count();
        $size = 15;
        $rows = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $Page       = new Page($count, $rows);
        $show       = $Page->show();
        $data = $Member
            ->field(['id,parentid,username,balance'])
            ->where($where)
            ->limit($Page->firstRow . ',' . $Page->listRows)
            ->select();
        if ($data) {
            foreach ($data as $k => $v) {
                $data[$k]['memberid'] = $v['id'] +10000;
                $data[$k]['username'] = $v['username'];
                //冲正金额
                $redoAddSum = M('redo_order')->where(['type'=>1,'user_id'=>$v['id'],'date'=>['between', [$beginDate, $endDate]]])->sum('money');
                $redoReduceSum = M('redo_order')->where(['type'=>2,'user_id'=>$v['id'],'date'=>['between', [$beginDate, $endDate]]])->sum('money');
                //入金通道费率
                $data[$k]['channel_rate'] = M('ProductUser')
                    ->join('LEFT JOIN __PRODUCT__ ON __PRODUCT__.id = __PRODUCT_USER__.pid')
                    ->where(['pay_product_user.userid'=>$v['id'],'pay_product_user.status'=>1,'pay_product.isdisplay'=>1])
                    ->field('pay_product.name,pay_product.id,pay_product.code,pay_product_user.status')
                    ->select();
                $tkconfig = M('Tikuanconfig')->where(['userid'=>$v['id']])->find();
                if(!$tkconfig || $tkconfig['tkzt']!=1 || $tkconfig['systemxz'] != 1){
                    $tkconfig = M('Tikuanconfig')->where(['issystem'=>1])->find();
                }
                foreach ($data[$k]['channel_rate'] as $key=>$item){
                    $_userrate =  M('Userrate')->where(['userid'=>$v['id'],'payapiid'=>$item['id']])->find();
                    $syschannel = M('Channel')->where(['id' => $item['channel']])->find();
                    if ($tkconfig['t1zt'] == 0) { //T+0费率
                        $feilv    = $_userrate['t0feilv'] ? $_userrate['t0feilv'] : $syschannel['t0defaultrate']; // 交易费率
                    } else { //T+1费率
                        $feilv    = $_userrate['feilv'] ? $_userrate['feilv'] : $syschannel['defaultrate']; // 交易费率
                    }
                    $data[$k]['channel_rate'][$key]['feilv'] = $feilv;
                }
                //期初余额
                $data[$k]['initial_money'] = $this->getDateBalance($v['id'],$beginDate);
                //入金金额
                $orderSum = M('Order')->where(['pay_memberid'=>10000+$v['id'],'pay_successdate' => ['between', [$begin, $end]], 'pay_status' => ['in', '1,2']])->sum('pay_amount');
                $profitSum = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>9])->sum('money');
                $data[$k]['income_money'] = $orderSum + $profitSum + $redoAddSum - $redoReduceSum;
                //出金待审核金额
                $payWaitCheckedSum1 = M('tklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','0,1']])->sum('tkmoney');
                $payWaitCheckedSum2 = M('wttklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','0,1']])->sum('tkmoney');
                $data[$k]['pay_wait_checked'] = $payWaitCheckedSum1 + $payWaitCheckedSum2;
                //出金成功金额
                $payCheckedSum1 = M('tklist')->where(['userid'=>$v['id'], 'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $payCheckedSum2 = M('wttklist')->where(['userid'=>$v['id'], 'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $data[$k]['pay_success'] = $payCheckedSum1 + $payCheckedSum2;
                //出金失败金额
                $payFailSum1 = M('tklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','3,4']])->sum('tkmoney');
                $payFailSum2 = M('wttklist')->where(['userid'=>$v['id'], 'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','3,4']])->sum('tkmoney');
                $data[$k]['pay_fail'] = $payFailSum1 + $payFailSum2;
                //出金手续费
                $tkConfig     = M('Tikuanconfig')->where(['userid' => $v['id'], 'tkzt' => 1])->find();
                if (!$tkConfig || $tkConfig['tkzt'] != 1) {
                    $tkConfig = M('Tikuanconfig')->where(['issystem' => 1])->find();
                }
                if($tkConfig['tktype'] == 1) {
                    $data[$k]['tksxf'] = $tkConfig['sxffixed'].'/笔';
                } else {
                    $data[$k]['tksxf'] = $tkConfig['sxfrate'].'%';
                }
                //冻结金额
                $frozen_money1 = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>1, 't'=>1])->sum('money');
                $frozen_money2 = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>7])->sum('money');
                $frozen_money3= M('complaints_deposit')->where(['user_id'=>$v['id'],'create_at'=>['between', [$begin, $end]]])->sum('freeze_money');
                $data[$k]['frozen_money'] = $frozen_money1 + $frozen_money2 + $frozen_money3;
                //商户实际到账金额
                $actualamount = M('Order')->where(['pay_memberid'=>10000+$v['id'],'pay_successdate' => ['between', [$begin, $end]], 'pay_status' => ['in', '1,2']])->sum('pay_actualamount');
                $orderSum = $actualamount + $profitSum + $redoAddSum - $redoReduceSum;
                $data[$k]['merchant_money'] = $orderSum;
                //期末余额
                $data[$k]['end_profit'] = $this->getDateBalance($v['id'],$endDate);
                //当前余额
                $data[$k]['current_money'] = $this->fans['balance'];
                foreach($data[$k] as $kk => $vv) {
                    if($kk !='memberid' && $kk != 'channel_rate' && $kk != 'username' && $kk != 'tksxf') {
                        $data[$k][$kk] = number_format($vv, 4, '.', ',');
                    }
                }
                if($v['parentid'] > 0) {
                    $data[$k]['parent'] = M('Member')->where(['id'=>$v['parentid']])->getField('username');
                } else {
                    $data[$k]['parent'] = '';
                }
            }
        }
        $this->assign('rows', $rows);
        $this->assign('page', $show);
        $this->assign('list', $data);
        $this->display();
    }

    /*
    * 代理报表
    */
    public function agentReport() {
        $date = urldecode(I("request.date", ''));
        if(!$date) {//默认今日
            $date = date('Y-m-d');
        }
        $this->assign('date', $date);
        if ($memberid = I('get.memberid', '')) {
            $where['id'] = $memberid - 10000;
        }
        $this->assign('memberid', $memberid);
        if($date>date('Y-m-d')) {
            $this->error('日期错误');
        }
        $timestamp = strtotime($date);
        //开始时间戳
        $begin = mktime(0, 0, 0, date('m',$timestamp), date('d',$timestamp), date('Y',$timestamp));
        //结束时间戳
        $end = mktime(0, 0, 0, date('m',$timestamp), date('d',$timestamp) + 1, date('Y',$timestamp)) - 1;
        $beginDate = date('Y-m-d H:i:s', $begin);
        $endDate = date('Y-m-d H:i:s', $end);
        $Member     = M('Member');
        $count      = $Member->where($where)->count();
        $size = 15;
        $rows = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $Page       = new Page($count, $rows);
        $show       = $Page->show();
        $where['groupid'] = ['gt', 4];
        $data = $Member
            ->field(['id,parentid,username,balance'])
            ->where($where)
            ->limit($Page->firstRow . ',' . $Page->listRows)
            ->select();
        if ($data) {
            foreach ($data as $k => $v) {
                $data[$k]['memberid'] = $v['id'] +10000;
                $data[$k]['username'] = $v['username'];
                //冲正金额
                $redoAddSum = M('redo_order')->where(['type'=>1,'user_id'=>$v['id'],'date'=>['between', [$beginDate, $endDate]]])->sum('money');
                $redoReduceSum = M('redo_order')->where(['type'=>2,'user_id'=>$v['id'],'date'=>['between', [$beginDate, $endDate]]])->sum('money');
                //入金通道费率
                $data[$k]['channel_rate'] = M('ProductUser')
                    ->join('LEFT JOIN __PRODUCT__ ON __PRODUCT__.id = __PRODUCT_USER__.pid')
                    ->where(['pay_product_user.userid'=>$v['id'],'pay_product_user.status'=>1,'pay_product.isdisplay'=>1])
                    ->field('pay_product.name,pay_product.id,pay_product.code,pay_product_user.status')
                    ->select();
                $tkconfig = M('Tikuanconfig')->where(['userid'=>$v['id']])->find();
                if(!$tkconfig || $tkconfig['tkzt']!=1 || $tkconfig['systemxz'] != 1){
                    $tkconfig = M('Tikuanconfig')->where(['issystem'=>1])->find();
                }
                foreach ($data[$k]['channel_rate'] as $key=>$item){
                    $_userrate =  M('Userrate')->where(['userid'=>$v['id'],'payapiid'=>$item['id']])->find();
                    $syschannel = M('Channel')->where(['id' => $item['channel']])->find();
                    if ($tkconfig['t1zt'] == 0) { //T+0费率
                        $feilv    = $_userrate['t0feilv'] ? $_userrate['t0feilv'] : $syschannel['t0defaultrate']; // 交易费率
                    } else { //T+1费率
                        $feilv    = $_userrate['feilv'] ? $_userrate['feilv'] : $syschannel['defaultrate']; // 交易费率
                    }
                    $data[$k]['channel_rate'][$key]['feilv'] = $feilv;
                }
                //期初余额
                $data[$k]['initial_money'] = $this->getDateBalance($v['id'], $date);
                //代理利润
                $profit = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>9])->sum('money');
                $data[$k]['income_money'] =  $profit + $redoAddSum - $redoReduceSum;
                //出金待审核金额
                $payWaitCheckedSum1 = M('tklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','0,1']])->sum('tkmoney');
                $payWaitCheckedSum2 = M('wttklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','0,1']])->sum('tkmoney');
                $data[$k]['pay_wait_checked'] = $payWaitCheckedSum1 + $payWaitCheckedSum2;
                //出金成功金额
                $payCheckedSum1 = M('tklist')->where(['userid'=>$v['id'], 'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $payCheckedSum2 = M('wttklist')->where(['userid'=>$v['id'], 'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $data[$k]['pay_success'] = $payCheckedSum1 + $payCheckedSum2;
                //出金失败金额
                $payFailSum1 = M('tklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','3,4']])->sum('tkmoney');
                $payFailSum2 = M('wttklist')->where(['userid'=>$v['id'], 'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','3,4']])->sum('tkmoney');
                $data[$k]['pay_fail'] = $payFailSum1 + $payFailSum2;
                //出金手续费
                $tkConfig     = M('Tikuanconfig')->where(['userid' => $v['id'], 'tkzt' => 1])->find();
                if (!$tkConfig || $tkConfig['tkzt'] != 1) {
                    $tkConfig = M('Tikuanconfig')->where(['issystem' => 1])->find();
                }
                if($tkConfig['tktype'] == 1) {
                    $data[$k]['tksxf'] = $tkConfig['sxffixed'].'/笔';
                } else {
                    $data[$k]['tksxf'] = $tkConfig['sxfrate'].'%';
                }
                //冻结金额
                $frozen_money1 = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>1, 't'=>1])->sum('money');
                $frozen_money2 = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>7])->sum('money');
                $frozen_money3= M('complaints_deposit')->where(['user_id'=>$v['id'],'create_at'=>['between', [$begin, $end]]])->sum('freeze_money');
                $data[$k]['frozen_money'] = $frozen_money1 + $frozen_money2 + $frozen_money3;
                //代理实际到账金额
                $data[$k]['merchant_money'] = $data[$k]['income_money'];
                //期末余额
                $data[$k]['end_profit'] = $this->getDateBalance($v['id'],$endDate);
                //当前余额
                $data[$k]['current_money'] = $this->fans['balance'];
                foreach($data[$k] as $kk => $vv) {
                    if($kk !='memberid' && $kk != 'channel_rate' && $kk != 'username' && $kk != 'tksxf') {
                        $data[$k][$kk] = number_format($vv, 4, '.', ',');
                    }
                }
                if($v['parentid'] > 0) {
                    $data[$k]['parent'] = M('Member')->where(['id'=>$v['parentid']])->getField('username');
                } else {
                    $data[$k]['parent'] = '';
                }
            }
        }
        $this->assign('page', $show);
        $this->assign('date', $date);
        $this->assign('list', $data);
        $this->assign('rows', $rows);
        $this->display();
    }

    /*
     * 获取初期余额
     */
    private function getAllMoney($date) {

        $money = 0;
        $lists = M('Member')->field('id')->select();
        foreach($lists as $v) {
            $money += $this->getUserBalance($v['id'], $date) ;
        }
        return $money;
    }


    /*
     * 根据日期获取用户余额
     */
    private function getUserBalance($userid, $date) {

        $money = M('Moneychange')->where(['userid'=>$userid, 'datetime'=>array('elt', $date), 't'=>['neq', 1], 'lx' => ['not in', '3,4']])->order('datetime DESC')->getField('gmoney');
        if(empty($money)) {
            $money = 0;
        }
        return $money;
    }

    /*
   * 根据日期获取用户期初余额
   */
    private function getDateBalance($userid, $date) {

        $log = M('Moneychange')->where(['userid'=>$userid, 'datetime'=>array('elt', $date), 't'=>['neq', 1], 'lx' => ['not in', '3,4']])->order('datetime DESC,id DESC')->find();
        if(empty($log)) {
            $money = 0;
        } else {
            $yesterdayTime = date("Y-m-d 00:00:00",strtotime($date)-1);
            $yesterdayRedAddSum = M('redo_order')->where(['type'=>1,'user_id'=>$userid,'date'=>$yesterdayTime, 'ctime'=>['gt', strtotime($log['datetime'])]])->sum('money');
            $lastlog = M('Moneychange')->where(['userid'=>$userid, 'datetime'=>array('elt', $date), 't'=>['neq', 1]])->order('datetime DESC,id DESC')->find();
            if($lastlog['lx'] == 3 || $lastlog['lx'] == 4) {
                $money = $lastlog['gmoney'];
            } else {
                $yesterdayRedReduceSum = M('redo_order')->where(['type'=>2,'user_id'=>$userid,'date'=>$yesterdayTime, 'ctime'=>['gt', strtotime($log['datetime'])]])->sum('money');
                $money = $log['gmoney'] + $yesterdayRedAddSum - $yesterdayRedReduceSum + 0;
            }
        }
        return $money;
    }

    /*
     * 冻结资金统计
     */
    public function frozenMoney()
    {
        if ($memberid = I('get.memberid', '')) {
            $where['id'] = $memberid - 10000;
        }
        $this->assign('memberid', $memberid);
        $createtime = urldecode(I("request.createtime"));
        if ($createtime) {
            list($cstime, $cetime)  = explode('|', $createtime);
            $map['create_at'] = ['between', [strtotime($cstime), strtotime($cetime) ? strtotime($cetime) : time()]];
        }
        $this->assign('createtime', $createtime);
        $size = 15;
        $rows = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $Member     = M('Member');
        $count      = $Member->where($where)->count();
        $Page       = new Page($count, $rows);
        $show       = $Page->show();
        $memberList = $Member
            ->field(['id'])
            ->where($where)
            ->limit($Page->firstRow . ',' . $Page->listRows)
            ->select();
        if ($memberList) {
            foreach ($memberList as $k => $v) {
                if(isset($map['status'])) {
                    unset($map['status']);
                }
                $payMemberid = $v['id'] + 10000;
                $memberList[$k]['pay_memberid'] = $payMemberid;
                //T+1金额待解冻
                $memberList[$k]['t1_freeze_money'] = M('blockedlog')->where(['userid'=>$v['id'], 'status'=>0])->sum('amount');
                //T+1金额已解冻
                $memberList[$k]['t1_unfreeze_money'] = M('blockedlog')->where(['userid'=>$v['id'], 'status'=>1])->sum('amount');
                //手动冻结金额待解冻
                $memberList[$k]['handle_frozen_money'] = M('auto_unfrozen_order')->where(['user_id'=>$v['id'], 'status'=>0])->sum('freeze_money');
                //手动冻结金额已解冻
                $memberList[$k]['handle_unfrozen_money'] = M('auto_unfrozen_order')->where(['user_id'=>$v['id'], 'status'=>0])->sum('freeze_money');
                //投诉保证金待解冻
                $memberList[$k]['complaints_deposit_freeze_money'] = M('complaints_deposit')->where(['user_id'=>$v['id'],'status'=>0])->sum('freeze_money');
                //投诉保证金已解冻
                $memberList[$k]['complaints_deposit_unfreeze_money'] = M('complaints_deposit')->where(['user_id'=>$v['id'],'status'=>1])->sum('freeze_money');
                //总待解冻金额
                $memberList[$k]['total_freeze_money'] = $memberList[$k]['t1_freeze_money'] + $memberList[$k]['handle_frozen_money'] + $memberList[$k]['complaints_deposit_freeze_money'];
                //总已解冻金额
                $memberList[$k]['total_unfreeze_money'] = $memberList[$k]['t1_unfreeze_money'] + $memberList[$k]['handle_unfrozen_money'] + $memberList[$k]['complaints_deposit_unfreeze_money'];

                foreach($memberList[$k] as $kk => $vv) {
                    $memberList[$k][$kk] += 0;
                }
            }
        }
        $this->assign('rows', $rows);
        $this->assign('show', $show);
        $this->assign('list', $memberList);
        $this->display();

    }


    //导出平台报表
    public function exportPlatform(){
        $date = urldecode(I("request.date", ''));
        if(!$date) {//默认今日
            $date = date('Y-m-d');
        }
        if ($memberid = I('get.memberid', '')) {
            $where['id'] = $memberid - 10000;
        }
        if($date>date('Y-m-d')) {
            $this->error('日期错误');
        }
        $timestamp = strtotime($date);
        //开始时间戳
        $begin = mktime(0, 0, 0, date('m',$timestamp), date('d',$timestamp), date('Y',$timestamp));
        //结束时间戳
        $end = mktime(0, 0, 0, date('m',$timestamp), date('d',$timestamp) + 1, date('Y',$timestamp)) - 1;
        $beginDate = date('Y-m-d H:i:s', $begin);
        $endDate = date('Y-m-d H:i:s', $end);
        $Member     = M('Member');
        $data = $Member
            ->field(['id,username,balance'])
            ->where($where)
            ->select();
        if ($data) {
            foreach ($data as $k => $v) {
                $data[$k]['memberid'] = $v['id'] +10000;
                $data[$k]['username'] = $v['username'];
                //冲正金额
                $redoAddSum = M('redo_order')->where(['type'=>1,'user_id'=>$v['id'],'date'=>['between', [$beginDate, $endDate]]])->sum('money');
                $redoReduceSum = M('redo_order')->where(['type'=>2,'user_id'=>$v['id'],'date'=>['between', [$beginDate, $endDate]]])->sum('money');
                //期初余额
                $data[$k]['initial_money'] = $this->getDateBalance($v['id'],$beginDate);
                //入金金额
                $orderSum = M('Order')->where(['pay_memberid'=>10000+$v['id'],'pay_successdate' => ['between', [$begin, $end]], 'pay_status' => ['in', '1,2']])->sum('pay_amount');
                $data[$k]['income_money'] = $orderSum + $redoAddSum - $redoReduceSum;
                //出金待审核金额
                $payWaitCheckedSum1 = M('tklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','0,1']])->sum('tkmoney');
                $payWaitCheckedSum2 = M('wttklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','0,1']])->sum('tkmoney');
                $data[$k]['pay_wait_checked'] = $payWaitCheckedSum1 + $payWaitCheckedSum2;
                //出金成功金额
                $payCheckedSum1 = M('tklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $payCheckedSum2 = M('wttklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $data[$k]['pay_success'] = $payCheckedSum1 + $payCheckedSum2;
                //出金失败金额
                $payFailSum1 = M('tklist')->where(['userid'=>$v['id'],'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','3,4']])->sum('tkmoney');
                $payFailSum2 = M('wttklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','3,4']])->sum('tkmoney');
                $data[$k]['pay_fail'] = $payFailSum1 + $payFailSum2;
                //入金利润
                $actualamount = M('Order')->where(['pay_memberid'=>10000+$v['id'],'pay_successdate' => ['between', [$begin, $end]], 'pay_status' => ['in', '1,2']])->sum('pay_actualamount');
                //$profitSum = M('moneychange')->where(['tcuserid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>9])->sum('money');
                $data[$k]['income_profit'] = $data[$k]['income_money'] - $actualamount - $redoAddSum + $redoReduceSum;
                //出金利润
                $tkmoney1 = M('tklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $tkmoney2 = M('wttklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $money1 = M('tklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('money');
                $money2 = M('wttklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('money');
                $cjcost = M('wttklist')->where(['userid'=>$v['id'], 'cldatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('cost');//出金成本
                //出金手续费
                $sxf1 = M('moneychange')->where(['userid'=>$v['id'],'lx'=>14, 'datetime'=>['between', [$beginDate, $endDate]]])->sum('money');
                $sxf2 = M('moneychange')->where(['userid'=>$v['id'],'lx'=>16, 'datetime'=>['between', [$beginDate, $endDate]]])->sum('money');
                //退回出金手续费
                $qxsxf1 = M('moneychange')->where(['userid'=>$v['id'],'lx'=>15, 'datetime'=>['between', [$beginDate, $endDate]]])->sum('money');
                $qxsxf2 = M('moneychange')->where(['userid'=>$v['id'],'lx'=>17, 'datetime'=>['between', [$beginDate, $endDate]]])->sum('money');
                //出金实际手续费
                $data[$k]['cjsxf'] = $sxf1 + $sxf2 - $qxsxf1 - $qxsxf2;
                $data[$k]['pay_profit'] = $tkmoney1 + $tkmoney2 - $money1 - $money2 - $cjcost + $data[$k]['cjsxf'];
                //冻结金额
                $frozen_money1 = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>1, 't'=>1])->sum('money');
                $frozen_money2 = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>7])->sum('money');
                $frozen_money3= M('complaints_deposit')->where(['user_id'=>$v['id'],'create_at'=>['between', [$begin, $end]]])->sum('freeze_money');
                $data[$k]['frozen_money'] = $frozen_money1 + $frozen_money2 + $frozen_money3;
                //商户实际到账金额
                $merchantProfitSum = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>9])->sum('money');
                $data[$k]['merchant_money'] = $actualamount + $merchantProfitSum + $redoAddSum - $redoReduceSum;
                //平台成本
                $cost1 = M('Order')->where(['pay_memberid'=>10000+$v['id'],'pay_successdate' => ['between', [$begin, $end]], 'pay_status' => ['in', '1,2']])->sum('cost');
                $cost2 = M('wttklist')->where(['userid'=>$v['id'],'cldatetime' => ['between', [$begin, $end]], 'status' => 2])->sum('cost');
                $cost3 = M('moneychange')->where(['tcuserid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>9])->sum('money');
                $data[$k]['platform_cost'] = $cost1 + $cost2 + $cost3;
                //平台利润
                $data[$k]['platform_profit'] = $data[$k]['income_profit'] +  $data[$k]['pay_profit'] - $data[$k]['platform_cost'] + $data['cjsxf'];
                //期末余额
                $data[$k]['end_profit'] = $this->getDateBalance($v['id'],$endDate);
                //当前余额
                $data[$k]['current_money'] = $v['balance'];
                foreach($data[$k] as $kk => $vv) {
                    if($kk !='memberid' && $kk != 'username' ) {
                        $data[$k][$kk] = number_format($vv, 4, '.', ',');
                    }
                }
            }
            foreach ($data as $m => $n){
                $list[] = array(
                    'memberid'=>$n['memberid'],
                    'username'=>$n['username'],
                    'initial_money'=>$n['initial_money'],
                    'income_money'=>$n['income_money'],
                    'pay_wait_checked'=>$n['pay_wait_checked'],
                    'pay_success'=>$n['pay_success'],
                    'pay_fail'=>$n['pay_fail'],
                    'cjsxf'=>$n['cjsxf'],
                    'income_profit'=>$n['income_profit'],
                    'pay_profit'=>$n['pay_profit'],
                    'frozen_money'=>$n['frozen_money'],
                    'merchant_money'=>$n['merchant_money'],
                    'platform_cost'=>$n['platform_cost'],
                    'platform_profit'=>$n['platform_profit'],
                    'end_profit'=>$n['end_profit'],
                    'current_money'=>$n['current_money'],
                );
            }
        }
        $title = array(
            '商户号',
            '用户名',
            '期初余额',
            '入金余额',
            '出金待审核金额',
            '出金成功金额',
            '出金失败金额',
            '入金利润',
            '出金利润',
            '冻结金额',
            '商户实际到账金额',
            '平台成本',
            '平台利润',
            '期末余额',
            '当前余额'
        );
        exportCsv($list, $title);
    }

    //导出商户报表
    public function exportMerchant(){
        $date = urldecode(I("request.date", ''));
        if(!$date) {//默认今日
            $date = date('Y-m-d');
        }
        if ($memberid = I('get.memberid', '')) {
            $where['id'] = $memberid - 10000;
        }
        if($date>date('Y-m-d')) {
            $this->error('日期错误');
        }
        $timestamp = strtotime($date);
        //开始时间戳
        $begin = mktime(0, 0, 0, date('m',$timestamp), date('d',$timestamp), date('Y',$timestamp));
        //结束时间戳
        $end = mktime(0, 0, 0, date('m',$timestamp), date('d',$timestamp) + 1, date('Y',$timestamp)) - 1;
        $beginDate = date('Y-m-d H:i:s', $begin);
        $endDate = date('Y-m-d H:i:s', $end);
        $Member     = M('Member');
        $where['groupid'] = 4;
        $data = $Member
            ->field(['id,username,balance'])
            ->where($where)
            ->select();
        if ($data) {
            foreach ($data as $k => $v) {
                $data[$k]['memberid'] = $v['id'] +10000;
                $data[$k]['username'] = $v['username'];
                //冲正金额
                $redoAddSum = M('redo_order')->where(['type'=>1,'user_id'=>$v['id'],'date'=>['between', [$beginDate, $endDate]]])->sum('money');
                $redoReduceSum = M('redo_order')->where(['type'=>2,'user_id'=>$v['id'],'date'=>['between', [$beginDate, $endDate]]])->sum('money');
                //入金通道费率
                $data[$k]['channel_rate'] = M('ProductUser')
                    ->join('LEFT JOIN __PRODUCT__ ON __PRODUCT__.id = __PRODUCT_USER__.pid')
                    ->where(['pay_product_user.userid'=>$v['id'],'pay_product_user.status'=>1,'pay_product.isdisplay'=>1])
                    ->field('pay_product.name,pay_product.id,pay_product.code,pay_product_user.status')
                    ->select();
                $tkconfig = M('Tikuanconfig')->where(['userid'=>$v['id']])->find();
                if(!$tkconfig || $tkconfig['tkzt']!=1 || $tkconfig['systemxz'] != 1){
                    $tkconfig = M('Tikuanconfig')->where(['issystem'=>1])->find();
                }
                foreach ($data[$k]['channel_rate'] as $key=>$item){
                    $_userrate =  M('Userrate')->where(['userid'=>$v['id'],'payapiid'=>$item['id']])->find();
                    $syschannel = M('Channel')->where(['id' => $item['channel']])->find();
                    if ($tkconfig['t1zt'] == 0) { //T+0费率
                        $feilv    = $_userrate['t0feilv'] ? $_userrate['t0feilv'] : $syschannel['t0defaultrate']; // 交易费率
                    } else { //T+1费率
                        $feilv    = $_userrate['feilv'] ? $_userrate['feilv'] : $syschannel['defaultrate']; // 交易费率
                    }
                    $data[$k]['channel_rate'][$key]['feilv'] = $feilv;
                }
                //期初余额
                $data[$k]['initial_money'] = $this->getDateBalance($v['id'],$beginDate);
                //入金金额
                $orderSum = M('Order')->where(['pay_memberid'=>10000+$v['id'],'pay_successdate' => ['between', [$begin, $end]], 'pay_status' => ['in', '1,2']])->sum('pay_amount');
                $profitSum = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>9])->sum('money');
                $data[$k]['income_money'] = $orderSum + $profitSum + $redoAddSum - $redoReduceSum;
                //出金待审核金额
                $payWaitCheckedSum1 = M('tklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','0,1']])->sum('tkmoney');
                $payWaitCheckedSum2 = M('wttklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','0,1']])->sum('tkmoney');
                $data[$k]['pay_wait_checked'] = $payWaitCheckedSum1 + $payWaitCheckedSum2;
                //出金成功金额
                $payCheckedSum1 = M('tklist')->where(['userid'=>$v['id'], 'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $payCheckedSum2 = M('wttklist')->where(['userid'=>$v['id'], 'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $data[$k]['pay_success'] = $payCheckedSum1 + $payCheckedSum2;
                //出金失败金额
                $payFailSum1 = M('tklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','3,4']])->sum('tkmoney');
                $payFailSum2 = M('wttklist')->where(['userid'=>$v['id'], 'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','3,4']])->sum('tkmoney');
                $data[$k]['pay_fail'] = $payFailSum1 + $payFailSum2;
                //出金手续费
                $tkConfig     = M('Tikuanconfig')->where(['userid' => $v['id'], 'tkzt' => 1])->find();
                if (!$tkConfig || $tkConfig['tkzt'] != 1) {
                    $tkConfig = M('Tikuanconfig')->where(['issystem' => 1])->find();
                }
                if($tkConfig['tktype'] == 1) {
                    $data[$k]['tksxf'] = $tkConfig['sxffixed'].'/笔';
                } else {
                    $data[$k]['tksxf'] = $tkConfig['sxfrate'].'%';
                }
                //冻结金额
                $frozen_money1 = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>1, 't'=>1])->sum('money');
                $frozen_money2 = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>7])->sum('money');
                $frozen_money3= M('complaints_deposit')->where(['user_id'=>$v['id'],'create_at'=>['between', [$begin, $end]]])->sum('freeze_money');
                $data[$k]['frozen_money'] = $frozen_money1 + $frozen_money2 + $frozen_money3;
                //商户实际到账金额
                $actualamount = M('Order')->where(['pay_memberid'=>10000+$v['id'],'pay_successdate' => ['between', [$begin, $end]], 'pay_status' => ['in', '1,2']])->sum('pay_actualamount');
                $orderSum = $actualamount + $profitSum + $redoAddSum - $redoReduceSum;
                $data[$k]['merchant_money'] = $orderSum;
                //期末余额
                $data[$k]['end_profit'] = $this->getDateBalance($v['id'],$endDate);
                //当前余额
                $data[$k]['current_money'] = $this->fans['balance'];
                foreach($data[$k] as $kk => $vv) {
                    if($kk !='memberid' && $kk != 'channel_rate' && $kk != 'username' && $kk != 'tksxf') {
                        $data[$k][$kk] = number_format($vv, 4, '.', ',');
                    }
                }
                if($v['parentid'] > 0) {
                    $data[$k]['parent'] = M('Member')->where(['id'=>$v['parentid']])->getField('username');
                } else {
                    $data[$k]['parent'] = '';
                }
            }
        }

        $title = array(
            '商户号',
            '用户名',
            '期初余额',
            '通道费率',
            '入金金额',
            '出金手续费',
            '出金待审核金额',
            '出金成功金额',
            '出金失败金额',
            '冻结金额',
            '商户实际到账金额',
            '期末余额',
            '当前余额',
            '上级代理',
        );
        exportCsv($data, $title);
    }

    //导出代理报表
    public function exportAgent(){
        $date = urldecode(I("request.date", ''));
        if(!$date) {//默认今日
            $date = date('Y-m-d');
        }
        if ($memberid = I('get.memberid', '')) {
            $where['id'] = $memberid - 10000;
        }
        if($date>date('Y-m-d')) {
            $this->error('日期错误');
        }
        $timestamp = strtotime($date);
        //开始时间戳
        $begin = mktime(0, 0, 0, date('m',$timestamp), date('d',$timestamp), date('Y',$timestamp));
        //结束时间戳
        $end = mktime(0, 0, 0, date('m',$timestamp), date('d',$timestamp) + 1, date('Y',$timestamp)) - 1;
        $beginDate = date('Y-m-d H:i:s', $begin);
        $endDate = date('Y-m-d H:i:s', $end);
        $Member     = M('Member');
        $where['groupid'] = ['gt', 4];
        $data = $Member
            ->field(['id,username,balance'])
            ->where($where)
            ->select();
        if ($data) {
            foreach ($data as $k => $v) {
                $data[$k]['memberid'] = $v['id'] +10000;
                $data[$k]['username'] = $v['username'];
                //冲正金额
                $redoAddSum = M('redo_order')->where(['type'=>1,'user_id'=>$v['id'],'date'=>['between', [$beginDate, $endDate]]])->sum('money');
                $redoReduceSum = M('redo_order')->where(['type'=>2,'user_id'=>$v['id'],'date'=>['between', [$beginDate, $endDate]]])->sum('money');
                //入金通道费率
                $data[$k]['channel_rate'] = M('ProductUser')
                    ->join('LEFT JOIN __PRODUCT__ ON __PRODUCT__.id = __PRODUCT_USER__.pid')
                    ->where(['pay_product_user.userid'=>$v['id'],'pay_product_user.status'=>1,'pay_product.isdisplay'=>1])
                    ->field('pay_product.name,pay_product.id,pay_product.code,pay_product_user.status')
                    ->select();
                $tkconfig = M('Tikuanconfig')->where(['userid'=>$v['id']])->find();
                if(!$tkconfig || $tkconfig['tkzt']!=1 || $tkconfig['systemxz'] != 1){
                    $tkconfig = M('Tikuanconfig')->where(['issystem'=>1])->find();
                }
                foreach ($data[$k]['channel_rate'] as $key=>$item){
                    $_userrate =  M('Userrate')->where(['userid'=>$v['id'],'payapiid'=>$item['id']])->find();
                    $syschannel = M('Channel')->where(['id' => $item['channel']])->find();
                    if ($tkconfig['t1zt'] == 0) { //T+0费率
                        $feilv    = $_userrate['t0feilv'] ? $_userrate['t0feilv'] : $syschannel['t0defaultrate']; // 交易费率
                    } else { //T+1费率
                        $feilv    = $_userrate['feilv'] ? $_userrate['feilv'] : $syschannel['defaultrate']; // 交易费率
                    }
                    $data[$k]['channel_rate'][$key]['feilv'] = $feilv;
                }
                //期初余额
                $data[$k]['initial_money'] = $this->getDateBalance($v['id'],$beginDate);
                //入金金额
                $orderSum = M('Order')->where(['pay_memberid'=>10000+$v['id'],'pay_successdate' => ['between', [$begin, $end]], 'pay_status' => ['in', '1,2']])->sum('pay_amount');
                $profitSum = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>9])->sum('money');
                $data[$k]['income_money'] = $orderSum + $profitSum + $redoAddSum - $redoReduceSum;
                //出金待审核金额
                $payWaitCheckedSum1 = M('tklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','0,1']])->sum('tkmoney');
                $payWaitCheckedSum2 = M('wttklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','0,1']])->sum('tkmoney');
                $data[$k]['pay_wait_checked'] = $payWaitCheckedSum1 + $payWaitCheckedSum2;
                //出金成功金额
                $payCheckedSum1 = M('tklist')->where(['userid'=>$v['id'], 'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $payCheckedSum2 = M('wttklist')->where(['userid'=>$v['id'], 'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>2])->sum('tkmoney');
                $data[$k]['pay_success'] = $payCheckedSum1 + $payCheckedSum2;
                //出金失败金额
                $payFailSum1 = M('tklist')->where(['userid'=>$v['id'],'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','3,4']])->sum('tkmoney');
                $payFailSum2 = M('wttklist')->where(['userid'=>$v['id'], 'sqdatetime'=>['between', [$beginDate, $endDate]],'status'=>['in','3,4']])->sum('tkmoney');
                $data[$k]['pay_fail'] = $payFailSum1 + $payFailSum2;
                //出金手续费
                $tkConfig     = M('Tikuanconfig')->where(['userid' => $v['id'], 'tkzt' => 1])->find();
                if (!$tkConfig || $tkConfig['tkzt'] != 1) {
                    $tkConfig = M('Tikuanconfig')->where(['issystem' => 1])->find();
                }
                if($tkConfig['tktype'] == 1) {
                    $data[$k]['tksxf'] = $tkConfig['sxffixed'].'/笔';
                } else {
                    $data[$k]['tksxf'] = $tkConfig['sxfrate'].'%';
                }
                //冻结金额
                $frozen_money1 = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>1, 't'=>1])->sum('money');
                $frozen_money2 = M('moneychange')->where(['userid'=>$v['id'],'datetime'=>['between', [$beginDate, $endDate]],'lx'=>7])->sum('money');
                $frozen_money3= M('complaints_deposit')->where(['user_id'=>$v['id'],'create_at'=>['between', [$begin, $end]]])->sum('freeze_money');
                $data[$k]['frozen_money'] = $frozen_money1 + $frozen_money2 + $frozen_money3;
                //商户实际到账金额
                $actualamount = M('Order')->where(['pay_memberid'=>10000+$v['id'],'pay_successdate' => ['between', [$begin, $end]], 'status' => ['in', '1,2']])->sum('pay_actualamount');
                $orderSum = $actualamount + $profitSum + $redoAddSum - $redoReduceSum;
                $data[$k]['merchant_money'] = $orderSum;
                //期末余额
                $data[$k]['end_profit'] = $this->getDateBalance($v['id'],$endDate);
                //当前余额
                $data[$k]['current_money'] = $this->fans['balance'];
                foreach($data[$k] as $kk => $vv) {
                    if($kk !='memberid' && $kk != 'channel_rate' && $kk != 'username' && $kk != 'tksxf') {
                        $data[$k][$kk] = number_format($vv, 4, '.', ',');
                    }
                }
                if($v['parentid'] > 0) {
                    $data[$k]['parent'] = M('Member')->where(['id'=>$v['parentid']])->getField('username');
                } else {
                    $data[$k]['parent'] = '';
                }
            }
        }

        foreach ($data as $m => $n){
            $channel_rate = '';
            if(empty($n['channel_rate'])){
                $channel_rate .= '-';
            }else{
                foreach ($n['channel_rate'] as $o => $p){
                    $feilv = $p['feilv']*1000;
                    $channel_rate .= $p['name'].':'.$feilv.'‰；';
                }
            }
            $list[] = array(
                'memberid'=>$n['memberid'],
                'username'=>$n['username'],
                'initial_money'=>$n['initial_money'],
                'channel_rate'=>$channel_rate,
                'income_money'=>$n['income_money'],
                'tksxf'=>$n['tksxf'],
                'pay_wait_checked'=>$n['pay_wait_checked'],
                'pay_success'=>$n['pay_success'],
                'pay_fail'=>$n['pay_fail'],
                'frozen_money'=>$n['frozen_money'],
                'merchant_money'=>$n['merchant_money'],
                'end_profit'=>$n['end_profit'],
                'current_money'=>$n['current_money'],
                'partent'=>$n['partent'],
            );
        }

        $title = array(
            '代理号',
            '用户名',
            '期初余额',
            '通道费率',
            '代理利润',
            '出金手续费',
            '出金待审核金额',
            '出金成功金额',
            '出金失败金额',
            '冻结金额',
            '商户实际到账金额',
            '期末余额',
            '当前余额',
            '上级代理',
        );
        exportCsv($list, $title);
    }

    //获取平台利润
    public function getPlatformProfit() {
        //冲正金额
        $redoAddSum = M('redo_order')->where(['type'=>1])->sum('money');
        $redoReduceSum = M('redo_order')->where(['type'=>2])->sum('money');
        //入金金额
        $orderSum = M('Order')->where(['pay_status' => ['in', '1,2']])->sum('pay_amount');
        $data['income_money'] = $orderSum + $redoAddSum - $redoReduceSum;

        //入金利润
        $actualamount = M('Order')->where(['pay_status' => ['in', '1,2']])->sum('pay_actualamount');
        $data['income_profit'] = $data['income_money'] - $actualamount - $redoAddSum + $redoReduceSum;
        //出金利润
        $tkmoney1 = M('tklist')->where(['status'=>2])->sum('tkmoney');
        $tkmoney2 = M('wttklist')->where(['status'=>2])->sum('tkmoney');
        $money1 = M('tklist')->where(['status'=>2])->sum('money');
        $money2 = M('wttklist')->where(['status'=>2])->sum('money');
        $data['pay_profit'] = $tkmoney1 + $tkmoney2 - $money1 - $money2;
        //平台成本
        $cost1 = M('Order')->where(['pay_status' => ['in', '1,2']])->sum('cost');
        $cost2 = M('wttklist')->where([ 'status' => 2])->sum('cost');
        $cost3 = M('moneychange')->where(['lx'=>9])->sum('money');
        $data['platform_cost'] = $cost1 + $cost2 + $cost3;
        //平台利润
        $platform_profit = $data['income_profit'] +  $data['pay_profit'] - $data['platform_cost'];
        return number_format($platform_profit, 4, '.', ',');
    }

    public function analysis() {

        $date = urldecode(I("request.date", '' , 'string,strip_tags,htmlspecialchars'));
        if(!$date) {//默认今日
            $date = date('Y-m-d');
        }
        $this->assign('date', $date);
        $startTime = strtotime($date);
        $endTime = $startTime+60*60*24-1;
        //订单金额
        $total_success_amount = M('order')->where(['pay_status'=>['in', '1,2'], 'pay_applydate' => ['between', [$startTime, $endTime]]])->sum('pay_amount');

        //订单笔数
        $total_success_count = M('order')->where(['pay_status'=>['in', '1,2'], 'pay_applydate' => ['between', [$startTime, $endTime]]])->count();

        //订单均价
        if($total_success_count>0) {
            $average = round($total_success_amount/$total_success_count,4);
        } else {
            $average = 0;
        }
        //成功率
        $total_fail_count = M('order')->where(['pay_applydate' => ['between', [$startTime, $endTime]]])->count();
        if($total_fail_count>0) {
            $success_rate = round($total_success_count/$total_fail_count,4)*100;
        } else {
            $success_rate = 0;
        }

        $where['pay_status'] = ['gt',0];
        //商户订单金额TOP10
        $amountRankTmp = M('Order')
            ->join('LEFT JOIN __MEMBER__ ON (__MEMBER__.id + 10000) = __ORDER__.pay_memberid')
            ->field('pay_member.id as userid,pay_member.username,sum(pay_amount) as total_charge')
            ->where(['pay_status'=>['in', '1,2'],'pay_applydate' => ['between', [$startTime, $endTime]]])
            ->limit(0,10)
            ->group('pay_memberid')
            ->order('total_charge desc')
            ->select();
        $i = 0;
        $userids = $amountRank = [];
        foreach($amountRankTmp as $k => $v) {
            if (!$v['userid']) {
                continue;
            }
            $i++;
            $amountRank[$v['userid']]['userid'] = $v['userid'];
            $amountRank[$v['userid']]['username'] = $v['username'];
            $amountRank[$v['userid']]['rank'] = $i;
            $amountRank[$v['userid']]['total_charge'] = $v['total_charge'];
            array_push($userids, $v['userid']);
        }
        //如果不够10个商户则补充
        $tmpwhere['status'] = 1;
        if(!empty($userids)) {
            $tmpwhere['id'] =  ['not in', $userids];
            $limit = 10-count($userids);
        } else {
            $limit = 10;
        }
        $tmplist = M('Member')->where($tmpwhere)->field('id as userid,username')->order('id ASC')->limit(0, $limit)->select();
        foreach($tmplist as $k => $v) {
            $i++;
            $amountRank[$v['userid']]['userid'] = $v['userid'];
            $amountRank[$v['userid']]['username'] = $v['username'];
            $amountRank[$v['userid']]['rank'] = $i;
            $amountRank[$v['userid']]['total_charge'] = 0;
        }
        //商户订单笔数TOP10
        $totalNumtRankTmp = M('Order')
            ->join('LEFT JOIN __MEMBER__ ON (__MEMBER__.id + 10000) = __ORDER__.pay_memberid')
            ->field('pay_member.id as userid,pay_member.username,count(pay_order.id) as total_num')
            ->where(['pay_status'=>['in', '1,2'],'pay_applydate' => ['between', [$startTime, $endTime]]])
            ->limit(0,10)
            ->group('pay_memberid')
            ->order('total_num desc')
            ->select();
        $i = 0;
        $userids = $totalNumtRank = [];
        foreach($totalNumtRankTmp as $k => $v) {
            if(!$v['userid']) {
                continue;
            }
            $i++;
            $totalNumtRank[$v['userid']]['userid'] = $v['userid'];
            $totalNumtRank[$v['userid']]['username'] = $v['username'];
            $totalNumtRank[$v['userid']]['rank'] = $i;
            $totalNumtRank[$v['userid']]['total_num'] = $v['total_num'];
            array_push($userids, $v['userid']);
        }
        unset($tmpwhere);
        //如果不够10个商户则补充
        $tmpwhere['status'] = 1;
        if(!empty($userids)) {
            $tmpwhere['id'] =  ['not in', $userids];
            $limit = 10-count($userids);
        } else {
            $limit = 10;
        }
        $tmplist = M('Member')->where($tmpwhere)->field('id as userid,username')->order('id ASC')->limit(0, $limit)->select();
        foreach($tmplist as $k => $v) {
            $i++;
            $totalNumtRank[$v['userid']] = $v;
            $totalNumtRank[$v['userid']]['rank'] = $i;
            $totalNumtRank[$v['userid']]['total_num'] = 0;
        }
        //商户成功率TOP10
        $userSuccessRate = [];
        $userList = M('Member')->field('id as userid,username')->select();
        if(!empty($userList)) {
            foreach($userList as $k => $v) {
                $success_count = M('order')->where(['pay_memberid' => $v['userid']+10000,'pay_status'=>['in', '1,2'],'pay_applydate' => ['between', [$startTime, $endTime]]])->count();
                $total_count = M('order')->where(['pay_memberid' => $v['userid']+10000,'pay_applydate' => ['between', [$startTime, $endTime]]])->count();
                if($total_count>0) {
                    $userSuccessRate[$k] = round($success_count/$total_count,4)*100;
                    $userList[$k]['success_rate'] = $userSuccessRate[$k];
                } else {
                    $userList[$k]['success_rate'] = 0;
                }
            }
            array_multisort($userSuccessRate,SORT_DESC,$userList);
            $userList = array_slice($userList,0,10);
            $i = 0;
            foreach($userList as $k => $v) {
                $i++;
                $userList[$k]['rank'] = $i;
            }
        }

        //30天订单曲线图
        $dateRange = urldecode(I("request.dateRange", '', 'trim,string,strip_tags,htmlspecialchars'));
        if ($dateRange) {
            list($firstday, $lastday)  = explode('|', $dateRange);
            $time_diff = strtotime($lastday) - strtotime($firstday);
            if($time_diff <=0) {
                $this->error('日期范围错误');
            }
            if($time_diff/86400>30) {
                $this->error('日期相隔天数不得大于30天');
            }
        }
        if(!isset($firstday) || !$firstday) {
            $firstday = date('Y-m-d', strtotime("-30 day"));
            $lastday = date('Y-m-d');
            $dateRange = $firstday.' | '.$lastday;
        }
        $this->assign('dateRange', $dateRange);
        $sql = "SELECT SUM( pay_actualamount ) AS total, FROM_UNIXTIME( pay_applydate,  '%Y-%m-%d' ) AS DATETIME
        FROM pay_order WHERE pay_applydate >= UNIX_TIMESTAMP(  '".$firstday."' ) AND pay_applydate <= UNIX_TIMESTAMP(  '".
            $lastday."' ) AND pay_status>=1  GROUP BY DATETIME";
        $ordertotal = M('Order')->query($sql);
        $chartData = $category ='';
        foreach($ordertotal as $k => $v) {
            $category .= date('Ymd',strtotime($v['datetime'])). ',';
            $chartData .= $v['total'].',';
        }
        $category = '['.trim($category,',').']';
        $chartData = '['.trim($chartData,',').']';
        $this->assign('total_success_amount', $total_success_amount>0?$total_success_amount:0);
        $this->assign('total_success_count', $total_success_count>0?$total_success_count:0);
        $this->assign('average', $average>0?$average:0);
        $this->assign('success_rate', $success_rate>0?$success_rate:0);
        $this->assign("amountRank", $amountRank);
        $this->assign("totalNumtRank", $totalNumtRank);
        $this->assign("userList", $userList);
        $this->assign("category", $category);
        $this->assign("chartData", $chartData);
        $this->display();

    }
  
	//并发量报表
    public function  conCurrency(){
        /***********************客户并发量  start***************************/

        $dateRange = urldecode(I("request.dateRange", '', 'trim,string,strip_tags,htmlspecialchars'));
        $firstday = date("Y-m-d H:i:s", strtotime("-1 hour"));// 前置一个小时
        if(!$dateRange) {
            $dateRange = date('Y-m-d H:i:s');//时间范围的最后一天
        }
        $this->assign('dateRange', $dateRange);

        //查询语句
        $cus_sql = "select count(id) AS total, pay_applydate div 300 as DATETIME
                    FROM pay_order 
                    where pay_applydate >= UNIX_TIMESTAMP( '".$dateRange."' )
                    AND pay_applydate <=UNIX_TIMESTAMP(  '".$firstday."' ) 
                    GROUP BY DATETIME";
        $cus_arr = M('Order')->query($cus_sql);

        $chartData =  "";
        $category = [];
        foreach($cus_arr as $k => $v) {
            $chartData .= $v["total"].',';//纵坐标为并发量
            $category[] = "'".date("m-d H:i:s",$v["datetime"]*300)."'";//横坐标

        }

        $category = implode(",",$category);
        $category = '['.$category.']';
        $chartData = '['.trim($chartData,',').']';
        $this->assign("category", $category);
        $this->assign("chartData", $chartData);
        /***********************客户并发量  end***************************/

        /***********************入金渠道并发量  start***************************/
        $channelList = M("Channel")->field('id,title')->select();
        $this->assign("channelList", $channelList);

        $dateRange1 = urldecode(I("request.dateRange1", '', 'trim,string,strip_tags,htmlspecialchars'));
        $firstday1 = date("Y-m-d H:i:s", strtotime("-1 hour"));// 前置一个小时
        if(!$dateRange1) {
            $dateRange1 = date('Y-m-d H:i:s');//时间范围的最后一天
        }
        $this->assign('dateRange1', $dateRange1);

        $channel1 = I("request.channel1", '', 'trim,string,strip_tags,htmlspecialchars');
        $this->assign('channel1', $channel1);

        //查询语句
        $cus_sql1 = "SELECT COUNT(o.id) AS total,pay_applydate div 300 as DATETIME
                     FROM pay_order o
                     WHERE o.pay_zh_tongdao = '$channel1'
                     AND pay_applydate >= UNIX_TIMESTAMP( '".$dateRange1."' )
                     AND pay_applydate <=UNIX_TIMESTAMP(  '".$firstday1."' ) 
                     GROUP BY DATETIME";
        //对应的表进行查询
        $cus_arr1 = M('Order')->query($cus_sql1);

        $chartData1 = '';
        $category1 = [];
        foreach($cus_arr1 as $k => $v) {
            $category1[] = "'".date("m-d H:i:s",$v["datetime"]*300)."'";//横坐标

            $chartData1 .= $v['total'].',';//纵坐标
        }

        $category1 = implode(",",$category1);
        $category1 = '['.$category1.']';
        $chartData1 = '['.trim($chartData1,',').']';
        $this->assign("category1", $category1);
        $this->assign("chartData1", $chartData1);
        /***********************入金渠道并发量  end***************************/



        /***********************渠道子账户并发量  start***************************/
        //通道列表
        $channellist = M("Channel")->field('id,code,title')->select();
        $this->assign("channellist", $channellist);
        //时间范围
        $dateRange2 = urldecode(I("request.dateRange2", '', 'trim,string,strip_tags,htmlspecialchars'));
        $firstday2 = date("Y-m-d H:i:s", strtotime("-1 hour"));// 前置一个小时
        if(!$dateRange2) {
            $dateRange2 = date('Y-m-d H:i:s');//时间范围的最后一天
        }
        $this->assign('dateRange2', $dateRange2);
        //查找通道
        $channel = I("request.channel", '', 'trim,string,strip_tags,htmlspecialchars');
        if($channel) {
            $accountlist = M('channel_account')->where(['channel_id' =>$channel])->select();
            $this->assign('accountlist',$accountlist);
        }
        $this->assign('channel', $channel);
        //查找子账户
        $account = I("request.account", '', 'trim,string,strip_tags,htmlspecialchars');
        $this->assign('account', $account);

        //查询语句
        $cus_sql2 = "SELECT COUNT(o.id) AS total,pay_applydate div 300 as DATETIME
                     FROM pay_order o
                     WHERE o.channel_id = '$channel' 
                     and o.account_id = '$account'
                     AND   pay_applydate >= UNIX_TIMESTAMP( '".$dateRange2."' )
                     AND   pay_applydate <=UNIX_TIMESTAMP(  '".$firstday2."' ) 
                     GROUP BY DATETIME";
//        //对应的表进行查询
        $cus_arr2 = M('Order')->query($cus_sql2);
        $chartData2 = '';
        $category2 = [];
        foreach($cus_arr2 as $k => $v) {
//            $category2[] = "'".date('Y-m-d H:i:s',strtotime($v["datetime"]))."'";//横坐标
            $category2[] = "'".date("m-d H:i:s",$v["datetime"]*300)."'";//横坐标
            $chartData2 .= $v['total'].',';//纵坐标
        }

        $category2 = implode(",",$category2);
        $category2 = '['.$category2.']';
        $chartData2 = '['.trim($chartData2,',').']';
        $this->assign("category2", $category2);
        $this->assign("chartData2", $chartData2);
        /***********************渠道子账户并发量  end***************************/
        $this->display();

    }

    //成功率报表
    public function successRate(){
        /*************所有客户成功率 start **************/
        $dateRange = urldecode(I("request.dateRange", '', 'trim,string,strip_tags,htmlspecialchars'));
        //如果存在的话
        if ($dateRange) {
            //分割时间范围 成两个时间 分别是开始一天和最后一天
            list($firstday, $lastday)  = explode('|', $dateRange);
            //计算开始和结束这两个时间的差 也就是等于小时数
            $time_diff = strtotime($lastday) - strtotime($firstday);
            //如果小时数小于0 表示所选时间范围是错的
            if($time_diff <=0) {
                $this->error('日期范围错误');
            }
            //小时数转化为天数 大于30天 报错!
            if($time_diff/86400>30) {
                $this->error('日期相隔天数不得大于30天');
            }
        }
        if(!isset($firstday) || !$firstday) {
            $firstday = date('Y-m-d', strtotime("-30 day"));// 前置30天 也就是时间范围的最开始一天
            $lastday = date('Y-m-d');//时间范围的最后一天
            $dateRange = $firstday.' | '.$lastday;//拼接两个时间
        }
        $this->assign('dateRange', $dateRange);

        //查询所有订单的成功率语句
        $cus_sql = "SELECT DATETIME,TRUNCATE(sum(suc)/sum(total),2) as suc_rate from(
                    SELECT COUNT(id) AS total,FROM_UNIXTIME( pay_applydate,  '%Y-%m-%d' ) AS DATETIME,0 as suc
                    FROM pay_order 
                    WHERE pay_applydate >= UNIX_TIMESTAMP(  '".$firstday."' ) 
                    AND pay_applydate <= UNIX_TIMESTAMP( '". $lastday."'  ) 
                    GROUP BY DATETIME
        union all 
                    SELECT 0 as total,FROM_UNIXTIME( pay_applydate,  '%Y-%m-%d' ) AS DATETIME,COUNT(id) AS suc
                    FROM pay_order 
                    WHERE pay_applydate >= UNIX_TIMESTAMP( '".$firstday."' ) 
                    AND pay_applydate <= UNIX_TIMESTAMP(  '". $lastday."' ) and pay_status!=0
                    GROUP BY DATETIME
        ) as new_table GROUP BY DATETIME";

        //对应的表进行查询
        $cus_arr = M('Order')->query($cus_sql);
        $chartData =  "";
        $category = [];
        foreach($cus_arr as $k => $v) {
            $chartData .= $v["suc_rate"].',';//纵坐标为成功率
            $category[] = "'".date('Y-m-d',strtotime($v["datetime"]))."'";//横坐标
        }

        $category = implode(",",$category);
        $category = '['.$category.']';
        $chartData = '['.trim($chartData,',').']';
        $this->assign("category", $category);
        $this->assign("chartData", $chartData);
        /************* 所有客户成功率 end **************/


        /*****************入金渠道成功率  start****************/
        $dateRange1 = urldecode(I("request.dateRange1", '', 'trim,string,strip_tags,htmlspecialchars'));
        //如果存在的话
        if ($dateRange1) {
            //分割时间范围 成两个时间 分别是开始一天和最后一天
            list($firstday1, $lastday1)  = explode('|', $dateRange1);
            //计算开始和结束这两个时间的差 也就是等于小时数
            $time_diff = strtotime($lastday1) - strtotime($firstday1);
            //如果小时数小于0 表示所选时间范围是错的
            if($time_diff <=0) {
                $this->error('日期范围错误');
            }
            //小时数转化为天数 大于30天 报错!
            if($time_diff/86400>30) {
                $this->error('日期相隔天数不得大于30天');
            }
        }
        if(!isset($firstday1) || !$firstday1) {
            $firstday1 = date('Y-m-d', strtotime("-30 day"));// 前置30天 也就是时间范围的最开始一天
            $lastday1 = date('Y-m-d');//时间范围的最后一天
            $dateRange1 = $firstday1.' | '.$lastday1;//拼接两个时间
        }
        $this->assign('dateRange1', $dateRange1);
        //查询所有订单的成功率语句

        $cus_sql1 = "SELECT channel_name,TRUNCATE(sum(suc)/sum(total),2) as suc_rate from(

            SELECT COUNT(o.id) AS total,0 as suc,o.`pay_zh_tongdao` AS channel_name
                    FROM  pay_order o
                    WHERE o.pay_applydate >= UNIX_TIMESTAMP(  '".$firstday1."' )
        AND   o.pay_applydate <= UNIX_TIMESTAMP( '". $lastday1."'  )
                    GROUP BY channel_name
                    
                    union all
                    
                    SELECT 0 as total,COUNT(o.id) AS suc,o.`pay_zh_tongdao` AS channel_name
                    FROM  pay_order o
                    WHERE o.pay_applydate >= UNIX_TIMESTAMP( '".$firstday1."' )
        AND   o.pay_applydate <= UNIX_TIMESTAMP(  '". $lastday1."' ) and o.pay_status!=0
                    GROUP BY channel_name
) as new_table GROUP BY channel_name";
        //对应的表进行查询
        $cus_arr1 = M('Order')->query($cus_sql1);
        $chartData1 =  "";
        $category1 = [];
        foreach($cus_arr1 as $k => $v) {
            $chartData1 .= $v["suc_rate"].',';//纵坐标为成功率
            $category1[] = "'".$v["channel_name"]."'";//横坐标

        }

        $category1 = implode(",",$category1);
        $category1 = '['.$category1.']';
        $chartData1 = '['.trim($chartData1,',').']';
        $this->assign("category1", $category1);
        $this->assign("chartData1", $chartData1);

        /*****************入金渠道成功率  end****************/


        /***************入金渠道子账户成功率 start****************/
        $dateRange2 = urldecode(I("request.dateRange2", '', 'trim,string,strip_tags,htmlspecialchars'));
        //如果存在的话
        if ($dateRange2) {
            //分割时间范围 成两个时间 分别是开始一天和最后一天
            list($firstday2, $lastday2)  = explode('|', $dateRange2);
            //计算开始和结束这两个时间的差 也就是等于小时数
            $time_diff = strtotime($lastday2) - strtotime($firstday2);
            //如果小时数小于0 表示所选时间范围是错的
            if($time_diff <=0) {
                $this->error('日期范围错误');
            }
            //小时数转化为天数 大于30天 报错!
            if($time_diff/86400>30) {
                $this->error('日期相隔天数不得大于30天');
            }
        }
        if(!isset($firstday2) || !$firstday2) {
            $firstday2 = date('Y-m-d', strtotime("-6 day"));// 前置30天 也就是时间范围的最开始一天
            $lastday2 = date('Y-m-d');//时间范围的最后一天
            $dateRange2 = $firstday2.' | '.$lastday2;//拼接两个时间
        }
        $this->assign('dateRange2', $dateRange2);

        //查询所有订单的成功率语句

        $cus_sql2 = "SELECT account_name,TRUNCATE(sum(suc)/sum(total),2) as suc_rate from(
            SELECT COUNT(o.id) AS total,0 as suc,o.`pay_channel_account` AS account_name
                    FROM  pay_order o
                    
                    
                    WHERE o.pay_applydate >= UNIX_TIMESTAMP( '".$firstday2."' )
        AND   o.pay_applydate <= UNIX_TIMESTAMP(  '". $lastday2."' ) 
                    GROUP BY account_name
                    union all
                    SELECT 0 as total,COUNT(o.id) AS suc,o.`pay_channel_account` AS account_name
                    FROM  pay_order o
                    
                    WHERE o.pay_applydate >= UNIX_TIMESTAMP( '".$firstday2."' )
        AND   o.pay_applydate <= UNIX_TIMESTAMP(  '". $lastday2."' )
        and o.pay_status!=0
                    GROUP BY account_name
        ) as new_table GROUP BY account_name";

        //对应的表进行查询
        $cus_arr2 = M('Order')->query($cus_sql2);
        $chartData2 =  "";
        $category2 = [];
        foreach($cus_arr2 as $k => $v) {
            $chartData2 .= $v["suc_rate"].',';//纵坐标为成功率
            $category2[] = "'".$v["account_name"]."'";//横坐标

        }

        $category2 = implode(",",$category2);
        $category2 = '['.$category2.']';
        $chartData2 = '['.trim($chartData2,',').']';

        $this->assign("category2", $category2);
        $this->assign("chartData2", $chartData2);
        /***************入金渠道子账户成功率 end****************/


        $this->display();

    }

    /*
     * 获取渠道子账号
     */
    public function getAccount(){
        $info = [
            'status' => 0,
            'msg' => 'fail',
            'data' => null,
        ];
        if(IS_AJAX){
            $channel_id= I('get.channel_id', 0, 'intval');
            if($channel_id) {
                try{
                    $data = M('channel_account')->where(["channel_id"=>$channel_id])->select();
                    $info = [
                        'status' => 1,
                        'msg' => 'ok',
                        'data' => $data,
                    ];
                } catch(\Exception $e) {

                }
            }
        }
        $this->ajaxReturn($info);
    }

    function exportProductChannelFinance(){
        $where = [];
        $createtime = urldecode(I("request.createtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime,$cetime) = explode('|',$createtime);
            $where['pay_applydate'] = ['between',[strtotime($cstime),strtotime($cetime)?strtotime($cetime):time()]];
        }
        $this->assign('createtime', $createtime);
        $id = I('id', 0, 'intval');
        if(!$id) {
            $this->error('缺少参数');
        }
        $product = M('Product')->where(['id' => $id])->find();
        if(empty($product)) {
            $this->error('支付产品不存在');
        }
        $list = M('channel')->where(['paytype' => $product['paytype']])->select();
        foreach($list as $k => $v) {
            $where['channel_id'] = $v['id'];
            $where['pay_status'] = ['in', '1,2'];
            $sum = M('Order')->field(['sum(`pay_amount`) pay_amount','sum(`cost`) cost', 'sum(`pay_poundage`) pay_poundage', 'sum(`pay_actualamount`) pay_actualamount', 'count(`id`) success_count'])
                ->where($where)->find();
            $list[$k]['pay_amount'] = $sum['pay_amount'];//交易笔数
            $list[$k]['pay_amount'] += 0;
            $list[$k]['pay_poundage'] = $sum['pay_poundage'];//手续费
            $list[$k]['pay_poundage'] += 0;
            $list[$k]['pay_actualamount'] = $sum['pay_actualamount'];//入金总额
            $list[$k]['pay_actualamount'] += 0;
            unset($where['pay_status']);
            $list[$k]['count'] = M('Order')->where($where)->count();//交易笔数
            $list[$k]['count'] += 0;
            $list[$k]['success_count'] = $sum['success_count'];//成功笔数
            $list[$k]['success_count'] += 0;
            $list[$k]['fail_count'] = $list[$k]['count'] - $list[$k]['success_count'];//失败笔数

            $list[$k]['success_rate'] = $list[$k]['count']>0?bcdiv($list[$k]['success_count'],$list[$k]['count'], 4) * 100 : 0;//成功率
        }
        //根据字段last_name对数组$data进行降序排列
        $pay_amount = array_column($list,'pay_amount');
        array_multisort($pay_amount,SORT_DESC,$list);
        //dump($list);

        $title = array(
            "通道编码",
            "交易金额",
            "手续费",
            "入金总额",
            "交易笔数",
            "成功笔数",
            "成功率",
            "失败笔数",
        );
        $arr = [];
        foreach ($list as $k => $v) {
            $arr[] = [
                'title' => $v['title'].'_'.$v['code'],
                'pay_amount' => $v['pay_amount'],
                'pay_poundage' => $v['pay_poundage'],
                'pay_actualamount' => $v['pay_actualamount'],
                'count' => $v['count'],
                'success_rate' => $v['success_rate'],
                'success_count' => $v['success_count'],
                'fail_count' => $v['fail_count'],
            ];
        }
        exportexcel($arr, $title);
        // 将已经写到csv中的数据存储变量销毁，释放内存占用
        unset($arr);
        //刷新缓冲区
        ob_flush();
        flush();
    }

    function exportChannelAccountFinance(){
        $where = [];
        $createtime = urldecode(I("request.createtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime,$cetime) = explode('|',$createtime);
            $where['pay_applydate'] = ['between',[strtotime($cstime),strtotime($cetime)?strtotime($cetime):time()]];
        }
        $this->assign('createtime', $createtime);
        $id = I('id', 0, 'intval');
        if(!$id) {
            $this->error('缺少参数');
        }
        $channel = M('Channel')->where(['id' => $id])->find();
        if(empty($channel)) {
            $this->error('支付通道不存在');
        }
        $list = M('channelAccount')->where(['channel_id' => $id])->select();

        foreach($list as $k => $v) {
            $where['account_id'] = $v['id'];
            $where['channel_id'] = $id;
            $where['pay_status'] = ['in', '1,2'];
            $sum = M('Order')->field(['sum(`pay_amount`) pay_amount','sum(`cost`) cost', 'sum(`pay_poundage`) pay_poundage', 'sum(`pay_actualamount`) pay_actualamount', 'count(`id`) success_count'])
                ->where($where)->find();

            $list[$k]['pay_amount'] = $sum['pay_amount'];//交易笔数
            $list[$k]['pay_amount'] += 0;
            $list[$k]['pay_poundage'] = $sum['pay_poundage'];//手续费
            $list[$k]['pay_poundage'] += 0;
            $list[$k]['pay_actualamount'] = $sum['pay_actualamount'];//入金总额
            $list[$k]['pay_actualamount'] += 0;
            unset($where['pay_status']);
            $list[$k]['count'] = M('Order')->where($where)->count();//交易笔数
            $list[$k]['count'] += 0;
            $list[$k]['success_count'] = $sum['success_count'];//成功笔数
            $list[$k]['success_count'] += 0;
            $list[$k]['fail_count'] = $list[$k]['count'] - $list[$k]['success_count'];//失败笔数
            $list[$k]['success_rate'] = $list[$k]['count']>0?bcdiv($list[$k]['success_count'],$list[$k]['count'], 4) * 100 : 0;//成功率
        }

        //根据字段last_name对数组$data进行降序排列
        $pay_amount = array_column($list,'pay_amount');
        array_multisort($pay_amount,SORT_DESC,$list);
        //dump($list);

        $title = array(
            "子账号",
            "交易金额",
            "手续费",
            "入金总额",
            "交易笔数",
            "成功笔数",
            "成功率",
            "失败笔数",
        );
        $arr = [];
        foreach ($list as $k => $v) {
            $arr[] = [
                'title' => $v['title'].'_'.$v['code'],
                'pay_amount' => $v['pay_amount'],
                'pay_poundage' => $v['pay_poundage'],
                'pay_actualamount' => $v['pay_actualamount'],
                'count' => $v['count'],
                'success_rate' => $v['success_rate'],
                'success_count' => $v['success_count'],
                'fail_count' => $v['fail_count'],
            ];
        }
        exportexcel($arr, $title);
        // 将已经写到csv中的数据存储变量销毁，释放内存占用
        unset($arr);
        //刷新缓冲区
        ob_flush();
        flush();
    }
}
