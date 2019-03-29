

/**
 * [展示轮播图]
 * @return {[type]} [description]
 */
function openAlertWindow(id){
    var html = $(id).html();

    layer.open({
        type: 1
        ,content: html
        ,anim: 'up'
    });
}