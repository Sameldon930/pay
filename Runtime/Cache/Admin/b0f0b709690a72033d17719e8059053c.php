<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <title><?php echo ($sitename); ?>---管理</title>
    <link rel="shortcut icon" href="favicon.ico">
    <link href="/Public/Front/css/bootstrap.min.css" rel="stylesheet">
    <link href="/Public/Front/css/font-awesome.min.css" rel="stylesheet">
    <link href="/Public/Front/css/animate.css" rel="stylesheet">
    <link href="/Public/Front/css/style.css" rel="stylesheet">
    <link href="/Public/Front/css/zuy.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/Public/Front/iconfont/iconfont.css"/>
    <link rel="stylesheet" href="/Public/Front/js/plugins/layui/css/layui.css">
    <style>
        .layui-form-label {width:110px;padding:4px}
        .layui-form-item .layui-form-checkbox[lay-skin="primary"]{margin-top:0;}
        .layui-form-switch {width:54px;margin-top:0px;}
    </style>
<body class="gray-bg">
<div class="wrapper wrapper-content animated">
<div class="row">
  <div class="col-sm-12">
    <?php if($installpwd == $member['password']): ?><div class="alert alert-danger">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <i class="fa fa-warning"></i>警告！您目前使用的是默认密码，请尽快修改！
      </div><?php endif; ?>
  </div>
</div>
<div class="row zuy-nav">
  <div class="col-sm-4">
    <div class="ibox float-e-margins">
      <div class="ibox-title">
        <h5><?php echo ($stat["allordersum"]); ?></h5>
      </div>
      <div class="ibox-content" style="padding-top:0;height: 67px">
        <h1 class="no-margins">平台总入金(元)</h1>
        <i class="iconfont icon-cunqianguan" style="color: #fff1f3;"></i>
      </div>
    </div>
  </div>
  <div class="col-sm-4" >
    <div class="ibox float-e-margins">
      <div class="ibox-title">
        <h5><?php echo ($stat["allmemberprofit"]); ?></h5>
      </div>
      <div class="ibox-content" style="padding-top:0;height: 67px">
        <h1 class="no-margins">商户总分成(元)</h1>
        <i class="iconfont icon-tuiguangzhuanqian" style="color: #fffbe8;"></i>
      </div>
    </div>
  </div>
  <div class="col-sm-4" >
    <div class="ibox float-e-margins">
      <div class="ibox-title">
        <h5><?php echo ($stat["allplatformincome"]); ?></h5>
      </div>
      <div class="ibox-content" style="padding-top:0;height: 67px">
        <h1 class="no-margins">平台总分成(元)</h1>
        <i class="iconfont icon-iconfontjikediancanicon20" style="color: #f0faf8;"></i>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
    <div class="ibox float-e-margins">
      <div class="ibox-title">
        <h5><?php echo ($stat["todayordersum"]); ?></h5>
      </div>
      <div class="ibox-content" style="padding-top:0;height: 67px">
        <h1 class="no-margins">今日平台总入金(元)</h1>
        <i class="iconfont icon-qianbao" style="color: #edf7fe;"></i>
      </div>
    </div>
  </div>
  <div class="col-sm-4" style="height: 140px">
    <div class="ibox float-e-margins">
      <div class="ibox-title">
        <h5><?php echo ($stat["todaymemberprofit"]); ?></h5>
      </div>
      <div class="ibox-content" style="padding-top:0;height: 67px">
        <h1 class="no-margins">今日商户总分成(元)</h1>
        <i class="iconfont icon-shourusel" style="color: #fff6f0;"></i>
      </div>
    </div>
  </div>
  <div class="col-sm-4" style="height: 140px">
    <div class="ibox float-e-margins">
      <div class="ibox-title">
        <h5><?php echo ($stat["todayplatformincome"]); ?></h5>
      </div>
      <div class="ibox-content" style="padding-top:0;height: 67px">
        <h1 class="no-margins">今日平台总分成(元)</h1>
        <i class="iconfont icon-shouru" style="color: #eff2fe;"></i>
      </div>
    </div>
  </div>
