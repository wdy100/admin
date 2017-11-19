<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>角色列表</title>
    <link rel="stylesheet" type="text/css" href="/resources/easyui-themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/resources/easyui-themes/icon.css">
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/js/easyui-lang-zh_CN.js"></script>
</head>
<body>
<div class="easyui-layout" data-options="fit : true,border : false">
    <div data-options="region:'north',title:'查询条件',border:false" style="height:200px;overflow: auto;" align="left">
        <form id="roleForm" action="/uploadReportFile.html" method="post">
            <table>
                <tr>
                    <td>角色名称</td>
                    <td>
                        <input id="name" name="name" class="easyui-textbox" style="width:100%;">
                    </td>
                    <td>角色描述</td>
                    <td>
                        <input id="description" name="description" class="easyui-textbox" style="width:100%;">
                    </td>
                </tr>
                <tr>
                    <td colspan="10">
                        <a id="searchPt" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                        <a id="add" href="#" class="easyui-linkbutton" iconCls="icon-add"  plain="false"  onclick="addRole()">新增</a>
                        <a id="update" href="#" class="easyui-linkbutton" iconCls="icon-edit"  plain="false"  onclick="updateRole()">修改</a>
                        <a id="delete" href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="false" onclick="delRole()">删除</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',title:'查询结果',border:false" style="left: 0px; top: 240px; width: 1920px;">
        <table id="dataGrid"></table>
    </div>
</div>
<script type="text/javascript">
var datagrid;
var queryParameters;

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
            url:'/system/findRoleList.html',
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
                    },
                    {
                        field: 'createdBy',
                        title: '创建者',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'createdAt',
                        title: '创建时间',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'updatedBy',
                        title: '最后修改人',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'updatedAt',
                        title: '最后更新时间',
                        width: 150,
                        align: 'center'
                    }
                ]
            ]
        });
    }
});

//角色新增
$("#add").click(function(){

});

//角色修改
$("#update").click(function(){

});

//角色删除
$("#delete").click(function(){

});

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
        url:'/system/findRoleList.html',
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
                },
                {
                    field: 'createdBy',
                    title: '创建者',
                    width: 150,
                    align: 'center'
                },
                {
                    field: 'createdAt',
                    title: '创建时间',
                    width: 150,
                    align: 'center'
                },
                {
                    field: 'updatedBy',
                    title: '最后修改人',
                    width: 150,
                    align: 'center'
                },
                {
                    field: 'updatedAt',
                    title: '最后更新时间',
                    width: 150,
                    align: 'center'
                }
            ]
        ]
    });
})
</script>
</body>