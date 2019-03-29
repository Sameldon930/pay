<?php
namespace Admin\Controller;

use Think\Page;

class AlipayController extends BaseController
{
    public function __construct()
    {
        parent::__construct();

    }

    public function cashSweep()
    {
        $where = [];
        //账号
        $username = I('param.username', "", "trim,string,strip_tags,htmlspecialchars");
        if ($username) $where["username"] = ["like", "%$username%"];
        //时间
        $addtime = urldecode(I("param.addtime", '', 'trim,string,strip_tags,htmlspecialchars'));
        if ($addtime) {
            list($cstime, $cetime) = explode('|', $addtime);
            $where['addtime'] = ['between', [strtotime($cstime), strtotime($cetime)]];
        }

        $count = M("cash_sweep")->where($where)->count();
        $rows = I('param.rows/d', 15);
        $page = new Page($count, $rows);
        $list = M("cash_sweep")->where($where)->limit($page->firstRow . ',' . $page->listRows)
            ->order('id desc')
            ->select();
        $this->assign(array(
            "list" => $list,
            "page" => $page,
        ));
        //取消令牌
        C('TOKEN_ON', false);
        $this->display();
    }

    function editAccount()
    {

        $id = I("param.id/d", 0);
        $data = [];
        $data["username"] = I("param.username");
        $data["realname"] = I("param.realname");
        $data["status"] = I("param.status");
        $data["toplimit"] = I("param.toplimit");
        if (IS_POST) {
            if ($id) {//编辑
                $data["updatetime"] = time();
                $res = M("cash_sweep")->where(["id" => $id])->save($data);
            } else {//添加
                $data["addtime"] = time();
                $res = M("cash_sweep")->add($data);
            }
            if ($res !== false) {
                $this->ajaxReturn(['status' => 1]);
            } else {
                $this->ajaxReturn(['status' => 0]);
            }
        } else {
            if ($id) {//编辑
                $info = M("cash_sweep")->where(["id" => $id])->find();
                $this->assign("info", $info);
                $this->display("editAccount");
            } else {//添加
                $this->display("addAccount");
            }

        }
    }

    function delAccount()
    {
        $id = I("param.id/d", 0);
        $res = M("cash_sweep")->where(["id" => $id])->delete();
        if ($res !== false) {
            $this->ajaxReturn(['status' => 1]);
        } else {
            $this->ajaxReturn(['status' => 0]);
        }
    }

    //用户状态切换
    public function editStatus()
    {
        if (IS_POST) {
            $id = I('post.id/d');
            $isstatus = I('post.isopen') ? I('post.isopen') : 0;
            $res = M("cash_sweep")->where(['id' => $id])->save(['status' => $isstatus]);
            $this->ajaxReturn(['status' => $res]);
        }
    }

    public function getSweepAccount()
    {
        $pid = I("param.pid");//渠道id
        $aid = I("param.aid");//渠道子账号id
        //获取所有的支付宝资金归集账号
        $list = M("cash_sweep")->field("id,username,realname")->select();
        //获取该子账号指定的支付宝资金归集账号
        $channel_account_cash_sweep = M("channel_account_cash_sweep")->where(['channel_id' => $pid, 'channel_account_id' => $aid])->find();
        $channel_account_cash_sweep_id_arr = explode(",", $channel_account_cash_sweep["cash_sweep_ids"]);
        array_walk($list, function (&$v, $k) use ($channel_account_cash_sweep_id_arr) {
            if (in_array($v["id"], $channel_account_cash_sweep_id_arr)) {
                $v['checked'] = 1;
            } else {
                $v['checked'] = 0;
            }
        });
        $this->assign(array(
                "list" => $list,
                "status" => $channel_account_cash_sweep["status"],
            )
        );
        $this->display();
    }

    //编辑归集账号
    public function saveSweepAccount()
    {
        $pid = I("param.pid");//渠道id
        $aid = I("param.aid");//渠道子账号id
        $account = implode(",", I("param.account/a"));
        $info = M("channel_account_cash_sweep")->where(['channel_id' => $pid, 'channel_account_id' => $aid])->order("id desc")->find();
        $data["cash_sweep_ids"] = $account;
        $data["status"] = I("param.status");
        if (!$info) {//添加
            $data["channel_id"] = $pid;
            $data["channel_account_id"] = $aid;
            $res = M("channel_account_cash_sweep")->add($data);
        } else {//更新
            $res = M("channel_account_cash_sweep")->where(['channel_id' => $pid, 'channel_account_id' => $aid])->save($data);
        }
        $this->ajaxReturn(['status' => $res]);
    }

    //下发
    public function dispense()
    {
        $id = I("param.id/d", 0);
        if (IS_POST) {
            $data["cash_sweep_id"] = $id;
            $data["target_username"] = I("param.target_username");
            $data["amount"] = I("param.amount");
            $data["addtime"] = time();
            //开启事物
            M()->startTrans();
            $res = M("alipay_dispense")->add($data);
            $res2 = M("cash_sweep")->where(['id' => $id])->setDec("account_balance", $data["amount"]);
            $res3 = M("cash_sweep")->where(['id' => $id])->setInc("withdraw_cash", $data["amount"]);
            if ($res && $res2 && $res3) {
                M()->commit();
            } else {
                M()->rollback();
            }
            $this->ajaxReturn(['status' => $res]);
        } else {
            $this->display();
        }
    }

