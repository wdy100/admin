<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="${staticURL}/hzscripts/enterSearch.js"></script>
	<title>用户查询</title>
</head>
<body>

<div class="easyui-layout" fit="true">
	<div data-options="region:'west'" title="组织架构" style="width:245px;">
		<ul id="tree" class="easyui-tree" data-options="
          		url: '${dynamicURL}/basic/departmentTree.action',
          		animate: true,
          		lines:true,
          		onClick: treeOnClick"></ul>
	</div>
	<div data-options="region:'center'">
		<div class="easyui-layout" fit="true">
			<div region="north" border="false" collapsible="true" collapsed="false"
				 class="zoc" title="查询条件" style="height: 60px; overflow: auto;">
				<form onsubmit="return false;" id="searchForm">
					<table class="fixedTb">
						<tr>
							<td class="cxlabel">登录名:</td>
							<td class="cxinput">
								<input id="departmentId" name="departmentId" type="hidden">
								<input name="user.name" class="easyui-textbox" style="width:100%;">
							</td>
							<td class="cxlabel">姓名:</td>
							<td class="cxinput">
								<input name="user.nickName" class="easyui-textbox" style="width:100%;">
							</td>
							<td class="cxlabel">邮箱:</td>
							<td class="cxinput">
								<input name="user.email" class="easyui-textbox" style="width:100%;">
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
						<th data-options="field:'name', halign : 'center' ,align : 'left', width:200">用户编码</th>
						<th field="nickName"  halign="center"  align="left" width="200">用户姓名</th>
						<th field="userDepName"  halign="center"  align="left"  width="360">所属部门</th>
						<th field="userRoleName"  halign="center"  align="left"  width="360">所属岗位</th>
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
			<div data-options="iconCls:'icon-excel'" onclick="doExport()">导出</div>
			<div data-options="iconCls:'icon-redo'" onclick="resetUserPassword()">重置密码</div>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove"  onclick="delUser()">删除</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit"  onclick="updateUser()">修改</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-add"  onclick="addUser()">新增</a>
		</div>
	</div>

	<div id="dlg" class="easyui-dialog" style="width:370px;height:200px;padding-top: 10px;"
		 closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post" novalidate >
			<table style="width:100%;">
				<tr style="height: 25px;">
					<td width="30%">&nbsp;&nbsp;登录名:</td>
					<td width="70%" style="padding-right: 20px;">
						<input name="userId" id="reset_password_user_id" type="hidden"/>
						<input id="user_name" name="name"  class="easyui-textbox" style="width:100%"
							   data-options="editable:false,iconCls:'icon-lock'"/>
					</td>
				</tr>
				<tr style="height: 25px;">
					<td >&nbsp;&nbsp;姓名:</td>
					<td style="padding-right: 20px;">
						<input id="user_nickName" name="nickName"  class="easyui-textbox" style="width:100%"
							   data-options="editable:false,iconCls:'icon-lock'"/>
					</td>
				</tr>
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
	var statusMap = {'1':'启用','0':'禁用'};
	function statusFormater(val,row){
		return statusMap[val];
	}
	function userDetailUrlFormatter(val,row){
		return "<a href='${dynamicURL}/security/updateUserInit.action?user.id="+row.id+"'>"+val+"</a>";
	}
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
			url:'${dynamicURL}/security/searchUser.action',
			nowrap : true,
			border : false,
			onDblClickRow : function(rowIndex,rowData){
				showFormWin(rowIndex,rowData);
			}
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
	function showFormWin(rowIndex,rowData){
		var selectedRow = $('#dg').datagrid('getSelected');
		parent.window.HROS.window.createTemp({
			title : "查看明细",
			url : '${dynamicURL}/security/viewUser.action?user.id='+selectedRow.id,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false,
			customWindow : window
		});
	}
	//新增用户
	function addUser(){
		parent.window.HROS.window.createTemp({
			title : "人员信息-新增",
			url : '${dynamicURL}/security/createUserInit.action',
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false,
			customWindow : window
		});
	}
	//修改用户
	function updateUser(){
		var selectedRow = $('#dg').datagrid('getSelected');
		if(!selectedRow || selectedRow == null){
			$.messager.alert('操作提示','请选择要修改的数据！','info');
			return;
		}
		parent.window.HROS.window.createTemp({
			title : "人员信息-修改",
			url : '${dynamicURL}/security/updateUserInit.action?user.id='+selectedRow.id,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false,
			customWindow : window
		});
	}
	function delUser(){
		var selectedRow = $('#dg').datagrid('getSelected');
		if(!selectedRow || selectedRow == null){
			$.messager.alert('操作提示','请选择要删除的数据！','info');
			return;
		}
		$.messager.confirm('删除用户确认', '确认要删除该用户吗？删除后用户数据将无法恢复。', function(r){
			if (r){
				$('#fm').form('submit',{
					url: '${dynamicURL}/security/deleteUser.action?userId='+selectedRow.id,
					onSubmit: function(){
						$.messager.progress({
							text : '正在删除，请稍后...',
							interval : 100
						});
						return true;
					},
					success: function(result){
						$.messager.progress('close');
						handleActionResult(result,{
							onSuccess:function(){
								$('#dg').datagrid('reload');
								$.messager.show({
									title : '提示',
									msg : '删除成功！'
								});
							}
						});
					}
				});
			}
		});
	}
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
		$('#fm').form('submit',{
			url: '${dynamicURL}/security/resetPassword.action',
			onSubmit: function(){
				var flag = $(this).form('validate');
				if(flag){
					$.messager.progress({
						text : '正在重置，请稍后...',
						interval : 100
					});
				}
				return flag;
			},
			success: function(result){
				$.messager.progress('close');
				handleActionResult(result,{
					onSuccess:function(){
						$('#dlg').dialog('close');        // close the dialog
						$.messager.show({
							title : '提示',
							msg : '重置成功！'
						});
					}
				});
			}
		});
	}
	function doExport(){
		$('#searchForm').form('submit',{
			url: '${dynamicURL}/security/exportUserList.action',
			onSubmit: function(){
				return $(this).form('validate');
			}
		});
	}
	function fillsize(percent){
		var bodyWidth = document.body.clientWidth;
		return (bodyWidth-90)*percent;
	}
</script>
</body>
</html>
