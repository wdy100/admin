<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>勘查反馈</title>
    <link rel="stylesheet" type="text/css" href="/resources/easyui-themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/resources/easyui-themes/icon.css">
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/js/easyui-lang-zh_CN.js"></script>
</head>
<body>
<div class="easyui-layout" data-options="fit : true,border : false">
    <div data-options="region:'north',title:'查询条件',border:false" style="height:200px;overflow: auto;" align="left">
        <form id="prospectForm" action="/uploadReportFile.html" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <td>客户名称</td>
                    <td>
                        <input id="customerName" class="txt" name="customerName">
                    </td>
                    <td>客户状态</td>
                    <td>
                        <input class="easyui-combobox" id="customerStatus"  name="customerStatus"  data-options="
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
                    <td>勘查状态</td>
                    <td>
                        <input class="easyui-combobox" id="prospectStatus"  name="prospectStatus"  data-options="
	       								valueField: 'value',textField: 'text',panelHeight:'auto',editable:false,value:'',
										data: [{value: '',text: '所有'},
												{value: '0',text: '未派单'},
										       {value: '1',text: '勘查中'},
												{value: '2',text: '勘查完成'},
												{value: '3',text: '勘查数据待上传'},
												{value: '4',text: '勘查报告待生成'}
												]" />
                    </td>
                </tr>
                <tr>
                    <td colspan="10">
                        <a id='search' href="#" class="easyui-linkbutton" iconCls="icon-search">查询</a>
                        <a id='download' href="#" class="easyui-linkbutton">勘查模板下载</a>
                        <#--<a id='upload' href="#" class="easyui-linkbutton">勘查数据上传</a>-->
                        <input type="file" name="file" /><input id='upload' type="submit" value="勘查数据上传"/>
                        <input type="hidden" id="id"/>
                        <a id='clean' href="#" class="easyui-linkbutton" iconCls="icon-remove">清空</a>
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

// 判断是否为空
$.isNotBlank = function(value) {
    if (value != undefined && value != "undefined" && value != null && value != "null" && value != "") {
        return true;
    }
    return false;
};

//发票邮寄列表查询
$('#search').click(function () {
    queryParameters = {
        customerName:$("#customerName").val(),
        customerStatus:$("#customerStatus").combobox("getValue"),
        prospectStatus:$("#prospectStatus").combobox("getValue")
    };
    if(datagrid){
        //grid加载
        $('#dataGrid').datagrid('load',queryParameters);
    }else{
        datagrid = $('#dataGrid').datagrid({
            url: "/prospect/findProspectList.html",
            method:'GET',
            fit: true,
            pagination: true,
            singleSelect: false,
            checkOnSelect:true,
            pageSize: 20,
            pageList: [100,200,300],
            nowrap: true,
            rownumbers: true,
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
                        field: 'customerName',
                        title: '客户名称',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'customerAddress',
                        title: '客户地址',
                        width: 200,
                        align: 'center'
                    },
                    {
                        field: 'name',
                        title: '联系人',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'mobile',
                        title: '联系电话',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'prospectTime',
                        title: '勘查时间',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'prospectContent',
                        title: '勘查内容',
                        width: 200,
                        align: 'center'
                    },
                    {
                        field: 'prospectArea',
                        title: '勘查区域',
                        width: 200,
                        align: 'center'
                    },
                    {
                        field: 'prospectRequire',
                        title: '勘查要求',
                        width: 200,
                        align: 'center'
                    },
                    {
                        field: 'prospectName',
                        title: '勘查人员',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'prospectStatus',
                        title: '勘查状态',
                        width: 120,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value == '0') return '待接收';
                            if(value == '1') return '勘查中';
                            if(value == '2') return '已勘查';
                            if(value == '3') return '待安装';
                            if(value == '4') return '待验收';
                            if(value == '5') return '已验收';
                            return '';
                        }
                    },
                    {
                        field: 'customerStatus',
                        title: '客户状态',
                        width: 120,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value == '0') return '未派单';
                            if(value == '1') return '勘查中';
                            if(value == '2') return '勘查完成';
                            if(value == '3') return '勘查数据待上传';
                            if(value == '4') return '勘查报告待生成';
                            return '';
                        }
                    },
                    {
                        field: 'submitName',
                        title: '下单人员',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'submitTime',
                        title: '下单日期',
                        width: 150,
                        align: 'center'
                    }
                ]
            ]
        });
    }
});

//勘查数据上传
$('#upload').click(function () {
    //获得选中行
    var item = $('#dataGrid').datagrid('getChecked');
    var prospectData = new Array();
    //筛选状态为待分发的记录
    if(item.prospectStatus != 0){
        $.messager.alert('错误','请先选择一行未派单的勘查记录！','error');
        return;
    }
    var id = item.id;
    $("#prospectForm").submit();
});

//清空
$("#clean").click(function(){
    $("#customerName").val("");
    $("#customerStatus").combobox('setValue', '');
    $("#prospectStatus").combobox('setValue', '');
});

$(function(){
    datagrid = $('#dataGrid').datagrid({
        url: "/prospect/findProspectList.html",
        method:'GET',
        fit: true,
        pagination: true,
        singleSelect: false,
        checkOnSelect:true,
        pageSize: 20,
        pageList: [100,200,300],
        nowrap: true,
        rownumbers: true,
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
                    field: 'customerName',
                    title: '客户名称',
                    width: 150,
                    align: 'center'
                },
                {
                    field: 'customerAddress',
                    title: '客户地址',
                    width: 200,
                    align: 'center'
                },
                {
                    field: 'name',
                    title: '联系人',
                    width: 150,
                    align: 'center'
                },
                {
                    field: 'mobile',
                    title: '联系电话',
                    width: 150,
                    align: 'center'
                },
                {
                    field: 'prospectTime',
                    title: '勘查时间',
                    width: 150,
                    align: 'center'
                },
                {
                    field: 'prospectContent',
                    title: '勘查内容',
                    width: 200,
                    align: 'center'
                },
                {
                    field: 'prospectArea',
                    title: '勘查区域',
                    width: 200,
                    align: 'center'
                },
                {
                    field: 'prospectRequire',
                    title: '勘查要求',
                    width: 200,
                    align: 'center'
                },
                {
                    field: 'prospectName',
                    title: '勘查人员',
                    width: 150,
                    align: 'center'
                },
                {
                    field: 'prospectStatus',
                    title: '勘查状态',
                    width: 120,
                    align: 'center',
                    formatter:function(value,rowData,rowIndex){
                        if(value == '0') return '待接收';
                        if(value == '1') return '勘查中';
                        if(value == '2') return '已勘查';
                        if(value == '3') return '待安装';
                        if(value == '4') return '待验收';
                        if(value == '5') return '已验收';
                        return '';
                    }
                },
                {
                    field: 'customerStatus',
                    title: '客户状态',
                    width: 120,
                    align: 'center',
                    formatter:function(value,rowData,rowIndex){
                        if(value == '0') return '未派单';
                        if(value == '1') return '勘查中';
                        if(value == '2') return '勘查完成';
                        if(value == '3') return '勘查数据待上传';
                        if(value == '4') return '勘查报告待生成';
                        return '';
                    }
                },
                {
                    field: 'submitName',
                    title: '下单人员',
                    width: 150,
                    align: 'center'
                },
                {
                    field: 'submitTime',
                    title: '下单日期',
                    width: 150,
                    align: 'center'
                }
            ]
        ]
    });
})
</script>
</body>