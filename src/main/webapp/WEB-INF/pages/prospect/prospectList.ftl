<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>���鷴��</title>
    <link rel="stylesheet" type="text/css" href="/resources/easyui-themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/resources/easyui-themes/icon.css">
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/js/easyui-lang-zh_CN.js"></script>
</head>
<body>
<div class="easyui-layout" data-options="fit : true,border : false">
    <div data-options="region:'north',title:'��ѯ����',border:false" style="height:200px;overflow: auto;" align="left">
        <form id="filterForm" action="#">
            <table>
                <tr>
                    <td>�ͻ�����</td>
                    <td>
                        <input id="customerName" class="txt" name="customerName">
                    </td>
                    <td>�ͻ�״̬</td>
                    <td>
                        <input class="easyui-combobox" id="customerStatus"  name="customerStatus"  data-options="
	       								valueField: 'value',textField: 'text',panelHeight:'auto',editable:false,value:'',
										data: [{value: '',text: '����'},
												{value: '0',text: '������'},
										       {value: '1',text: '������'},
												{value: '2',text: '�ѿ���'},
												{value: '3',text: '����װ'},
												{value: '4',text: '������'},
												{value: '5',text: '������'}
												]" />
                    </td>
                    <td>����״̬</td>
                    <td>
                        <input class="easyui-combobox" id="prospectStatus"  name="prospectStatus"  data-options="
	       								valueField: 'value',textField: 'text',panelHeight:'auto',editable:false,value:'',
										data: [{value: '',text: '����'},
												{value: '0',text: 'δ�ɵ�'},
										       {value: '1',text: '������'},
												{value: '2',text: '�������'},
												{value: '3',text: '�������ݴ��ϴ�'},
												{value: '4',text: '���鱨�������'}
												]" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',title:'��ѯ���',border:false" style="left: 0px; top: 240px; width: 1920px;">
        <table id="dataGrid"></table>
    </div>