    //归集流水
    public function sweepList()
    {
        //归集账号列表
        $usernameList = M("cash_sweep")->order("id desc")->select();
        $where = [];
        //账号
        $username = I('param.username', "", "trim,string,strip_tags,htmlspecialchars");
        if ($username) $where["csd.sweep_account"] = ["like", "%$username%"];
        //时间
        $addtime = urldecode(I("param.addtime", '', 'trim,string,strip_tags,htmlspecialchars'));
        if ($addtime) {
            list($cstime, $cetime) = explode('|', $addtime);
            $where['addtime'] = ['between', [strtotime($cstime), strtotime($cetime)]];
        }

        //归集状态
        $status = I("param.status", "");
        if ($status ||$status==="0") $where["csd.status"] = $status;

        //入金渠道
        $channel = I("param.channel", 0);//渠道id
        if ($channel) $where["csd.channel_id"] = $channel;

        //入金渠道子账号
        $account = I("param.account", 0);//渠道id
        $accountlist = M('channel_account')->where(["channel_id" => $channel])->select();
        if ($account) $where["csd.channel_account_id"] = $account;

        //所有入金渠道
        $channelList = M("Channel")->field('id,code,title')->select();
        //join查询列表
        $field = array("c.title", "ca.title as account_name", "csd.*");
        $rows = I('param.rows/d', 15);
        //归集总数
        $count = M('cash_sweep_detail')->alias('as csd')->join(array(' __CHANNEL_ACCOUNT__  as ca ON ca.id = csd.channel_account_id', '__CHANNEL__ as c ON c.id = csd.channel_id'))->field($field)->where($where)->count();

        $page = new Page($count, $rows);
        $list = M('cash_sweep_detail')->alias('as csd')->join(array(' __CHANNEL_ACCOUNT__  as ca ON ca.id = csd.channel_account_id', '__CHANNEL__ as c ON c.id = csd.channel_id'))->field($field)->where($where)->limit($page->firstRow . ',' . $page->listRows)
            ->order('csd.id desc')
            ->select();

        //归集成功数,失败数
        $success_count = M('cash_sweep_detail')->alias('as csd')->join(array(' __CHANNEL_ACCOUNT__  as ca ON ca.id = csd.channel_account_id', '__CHANNEL__ as c ON c.id = csd.channel_id'))->where($where)->where(['csd.status'=>1])->count();
        $fail_count = $count - $success_count;

        //成功金额,失败金额
        $amount = M('cash_sweep_detail')->alias('as csd')->join(array(' __CHANNEL_ACCOUNT__  as ca ON ca.id = csd.channel_account_id', '__CHANNEL__ as c ON c.id = csd.channel_id'))->where($where)->sum("amount");
        $success_amount = M('cash_sweep_detail')->alias('as csd')->join(array(' __CHANNEL_ACCOUNT__  as ca ON ca.id = csd.channel_account_id', '__CHANNEL__ as c ON c.id = csd.channel_id'))->where($where)->where(['csd.status'=>1])->sum("amount");
        $fail_amount = $amount - $success_amount;



        $this->assign(array(
                "usernameList" => $usernameList,
                "channelList" => $channelList,
                "accountlist" => $accountlist,
                "list" => $list,
                "page" => $page,
                "count" => $count,
                "success_count" => $success_count,
                "fail_count" => $fail_count,
                "amount" => $amount,
                "success_amount" => $success_amount,
                "fail_amount" => $fail_amount,
            )
        );
        if (I("param.star", 0)) {
            $this->display('sweepList2');
        } else {
            $this->display();
        }
    }

    /*
     * 获取渠道子账号
     */
    public function getAccount()
    {
        $info = [
            'status' => 0,
            'msg' => 'fail',
            'data' => null,
        ];
        if (IS_AJAX) {
            $channel_id = I('get.channel_id', 0, 'intval');
            if ($channel_id) {
                try {
                    $data = M('channel_account')->where(["channel_id" => $channel_id])->select();
                    $info = [
                        'status' => 1,
                        'msg' => 'ok',
                        'data' => $data,
                    ];
                } catch (\Exception $e) {

                }
            }
        }
        $this->ajaxReturn($info);
    }

