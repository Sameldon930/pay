<?php

namespace Admin\Controller;

use Think\Page;

class ChannelController extends BaseController
{
    public function __construct()
    {
        parent::__construct();
        $this->assign("Public", MODULE_NAME); // 模块名称
        $this->assign('paytypes', C('PAYTYPES'));

        //通道
        $channels = M('Channel')
            ->where(['status' => 1])
            ->field('id,code,title,paytype,status')
            ->select();
        $this->assign('channels', $channels);
        $this->assign('channellist', json_encode($channels));
    }

    //供应商接口列表
    public function index()
    {
        //通道id和通道名称和通道代码
        $keyword = I("request.keyword", '', 'trim,string,strip_tags,htmlspecialchars');
        if ($keyword) {
            $where['id|title|code'] = array('like', '%' . $keyword . '%');
        }
        //获取所有产品
        $products = M('Product')->field('id,name')->select();
        $this->assign('products', $products);

        //通道类型筛选
        $type = I("request.type", '', 'trim,string,strip_tags,htmlspecialchars');
        if ($type != "") {
            $where['paytype'] = array('eq', $type - 900);
        }
        $this->assign('type', $type);

        $this->assign("keyword", $keyword);
        $count = M('Channel')->where($where)->count();
        $size = 15;
        $rows = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $Page = new Page($count, $rows);
        $data = M('Channel')
            ->where($where)
            ->limit($Page->firstRow . ',' . $Page->listRows)
            ->order('id DESC')
            ->select();
        $this->assign('rows', $rows);
        $this->assign('list', $data);
        $this->assign('page', $Page->show());
        $this->display();
    }

    /**
     * 保存编辑供应商
     */
    public function saveEditSupplier()
    {
        if (IS_POST) {
            $id = I('post.id', 0, 'intval');
            $papiacc = I('post.pa/a');
            $_request['code'] = trim($papiacc['code']);
            $_request['title'] = trim($papiacc['title']);
            $_request['mch_id'] = trim($papiacc['mch_id']);
            $_request['signkey'] = trim($papiacc['signkey']);
            $_request['appid'] = trim($papiacc['appid']);
            $_request['appsecret'] = trim($papiacc['appsecret']);
            $_request['gateway'] = trim($papiacc['gateway']);
            $_request['pagereturn'] = $papiacc['pagereturn'];
            $_request['serverreturn'] = $papiacc['serverreturn'];
            $_request['defaultrate'] = $papiacc['defaultrate'] ? $papiacc['defaultrate'] : 0;
            $_request['fengding'] = $papiacc['fengding'] ? $papiacc['fengding'] : 0;
            $_request['rate'] = $papiacc['rate'] ? $papiacc['rate'] : 0;
            $_request['t0defaultrate'] = $papiacc['t0defaultrate'] ? $papiacc['t0defaultrate'] : 0;
            $_request['t0fengding'] = $papiacc['t0fengding'] ? $papiacc['t0fengding'] : 0;
            $_request['t0rate'] = $papiacc['t0rate'] ? $papiacc['t0rate'] : 0;
            $_request['updatetime'] = time();
            $_request['unlockdomain'] = $papiacc['unlockdomain'];
            //$_request['paytype']      = $papiacc['paytype'];
            $_request['status'] = $papiacc['status'];
            $_request['controller_id'] = $papiacc['controller_id'] ? $papiacc['controller_id'] :0;//归属于控制器
            $_request['payment_product_id'] = $papiacc['payment_product_id'];//归属于哪种支付产品
            $_request['product_id'] = M("payment_product")->where(['id' => $papiacc['payment_product_id']])->getField("pid");
            if ($id) {
                //更新
                $res = M('Channel')->where(array('id' => $id))->save($_request);
            } else {
                //添加
                $res = M('Channel')->add($_request);
            }
            //更新支付产品下入金渠道的条数
            $num = M('Channel')->where(["payment_product_id" => $_request['payment_product_id']])->count();
            M("payment_product")->where(["id" => $_request['payment_product_id']])->setField("num", $num);
            $this->ajaxReturn(['status' => $res]);
        }
    }

    //开启供应商接口
    public function editStatus()
    {
        if (IS_POST) {
            $pid = intval(I('post.pid'));
            $isopen = I('post.isopen') ? I('post.isopen') : 0;
            $res = M('Channel')->where(['id' => $pid])->save(['status' => $isopen]);
            $this->ajaxReturn(['status' => $isopen]);
        }
    }

