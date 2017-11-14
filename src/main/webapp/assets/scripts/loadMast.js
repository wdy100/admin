function showLoadMast(dom,msg){
	var msg = msg||"正在处理，请稍候。。。";
	$("<div class='hz_loadMast' ></div>").css({display:"block",width:"100%",height:$(dom).height()}).appendTo($("body",dom.document)); 
	$("<div class='hz_loadMast_message'></div>").html(msg).appendTo($("body",dom.document)).css({display:"block",left:($(dom.document.body).outerWidth(true) - 190) / 2,top:($(dom).height() - 45) / 2}); 
}
function hideLoadMast(dom){
	$(".hz_loadMast,.hz_loadMast_message",dom.document).remove();
}