$(function(){
	$("#user_name,#user_pass").focus(function(event){
		var o = $(this);
		if(o.val() == o.attr("title")) o.val('');
		$(this).addClass("inputbgOver");
	}).blur(function(event){
		var o = $(this);
		if(o.val() == '') o.val(o.attr("title"));
		$(this).removeClass("inputbgOver");		
	});
	
	
	//////////
	$("#login").mouseover(function(){
		$(this).addClass("button_hover");
	}).mouseout(function(){
		$(this).removeClass("button_hover");
	})
});