    /**
    控制器列表
     */
    public function controllerList()
    {
        $where = array();
        if(I("keyword","")){
            $keyword = I("keyword");
            $where["code|name"] = array("like","%$keyword%");
        }
        $size = 15;
        $rows = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $count = M('controller')->where($where)->count();
        $Page = new Page($count, $rows);
        $list = M("controller")->where($where)
            ->limit($Page->firstRow . ',' . $Page->listRows)
            ->order('id DESC')
            ->select();
        $this->assign(array(
            "list"=>$list,
            "page"=>$Page->show()
        ));
        $this->display();
    }

    /**
     * 编辑控制器
    */
    public function editController()
    {
        $id = I("param.id/d", 0);
        $data = [];
        $data["name"] = I("param.name", "", "trim");
        $data["code"] = I("param.code", "", "trim");
        $data["updatetime"] = time();
        if (IS_POST) {
            if ($id) {//编辑
                $res = M("controller")->where(["id" => $id])->save($data);
            } else {//添加
                $data["addtime"] = time();
                $res = M("controller")->add($data);
            }
            if ($res !== false) {
                $this->ajaxReturn(['status' => 1]);
            } else {
                $this->ajaxReturn(['status' => 0]);
            }
        } else {
            if ($id) {//编辑
                $info = M("controller")->where(["id" => $id])->find();
                $this->assign(array(
                    "info" => $info,
                ));
            }
            $this->display();
        }
    }

    /**
     * 删除控制器delController
    */
    public function delController()
    {
        $id = I('post.id', 0, 'intval');
        if ($id) {
            // 删除子账号
            $res = M('controller')->where(['id' => $id])->delete();
            $this->ajaxReturn(['status' => $res]);
        }
    }

    //新增供应商接口
    public function addSupplier()
    {
        //所有入金渠道控制器
        $controller = M("controller")->select();
        $payment_product = M("payment_product")->order("id desc")->select();
        $this->assign(array(
            "payment_product" => $payment_product,
            "controller" => $controller,
        ));
        $this->display();
    }

    //编辑供应商接口
    public function editSupplier()
    {
        //所有入金渠道控制器
        $controller = M("controller")->select();
        //全部支付产品
        $payment_product = M("payment_product")->select();
        $pid = intval($_GET['pid']);
        if ($pid) {
            $pa = M('Channel')->where(['id' => $pid])->find();
        }
        $this->assign(array(
            'pa' => $pa,
            "payment_product" => $payment_product,
            "controller" => $controller,
        ));
        $this->display('addSupplier');
    }

    //删除供应商接口
    public function delSupplier()
    {
        $pid = I('post.pid', 0, 'intval');
        if ($pid) {
            // 删除子账号
            M('channel_account')->where(['channel_id' => $pid])->delete();
            $res = M('Channel')->where(['id' => $pid])->delete();
            $this->ajaxReturn(['status' => $res]);
        }
    }

    //编辑费率
    public function editRate()
    {
        if (IS_POST) {
            $pa = I('post.pa/a');
            $pid = I('post.pid', 0, 'intval');
            if ($pid) {
                $res = M('Channel')->where(['id' => $pid])->save($pa);
                $pa['pid'] = $pid;
                $this->ajaxReturn(['status' => $res, 'data' => $pa]);
            }
        } else {
            $pid = intval(I('get.pid'));
            if ($pid) {
                $data = M('Channel')->where(['id' => $pid])->find();
            }

            $this->assign('pid', $pid);
            $this->assign('pa', $data);
            $this->display();
        }
    }

    //产品列表
    public function product()
    {
        $data = M('Product')->select();
        $this->assign('list', $data);
        $this->display();
    }

    //切换产品状态
    public function prodStatus()
    {
        if (IS_POST) {
            $id = I('post.id', 0, 'intval');
            $colum = I('post.k');
            $value = I('post.v/d');
            $res = M('Product')->where(['id' => $id])->save([$colum => $value]);
            $this->ajaxReturn(['status' => $value]);
        }
    }

    //切换用户显示状态
    public function prodDisplay()
    {
        if (IS_POST) {
            $id = I('post.id', 0, 'intval');
            $colum = I('post.k');
            $value = I('post.v/d');
            $res = M('Product')->where(['id' => $id])->save([$colum => $value]);
            $this->ajaxReturn(['status' => $value]);
        }
    }

