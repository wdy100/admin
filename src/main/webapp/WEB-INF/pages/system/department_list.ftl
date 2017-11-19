<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>组织架构管理</title>
  <#include "../common/easyui_core.ftl"/>
  <link rel="stylesheet" href="${domainUrlUtil.staticURL}/style/manage_department.css">
  <link type="text/css" rel="stylesheet" href="${domainUrlUtil.staticURL}/style/loadMast.css" />
</head>
<body class="easyui-layout" fit="true">

<div data-options="region:'west'" title="组织架构" style="width:245px;">
  <ul id="tree" class="easyui-tree" data-options="
          url: '/system/departmentTree',
          animate: true,
          lines:true,
          onClick: treeOnClick"></ul>
</div>
<div data-options="region:'center'">
  <div class="easyui-layout" fit="true">
    <div data-options="region:'north',border:false,title:'查询条件'" style="height: 60px;" class="zoc">
      <form onsubmit="return false;" id="searchForm">
        <table class="fixedTb">
          <tr>
            <td class="cxlabel">部门名称:</td>
            <td class="cxinput">
              <input id="name" name="department.name" class="easyui-textbox" style="width:100%;">
            </td>
            <td class="cxlabel">
              <a href="#"  id = "searchPt"  class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
            </td>
            <td class="cxlabel"></td>
            <td class="cxinput"></td>
            <td class="cxlabel"></td>
            <td class="cxinput"></td>
            <td class="cxlabel"></td>
            <td class="cxinput"></td>
          </tr>
        </table>
      </form>
    </div>
    <div data-options="region:'center',border:false">
      <table id="dg">
        <thead>
        <tr>
          <th data-options="field:'ck',checkbox:true"></th>
          <th field="name" width="300" align="center">部门名称</th>
          <th field="code" width="200" align="center">部门编码</th>
        </tr>
        </thead>
      </table>
      <form method="post" id="fm" style="display: none;"></form>
      <div id="tb">
        <a href="#"  class="easyui-linkbutton" iconCls="icon-remove" plain="false" onclick="delDepartment()">删除</a>
        <a href="#"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="updateDepartment()">修改</a>
        <a href="#"  class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="createDepartment()">新增</a>

      </div>
    </div>
  </div>
</div>

<!-- 查看、新增、修改部门 -->
<div id="manageDepartmentDiv"  class="easyui-dialog" title=""   closed="true"
     data-options="resizable:true,modal:true" >


</div>

