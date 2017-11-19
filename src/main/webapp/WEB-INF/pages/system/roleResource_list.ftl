<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>权限列表</title>
    <#include "../common/easyui_core.ftl"/>
</head>
<body>
<div class="easyui-layout" data-options="fit : true,border : false">
    <div data-options="region:'north',title:'查询条件',border:false" style="height:100px;overflow: auto;" align="left">
        <form id="roleForm" action="/uploadReportFile.html" method="post">
            <table>
                <tr>
                    <td>角色名称</td>
                    <td>
                        <input id="name" name="name" class="easyui-textbox" style="width:100%;width:100px;">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <a id="searchPt" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                        <a id="updateRole" href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="updateRole()">授权</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',title:'查询结果',border:false" style="left: 0px; top: 240px; width: 1920px;">
        <table id="dataGrid"></table>
    </div>
</div>

<!-- 查看、新增、修改部门 -->
<div id="manageDepartmentDiv"  class="easyui-dialog" title=""   closed="true"
     data-options="resizable:true,modal:true" >
    <table style="font-weight: 400;" border="0">
        <tr>
            <td style="text-align: right;">部门名称<span class="star">*</span>:</td>
            <td>
                <input id="dname" name="name" size="54" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width: 200px;"/></td>
        </tr>

        <tr>
            <td style="text-align: right;">上级部门<span class="star">*</span>:</td>
            <td>
            <input id="cc" value="01">
            <select id="cc" class="easyui-combotree" style="width:200px;"
			    data-options="url:'get_data.php',required:true">
			</select>
                <input size="54" name="parentId" id="parent_department_id"  style="width: 200px;" class="easyui-combotree"data-options="
						url: '/system/departmentTree',
						animate: true,required:true"/>
            </td>
        </tr>


    </table>

</div>
<ul id="tt">
li>
		<span>Folder</span>
		<ul>
			<li>
				<span>Sub Folder 1</span>
				<ul>
					<li><span><a href="#">File 11</a></span></li>
					<li><span>File 12</span></li>
					<li><span>File 13</span></li>
				</ul>
			</li>
			<li><span>File 2</span></li>
			<li><span>File 3</span></li>
		</ul>
	</li>
    <li><span>File21</span></li></ul>
<script type="text/javascript">
var datagrid;
var queryParameters;


$('#cc').combotree({
    url: 'get_data.php',
    required: true
});

//角色查询
$('#searchPt').click(function () {
    queryParameters = {
        name:$("#name").val(),
        description:$("#description").val()
    };
    if(datagrid){
        //grid加载
        $('#dataGrid').datagrid('load',queryParameters);
    }else{
        datagrid = $('#dataGrid').datagrid({
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
            url:'/system/roleResourceList.html',
            queryParams:queryParameters,
            columns: [
                [
                    {
                        field: 'id',
                        title: '编号',
                        width: 10,
                        align: 'center',
                        hidden:true
                    },
                    {
                        field: 'checked',
                        width: 10,
                        align: 'center',
                        checkbox:true
                    },
                    {
                        field: 'name',
                        title: '角色名称',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'description',
                        title: '角色描述',
                        width: 200,
                        align: 'center'
                    }
                ]
            ]
        });
    }
});


//修改
function updateRole(){
	    var row = $('#dataGrid').datagrid('getSelected');
	    if (!row){
	      $.messager.alert('操作提示','请选择要授权的数据！','info');
	      return;
	    }
	    $("#manageDepartmentDiv").dialog({
	      title: '授权',
	      width: 340,
	      height: 350,
	      top: 50,
	      closed: true,
	      cache: false,
	      modal: true,
	      buttons:[{
	        text:'保存',
	        iconCls:'icon-ok',
	        handler:function(){
	          submitManageDepartmentForm('/system/updateDepartment',"更新");
	        }
	      },{
	        text:'取消',
	        iconCls:'icon-cancel',
	        handler:function(){
	          $('#manageDepartmentDiv').dialog('close');
	        }
	      }]
	    });
	    //绑定数据列表
	    $('#did').val(row.id);
	    $('#dname').textbox("setValue",row.name);
	    $('#dcode').textbox("setValue",row.code);
	    $("#manageDepartmentDiv").dialog("open");
};

//


$(function(){
    datagrid = $('#dataGrid').datagrid({
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
        url:'/system/roleResourceList.html',
        queryParams:queryParameters,
        columns: [
            [
                {
                    field: 'id',
                    title: '编号',
                    width: 10,
                    align: 'center',
                    hidden:true
                },
                {
                    field: 'checked',
                    width: 10,
                    align: 'center',
                    checkbox:true
                },
                {
                    field: 'name',
                    title: '角色名称',
                    width: 150,
                    align: 'center'
                },
                {
                    field: 'description',
                    title: '角色描述',
                    width: 200,
                    align: 'center'
                }
            ]
        ]
    });
})
</script>
</body>