    //添加产品
    public function addProduct()
    {
        $this->display();
    }

    //编辑产品
    public function editProduct()
    {
        $id = I('get.pid', 0, 'intval');
        $data = M('Product')->where(['id' => $id])->find();

        //权重
        $weights = [];
        $weights = explode('|', $data['weight']);
        $_tmpWeight = '';
        if (is_array($weights)) {
            foreach ($weights as $value) {
                list($pid, $weight) = explode(':', $value);
                if ($pid) {
                    $_tmpWeight[$pid] = ['pid' => $pid, 'weight' => $weight];
                }
            }
        } else {
            list($pid, $weight) = explode(':', $data['weight']);
            if ($pid) {
                $_tmpWeight[$pid] = ['pid' => $pid, 'weight' => $weight];
            }
        }
        $data['weight'] = $_tmpWeight;
        //通道
        $channels = M('Channel')->where(["paytype" => $data['paytype'], "status" => 1])->select();
        $this->assign('channels', $channels);
        $this->assign('pd', $data);
        $this->display('addProduct');
    }

    //保存更改
    public function saveProduct()
    {
        if (IS_POST) {
            $id = intval(I('post.id'));
            $rows = I('post.pd/a');
            $weight = I('post.w/a');
            //权重
            $weightStr = '';
            if (is_array($weight)) {
                foreach ($weight as $weigths) {
                    if ($weigths['pid']) {
                        $weightStr .= $weigths['pid'] . ':' . $weigths['weight'] . "|";
                    }
                }
            }
            $rows['weight'] = trim($weightStr, '|');
            //检查费率合法性

            if ($rows['t0defaultrate'] > 0 && $rows['t0defaultrate'] > $rows['t0fengding']) {
                $this->ajaxReturn(['status' => 0, 'msg' => 'T+0封顶费率不得低于T+0运营费率']);
            }
            if ($rows['defaultrate'] > 0 && $rows['defaultrate'] > $rows['fengding']) {
                $this->ajaxReturn(['status' => 0, 'msg' => 'T+1封顶费率不得低于T+1运营费率']);
            }
            if ($rows['polling'] == 0 && $rows['channel'] > 0) {//单独渠道的情况
                $channel = M('Channel')
                    ->where(['id' => $rows['channel'], 'status' => 1])
                    ->find();
                $channel_account_list = M('channel_account')->where(['channel_id' => $rows['channel'], 'status' => '1', 'custom_rate' => 1])->select();
                if (!empty($channel)) {
                    if (!empty($channel_account_list)) {
                        foreach ($channel_account_list as $k => $v) {
                            if ($rows['t0defaultrate'] > 0 && $rows['t0defaultrate'] < $v['rate']) {
                                $this->ajaxReturn(['status' => 0, 'msg' => '【' . $channel['title'] . '】T+0运营费率不得低于渠道子账号成本费率']);
                            }
                            if ($rows['defaultrate'] > 0 && $rows['defaultrate'] < $v['rate']) {
                                $this->ajaxReturn(['status' => 0, 'msg' => '【' . $channel['title'] . '】T+1运营费率不得低于渠道子账号成本费率']);
                            }
                        }
                    } else {
                        if ($rows['t0defaultrate'] > 0 && $rows['t0defaultrate'] < $channel['rate']) {
                            $this->ajaxReturn(['status' => 0, 'msg' => '【' . $channel['title'] . '】T+0运营费率不得低于渠道成本费率']);
                        }
                        if ($rows['defaultrate'] > 0 && $rows['defaultrate'] < $channel['rate']) {
                            $this->ajaxReturn(['status' => 0, 'msg' => '【' . $channel['title'] . '】T+1运营费率不得低于渠道成本费率']);
                        }
                    }
                }
            }
            if ($rows['polling'] == 1 && $rows['weight'] != '') {//渠道轮询的情况
                $temp_weights = explode('|', $rows['weight']);
                if (!empty($temp_weights)) {
                    foreach ($temp_weights as $k => $v) {
                        list($pid, $weight) = explode(':', $v);
                        $channel = M('channel')->where(['id' => $pid, 'status' => 1])->find();
                        $channel_account_list = M('channel_account')->where(['channel_id' => $pid, 'status' => '1', 'custom_rate' => 1])->select();
                        if (!empty($channel)) {
                            if (!empty($channel_account_list)) {
                                foreach ($channel_account_list as $k => $v) {
                                    if ($rows['t0defaultrate'] > 0 && $rows['t0defaultrate'] < $v['rate']) {
                                        $this->ajaxReturn(['status' => 0, 'msg' => '【' . $channel['title'] . '】T+0运营费率不得低于渠道子账号成本费率']);
                                    }
                                    if ($rows['defaultrate'] > 0 && $rows['defaultrate'] < $v['rate']) {
                                        $this->ajaxReturn(['status' => 0, 'msg' => '【' . $channel['title'] . '】T+1运营费率不得低于渠道子账号成本费率']);
                                    }
                                }
                            } else {
                                if ($rows['t0defaultrate'] > 0 && $rows['t0defaultrate'] < $channel['rate']) {
                                    $this->ajaxReturn(['status' => 0, 'msg' => '【' . $channel['title'] . '】T+0运营费率不得低于渠道成本费率']);
                                }
                                if ($rows['defaultrate'] > 0 && $rows['defaultrate'] < $channel['rate']) {
                                    $this->ajaxReturn(['status' => 0, 'msg' => '【' . $channel['title'] . '】T+1运营费率不得低于渠道成本费率']);
                                }
                            }
                        }
                    }
                }
            }
            //保存
            if ($id) {
                $res = M('Product')->where(['id' => $id])->save($rows);
            } else {
                $res = M('Product')->add($rows);
            }
            if (FALSE !== $res) {
                $this->ajaxReturn(['status' => 1]);
            } else {
                $this->ajaxReturn(['status' => 0]);
            }
        }
    }

