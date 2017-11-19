<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<#include "../common/easyui_core.ftl"/>
	<title>用户查询</title>
</head>
<body>

<div class="easyui-layout" fit="true">
	<#--<div data-options="region:'west'" title="组织架构" style="width:245px;">-->
		<#--<ul id="tree" class="easyui-tree" data-options="-->
          		<#--url: '/system/departmentTree',-->
          		<#--animate: true,-->
          		<#--lines:true,-->
          		<#--onClick: treeOnClick"></ul>-->
	<#--</div>-->
	<div data-options="region:'center'">
		<div class="easyui-layout" fit="true">
			<div region="north" border="false" collapsible="true" collapsed="false"
				 class="zoc" title="查询条件" style="height: 60px; overflow: auto;">
				<form onsubmit="return false;" id="searchForm">
					<table class="fixedTb">
						<tr>
							<td class="cxlabel">姓名:</td>
							<td class="cxinput">
								<input name="nickName" class="easyui-textbox" style="width:100px;">
							</td>

							<td class="cxlabel">
									<a href="#"  id = "searchPt" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
							</td>
							<td class="cxlabel"></td>
							<td class="cxinput"></td>
						</tr>
					</table>
				</form>
			</div>
			<div region="center" border="false">
				<table id="dg">
					<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true,formatter : function(value, row, index) {return row.rowId;}"></th>
						<th data-options="field:'userName', halign : 'center' ,align : 'left', width:200">用户名</th>
						<th field="nickName"  halign="center"  align="left" width="200">真实姓名</th>
						<th field="mobile"  halign="center"  align="left"  width="360">手机号</th>
						<th field="email"  halign="center"  align="left"  width="360">邮箱</th>
						<th data-options="field:'status',align:'center',width:200,formatter:statusFormater">使用状态</th>
					</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="tb" >
		<a href="javascript:void(0)" id="morefunction" class="easyui-menubutton"  plain="false"
		   data-options="menu:'#functions',iconCls:'icon-task'">更多</a>
		<div id="functions" style="width:150px;">
			<div data-options="iconCls:'icon-redo'" onclick="resetUserPassword()">重置密码</div>
		</div>
        <a href="#" class="easyui-linkbutton" iconCls="icon-edit"  onclick="updateUser()">审核通过</a>
	</div>

	<div id="dlg" class="easyui-dialog" style="width:370px;height:200px;padding-top: 10px;"
		 closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post" novalidate >
			<table style="width:100%;">
                <input name="userId" id="reset_password_user_id" type="hidden"/>
				<tr style="height: 25px;">
					<td >&nbsp;&nbsp;新密码<font color="red">*</font>:</td>
					<td style="padding-right: 20px;">
						<input id="user_newPassword"  name="newPassword"  class="easyui-textbox" style="width:100%"
							   data-options="required:true,type:'password',missingMessage:'该输入项为必输项'"/>
					</td>
				</tr>
				<tr style="height: 25px;">
					<td >&nbsp;&nbsp;确认密码<font color="red">*</font>:</td>
					<td style="padding-right: 20px;">
						<input id="user_confirmPassword" name="confirmPassword"  class="easyui-textbox" style="width:100%"
							   data-options="required:true,type:'password',missingMessage:'该输入项为必输项'"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
