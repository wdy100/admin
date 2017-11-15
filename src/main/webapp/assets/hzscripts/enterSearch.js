$(function(){
	$(document).keydown(function(e){
		if(e.keyCode == 13) {//回车键的键值为13 
			//获取触发事件的dom节点
			var searchDom = null;
			//对主查询页面进行判断
			if($("#searchPt").size()>0){
				searchDom = $("#searchPt");
				var dom = $(e.target);
				//判断是否为easyUI中的textbox控件
				if(dom.hasClass("textbox-text")){
					var valueDom = $("input[class*='textbox-value']",dom.parent());
					if(valueDom.size()>0){
						valueDom.val(dom.val());
					}
				}
				//判断有没有出现遮罩层（比如弹出了其他窗口），有的话不进行查询
				if($("div[class='window-mask']:visible").size()==0 ){
					//查询
					searchDom.click();
				}
			}
			//对子页面进行判断
			if("undefined"  !=  typeof(subWinIdArr_)  && subWinIdArr_.length>0){
				for(var i=0;i<subWinIdArr_.length;i++){
					//判断哪个正在展示
					if($("#"+subWinIdArr_[i]).is(":visible")){
						var dom = $(e.target);
						//判断是否为easyUI中的textbox控件
						if(dom.hasClass("textbox-text")){
							var valueDom = $("input[class*='textbox-value']",dom.parent());
							if(valueDom.size()>0){
								valueDom.val(dom.val());
							}
						}
						//查找窗口的查询按钮
						$("#"+subWinIdArr_[i]+" form td>a:visible").click();
					}
				}
			}
		}
	});
	//解决IE下console未定义的问题
	if (!window.console || !console.firebug){
	    var names = ["log", "debug", "info", "warn", "error", "assert", "dir", "dirxml", "group", "groupEnd", "time", "timeEnd", "count", "trace", "profile", "profileEnd"];
	 
	    window.console = {};
	    for (var i = 0; i < names.length; ++i)
	        window.console[names[i]] = function() {}
	}
});