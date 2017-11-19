<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="${staticURL}/hzscripts/enterSearch.js"></script>
	<title>角色列表</title>
</head>
<body>

<div class="easyui-layout" fit="true">
	<div region="north" border="false" collapsible="true" collapsed="false"
		 class="zoc" title="查询条件" style="height: 60px; overflow: auto;">
		<form onsubmit="return false;" id="searchForm">
			<table class="fixedTb">
				<tr>
					<td class="cxlabel">角色名称:</td>
					<td class="cxinput"><input name="role.name" class="easyui-textbox" style="width:100%;"></td>
					<td class="cxlabel">角色描述:</td>
					<td class="cxinput"><input name="role.description" class="easyui-textbox" style="width:100%;"></td>
					<td class="cxlabel">
						<a href="#"  id = "searchPt"  class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
					</td>
					<td class="cxlabel"></td>
					<td class="cxinput"></td>
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
				<th data-options="field:'ck',checkbox:true"></th>
				<!-- 	            	<th data-options="field:'name',formatter:roleDetailUrlFormatter,width:300">角色名称</th> -->
				<th data-options="field:'name',width:300">角色名称</th>
				<th field="description" width="400" align="center">角色描述</th>
				<th data-options="field:'createName',width:200,align:'center'">创建者</th>
				<th data-options="field:'create',width:300,align:'center',formatter:formatDateTime">创建时间</th>
				<th data-options="field:'updateNmae',width:200,align:'center'">最后修改人</th>
				<th data-options="field:'update',width:300,align:'center',formatter:formatDateTime">最后更新时间</th>
			</tr>
			</thead>
		</table>
		<div id="tb" >
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="false" onclick="delRole()">删除</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit"  plain="false"  onclick="updateRole()">修改</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-add"  plain="false"  onclick="addRole()">新增</a>

		</div>
		<form method="post" id="fm" style="display: none;"></form>
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
	function roleDetailUrlFormatter(val,row){
		return "<a href='${dynamicURL}/security/updateRoleInit.action?roleId="+row.id+"'>"+val+"</a>";
	}
	$(function(){
		$('#dg').datagrid({
			title:'角色列表',
			toolbar:'#tb',
			singleSelect:true,
			fitColumns:true,
			fit:true,
			collapsible: true,
			rownumbers: true, //显示行数 1，2，3，4...
			pagination: true, //显示最下端的分页工具栏
			pageList: [5,10,15,20], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据
			pageSize: 20, //读取分页条数，即向后台读取数据时传过去的值
			url:'${dynamicURL}/security/searchRole.action',
		});
	});

	//新增角色
	function addRole(){
		parent.window.HROS.window.createTemp({
			title : "新增角色",
			url : '${dynamicURL}/security/createRoleInit.action',
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false,
			customWindow : window
		});
	}
	//修改角色
	function updateRole(){
		var selectedRow = $('#dg').datagrid('getSelected');
		if(!selectedRow || selectedRow == null){
			$.messager.alert('操作提示','请选择要修改的数据！','info');
			return;
		}
		parent.window.HROS.window.createTemp({
			title : "修改角色",
			url : '${dynamicURL}/security/updateRoleInit.action?roleId='+selectedRow.id,
			width : 800,
			height : 400,
			isresize : false,
			isopenmax : true,
			isflash : false,
			customWindow : window
		});
	}

	function delRole(){
		var row = $('#dg').datagrid('getSelected');
		if (!row){
			$.messager.alert('操作提示','请选择要删除的数据！','info');
			return;
		}

		$('#fm').form('submit',{
			url: '${dynamicURL}/security/deleteRole.action?roleId='+row.id,
			onSubmit: function(){
				var flag = $(this).form('validate');
				if(flag){
					$.messager.progress({
						text : '正在删除，请稍后...',
						interval : 100
					});
				}
				return flag;
			},
			success: function(result){
				$.messager.progress('close');
				handleActionResult(result,{
					onSuccess:function(){
						$.messager.show({
							title : '提示',
							msg : '删除成功！'
						});
						$('#dg').datagrid('reload');//重新加载数据
					}
				});
			}
		});
	}
</script>
</body>
</html>
