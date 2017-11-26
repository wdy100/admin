<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>合同列表</title>
<#include "../common/easyui_core.ftl"/>
</head>
<body>
<div class="easyui-layout" data-options="fit : true,border : false">
    <div data-options="region:'north',title:'查询条件',border:false" style="height:120px;" class="zoc">
        <form id="roleForm" action="/uploadReportFile.html" method="post">
            <table class="fixedTb">
                <tr>
                    <td class="cxlabel">客户名称:</td>
                    <td class="cxinput">
                        <input id="q_firstParty" name="q_firstParty" class="easyui-textbox" style="width:100px;">
                    </td>
                    
                    <td class="cxlabel">合同状态:</td>
                    <td class="cxinput">
                        <select id="q_approvalStatus" name="q_approvalStatus" class="" style="width:100px" panelHeight="auto" >
	                        <option value="">--全部--</option>
	                        <option value="0" >待提交</option>
	                        <option value="1" >待内勤初审</option>
	                        <option value="2" >待总监审核</option>
	                        <option value="3" >待合同上传</option>
	                        <option value="4" >待签订完成</option>
	                    </select>
                    </td>
                    
                    </tr>
                    <tr>
                    
                    <td class="cxlabel">签订日期:</td>
                    <td class="cxinput">
                    	<input type="text" id="q_agreeDate" name="q_agreeDate" class="Wdate {required:true}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;"/>
                    </td>
                    
                    </tr>
                  </table>
                     
                    <td class="cxlabel">
                        <a href="#"  id = "searchPt"  class="easyui-linkbutton" iconCls="icon-search">查询</a>
                        <a id="add" href="#" class="easyui-linkbutton" iconCls="icon-add"  plain="false" >新增</a>
                        <a id="update" href="#" class="easyui-linkbutton" iconCls="icon-edit"  plain="false"  onclick="updateRole()">修改</a>
                        <a id="delete" href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="false" onclick="delRole()">删除</a>
                    </td>

           

        </form>
    </div>
    <div data-options="region:'center',title:'查询结果',border:false" style="left: 0px; top: 240px; width: 1920px;">
        <table id="dataGrid"></table>
    </div>
</div>

<div id="roleInputInfo" style="padding:10px;display:none;" title="新增角色">
    ##    <div id="w" class="easyui-dialog" title="" data-options="modal:true,closed:true,iconCls:'icon-save'" style="padding:10px;">
    <table>
        <tr>
            <td>客户名称</td>
            <td><input id="code_edit" type="text"/></td>
        </tr>
        <tr>
            <td>合同状态</td>
            <td><input id="name_edit" type="text"/></td>
        </tr>
        <tr>
            <td>合同签订日期</td>
            <td><input id="description_edit" type="text"/></td>
        </tr>
        <tr>
            <td>创建者</td>
            <td><input id="createdBy_edit" type="text"/></td>
        </tr>
    </table>
    </br>
    <div style="text-align:center"><input id="saveBtn" type="button" value="保存" class="l-btn" style=" font-size: 12px;line-height: 24px; width: 52px; font-family: 微软雅黑"/>
    </div>
    ##    </div>
</div>

<script type="text/javascript">
var datagrid;
var queryParameters;

// 判断是否为空
$.isNotBlank = function(value) {
    if (value != undefined && value != "undefined" && value != null && value != "null" && value != "") {
        return true;
    }
    return false;
};

//查询
$('#searchPt').click(function () {
    //grid加载
    $('#dataGrid').datagrid('load',queryParamsHandler());
});

//角色新增
$("#add").click(function(){
    $("#name_edit").val("");
    $("#description_edit").val("");
    $("#createdBy_edit").val("");

    $("#roleInputInfo").show();
    $("#roleInputInfo").dialog({
        collapsible: true,
        minimizable: false,
        maximizable: false,
        height:270,
        width:350
    });
});

//新增提交
$("#saveBtn").click(function(){
    if(!$.isNotBlank($("#code_edit").val())){
        $.messager.alert("提示","请填写角色编码","info")
        return false;
    }
    if(!$.isNotBlank($("#name_edit").val())){
        $.messager.alert("提示","请填写角色名称","info")
        return false;
    }
    if(!$.isNotBlank($("#description_edit").val())){
        $.messager.alert("提示","请填写角色描述","info")
        return false;
    }
    if(!$.isNotBlank($("#createdBy_edit").val())){
        $.messager.alert("提示","请填写创建人","info")
        return false;
    }
    $.messager.progress({text:"提交中..."});
    jQuery.ajax({
        url: "/system/saveRole.html",
        data:{
            "code": $("#code_edit").val(),
            "name": $("#name_edit").val(),
            "description": $("#description_edit").val(),
            "createdBy": $("#createdBy_edit").val()
        },
        type: "GET",
        success: function(result) {
            $.messager.progress('close');
            if(result.success == true){
                $('#dataGrid').datagrid('reload');
                $("#roleInputInfo").dialog("close");
            }else
                $.messager.alert('错误', result.message, 'error');
        },
        fail: function(data) {
            $.messager.progress('close');
            $.messager.alert('错误',"保存信息出错,请联系管理员！");
        }
    });
});

function approvalStatusFormatter(value, row, index){
	//审批状态。0已保存待提交 1待内勤初审 2总监审核 3合同上传 4签订完成
	var result = "";
	if(value==0){
		result = '已保存待提交';
	}else if(value==1){
		result = '待内勤初审';
	}else if(value==2){
		result = '待总监审核';
	}else if(value==3){
		result = '待合同上传';
	}else if(value==4){
		result = '待签订完成';
	}
	return result;
}

$(function(){
    datagrid = $('#dataGrid').datagrid({
        title:'合同信息列表',
        toolbar:'#tb',
        singleSelect:true,
        fitColumns: false,
        fit: true,
        collapsible: true,
        rownumbers: true, //显示行数 1，2，3，4...
        pagination: true, //显示最下端的分页工具栏
        pageList: [5,10,15,20], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据
        pageSize: 20, //读取分页条数，即向后台读取数据时传过去的值
        url:'/agreementInfo/agreementList',
        queryParams: queryParamsHandler(),
        columns: [
            [
                {
                    field: 'id',
                    width: 10,
                    align: 'center',
                    hidden:true
                },{
                    field: 'checked',
                    width: 10,
                    align: 'center',
                    checkbox:true
                },{
                    field: 'agreeSn',
                    title: '合同编号',
                    width: 70,
                    align: 'center'
                },
                {
                    field: 'firstParty',
                    title: '客户名称',
                    width: 150,
                    align: 'center'
                },{
                    field: 'agreementAmount',
                    title: '合同金额',
                    width: 70,
                    align: 'center'
                },{
                    field: 'approvalStatus',
                    title: '合同状态',
                    width: 100,
                    align: 'center',
                    formatter: approvalStatusFormatter
                },{
                    field: 'agreeDate',
                    title: '合同签订时间',
                    width: 120,
                    align: 'center'
                },
                {
                    field: 'createdBy',
                    title: '合同详情',
                    width: 70,
                    align: 'center',
                    formatter: function(value, row, index){
                    	var result = '<a href="#" onclick="doEdit(\'' + row.id + '\' )">详情</a> ';
                    	return result;
                    }
                }
            ]
        ]
    });
})
</script>
</body>