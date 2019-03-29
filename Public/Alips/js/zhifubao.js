

/**
 * [展示轮播图]
 * @return {[type]} [description]
 */
function openAlertWindow(id){
        $(id).css("display","block");
        // var html = $(id).html();
        
        // layer.open({
        //     type: 1
        //     ,content: html
        //     ,anim: 'up'
        // });
    }

function closeAlertWindow(id){
  $(id).css("display","none")
}