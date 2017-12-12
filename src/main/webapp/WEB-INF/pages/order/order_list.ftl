<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../common/easyui_core.ftl"/>
    <title>订单信息查询</title>
    <style type="text/css">

    </style>
</head>
<body >

<div id="layout" class="easyui-layout" fit="true">
    <div region="north" border="false" collapsible="true" collapsed="false"
         class="zoc" title="查询条件" style="height: 60px; overflow: inherit;">
        <form onsubmit="return false;" id="searchForm">
            <table class="fixedTb">
                <tr>
                    <td class="cxlabel">客户名称:</td>
                    <td class="cxinput"><input name="q_customerName" id="q_customerName" type="text" class="easyui-textbox" style="width:100px;"/></td>
                    <td class="cxlabel">
                        <a id="searchPt" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div id="tb" >

                <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-add" plain="false" >跟进反馈</a>

                <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" >预约安装时间</a>

                <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" >验收</a>


    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true,formatter : function(value, row, index) {return row.id;}"></th>
                <th data-options="field:'customerName',width:150,halign:'center',align:'left'">客户名称</th>
                <th data-options="field:'approvalStatus',width:100,halign:'center',align:'left',formatter:statusFormater">合同状态</th>
                <th data-options="field:'feedback',width:100,halign:'center',align:'center',formatter:feedbackFormater">反馈情况</th>
                <th data-options="field:'agreeSn',width:100,halign:'center',align:'center',formatter:agreeFormater">合同</th>
                <th data-options="field:'preInstallAt',width:100,halign:'center',align:'center'">预约安装时间</th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<script type="text/javascript">
    var datagrid;

    function loaddata(){
        $('#dg').datagrid('load',sy.serializeObject($("#searchForm").form()));
    }

    $(function(){
        datagrid = $('#dg').datagrid({
            title:'订单列表',
            toolbar:'#tb',
            singleSelect:true,
            fit:true,
            fitColumns:true,
            collapsible: true,
            rownumbers: true, //显示行数 1，2，3，4...
            pagination: true, //显示最下端的分页工具栏
            pagePosition : 'bottom',
            pageList: [5,10,15,20], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据
            pageSize: 20, //读取分页条数，即向后台读取数据时传过去的值
            url:'/order/orderList',
            nowrap : true,
            border : false
        });
    });

    var statusMap = {'1':'待内勤初审','0':'已保存待提交'};
    function statusFormater(val,row){
        return statusMap[val];
    }

    function feedbackFormater(val,row){
        return '<a href="#" >查看详情</a>';
    }

    function agreeFormater(val,row){
        return '<a href="#" >查看详情</a>';
    }

</script>
</body>
</html>