    //删除产品
    public function delProduct()
    {
        if (IS_POST) {
            $id = I('post.pid', 0, 'intval');
            $res = M('Product')->where(['id' => $id])->delete();
            $this->ajaxReturn(['status' => $res]);
        }
    }

    //接口模式
    public function selProduct()
    {
        if (IS_POST) {
            $paytyep = I('post.paytype', 0, 'intval');
            //通道
            $data = M('Channel')->where(["paytype" => $paytyep, "status" => 1])->select();
            $this->ajaxReturn(['status' => 0, 'data' => $data]);
        }
    }

    /**
     * 通道账户列表
     */
    public function account()
    {
        $channel_id = I('get.pid');
        $channel = M('Channel')->where(['id' => $channel_id])->find();
        $accounts = M('channel_account')->where(['channel_id' => $channel_id])->select();
        $this->assign('channel', $channel);
        $this->assign('accounts', $accounts);
        $this->display();
    }

    /**
     * 编辑账户
     */
    public function editAccountControl()
    {
        if (IS_POST) {
            $data = I('post.data', '');

            if ($data['start_time'] != 0 || $data['end_time'] != 0) {
                if ($data['start_time'] >= $data['end_time']) {
                    $this->ajaxReturn(['status' => 0, 'msg' => '交易结束时间不能小于开始时间！']);
                }
            }
            if ($data['max_money'] != 0 && $data['min_money'] != 0) {
                if ($data['min_money'] >= $data['max_money']) {
                    $this->ajaxReturn(['status' => 0, 'msg' => '最大交易金额不能小于或等于最小金额！']);
                }
            }
            if ($data['is_defined'] == 0) {
                $channel_id = M('ChannelAccount')->where(['id' => $data['id']])->getField('channel_id');
                $channelInfo = M('Channel')->where(['id' => $channel_id])->find();
                $data['offline_status'] = $channelInfo['offline_status'];
                $data['control_status'] = $channelInfo['control_status'];
            }
            $res = M('ChannelAccount')->where(['id' => $data['id']])->save($data);
            $this->ajaxReturn(['status' => $res]);
        } else {
            $aid = I('get.aid', '', 'intval');
            $info = M('ChannelAccount')->where(['id' => $aid])->find();

            $this->assign('info', $info);
            $this->assign('aid', $aid);
            $this->display();
        }

    }

    /**
     * 编辑账户
     */
    public function editAccount()
    {
        $aid = intval($_GET['aid']);
        if ($aid) {
            $pa = M('channel_account')->where(['id' => $aid])->find();
        }
        $this->assign('pa', $pa);
        $this->assign('pid', $pa['channel_id']);
        $this->display('addAccount');
    }