</div>
<script type="text/javascript">

	function loaddata(){
		$('#dg').datagrid('load',sy.serializeObject($("#searchForm").form()));
	}
	function formatDateTime(val,row){
		if(!val.time){
			return "";
		}
		var date = new Date(val.time);
		return defaultDateTimeFormatter(date);
	}
	function formatDate(val,row){
		if(!val.time){
			return "";
		}
		var date = new Date(val.time);
		return defaultDateFormatter(date);
	}
	var statusMap = {'1':'启用','0':'待审核'};
	function statusFormater(val,row){
		return statusMap[val];
	}
	<#--function userDetailUrlFormatter(val,row){-->
		<#--return "<a href='${dynamicURL}/security/updateUserInit.action?user.id="+row.id+"'>"+val+"</a>";-->
	<#--}-->
	$(function(){
		$('#dg').datagrid({
			title:'用户查询',
			toolbar:'#tb',
			singleSelect:true,
			fit:true,
			fitColumns:true,
			collapsible: true,
			rownumbers: true, //显示行数 1，2，3，4...
			pagination: true, //显示最下端的分页工具栏
			pagePosition : 'bottom',
			pageList: [5,10,15,20], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据
			pageSize: 15, //读取分页条数，即向后台读取数据时传过去的值
			queryParams : {
				'departmentId' : '0'
			},
			url:'/system/userInfoList',
			nowrap : true,
			border : false
		});
	});
	//部门树点击事件
	function treeOnClick(treeNode) {
		var node = $('#tree').tree("getSelected");
		var nodeTarget = treeNode.target;
		var isLeaf = $('#tree').tree('isLeaf',nodeTarget);
		$("#departmentId").val(node.id);
		$('#dg').datagrid('load',sy.serializeObject($("#searchForm").form()));
//         	$('#dg').datagrid('load',{
//         		'departmentId' : node.id
//         	});
	}
	//双击看明细
	<#--function showFormWin(rowIndex,rowData){-->
		<#--var selectedRow = $('#dg').datagrid('getSelected');-->
		<#--parent.window.HROS.window.createTemp({-->
			<#--title : "查看明细",-->
			<#--url : '${dynamicURL}/security/viewUser.action?user.id='+selectedRow.id,-->
			<#--width : 800,-->
			<#--height : 400,-->
			<#--isresize : false,-->
			<#--isopenmax : true,-->
			<#--isflash : false,-->
			<#--customWindow : window-->
		<#--});-->
	<#--}-->

	//审核通过
	function updateUser(){
		var selectedRow = $('#dg').datagrid('getSelected');
		if(!selectedRow || selectedRow == null){
			$.messager.alert('操作提示','请选择要修改的数据！','info');
			return;
		}
		var userId = selectedRow.id;
        $.ajax({
            type:'post',
            url:'/system/updateUser',
            dataType : "json",
            data:{userId:userId},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');//重新加载数据
                $.messager.alert('提示',"操作成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

	}
	<#--function delUser(){-->
		<#--var selectedRow = $('#dg').datagrid('getSelected');-->
		<#--if(!selectedRow || selectedRow == null){-->
			<#--$.messager.alert('操作提示','请选择要删除的数据！','info');-->
			<#--return;-->
		<#--}-->
		<#--$.messager.confirm('删除用户确认', '确认要删除该用户吗？删除后用户数据将无法恢复。', function(r){-->
			<#--if (r){-->
				<#--$('#fm').form('submit',{-->
					<#--url: '${dynamicURL}/security/deleteUser.action?userId='+selectedRow.id,-->
					<#--onSubmit: function(){-->
						<#--$.messager.progress({-->
							<#--text : '正在删除，请稍后...',-->
							<#--interval : 100-->
						<#--});-->
						<#--return true;-->
					<#--},-->
					<#--success: function(result){-->
						<#--$.messager.progress('close');-->
						<#--handleActionResult(result,{-->
							<#--onSuccess:function(){-->
								<#--$('#dg').datagrid('reload');-->
								<#--$.messager.show({-->
									<#--title : '提示',-->
									<#--msg : '删除成功！'-->
								<#--});-->
							<#--}-->
						<#--});-->
					<#--}-->
				<#--});-->
			<#--}-->
		<#--});-->
	<#--}-->
	function resetUserPassword(){
		var row = $('#dg').datagrid('getSelected');
		if (row){
			$('#fm').form('clear');
			$('#dlg').dialog('open').dialog('setTitle','重置密码');
			$('#fm').form('load',row);
			$('#reset_password_user_id').val(row.id);
		}else{
			$.messager.alert('操作提示','请选择需要重置密码的用户！','info');
		}
	}
	function saveUser(){
        var userId = $('#reset_password_user_id').val();
        var newPassword = $('#user_newPassword').val();
        var confirmPassword = $('#user_confirmPassword').val();
        $.ajax({
            type:'post',
            url:'/system/resetPassword',
            dataType : "json",
            data:{userId:userId, newPassword:newPassword, confirmPassword:confirmPassword},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dlg').dialog('close');
                $.messager.alert('提示',"操作成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

	}
	<#--function doExport(){-->
		<#--$('#searchForm').form('submit',{-->
			<#--url: '${dynamicURL}/security/exportUserList.action',-->
			<#--onSubmit: function(){-->
				<#--return $(this).form('validate');-->
			<#--}-->
		<#--});-->
	<#--}-->
	function fillsize(percent){
		var bodyWidth = document.body.clientWidth;
		return (bodyWidth-90)*percent;
	}
</script>
</body>
</html>
