<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="renderer" content="webkit">
  <title><?php echo ($sitename); ?></title>
  <!--[if lt IE 9]>
  <meta http-equiv="refresh" content="0;ie.html" />
  <![endif]-->
  <link rel="shortcut icon" href="favicon.ico">
  <link href="/Public/Front/css/bootstrap.min.css" rel="stylesheet">
  <link href="/Public/Front/css/font-awesome.min.css" rel="stylesheet">
  <link href="/Public/Front/css/animate.css" rel="stylesheet">
  <link href="/Public/Front/css/style.css" rel="stylesheet">
  <link href="/Public/Front/css/zuy.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="/Public/Front/iconfont/iconfont.css"/>
  <meta name="__hash__" content="1a867bd89780c2b32d34adbe6aad0245_3530c36d5df41f1e030cc6b9adddeda1" /></head>
<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">

<div class=" zuy-header">
  <nav class="navbar navbar-static-top" role="navigation" >
    <!--<div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>

    </div>-->
    <ul class="nav navbar-left">
      <li class="nav-header zuy-user">
        <div class="dropdown profile-element">

          <span><i class="iconfont icon-mine_fill"></i></span>
          <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                <span >
                    <span class=" m-t-xs">
                       <font><?php echo ($member["username"]); ?></font>
                       
                       <label>【
                    <?php switch($member["groupid"]): case "1": ?>总管理员<?php break;?>
                        <?php case "2": ?>运营管理员<?php break;?>
                        <?php case "3": ?>财务管理员<?php break; endswitch;?>
                      】</label>
                    </span>
                </span>
          </a>
        </div>
        <div class="logo-element">MENU</div>
      </li>
    </ul>
    <ul class="nav navbar-top-links navbar-right">

      <li class="hidden-xs edtpwd">
        <a href="javascript:;" onClick="reset_pwd('修改密码','<?php echo U('System/editPassword');?>',360,320)"><i class="iconfont icon-mima"></i><label>修改密码</label></a>
      </li>
      <li class="dropdown hidden-xs"> <a  href="<?php echo U("Login/loginout");?>" class="right-sidebar-toggle"
                                          aria-expanded="false"> <i class="fa fa-sign-out"></i> <label>退出登录</label> </a> </li>
    </ul>
  </nav>
</div>
<div id="wrapper">
  <!--左侧导航开始-->
  <nav class="navbar-default navbar-static-side" role="navigation">
    <div class="nav-close"><i class="fa fa-times-circle"></i></div>
    <div class="sidebar-collapse">
        <ul class="nav" id="side-menu">
            <?php if(is_array($navmenus)): $i = 0; $__LIST__ = $navmenus;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$nm): $mod = ($i % 2 );++$i;?><li><a href="<?php if(!count($nm[$nm['id']])): echo U($nm[menu_name]); else: ?>#<?php endif; ?>"<i
                    class="<?php echo ($nm['icon']); ?> <?php if(!count($nm[$nm['id']])): ?>J_menuItem<?php endif; ?>"></i> <span
                        class="nav-label"><?php echo ($nm['title']); ?></span>
                    <?php if($nm[$nm['id']]): ?><span class="fa arrow"></span><?php endif; ?></a>
                    <?php if($nm[$nm['id']]): ?><ul class="nav nav-second-level">
                        <?php if(is_array($nm[$nm['id']])): $i = 0; $__LIST__ = $nm[$nm['id']];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$sub): $mod = ($i % 2 );++$i;?><li><a href="<?php echo U($sub[menu_name]);?>" class="J_menuItem"><i
                                    class="<?php echo ($sub['icon']); ?>"></i> <?php echo ($sub['title']); ?></a></li><?php endforeach; endif; else: echo "" ;endif; ?>
                    </ul><?php endif; ?>
                </li><?php endforeach; endif; else: echo "" ;endif; ?>
        </ul>
    </div>
</nav>

  <!--左侧导航结束-->
  <!--右侧部分开始-->
  <div id="page-wrapper" class="gray-bg dashbard-1">
    <div class="row J_mainContent" id="content-main">
      <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="<?php echo U('Admin/Index/main');?>"
              frameborder="0" data-id="<?php echo U('Admin/Index/main');?>" seamless></iframe>
    </div>
    <div class="footer">
      <div class="pull-right">版本：<?php echo C('SOFT_VERSION');?></div>
    </div>
  </div>
  <!--右侧部分结束-->
</div>
<!-- 全局js -->
</div>
<script src="/Public/Front/js/jquery.min.js"></script>
<script src="/Public/Front/js/bootstrap.min.js"></script>
<script src="/Public/Front/js/plugins/peity/jquery.peity.min.js"></script>
<script src="/Public/Front/js/content.js"></script>
<script src="/Public/Front/js/plugins/layui/layui.js" charset="utf-8"></script>
<script src="/Public/Front/js/x-layui.js" charset="utf-8"></script>
<script src="/Public/Front/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="/Public/Front/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="/Public/Front/js/hplus.js"></script>
<script type="text/javascript" src="/Public/Front/js/contabs.js"></script>
<script src="/Public/Front/js/iNotify.js"></script>
<script>
    layui.use(['laypage', 'layer', 'form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.jquery;
    });
    function reset_pwd(title,url,w,h){
        x_admin_show(title,url,w,h);
    }
</script>
<script>
    var iNotify = new iNotify({
        message: '有消息了。',//标题
        effect: 'flash', // flash | scroll 闪烁还是滚动
        interval: 300,
        audio:{
            //file: ['/Public/sound/msg.mp4','/Public/sound/msg.mp3','/Public/sound/msg.wav']
            file:'/Public/Front/sounds/tsy.mp3'
        }
    });
    <?php if(($withdraw) == "1"): ?>setInterval(function() {
            $.ajax({
                type: "GET",
                url: "<?php echo U('Withdrawal/checkNotice');?>",
                cache: false,
                success: function (res) {
                    if (res.num>0) {
                        iNotify.setFavicon(res.num).setTitle('提现通知').notify({
                            title: "新通知",
                            body: "有客户，提现啦..."
                        }).player();
                    }
                }
            });
        },10000);<?php endif; ?>



//side
$(function(){
    	 $('.logo-element').click(function(){
    	 	 if($('.navbar-static-side').hasClass('show')){
    	 	 	$('.navbar-static-side').removeClass('show');
    	 	 }
    	 	 else{
    	 	 	$('.navbar-static-side').addClass('show');
    	 	 }
    	 })
		 
		 
		 $('.navbar-static-side li>ul a').click(function(){
		 	$('.navbar-static-side').removeClass('show');
		 })
    })
</script>
<?php echo tongji(0);?>
</body>
</html>