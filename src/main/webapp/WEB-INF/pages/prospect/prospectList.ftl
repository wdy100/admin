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
        <form id="filterForm" action="#">
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
                        /*{
                            field: 'caozuo',
                            title: '勘查数据文件',
                            width: 100,
                            align: 'center',
                            formatter:function(value,rowData,rowIndex){
                                if($.isNotBlank(rowData.prospectFileAddress)){
                                    //return "<form action=\"uploadReportFile.html\" method=\"post\" enctype=\"multipart/form-data\"><input type=\"file\" name=\"file\"/><input type=\"submit\" value=\"Submit\"/></form>";
                                }else{
                                    return "<form action=\"uploadReportFile.html\" method=\"post\" enctype=\"multipart/form-data\"><input type=\"file\" name=\"file\"/><input type=\"submit\" value=\"Submit\"/></form>";
                                }
                            }
                        },*/
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

    //发票分发
    $('#dispense').click(function () {
        //获得选中行
        var checkedItems = $('#dataGrid').datagrid('getChecked');
        var dispenseData = new Array();
        //筛选状态为待分发的记录
        $.each(checkedItems, function(index, item){
            if(item.status == 2){
                dispenseData.push(item.id);
            }
        });
        if(dispenseData == null || dispenseData.length == 0){
            $.messager.alert('错误','请至少选择一行待分发状态的发票！','error');
            return;
        }
        var dispenseData = JSON.stringify(dispenseData);
        window.location.href="/invoice/invoicePostDispense.html?dispenseData=" + dispenseData;
    });

    //发票签收
    $('#receipt').click(function () {
        //获得选中行
        var checkedItems = $('#dataGrid').datagrid('getChecked');
        var receiptData = new Array();
        //筛选状态为待业务签收的记录
        $.each(checkedItems, function(index, item){
            if(item.status == 3){
                receiptData.push(item.id);
            }
        });
        if(receiptData == null || receiptData.length == 0){
            $.messager.alert('错误','请至少选择一行待签收状态的发票！','error');
            return;
        }

        $.messager.confirm('签收','请确认所选发票是否全部收到？', function(r){
            if (r){
                jQuery.ajax({
                    url: "/invoice/invoicePostReceipt.html",
                    type: "POST",                   // 设置请求类型为"POST"，默认为"GET"
                    data:{"receiptData": JSON.stringify(receiptData)},
                    success: function (data) {
                        if(!data.success) {
                            $.messager.alert('错误',data.message,'error');
                            return;
                        }else {
                            $('#dataGrid').datagrid('reload');
                        }
                    }
                });
            }
        });
    });

    //发票邮寄信息录入
    function goExpressInputInfo(orderSn,corderSn,jdeCode,invoiceNumber,invoiceSource,receiptAddress){
        if(orderSn == undefined || orderSn == 'undefined' || orderSn == null) {
            orderSn = "";
        }
        if(invoiceSource == 2) {
            $(".notJDE").hide();
            $(".isJDE").show();
        } else {
            $(".notJDE").show();
            $(".isJDE").hide();
        }

        if($.isNotBlank(receiptAddress)){
            $(".ifInputReceipt").hide();
        } else {
            $(".ifInputReceipt").show();
        }

        $("#receiptAddress").val(receiptAddress);
        $("#orderSn_edit").val(orderSn);
        $("#corderSn_edit").val(corderSn);
        $("#jdeCode_edit").val(jdeCode);
        $("#invoiceNumber_edit").val(invoiceNumber);

        $("#receiptConsignee_edit").val("");
        $("#receiptAddress_edit").val("");
        $("#receiptMobile_edit").val("");
        $("#receiptZipCode_edit").val("");

        $("#expressCompany").val("");
        $("#expressNum").val("");
        $("#expressInputInfo").show();
        $("#expressInputInfo").dialog({
            collapsible: true,
            minimizable: false,
            maximizable: false,
            height:270,
            width:350
        });
    }

    //发票邮寄信息录入提交
    $("#saveBtn").click(function(){
        var receiptAddress = $("#receiptAddress").val();
        if(!$.isNotBlank(receiptAddress)){
            if(!$.isNotBlank($("#receiptConsignee_edit").val())){
                $.messager.alert("提示","请填写收票人姓名","info")
                return false;
            }
            if(!$.isNotBlank($("#receiptAddress_edit").val())){
                $.messager.alert("提示","请填写收票地址","info")
                return false;
            }
            if(!$.isNotBlank($("#receiptMobile_edit").val())){
                $.messager.alert("提示","请填写收票电话","info")
                return false;
            }
            if(!$.isNotBlank($("#receiptZipCode_edit").val())){
                $.messager.alert("提示","请填写收票邮编","info")
                return false;
            }
        }
        if(!$.isNotBlank($("#expressCompany").val())){
            $.messager.alert("提示","请选择快递名称","info")
            return false;
        }
        if(!$.isNotBlank($("#expressNum").val())){
            $.messager.alert("提示","请填写快递号","info")
            return false;
        }
        $.messager.progress({text:"提交中..."});
        jQuery.ajax({
            url: "/invoice/saveInvoicePostExpress.html",
            data:{
                "invoiceNumber": $("#invoiceNumber_edit").val(),
                "receiptConsignee": $("#receiptConsignee_edit").val(),
                "receiptAddress": $("#receiptAddress_edit").val(),
                "receiptMobile": $("#receiptMobile_edit").val(),
                "receiptZipCode": $("#receiptZipCode_edit").val(),
                "expressCompany": $("#expressCompany").val(),
                "expressNum": $("#expressNum").val()
            },
            type: "GET",
            success: function(result) {
                $.messager.progress('close');
                if(result.success == true){
                    $('#dataGrid').datagrid('reload');
                    $("#expressInputInfo").dialog("close");
                }else
                    $.messager.alert('错误', result.message, 'error');
            },
            fail: function(data) {
                $.messager.progress('close');
                $.messager.alert('错误',"保存信息出错,请联系管理员！");
            }
        });
    });

    //清空
    $("#clean").click(function(){
        $('#payTimeMin').datetimebox('setValue', '');
        $('#payTimeMax').datetimebox('setValue', '');
        $("#receiptMobile").val("");
        $("#receiptConsignee").val("");
        $("#orderStatus").combobox('setValue', '');
        $('#closeTimeMin').datetimebox('setValue', '');
        $('#closeTimeMax').datetimebox('setValue', '');
        $("#invoiceStatus").combobox('setValue', '');
        $("#inputStatus").combobox('setValue', '');
        $("#invoiceNumber").val("");
        $("#expressInputTimeMin").datetimebox('setValue', '');
        $("#expressInputTimeMax").datetimebox('setValue', '');
        $("#memberName").val("");
        $("#corderSn").val("");
        $("#orderSn").val("");
        $("#expressInputName").val("");
        $("#xiaowei").combobox('setValue', '');
        $("#jdeCode").val("");
        $("#incomeType").combobox('setValue', '');
        $("#receiptStatus").combobox('setValue', '');
        $("#status").combobox('setValue', '');
        $('#managerReceiptTimeMin').datetimebox('setValue', '');
        $('#managerReceiptTimeMax').datetimebox('setValue', '');
        $('#receiptTimeMin').datetimebox('setValue', '');
        $('#receiptTimeMax').datetimebox('setValue', '');
    });

    $(function(){
        datagrid = $('#dataGrid').datagrid({
            url: "/invoice/invoicePostList.html",
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
                        title: '发票Id',
                        width: 10,
                        align: 'center',
                        hidden:true
                    },
                    {
                        field: 'invoiceSource',
                        title: '发票来源',
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
                        field: 'caozuo',
                        title: '操作',
                        width: 100,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if($.isNotBlank(rowData.expressCompany) && $.isNotBlank(rowData.expressNum)){
                                return "已录入";
                            }else{
                                if(rowData.updatedBy == '999999' && (rowData.status == 4 || rowData.status == 5)) {
                                    return '<input type="button" onclick="goExpressInputInfo(\'' + rowData.orderSn + '\',\'' + rowData.corderSn + '\',\'' + rowData.jdeCode + '\',\'' + rowData.invoiceNumber + '\',' + rowData.invoiceSource + ',\'' + rowData.receiptAddress + '\')" value="录入">';
                                } else{
                                    return '<input type="button" disabled="disabled" value="录入">';
                                }
                            }
                        }
                    },
                    {
                        field: 'incomeType',
                        title: '收入类型',
                        width: 120,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value == '1') return '水站自营收入';
                            if(value == '2') return '水站周边产品自营收入';
                            if(value == '3') return '滤芯收入';
                            if(value == '4') return '增值延保';
                            if(value == '5') return '技术服务费';
                            if(value == '6') return '海尔服务收入';
                            if(value == '7') return '社会化服务收入';
                            if(value == '8') return '生态收入';
                            if(value == '9') return '广告收入';
                            if(value == '10') return '充值收入';
                            if(value == '11') return '第三方品牌及资源方收入';
                            if(value == '12') return '售后服务收入';
                            if(value == '13') return '健康产品收入';
                            return '';
                        }
                    },
                    {
                        field: 'status',
                        title: '状态',
                        width: 120,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value == '1') return '待开票';
                            if(value == '2') return '待分发';
                            if(value == '3') return '待业务签收';
                            if(value == '4') return '待邮寄';
                            if(value == '5') return '超期待邮寄';
                            if(value == '6') return '待收票人签收';
                            if(value == '7') return '已完成';
                            return '';
                        }
                    },
                    {
                        field: 'corderSn',
                        title: '网单号',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'orderSn',
                        title: '订单号',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'jdeCode',
                        title: 'JDE单号',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'payTime',
                        title: '支付时间',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'orderStatus',
                        title: '订单状态',
                        width: 100,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value=='200') return '未确认';
                            if(value=='201') return '已确认';
                            if(value=='202') return '已取消';
                            if(value=='203') return '已完成';
                            return '';
                        }
                    },
                    {
                        field: 'closeTime',
                        title: '订单关闭时间',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'xiaowei',
                        title: '订单所属小微',
                        width: 120,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value == '14') return '生态收入';
                            if(value == '15') return '卖设备';
                            if(value == '16') return 'O2O';
                            if(value == '17') return '大赢家企业微店主';
                            if(value == '18') return '大赢家个人微店主';
                            if(value == '19') return '线上';
                            return '';
                        }
                    },
                    {
                        field: 'managerName',
                        title: '发票责任人',
                        width: 120,
                        align: 'center'
                    },
                    {
                        field: 'managerReceiptTime',
                        title: '责任人签收时间',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'memberName',
                        title: '买家账号',
                        width: 100,
                        align: 'center'
                    },
                    {
                        field: 'mobile',
                        title: '买家手机号',
                        width: 100,
                        align: 'center'
                    },
                    {
                        field: 'receiptConsignee',
                        title: '收票人',
                        width: 100,
                        align: 'center'
                    },
                    {
                        field: 'receiptAddress',
                        title: '收票地址',
                        width: 200,
                        align: 'center'
                    },
                    {
                        field: 'receiptMobile',
                        title: '收票电话',
                        width: 100,
                        align: 'center',
                    },
                    {
                        field: 'receiptZipCode',
                        title: '收票邮编',
                        width: 80,
                        align: 'center'
                    },
                    {
                        field: 'invoiceStatus',
                        title: '开具状态',
                        width: 80,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value=='0') return '未开具';
                            if(value=='1') return '已开具';
                            if(value=='3') return '开具中';
                            return '未开具';
                        }
                    },
                    {
                        field: 'invoiceNumber',
                        title: '发票号',
                        width: 100,
                        align: 'center'
                    },
                    {
                        field: 'invoiceType',
                        title: '发票类型',
                        width: 80,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value=='1') return '增票';
                            if(value=='2') return '普票（纸质）';
                            return '';
                        }
                    },
                    {
                        field: 'billingTime',
                        title: '开票时间',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'expressCompany',
                        title: '快递名称',
                        width: 100,
                        align: 'center'
                    },
                    {
                        field: 'expressNum',
                        title: '快递号',
                        width: 100,
                        align: 'center'
                    },
                    {
                        field: 'expressInputName',
                        title: '录入人',
                        width: 80,
                        align: 'center'
                    },
                    {
                        field: 'expressInputTime',
                        title: '录入时间',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'receiptStatus',
                        title: '快递签收状态',
                        width: 100,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value=='0') return '未签收';
                            if(value=='1') return '已签收';
                            return '未签收';
                        }
                    },
                    {
                        field: 'receiptTime',
                        title: '快递签收时间',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'timeoutDays',
                        title: '邮寄超期天数',
                        width: 100,
                        align: 'center'
                    }
                ]
            ]
        });
    })
</script>
</body>