    //下发流水
    public function dispenseDetail()
    {
        $where = [];
        //账号
        $username = I('param.username', "", "trim,string,strip_tags,htmlspecialchars");
        if ($username) $where["username"] = ["like", "%$username%"];
        //目标账号（收款方）
        $target_username = I('param.target_username', "", "trim,string,strip_tags,htmlspecialchars");
        if ($target_username) $where["target_username"] = ["like", "%$target_username%"];
        //时间
        $addtime = urldecode(I("param.addtime", '', 'trim,string,strip_tags,htmlspecialchars'));
        if ($addtime) {
            list($cstime, $cetime) = explode('|', $addtime);
            $where['ad.addtime'] = ['between', [strtotime($cstime), strtotime($cetime)]];
        }

        //join查询列表
        $field = array("cs.username", "ad.*");
        $rows = I('param.rows/d', 15);
        $count = M("cash_sweep")->alias("cs")->join(array('__ALIPAY_DISPENSE__ as ad ON cs.id = ad.cash_sweep_id'))->field($field)->where($where)->count();
        $page = new Page($count, $rows);
        $list = M("cash_sweep")->alias("cs")->join(array('__ALIPAY_DISPENSE__ as ad ON cs.id = ad.cash_sweep_id'))->field($field)->where($where)->limit($page->firstRow . ',' . $page->listRows)
            ->order('ad.id desc')
            ->select();
        $this->assign(array(
                "list" => $list,
                "page" => $page,
            )
        );
        $this->display();
    }

    public function sweepExportorder()
    {
        $where = [];
        //账号
        $username = I('param.username', "", "trim,string,strip_tags,htmlspecialchars");
        if ($username) $where["csd.sweep_account"] = ["like", "%$username%"];
        //时间
        $addtime = urldecode(I("param.addtime", '', 'trim,string,strip_tags,htmlspecialchars'));
        if ($addtime) {
            list($cstime, $cetime) = explode('|', $addtime);
            $where['addtime'] = ['between', [strtotime($cstime), strtotime($cetime)]];
        }

        //归集状态
        $status = I("param.status", "");
        if ($status ||$status==="0") $where["csd.status"] = $status;
        //入金渠道
        $channel = I("param.channel", 0);//渠道id
        if ($channel) $where["csd.channel_id"] = $channel;

        //入金渠道子账号
        $account = I("param.account", 0);//渠道id
        if ($account) $where["csd.channel_account_id"] = $account;

        //join查询列表
        $field = array("c.title", "ca.title as account_name", "csd.*");
        $list = M('cash_sweep_detail')->alias('as csd')->join(array(' __CHANNEL_ACCOUNT__  as ca ON ca.id = csd.channel_account_id', '__CHANNEL__ as c ON c.id = csd.channel_id'))->field($field)->where($where)
            ->order('csd.id desc')
            ->select();

        if(I("star",0)){
            $title = array(
                "入金渠道子账号",
                "入金渠道(供应商)",
                "支付宝归集账号",
                "归集金额",
                "状态",
                "归集时间",
                "备注",
            );
            $arr = [];
            foreach ($list as $k => $v) {
                $arr[] = [
                    'account_name' => $v['account_name'],
                    'title' => $v['title'],
                    'sweep_account' => $v['sweep_account'],
                    'amount' => $v['amount'],
                    'status' => $v['status'] ? "成功":"失败",
                    'addtime' => date('Y-m-d H:i:s', $v['addtime']),
                    'remark' => $v['remark'],
                ];
            }
        }else{
            $title = array(
                "支付宝归集账号",
                "入金渠道(供应商)",
                "入金渠道子账号",
                "归集金额",
                "状态",
                "归集时间",
                "备注",
            );
            $arr = [];
            foreach ($list as $k => $v) {
                $arr[] = [
                    'sweep_account' => $v['sweep_account'],
                    'title' => $v['title'],
                    'account_name' => $v['account_name'],
                    'amount' => $v['amount'],
                    'status' => $v['status'] ? "成功":"失败",
                    'addtime' => date('Y-m-d H:i:s', $v['addtime']),
                    'remark' => $v['remark'],
                ];
            }
        }

        exportexcel($arr, $title);
        // 将已经写到csv中的数据存储变量销毁，释放内存占用
        unset($arr);
        //刷新缓冲区
        ob_flush();
        flush();
    }

    public function dispenseExportorder(){
        $where = [];
        //账号
        $username = I('param.username', "", "trim,string,strip_tags,htmlspecialchars");
        if ($username) $where["username"] = ["like", "%$username%"];
        //目标账号（收款方）
        $target_username = I('param.target_username', "", "trim,string,strip_tags,htmlspecialchars");
        if ($target_username) $where["target_username"] = ["like", "%$target_username%"];
        //时间
        $addtime = urldecode(I("param.addtime", '', 'trim,string,strip_tags,htmlspecialchars'));
        if ($addtime) {
            list($cstime, $cetime) = explode('|', $addtime);
            $where['ad.addtime'] = ['between', [strtotime($cstime), strtotime($cetime)]];
        }

        //join查询列表
        $field = array("cs.username", "ad.*");
        $list = M("cash_sweep")->alias("cs")->join(array('__ALIPAY_DISPENSE__ as ad ON cs.id = ad.cash_sweep_id'))->field($field)->where($where)
            ->order('ad.id desc')
            ->select();

        $title = array(
            "支付宝归集账号",
            "下发金额",
            "收款方账号",
            "下发时间",
        );
        $arr = [];
        foreach ($list as $k => $v) {
            $arr[] = [
                'username' => $v['username'],
                'amount' => $v['amount'],
                'target_username' => $v['target_username'],
                'addtime' => date('Y-m-d H:i:s', $v['addtime']),
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

?>
