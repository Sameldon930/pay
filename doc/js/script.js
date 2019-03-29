if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {

	head = document.getElementsByTagName('head');
	viewport = document.createElement('meta');
	viewport.name = 'viewport';
	viewport.content = 'target-densitydpi=device-dpi, width=' + 640 + 'px, user-scalable=no';
	head.length > 0 && head[head.length - 1].appendChild(viewport);    
}
	
	$('.gh').click(function(){
		if($('.header').hasClass('selected')){
			$('.header,.gh').removeClass('selected');
			$('.nav').slideUp();
		}										
		else{
			$('.header,.gh').addClass('selected');
			$('.nav').slideDown();
		}					
	})
	



$(function(){
	wow = new WOW({
 　　animateClass: "animated",
  });
  wow.init();
  
  
	$(".nav li").click(function(){
		$(this).addClass('on').siblings().removeClass('on')
	})
});