<script type="text/javascript">
  $(document).ready(function(){
    $(function(){
      $("#tree").tree({
        onLoadSuccess : function(node,data){
          var r = $("#tree").tree("getRoot");
          $("#tree").tree("expandAll",r.target);
        }
      });

      $('#dg').datagrid({
        title:'部门列表',
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
        queryParams : {
          'parentId' : '0'
        },
        url:'/system/departmentList',
        onDblClickRow : function(rowIndex,rowData){
          showFormWin(rowIndex,rowData);
        }

      });

    });

  });

  function showFormWin(rowIndex,rowData){
    $("#manageDepartmentDiv").dialog({
      title: '部门明细',
      width: 340,
      height: 350,
      top:80,
      closed: true,
      cache: false,
      modal: true,
      buttons:[]
    });
    //绑定数据列表
    $('#did').val(rowData.id);
    $('#dname').textbox("setValue",rowData.name);
    $('#dcode').textbox("setValue",rowData.code);
    $("#manageDepartmentDiv").dialog("open");
  }

  function treeOnClick(treeNode) {
    var node = $('#tree').tree("getSelected");
    var nodeTarget = treeNode.target;
    var isLeaf = $('#tree').tree('isLeaf',nodeTarget);
    $('#dg').datagrid('load',{
      'parentId' : node.id
    });
  }

  function formatDateTime(val,row){
    if(!val.time){
      return "";
    }
    var date = new Date(val.time);
    return defaultDateTimeFormatter(date);
  }

  function departmentDetailUrlFormatter(val,row){
    return "<a href='/system/updateDepartmentInit?department.id="+row.id+"'>"+val+"</a>";
  }

  var statusMap = {"1":'启用','0':'禁用'};

  function statusFormater(val,row){
    return statusMap[val];
  }

  var boolMap = {"1":'是','0':'否'};

  function boolFormater(val,row){
    return boolMap[val];
  }
  function loaddata(){
    $('#dg').datagrid('load',sy.serializeObject($("#searchForm").form()));
  }
  function delDepartment(){
    var row = $('#dg').datagrid('getSelected');
    if (!row){
      $.messager.alert('操作提示','请选择要删除的数据！','info');
      return;
    }

    $('#fm').form('submit',{
      url: '/system/deleteDepartment?id='+row.id,
      onSubmit: function(){
        var flag = $(this).form('validate');
        if(flag){
          //打开遮罩层
//               showLoadMast(window,"正在删除，请稍后...");
          $.messager.progress({
            text : "正在删除，请稍后...",
            interval : 100
          });
        }
        return flag;
      },
      success: function(result){
        //关闭遮罩层
//        		hideLoadMast(window);
        $.messager.progress('close');
        handleActionResult(result,{
          onSuccess:function(){
            $.messager.show({
              title : '提示',
              msg : '删除成功！'
            });
            $('#tree').tree('reload');
            var r = $("#tree").tree("getRoot");
            $("#tree").tree("expandAll",r.target);
            $('#parent_department_id').combotree("tree").tree("reload");
            $('#dg').datagrid('reload');//重新加载数据
          }
        });
      }
    });
  }

  function createDepartment(){
    $("#manageDepartmentDiv").dialog({
      title: '新增部门',
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
          submitManageDepartmentForm('/system/createDepartment',"保存");
        }
      },{
        text:'取消',
        iconCls:'icon-cancel',
        handler:function(){
          $('#manageDepartmentDiv').dialog('close');
        }
      }]
    });
    $('#did').val("");
    $('#dname').textbox("setValue","");
    $('#dcode').textbox("setValue","");
    $("#manageDepartmentDiv").dialog("open");
  }

  function updateDepartment(){
    $('#manageDepartmentForm').form('clear');
    var row = $('#dg').datagrid('getSelected');
    if (!row){
      $.messager.alert('操作提示','请选择要修改的数据！','info');
      return;
    }
    $("#manageDepartmentDiv").dialog({
      title: '修改部门',
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
    //$('#manageDepartmentForm').form('load', row);

  }
  function submitManageDepartmentForm(submitUrl,text){
    $('#manageDepartmentForm').form('submit',{
      url:submitUrl,
      onSubmit: function(){
        var flag = $(this).form('validate');
        if(flag){
          var type = $('#dtype').combobox("getValue");
          if(""==type){
            $.messager.alert('提示','请选择部门类别！','warning');
            return false;
          }

          //打开遮罩层
//              showLoadMast(window,"正在"+text+"，请稍后...");
          $.messager.progress({
            text : "正在"+text+"，请稍后...",
            interval : 100
          });
        }
        return flag;
      },
      success:function(result){
        //关闭遮罩层
// 	       	 hideLoadMast(window);
        $.messager.progress('close');
        handleActionResult(result,{
          onSuccess:function(){
            $.messager.show({
              title : '提示',
              msg : text+'成功！'
            });
            $('#manageDepartmentDiv').dialog('close');
            $('#tree').tree('reload');
            var r = $("#tree").tree("getRoot");
            $("#tree").tree("expandAll",r.target);
            $('#parent_department_id').combotree("tree").tree("reload");
            $('#dg').datagrid('reload');//重新加载数据
          }
        });
      }
    });
  }

  function initTree(){
    var value = $("#parent_department_id").val();
    expandTo(value);
  }
  function expandTo(value){
    var node = $('.tree').tree('find',value);
    $('.tree').tree('expandTo', node.target).tree('select', node.target);
  }
</script>
</body>
</html>

