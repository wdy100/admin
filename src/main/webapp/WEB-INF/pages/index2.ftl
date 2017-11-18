<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>淼盾CRM客户管理系统</title>
<link href="assets/css/login_index.css"  rel="stylesheet" />
    <STYLE>
        .main_header{width:100%;height:64px;margin:0px;background:url("assets/images/login_bg.jpg") repeat-x;overflow: hidden;}
        .header_left{float:left;width:262px;height:100%;background:url("assets/images/loginlong.png");}
    </STYLE>

    <script type="text/javascript">
        $(function() {
            $('#mainMenu').tree({
                url : '/getMenu',
                parentField : 'pid',
                onClick : function(node) {
                    if (node.attributes.url) {
                        var src = node.attributes.url;
                        if (!$.startWith(node.attributes.url, '/')) {	//不是本项目的url，例如www.baidu.com
                            src = node.attributes.url;
                        }
                        var tabs = $('#mainTabs');
                        var opts = {
                            title : node.text,
                            closable : true,
                            iconCls : node.iconCls,
                            content : $.formatString('<iframe src="{0}" allowTransparency="true" style="border:0;width:99%;height:99%;padding-left:2px;" frameBorder="0"></iframe>', src),
                            border : false,
                            fit : true
                        };
                        if (tabs.tabs('exists', opts.title)) {
                            tabs.tabs('select', opts.title);
                        } else {
                            tabs.tabs('add', opts);
                        }
                    }
                }
            });
        })
    </script>
</head>
<body>
<#include "common/easyui_core.ftl"/>
<body class="easyui-layout">
<!-- 正上方panel -->
<div data-options="region:'north',border:false" style="height:60px;background:#46B43B;padding:0px">
    <!-- <div class="main_header" region="north" style="height:70px;padding:5px;" > -->
    <div class="header_left"></div>

    <div id="sessionInfoDiv" style="position: absolute;right: 5px;top:10px;">
        <strong></SPAN></strong>&nbsp;欢迎你！

    </div>

    <div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
        <div onclick="#">个人信息</div>
    </div>
    <div id="layout_north_zxMenu" style="width: 100px; display: none;">
        <div onclick="#">重新登录</div>
        <div class="menu-sep"></div>
        <div onclick="#">退出系统</div>
    </div>

</div>

<!-- 左侧菜单 -->
<div data-options="region:'west',href:''" title="导航菜单" style="width: 200px; padding: 0px;">
    <ul id="mainMenu"></ul>

</div>

<!-- 正中间panel -->
<!-- <div region="center" title="功能区" >   -->
<div region="center">
    <div class="easyui-tabs" id="mainTabs" fit="true" border="false">
        <div title="欢迎使用" style="padding:20px;">
            <div style="margin-top:20px; float:left;min-width:600px;widht: 600px; height: 90%; ">
                <h1 style="font-size:24px;">欢迎使用项目管理系统</h1>
            </div>
        </div>
    </div>
</div>

<!-- 正下方panel -->
<div region="south" style="height:24px;line-height:22px;" align="center">
    <label style="font-size:11px;">CRM-V5.0&nbsp;&nbsp;&nbsp;[&nbsp;gjf04@163.com&nbsp;]</label>
</div>
</body>
</html>