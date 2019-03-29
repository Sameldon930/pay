<?php
namespace User\Controller;

use Think\Controller;

class ApplyIPSController extends UserController
{

    public function index()
    {
        $applyIpsInfo = M('ApplyIps')->where(['user_id' => session('user_auth.uid')])->find();
        $this->assign('applyIpsInfo', $applyIpsInfo);
        $this->display();
    }

    public function add()
    {
        if (IS_AJAX) {
            $data       = I('post.', '');
            $username   = M('member')->where(['id' => session('user_auth.uid')])->getField('username');
            $supplierId = 'z' . (session('user_auth.uid') + 10000);
            $res        = M('ApplyIps')->add([
                'supplier_id'   => $supplierId,
                'batch_id'      => date('Ymd') . mt_rand(10, 99) . str_pad(session('user_auth.uid'), 4, 0, STR_PAD_LEFT),
                'user_id'       => session('user_auth.uid'),
                'ips_name'      => $username,
                'login_pass'    => 'z123456',
                'pay_pass'      => 'z123456',
                'id_no'         => $data['id_no'],
                'email'         => $data['email'],
                'bank_fullname' => $data['bank_fullname'],
                'bank_code'     => $data['bank_code'],
                'bank_account'  => $data['bank_account'],
                'bank_address'  => $data['bank_address'],
                'mobile'        => $data['mobile'],
                'create_at'     => time(),
                'status'        => '0',
            ]);
            $this->ajaxReturn(['status' => $res]);
        }
    }
}