    /**
     * 新增账户
     */
    public function addAccount()
    {
        $pid = intval($_GET['pid']);
        $this->assign('pid', $pid);
        $this->display('addAccount');
    }

    public function showEven()
    {
        // echo "<pre>";
        $channelList = M('Channel')->where(['control_status' => 1, 'status' => 1])->select();
        $accountList = M('ChannelAccount')->where(['control_status' => 1, 'status' => 1])->select();

        $list = [];
        foreach ($channelList as $k => $v) {
            $v['offline_status'] = $v['offline_status'] ? '上线' : '下线';
            $list[$k] = $v;
            foreach ($accountList as $k1 => $v1) {
                if ($v1['channel_id'] == $v['id']) {
                    $v1['offline_status'] = $v1['offline_status'] ? '上线' : '下线';
                    $list[$k]['account'][] = $v1;
                }
            }
        }
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 保存账户
     */
    public function saveEditAccount()
    {
        if (IS_POST) {
            $id = I('post.id', 0, 'intval');
            $papiacc = I('post.pa/a');
            $_request['title'] = trim($papiacc['title']);
            $_request['channel_id'] = trim($papiacc['pid']);
            $_request['mch_id'] = trim($papiacc['mch_id']);
            $_request['signkey'] = trim($papiacc['signkey']);
            $_request['appid'] = trim($papiacc['appid']);
            $_request['appsecret'] = trim($papiacc['appsecret']);
            // 默认为1
            $weight = trim($papiacc['weight']);
            $_request['weight'] = $weight === '' ? 1 : $weight;
            $_request['custom_rate'] = $papiacc['custom_rate'];
            $_request['defaultrate'] = $papiacc['defaultrate'] ? $papiacc['defaultrate'] : 0;
            $_request['fengding'] = $papiacc['fengding'] ? $papiacc['fengding'] : 0;
            $_request['rate'] = $papiacc['rate'] ? $papiacc['rate'] : 0;
            $_request['t0defaultrate'] = $papiacc['t0defaultrate'] ? $papiacc['t0defaultrate'] : 0;
            $_request['t0fengding'] = $papiacc['t0fengding'] ? $papiacc['t0fengding'] : 0;
            $_request['t0rate'] = $papiacc['t0rate'] ? $papiacc['t0rate'] : 0;
            $_request['updatetime'] = time();
            $_request['status'] = $papiacc['status'];
            $_request['is_defined'] = $papiacc['is_defined'];
            $_request['all_money'] = $papiacc['all_money'] == '' ? 0 : $papiacc['all_money'];
            $_request['min_money'] = $papiacc['min_money'] == '' ? 0 : $papiacc['min_money'];
            $_request['max_money'] = $papiacc['max_money'] == '' ? 0 : $papiacc['max_money'];
            $_request['start_time'] = $papiacc['start_time'];
            $_request['end_time'] = $papiacc['end_time'];
            $_request['offline_status'] = $papiacc['offline_status'];
            $_request['control_status'] = $papiacc['control_status'];
            $_request['unlockdomain'] = $papiacc['unlockdomain'];
            if ($id) {
                //更新
                $res = M('channel_account')->where(array('id' => $id))->save($_request);
            } else {
                //添加
                $res = M('channel_account')->add($_request);
            }
            $this->ajaxReturn(['status' => $res]);
        }
    }

    //开启供应商接口
    public function editAccountStatus()
    {
        if (IS_POST) {
            $aid = intval(I('post.aid'));
            $isopen = I('post.isopen') ? I('post.isopen') : 0;
            $res = M('channel_account')->where(['id' => $aid])->save(['status' => $isopen]);
            $this->ajaxReturn(['status' => $res]);
        }
    }

    //删除供应商接口
    public function delAccount()
    {
        $aid = I('post.aid', 0, 'intval');
        if ($aid) {
            $res = M('channel_account')->where(['id' => $aid])->delete();
            $this->ajaxReturn(['status' => $res]);
        }
    }

    //编辑费率
    public function editAccountRate()
    {
        if (IS_POST) {
            $pa = I('post.pa');
            $accountId = I('post.aid');
            if ($accountId) {
                $res = M('channel_account')->where(['id' => $accountId])->save($pa);
                $pa['aid'] = $accountId;
                $this->ajaxReturn(['status' => $res, 'data' => $pa]);
            }
        } else {
            $aid = intval(I('get.aid'));
            if ($aid) {
                $data = M('channel_account')->where(['id' => $aid])->find();
            }

            $this->assign('aid', $aid);
            $this->assign('pa', $data);
            $this->display();
        }
    }

    //编辑风控
    public function editControl()
    {
        if (IS_POST) {
            $data = I('post.data', '');
            if ($data['start_time'] != 0 || $data['end_time'] != 0) {
                if ($data['start_time'] >= $data['end_time']) {
                    $this->ajaxReturn(['status' => 0, 'msg' => '交易结束时间不能小于开始时间！']);
                }
            }
            if ($data['max_money'] != 0 && $data['min_money'] != 0) {
                if ($data['min_money'] >= $data['max_money']) {
                    $this->ajaxReturn(['status' => 0, 'msg' => '最大交易金额不能小于或等于最小金额！']);
                }
            }
            $res = M('Channel')->where(['id' => $data['id']])->save($data);
            $this->ajaxReturn(['status' => $res]);
        } else {
            $pid = I('get.pid', '');
            $info = M('Channel')->where(['id' => $pid])->find();
            $this->assign('info', $info);
            $this->assign('pid', $pid);
            $this->display();
        }
    }

    /**
     * 支付产品（用于归类入金渠道）
     */
    public function paymentProducts()
    {
        $where = [];
        //账号
        $username = I('param.name', "", "trim,string,strip_tags,htmlspecialchars");
        if ($username) $where["name"] = ["like", "%$username%"];
        //时间
        $addtime = urldecode(I("param.addtime", '', 'trim,string,strip_tags,htmlspecialchars'));
        if ($addtime) {
            list($cstime, $cetime) = explode('|', $addtime);
            $where['addtime'] = ['between', [strtotime($cstime), strtotime($cetime)]];
        }

        $count = M("payment_product")->where($where)->count();
        $rows = I('param.rows/d', 15);
        $page = new Page($count, $rows);
        $list = M("payment_product")->where($where)->limit($page->firstRow . ',' . $page->listRows)
            ->order('id desc')
            ->select();
        $this->assign(array(
            "list" => $list,
            "page" => $page->show(),
        ));
        $this->display();
    }

    //编辑支付产品
    public function editPaymentProduct()
    {
        $id = I("param.id/d", 0);
        $data = [];
        $data["name"] = I("param.name", "", "trim");
        $data["pid"] = I("param.pid/d", 0);
        $data["status"] = I("param.status/d", 0);
        $data["updatetime"] = time();
        //全部通道编码
        $product = M("product")->select();
        $this->assign("product", $product);
        if (IS_POST) {
            if ($id) {//编辑
                $res = M("payment_product")->where(["id" => $id])->save($data);
                //更改入金渠道所属的通道编码
                M("channel")->where(["payment_product_id"=>$id])->setField("product_id",$data["pid"]);
            } else {//添加
                $data["addtime"] = time();
                $res = M("payment_product")->add($data);
            }
            if ($res !== false) {
                $this->ajaxReturn(['status' => 1]);
            } else {
                $this->ajaxReturn(['status' => 0]);
            }
        } else {
            if ($id) {//编辑
                $info = M("payment_product")->where(["id" => $id])->find();
                //全部入金渠道
                $channelList = M('Channel')->where(["payment_product_id" => $id])->select();
                $this->assign(array(
                    "info" => $info,
                    "channelList" => $channelList,
                ));
            }
            $this->display();
        }
    }

    //支付产品状态切换
    public function editPaymentProductStatus()
    {
        if (IS_POST) {
            $id = I('post.id/d');
            $isstatus = I('post.isopen') ? I('post.isopen') : 0;
            $res = M("payment_product")->where(['id' => $id])->save(['status' => $isstatus]);
            $this->ajaxReturn(['status' => $isstatus]);
        }
    }

    //删除支付产品
    public function delPaymentProduct()
    {
        $id = I("param.id/d", 0);
        $res = M("payment_product")->where(["id" => $id])->delete();
        if ($res !== false) {
            $this->ajaxReturn(['status' => 1]);
        } else {
            $this->ajaxReturn(['status' => 0]);
        }
    }
}
