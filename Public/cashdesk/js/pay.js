/**
 * 登录
 */

function playerLogin(){
    layer.load(0, {
        shade: [0.8,'#333'] //0.1透明度的白色背景
    });
    var account=$("#account").val();
    var pass=$("#pass").val();
    var goodsId=$("input[name='goods-pt']:checked").val();

    if(account==""||account==null||account==undefined){
        layer.msg("请输入账号");
        layer.closeAll("loading");
    }else if(pass==""||pass==null||pass==undefined){
        layer.msg("请输入密码");
        layer.closeAll("loading");
    }else{
        $.ajax({
            url:path+"/doLogin",
            type:"post",
            data: {
                "account": account,
                "pass": pass,
                "goodsId":goodsId
            },
            dataType:"json",
            success: function(data){
                layer.msg(data.msg);
                layer.closeAll("loading");
                if(data.code==1){}
                    if(data.code == 0){
                        setTimeout(function(){location.href=path+"goGoods?type=1&goodsId=2";},1000);
                    }else{
                        if(isWanma=='1'){
                            setTimeout(function(){location.href=path+"wanmaGoods?type=1";},1000);
                        }else {
                            setTimeout(function(){location.href=path+"goGoods?type=1";},1000);
                        }
                    }

            },
            error:function(){
                layer.msg("提交失败,稍后重试···");
                layer.closeAll("loading");
            }
        });
    }
}



//下单
function pay(){
    // console.log(111);
    var paytype=$("input[name='r-pt']:checked").val();
    var goodsId=$("input[name='goods-pt']:checked").val();
    var userId=$("#userId").val();
    var platform=$("#platform").val();
    var pay_callbackurl=$("#pay_callbackurl").val();
    var data = $('#doc-vld-msg').serialize();
    // console.log(data);
    $.ajax({
        url:"<{:U('Index/pay')}>",
        type:"post",
        data:$('#doc-vld-msg').serialize(),
        success:function(res){
            // if(res.status){
            //     layer.alert("编辑成功", {icon: 6},function () {
            //         parent.location.reload();
            //         var index = parent.layer.getFrameIndex(window.name);
            //         parent.layer.close(index);
            //     });
            // }else {
            //     layer.alert(res.msg ? res.msg : "操作失败", {icon: 5},function () {
            //         parent.location.reload();
            //         var index = parent.layer.getFrameIndex(window.name);
            //         parent.layer.close(index);
            //     });
            // }
        }
    });
    // console.log(paytype);
    // console.log(goodsId);
    // console.log(userId);
    // console.log(platform);
    // console.log(pay_callbackurl);
    // location.href=path+"gmzamall?id="+userId+"&platform="+platform+"&zaid="+goodsId+"&paytype="+paytype+"&pay_callbackurl"+pay_callbackurl;
}

//设置倒计时
function countDown() {
    if (maxtime >= 0) {
        minutes = Math.floor(maxtime / 60);
        seconds = Math.floor(maxtime % 60);
        msg = minutes + "分" + seconds + "秒";
        document.all["timer"].innerHTML = msg;
        if (maxtime == 3 * 60){
            layer.msg("还剩3分钟")
        };
        --maxtime;
    } else{
        clearInterval(timer);
        layer.msg("支付时间到!请重新下单");
        $("#imgdiv").hide();
    }
}

//查询支付情况
function checkPay(){
    $.ajax({
        type:"post",
        url:path+"checkPayResult",
        data:{
            "outTradeNo":outTradeNo,
            "payType":payType,
            "uid":uid,
            "platform":platform
        } ,
        dataType:"json",
        success:function (data) {
            if (data.code==1){
                location.href=path+"goPayResult?resultMsg="+data.msg+"&payType="+payType+
                    "&platform="+platform+"&money="+data.money+"&orderCode="+data.orderCode;
            }

        },error:function () {

        }
    });
}

//返回收银台
function callBack(){
    location.href = path+"goGoods.html?type=1";
}

//万码下单
function wanmaPay(){
    layer.load(0, {
        shade: [0.8,'#333'] //0.1透明度的白色背景
    });
    var paytype=$("input[name='r-pt']:checked").val();
    // var goodsId=$("input[name='goods-pt']:checked").val();
    var goodsId=undefined;
    var payMoney = $("input[name='goods-pt']").val();
    console.log(payMoney);
    var userId=$("#userId").val();
    var platform=$("#platform").val();
    location.href=path+"wanmaMall?id="+userId+"&platform="+platform+"&zaid="+goodsId+"&paytype="+paytype+"&payMoney"+payMoney;
}

//万码返回收银台
function wanmaCallBack(){
    location.href = path+"wanmaGoods.html?type=1";
}