</div>
<div class="row">
  <div class="col-md-12">
    <div class="ibox float-e-margins">
      <div class="ibox-title">
        <h5>月度交易统计</h5>
      </div>
      <div class="ibox-content" style="padding:14px 20px;">
        <div id="dmonth" style="height:315px; margin-top: -40px;"></div>
      </div>
    </div>
  </div>
</div>
</div>
<!-- 全局js -->
</div>
<script src="/Public/Front/js/jquery.min.js"></script>
<script src="/Public/Front/js/bootstrap.min.js"></script>
<script src="/Public/Front/js/plugins/peity/jquery.peity.min.js"></script>
<script src="/Public/Front/js/content.js"></script>
<script src="/Public/Front/js/plugins/layui/layui.js" charset="utf-8"></script>
<script src="/Public/Front/js/x-layui.js" charset="utf-8"></script>
<script src="/Public/Front/js/echarts.common.min.js"></script>
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
    var myChartmonth = echarts.init(document.getElementById('dmonth'));
    // 使用刚指定的配置项和数据显示图表。
    myChartmonth.setOption({
        grid:{
                x:50,
                x2:20,
                y:70,
                y2:40,
                borderWidth:1
            },
        title : {
            text: '',
            subtext: ''
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
        	x: 'center',
        y: '0',
            data:['交易金额','支出金额','收入金额'],
            textStyle:{
            	fontSize:14,
            	color:'#b2b5c4'
            }
        },
        toolbox: {
            show : false,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        xAxis : [
            {
            	axisLabel:{
		            textStyle:{
		                fontSize:14,
		                color:'#5b6e89'
		            }
		        },
                type : 'category',
                boundaryGap : false,
                data : [<?php echo (implode($mdata["mdate"],",")); ?>]
            }
        ],
        yAxis : [
            {
            	splitLine:{
            		show: true,
            		lineStyle:{
            			type:"dashed",
            			color:"#dfdfdf"
            		}
            	},
            	axisLabel:{
		            textStyle:{
		                fontSize:14,
		                color:'#5b6e89'
		            }
		        },
                type : 'value'
            }
        ],
        series : [
            {
                name:'交易金额',
                type:'line',
                smooth:true,
                itemStyle: {
                	normal: {
	                	areaStyle: {
	                		type: 'default',
	                		color: {
							    type: 'linear',
							    x: 0,
							    y: 0,
							    x2: 0,
							    y2: 1,
							    colorStops: [{
							        offset: 0, color: '#ffe9da'
							    }, {
							        offset: 1, color: '#ffffff'
							    }],
							    globalCoord: false
							}
	                	}
	                	,color:'#ff8b88'
                	}
                },
                data:[<?php echo (implode($mdata["amount"],",")); ?>]
            },
            {
                name:'支出金额',
                type:'line',
                smooth:true,

                itemStyle: {
                	normal: {
	                	areaStyle: {
	                		type: 'default',
	                		color: {
							    type: 'linear',
							    x: 0,
							    y: 0,
							    x2: 0,
							    y2: 1,
							    colorStops: [{
							        offset: 0, color: '#e7dde7'
							    }, {
							        offset: 1, color: '#ffffff'
							    }],
							    globalCoord: false
							}
	                	}
	                	,color:'#6e94ff'
                	}
                },
                data:[<?php echo (implode($mdata["total"],",")); ?>]
            },
            {
                name:'收入金额',
                type:'line',
                smooth:true,

                itemStyle: {
                	normal: {
	                	areaStyle: {
	                		type: 'default',
	                		color: {
							    type: 'linear',
							    x: 0,
							    y: 0,
							    x2: 0,
							    y2: 1,
							    colorStops: [{
							        offset: 0, color: '#ffe9db'
							    }, {
							        offset: 1, color: '#ffffff'
							    }],
							    globalCoord: false
							}
	                	}
	                	,color:'#ffd74c'
                	}
                },
                data:[<?php echo (implode($mdata["rate"],",")); ?>]
            }
        ]
    });
</script>
<?php echo tongji(0);?>
</body>
</html>