</div>
<script type="text/javascript">
    var datagrid;
    var queryParameters;

    // �ж��Ƿ�Ϊ��
    $.isNotBlank = function(value) {
        if (value != undefined && value != "undefined" && value != null && value != "null" && value != "") {
            return true;
        }
        return false;
    };

    //��Ʊ�ʼ��б��ѯ
    $('#search').click(function () {
        queryParameters = {
            customerName:$("#customerName").val(),
            customerStatus:$("#customerStatus").combobox("getValue"),
            prospectStatus:$("#prospectStatus").combobox("getValue")
        };
        if(datagrid){
            //grid����
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
                            title: '���',
                            width: 10,
                            align: 'center',
                            hidden:true
                        },
                        /*{
                            field: 'caozuo',
                            title: '���������ļ�',
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
                            title: '�ͻ�����',
                            width: 150,
                            align: 'center'
                        },
                        {
                            field: 'customerAddress',
                            title: '�ͻ���ַ',
                            width: 200,
                            align: 'center'
                        },
                        {
                            field: 'name',
                            title: '��ϵ��',
                            width: 150,
                            align: 'center'
                        },
                        {
                            field: 'mobile',
                            title: '��ϵ�绰',
                            width: 150,
                            align: 'center'
                        },
                        {
                            field: 'prospectTime',
                            title: '����ʱ��',
                            width: 150,
                            align: 'center'
                        },
                        {
                            field: 'prospectContent',
                            title: '��������',
                            width: 200,
                            align: 'center'
                        },
                        {
                            field: 'prospectArea',
                            title: '��������',
                            width: 200,
                            align: 'center'
                        },
                        {
                            field: 'prospectRequire',
                            title: '����Ҫ��',
                            width: 200,
                            align: 'center'
                        },
                        {
                            field: 'prospectName',
                            title: '������Ա',
                            width: 150,
                            align: 'center'
                        },
                        {
                            field: 'prospectStatus',
                            title: '����״̬',
                            width: 120,
                            align: 'center',
                            formatter:function(value,rowData,rowIndex){
                                if(value == '0') return '������';
                                if(value == '1') return '������';
                                if(value == '2') return '�ѿ���';
                                if(value == '3') return '����װ';
                                if(value == '4') return '������';
                                if(value == '5') return '������';
                                return '';
                            }
                        },
                        {
                            field: 'customerStatus',
                            title: '�ͻ�״̬',
                            width: 120,
                            align: 'center',
                            formatter:function(value,rowData,rowIndex){
                                if(value == '0') return 'δ�ɵ�';
                                if(value == '1') return '������';
                                if(value == '2') return '�������';
                                if(value == '3') return '�������ݴ��ϴ�';
                                if(value == '4') return '���鱨�������';
                                return '';
                            }
                        },
                        {
                            field: 'submitName',
                            title: '�µ���Ա',
                            width: 150,
                            align: 'center'
                        },
                        {
                            field: 'submitTime',
                            title: '�µ�����',
                            width: 150,
                            align: 'center'
                        }
                    ]
                ]
            });
        }
    });

    //��Ʊ�ַ�
    $('#dispense').click(function () {
        //���ѡ����
        var checkedItems = $('#dataGrid').datagrid('getChecked');
        var dispenseData = new Array();
        //ɸѡ״̬Ϊ���ַ��ļ�¼
        $.each(checkedItems, function(index, item){
            if(item.status == 2){
                dispenseData.push(item.id);
            }
        });
        if(dispenseData == null || dispenseData.length == 0){
            $.messager.alert('����','������ѡ��һ�д��ַ�״̬�ķ�Ʊ��','error');
            return;
        }
        var dispenseData = JSON.stringify(dispenseData);
        window.location.href="/invoice/invoicePostDispense.html?dispenseData=" + dispenseData;
    });

    //��Ʊǩ��
    $('#receipt').click(function () {
        //���ѡ����
        var checkedItems = $('#dataGrid').datagrid('getChecked');
        var receiptData = new Array();
        //ɸѡ״̬Ϊ��ҵ��ǩ�յļ�¼
        $.each(checkedItems, function(index, item){
            if(item.status == 3){
                receiptData.push(item.id);
            }
        });
        if(receiptData == null || receiptData.length == 0){
            $.messager.alert('����','������ѡ��һ�д�ǩ��״̬�ķ�Ʊ��','error');
            return;
        }

        $.messager.confirm('ǩ��','��ȷ����ѡ��Ʊ�Ƿ�ȫ���յ���', function(r){
            if (r){
                jQuery.ajax({
                    url: "/invoice/invoicePostReceipt.html",
                    type: "POST",                   // ������������Ϊ"POST"��Ĭ��Ϊ"GET"
                    data:{"receiptData": JSON.stringify(receiptData)},
                    success: function (data) {
                        if(!data.success) {
                            $.messager.alert('����',data.message,'error');
                            return;
                        }else {
                            $('#dataGrid').datagrid('reload');
                        }
                    }
                });
            }
        });
    });

    //��Ʊ�ʼ���Ϣ¼��
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

    //��Ʊ�ʼ���Ϣ¼���ύ
    $("#saveBtn").click(function(){
        var receiptAddress = $("#receiptAddress").val();
        if(!$.isNotBlank(receiptAddress)){
            if(!$.isNotBlank($("#receiptConsignee_edit").val())){
                $.messager.alert("��ʾ","����д��Ʊ������","info")
                return false;
            }
            if(!$.isNotBlank($("#receiptAddress_edit").val())){
                $.messager.alert("��ʾ","����д��Ʊ��ַ","info")
                return false;
            }
            if(!$.isNotBlank($("#receiptMobile_edit").val())){
                $.messager.alert("��ʾ","����д��Ʊ�绰","info")
                return false;
            }
            if(!$.isNotBlank($("#receiptZipCode_edit").val())){
                $.messager.alert("��ʾ","����д��Ʊ�ʱ�","info")
                return false;
            }
        }
        if(!$.isNotBlank($("#expressCompany").val())){
            $.messager.alert("��ʾ","��ѡ��������","info")
            return false;
        }
        if(!$.isNotBlank($("#expressNum").val())){
            $.messager.alert("��ʾ","����д��ݺ�","info")
            return false;
        }
        $.messager.progress({text:"�ύ��..."});
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
                    $.messager.alert('����', result.message, 'error');
            },
            fail: function(data) {
                $.messager.progress('close');
                $.messager.alert('����',"������Ϣ����,����ϵ����Ա��");
            }
        });
    });

    //���
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
                        title: '��ƱId',
                        width: 10,
                        align: 'center',
                        hidden:true
                    },
                    {
                        field: 'invoiceSource',
                        title: '��Ʊ��Դ',
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
                        title: '����',
                        width: 100,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if($.isNotBlank(rowData.expressCompany) && $.isNotBlank(rowData.expressNum)){
                                return "��¼��";
                            }else{
                                if(rowData.updatedBy == '999999' && (rowData.status == 4 || rowData.status == 5)) {
                                    return '<input type="button" onclick="goExpressInputInfo(\'' + rowData.orderSn + '\',\'' + rowData.corderSn + '\',\'' + rowData.jdeCode + '\',\'' + rowData.invoiceNumber + '\',' + rowData.invoiceSource + ',\'' + rowData.receiptAddress + '\')" value="¼��">';
                                } else{
                                    return '<input type="button" disabled="disabled" value="¼��">';
                                }
                            }
                        }
                    },
                    {
                        field: 'incomeType',
                        title: '��������',
                        width: 120,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value == '1') return 'ˮվ��Ӫ����';
                            if(value == '2') return 'ˮվ�ܱ߲�Ʒ��Ӫ����';
                            if(value == '3') return '��о����';
                            if(value == '4') return '��ֵ�ӱ�';
                            if(value == '5') return '���������';
                            if(value == '6') return '������������';
                            if(value == '7') return '��ữ��������';
                            if(value == '8') return '��̬����';
                            if(value == '9') return '�������';
                            if(value == '10') return '��ֵ����';
                            if(value == '11') return '������Ʒ�Ƽ���Դ������';
                            if(value == '12') return '�ۺ��������';
                            if(value == '13') return '������Ʒ����';
                            return '';
                        }
                    },
                    {
                        field: 'status',
                        title: '״̬',
                        width: 120,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value == '1') return '����Ʊ';
                            if(value == '2') return '���ַ�';
                            if(value == '3') return '��ҵ��ǩ��';
                            if(value == '4') return '���ʼ�';
                            if(value == '5') return '���ڴ��ʼ�';
                            if(value == '6') return '����Ʊ��ǩ��';
                            if(value == '7') return '�����';
                            return '';
                        }
                    },
                    {
                        field: 'corderSn',
                        title: '������',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'orderSn',
                        title: '������',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'jdeCode',
                        title: 'JDE����',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'payTime',
                        title: '֧��ʱ��',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'orderStatus',
                        title: '����״̬',
                        width: 100,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value=='200') return 'δȷ��';
                            if(value=='201') return '��ȷ��';
                            if(value=='202') return '��ȡ��';
                            if(value=='203') return '�����';
                            return '';
                        }
                    },
                    {
                        field: 'closeTime',
                        title: '�����ر�ʱ��',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'xiaowei',
                        title: '��������С΢',
                        width: 120,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value == '14') return '��̬����';
                            if(value == '15') return '���豸';
                            if(value == '16') return 'O2O';
                            if(value == '17') return '��Ӯ����ҵ΢����';
                            if(value == '18') return '��Ӯ�Ҹ���΢����';
                            if(value == '19') return '����';
                            return '';
                        }
                    },
                    {
                        field: 'managerName',
                        title: '��Ʊ������',
                        width: 120,
                        align: 'center'
                    },
                    {
                        field: 'managerReceiptTime',
                        title: '������ǩ��ʱ��',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'memberName',
                        title: '����˺�',
                        width: 100,
                        align: 'center'
                    },
                    {
                        field: 'mobile',
                        title: '����ֻ���',
                        width: 100,
                        align: 'center'
                    },
                    {
                        field: 'receiptConsignee',
                        title: '��Ʊ��',
                        width: 100,
                        align: 'center'
                    },
                    {
                        field: 'receiptAddress',
                        title: '��Ʊ��ַ',
                        width: 200,
                        align: 'center'
                    },
                    {
                        field: 'receiptMobile',
                        title: '��Ʊ�绰',
                        width: 100,
                        align: 'center',
                    },
                    {
                        field: 'receiptZipCode',
                        title: '��Ʊ�ʱ�',
                        width: 80,
                        align: 'center'
                    },
                    {
                        field: 'invoiceStatus',
                        title: '����״̬',
                        width: 80,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value=='0') return 'δ����';
                            if(value=='1') return '�ѿ���';
                            if(value=='3') return '������';
                            return 'δ����';
                        }
                    },
                    {
                        field: 'invoiceNumber',
                        title: '��Ʊ��',
                        width: 100,
                        align: 'center'
                    },
                    {
                        field: 'invoiceType',
                        title: '��Ʊ����',
                        width: 80,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value=='1') return '��Ʊ';
                            if(value=='2') return '��Ʊ��ֽ�ʣ�';
                            return '';
                        }
                    },
                    {
                        field: 'billingTime',
                        title: '��Ʊʱ��',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'expressCompany',
                        title: '�������',
                        width: 100,
                        align: 'center'
                    },
                    {
                        field: 'expressNum',
                        title: '��ݺ�',
                        width: 100,
                        align: 'center'
                    },
                    {
                        field: 'expressInputName',
                        title: '¼����',
                        width: 80,
                        align: 'center'
                    },
                    {
                        field: 'expressInputTime',
                        title: '¼��ʱ��',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'receiptStatus',
                        title: '���ǩ��״̬',
                        width: 100,
                        align: 'center',
                        formatter:function(value,rowData,rowIndex){
                            if(value=='0') return 'δǩ��';
                            if(value=='1') return '��ǩ��';
                            return 'δǩ��';
                        }
                    },
                    {
                        field: 'receiptTime',
                        title: '���ǩ��ʱ��',
                        width: 150,
                        align: 'center'
                    },
                    {
                        field: 'timeoutDays',
                        title: '�ʼĳ�������',
                        width: 100,
                        align: 'center'
                    }
                ]
            ]
        });
    })
</script>
</body>