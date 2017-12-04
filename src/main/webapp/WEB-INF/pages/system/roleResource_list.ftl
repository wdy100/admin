<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>权限列表</title>
    <#include "../common/easyui_core.ftl"/>
    <link type="text/css" rel="stylesheet" href="${domainUrlUtil.staticURL}/style/loadMast.css" />
</head>
<body>
<div class="easyui-layout" data-options="fit : true,border : false">
    <div data-options="region:'north',title:'查询条件',border:false" style="height: 60px;" class="zoc">
        <form onsubmit="return false;" id="searchForm">
            <table class="fixedTb">
                <tr>
                    <td class="cxlabel">角色名称:</td>
                    <td class="cxinput">
                        <input id="name" name="name" class="easyui-textbox" style="width:100px;">
                    </td>
                    <td class="cxlabel">
                        <a href="#"  id = "searchPt"  class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                    </td>

                </tr>
            </table>

        </form>
    </div>

    <div id="tb" >
        <a id="update" href="#" class="easyui-linkbutton" iconCls="icon-edit"  plain="false"  >设置权限</a>

    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true,formatter : function(value, row, index) {return row.id;}"></th>
                <th data-options="field:'name',width:150,halign:'center',align:'center'">角色名称</th>
                <th data-options="field:'description',width:200,halign:'center',align:'center'">角色描述</th>
                <th data-options="field:'createdBy',width:150,halign:'center',align:'center'">创建者</th>
                <th data-options="field:'createdAt',width:150,halign:'center',align:'center'">创建时间</th>
                <th data-options="field:'updatedBy',width:150,halign:'center',align:'center'">最后修改人</th>
                <th data-options="field:'updatedAt',width:150,halign:'center',align:'center'">最后更新时间</th>
            </tr>
            </thead>
        </table>
    </div>

</div>

<div id="roleInputInfo" style="padding:10px;display:none;" title="设置角色权限">
    <table>
        <tr>
            <td>角色名称</td>
            <td><input id="name_edit" type="text"/></td>
        </tr>
        <tr>
            <td>角色描述</td>
            <td><input id="description_edit" type="text"/></td>
        </tr>
        <tr>
            <td>角色权限</td>
            <td>
                <select style="width:174px;" name="resourceIds" id="resourceIds" multiple  class="easyui-combotree"
                        data-options="
							url: '/system/allModuleResourceTree',
							animate: true,
							checkbox:true">
                </select>
            </td>
        </tr>
    </table>
    </br>
    <div style="text-align:center"><input id="saveBtn" type="button" value="保存" class="l-btn" style=" font-size: 12px;line-height: 24px; width: 52px; font-family: 微软雅黑"/>
    </div>
</div>

<script type="text/javascript">
    function loaddata(){
        $('#dg').datagrid('load',sy.serializeObject($("#searchForm").form()));
    }

    $(document).ready(function(){
        $(function(){
            $('#dg').datagrid({
                title:'角色列表',
                toolbar:'#tb',
                border:false,
                singleSelect:true,//单选模式，只能选择一条记录
                fit:true,//自适应父容器下
                fitColumns:true,//列长度自适应，不出现横向动作条
                collapsible: true,//可折叠
                rownumbers: true, //显示行数 1，2，3，4...
                pagination: true, //显示最下端的分页工具栏
                pageList: [5,10,15,20], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据
                pageSize: 15, //读取分页条数，即向后台读取数据时传过去的值
                url:'/system/roleList'

            });

        });

    });

    //设置角色权限
    $("#update").click(function(){
        var rows = $('#dg').datagrid('getSelections');
        if(rows.length == 1) {
            $("#name_edit").val(rows[0].name);
            $("#description_edit").val(rows[0].description);
        }else{
            $.messager.alert('操作提示', '请选择要分配权限的角色！', 'info');
            return;
        }

        $("#roleInputInfo").show();
        $("#roleInputInfo").dialog({
            collapsible: true,
            minimizable: false,
            maximizable: false,
            height:230,
            width:300
        });
    });

    //设置角色权限提交
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
        $.messager.progress({text:"提交中..."});
        jQuery.ajax({
            url: "/system/saveRole",
            data:{
                "code": $("#code_edit").val(),
                "name": $("#name_edit").val(),
                "description": $("#description_edit").val()
            },
            type: "POST",
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

</script>
</body>