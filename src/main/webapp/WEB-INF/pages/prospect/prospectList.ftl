<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../common/easyui_core.ftl"/>
    <title>勘查反馈</title>
    <style type="text/css">

    </style>
</head>
<body >

<div id="layout" class="easyui-layout" fit="true">
    <div region="north" border="false" collapsible="true" collapsed="false"
         class="zoc" title="查询条件" style="height: 60px; overflow: inherit;">
        <form onsubmit="return false;" action="" id="searchForm" enctype="multipart/form-data" method="post">
            <table class="fixedTb">
                <tr>
                    <td class="cxlabel">客户名称:</td>
                    <td class="cxinput"><input name="customerName" type="text" class="easyui-textbox" style="width:100px;"/></td>
                    <td class="cxlabel">客户状态:</td>
                    <td class="cxinput">
                        <input class="easyui-combobox" name="customerStatus" style="width:100px;" data-options="
	       								valueField: 'value',textField: 'text',panelHeight:'auto',editable:false,value:'',
										data: [{value: '',text: '所有'},
												{value: '0',text: '待接收'},
										       {value: '1',text: '勘查中'},
												{value: '2',text: '已勘查'},
												{value: '3',text: '待安装'},
												{value: '4',text: '待验收'},
												{value: '5',text: '已验收'}
												]" />
                    </td>
                    <td class="cxlabel">勘查状态</td>
                    <td class="cxinput">
                        <input class="easyui-combobox" name="prospectStatus" style="width:100px;" data-options="
	       								valueField: 'value',textField: 'text',panelHeight:'auto',editable:false,value:'',
										data: [{value: '',text: '所有'},
												{value: '0',text: '未派单'},
										       {value: '1',text: '勘查中'},
												{value: '2',text: '勘查完成'},
												{value: '3',text: '勘查数据待上传'},
												{value: '4',text: '勘查报告待生成'}
												]" />
                    </td>
                    <td class="cxlabel">
                        <a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                        <a href="#"  class="easyui-linkbutton" iconCls="icon-edit" plain="false">勘查模板下载</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div id="tb" >
        <form action="/prospect/uploadReportFile.html" id="uploadForm" enctype="multipart/form-data" method="post">
            <a href="javascript:void(0)"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="uploadData()">勘查数据上传</a>
            <input type="file" name="file" id="file"/>
            <input type="hidden" nam="id" id="id"/>
        </form>
    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true,formatter : function(value, row, index) {return row.id;}"></th>
                <th data-options="field:'customerName',width:150,halign:'center',align:'left'">客户名称</th>
                <th data-options="field:'customerAddress',width:300,halign:'center',align:'left'">客户地址</th>
                <th data-options="field:'name',width:150,halign:'center',align:'left'">联系人</th>
                <th data-options="field:'mobile',width:150,halign:'center',align:'left'">联系电话</th>
                <th data-options="field:'prospectTime',width:250,halign:'center',align:'left'">勘查时间</th>
                <th data-options="field:'prospectContent',width:300,halign:'center',align:'left'">勘查内容</th>
                <th data-options="field:'prospectRequire',width:300,halign:'center',align:'left'">勘查要求</th>
                <th data-options="field:'prospectName',width:150,halign:'center',align:'left'">勘查人员</th>
                <th data-options="field:'prospectStatus',width:150,halign:'center',align:'left',
						formatter:function(value,row,index){
                            if(value == '0') return '待接收';
                            if(value == '1') return '勘查中';
                            if(value == '2') return '已勘查';
                            if(value == '3') return '待安装';
                            if(value == '4') return '待验收';
                            if(value == '5') return '已验收';
                            return '';
                        }">勘查状态</th>
                <th data-options="field:'customerStatus',width:150,halign:'center',align:'left',
                        formatter:function(value,rowData,rowIndex){
                            if(value == '0') return '未派单';
                            if(value == '1') return '勘查中';
                            if(value == '2') return '勘查完成';
                            if(value == '3') return '勘查数据待上传';
                            if(value == '4') return '勘查报告待生成';
                            return '';
                        }">客户状态</th>
                <th data-options="field:'submitName',width:100,halign:'center',align:'left'">下单人员</th>
                <th data-options="field:'submitTime',width:250,halign:'center',align:'left'">下单日期</th>
            </tr>
            </thead>
        </table>
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
        return simpleDateTimeFormatter(date);
    }

    //勘查数据上传
    function uploadData() {
        var rows = $('#dg').datagrid('getSelected');
        if(rows) {
            if(rows.prospectStatus != 1){
                $.messager.alert('错误','请先选择一条状态为勘察中的勘查记录！','error');
                return;
            }
            if(!$("#file").val()) {
                $.messager.alert('错误','请先选择上传文件！','error');
                return;
            }
            $("#id").val(rows.id);
            $("#uploadForm").submit();
        }else{
            $.messager.alert('操作提示', '请先选择一条状态为勘察中的勘查记录！', 'info');
            return;
        }
    }

    $(function(){
        $('#dg').datagrid({
            title:'勘查反馈列表',
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
            url:'/prospect/findProspectList.html',
            nowrap : true,
            border : false
        });
    });
</script>
</body>
</html>
