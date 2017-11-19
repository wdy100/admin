<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="security" uri="/security-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%-- <script type="text/javascript" src="${staticURL}/hzscripts/enterSearch.js"></script> --%>
    <title>客户信息查询</title>
    <style type="text/css">

    </style>
</head>
<body >

<div id="layout" class="easyui-layout" fit="true">
    <div region="north" border="false" collapsible="true" collapsed="false"
         class="zoc" title="查询条件" style="height: 60px; overflow: inherit;">
        <form onsubmit="return false;" id="searchForm">
            <table class="fixedTb">
                <tr>
                    <td class="cxlabel">客户代码:</td>
                    <td class="cxinput"><input name="customer.cusCode" type="text" class="easyui-textbox" style="width:100%;"/></td>
                    <td class="cxlabel">客户名称:</td>
                    <td class="cxinput"><input name="customer.cusName" type="text" class="easyui-textbox" style="width:100%;"/></td>
                    <td class="cxlabel">
                        <a id="searchPt" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                    </td>
                    <td class="cxlabel"></td>
                    <td class="cxinput"></td>
                </tr>
            </table>
        </form>
    </div>
    <div id="tb" >
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="false" onclick="deleteCustomer()">删除</a>
        <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="updateCustomer()">修改</a>
        <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="createCustomer()">新增</a>

    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true,formatter : function(value, row, index) {return row.id;}"></th>
                <th data-options="field:'areaDesc',width:100,halign:'center',align:'left'">大区</th>
                <th data-options="field:'officeDesc',width:100,halign:'center',align:'left'">办事处</th>
                <th data-options="field:'warroomDesc',width:100,halign:'center',align:'left'">作战室</th>
                <th data-options="field:'cusCode',width:100,halign:'center',align:'left'">客户代码</th>
                <th data-options="field:'cusName',width:400,halign:'center',align:'left'">客户名称</th>
            </tr>
            </thead>
        </table>
    </div>
</div>


<!-- create  -->
<div class="easyui-dialog" id="addCustomerDiv" style="width:320px;height:380px;"
     data-options="modal:true,closed:true,resizable:false" >
    <form id="createCustomerForm" method="post" action="${dynamicURL}/basic/createCustomer.action">
        <table>
            <tr>
                <td style="text-align: right;width:70px;">所属大区<span style="color:red;">*</span>:</td>
                <td>
                    <input name="customer.area" id="area" class="easyui-combobox" style="color:red;width: 200px;" required="true" missingMessage="该输入项为必输项" panelHeight="100px"  editable="false" data-options="onSelect:changeArea"/>
                    <input id="areaDesc" type="hidden" name="customer.areaDesc" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right;width:70px;">所属办事处<span style="color:red;">*</span>:</td>
                <td>
                    <input id="office"  name="customer.office" required = true class="easyui-combobox"  style="width:200px;"  data-options="onSelect:changeOffice"/>
                    <input id="officeDesc" type="hidden" name="customer.officeDesc" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right;width:70px;">所属作战室<span style="color:red;">*</span>:</td>
                <td>
                    <input id="warroom"  name="customer.warroom" required = true class="easyui-combobox"  style="width:200px;" data-options="onSelect:changeWarroom"/>
                    <input id="warroomDesc" type="hidden" name="customer.warroomDesc" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">客户代码<span style="color:red;">*</span>:</td>
                <td>
                    <input id="cusCode" name="customer.cusCode" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:200px;"></input>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">客户名称<span style="color:red;">*</span>:</td>
                <td>
                    <input id="cusName" name="customer.cusName" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:200px;"></input>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">联系人:</td>
                <td>
                    <input id="contact" name="customer.contact" type="text" class="easyui-textbox" style="width:200px;"></input>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">联系人电话:</td>
                <td>
                    <input id="contactPhone" name="customer.contactPhone" type="text" class="easyui-textbox" style="width:200px;"></input>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">地址:</td>
                <td>
                    <input id="dealerAddress" name="customer.dealerAddress" type="text" class="easyui-textbox" style="width:200px;"></input>
                </td>
            </tr>
        </table>
    </form>
</div>


<!-- 修改框 -->
<div class="easyui-dialog" id="customerEditDialog" style="width:320px;height:380px;"
     data-options="modal:true,closed:true,resizable:false" >
    <form id="updateCustomerData" method="post" action="${dynamicURL}/basic/updateCustomer.action">
        <input id ="customerid" type="hidden"  name = "customer.id">
        <table>
            <tr>
                <td style="text-align: right;width:70px;">所属大区<span style="color:red;">*</span>:</td>
                <td>
                    <input name="customer.areaDesc" class="easyui-textbox" style="color:red;width: 200px;" required="true"  panelHeight="100px"  data-options="editable:false,iconCls:'icon-lock'" />
                    <input type="hidden" name="customer.area" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right;width:70px;">所属办事处<span style="color:red;">*</span>:</td>
                <td>
                    <input name="customer.officeDesc" required = true class="easyui-textbox"  style="width:200px;" data-options="editable:false,iconCls:'icon-lock'"/>
                    <input type="hidden" name="customer.office" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right;width:70px;">所属作战室<span style="color:red;">*</span>:</td>
                <td>
                    <input name="customer.warroomDesc" required = true class="easyui-textbox"  style="width:200px;" data-options="editable:false,iconCls:'icon-lock'"/>
                    <input type="hidden" name="customer.warroom" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">客户代码<span style="color:red;">*</span>:</td>
                <td>
                    <input id="edcusCode" name="customer.cusCode" type="text" class="easyui-textbox" data-options="editable:false,iconCls:'icon-lock'" style="width:200px;"></input>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">客户名称<span style="color:red;">*</span>:</td>
                <td>
                    <input id="edcusName" name="customer.cusName" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:200px;"></input>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">联系人:</td>
                <td>
                    <input id="edcontact" name="customer.contact" type="text" class="easyui-textbox" style="width:200px;"></input>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">联系人电话:</td>
                <td>
                    <input id="edcontactPhone" name="customer.contactPhone" type="text" class="easyui-textbox" style="width:200px;"></input>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;">地址:</td>
                <td>
                    <input id="eddealerAddress" name="customer.dealerAddress" type="text" class="easyui-textbox" style="width:200px;"></input>
                </td>
            </tr>
        </table>
    </form>
</div>


<script type="text/javascript">
    var addCustomerDialog;
    var customerEditDialog;
    function loaddata(){
        $('#dg').datagrid({url:'${dynamicURL}/basic/searchCustomer.action?'+$("#searchForm").form().serialize()});
    }
    function formatDateTime(val,row){
        if(!val.time){
            return "";
        }
        var date = new Date(val.time);
        return simpleDateTimeFormatter(date);
    }
    var statusMap = {'1':'启用','0':'禁用'};
    function statusFormater(val,row){
        return statusMap[val];
    }

    //更改大区时改变办事处、作战室
    function changeArea(){
        var areaCode =  $("#area").combobox("getValue");
        $("#office").combobox({
            url:'${dynamicURL}/basic/departmentCombox.action?type='+areaCode,
            valueField:'id',
            textField:'text',
            value:''
        });
        var areaDesc = $("#area").combobox('getText');
        $("#areaDesc").val(areaDesc);
        $("#office").combobox("reload");
        $("#warroom").empty();
    }

    //更改大区时改变办事处、作战室
    function changeOffice(){
        var officeCode =  $("#office").combobox("getValue");
        $("#warroom").combobox({
            url:'${dynamicURL}/basic/departmentCombox.action?type='+officeCode,
            valueField:'id',
            textField:'text',
            value:''
        });
        $("#warroom").combobox("reload");

        var officeDesc = $("#office").combobox('getText');
        $("#officeDesc").val(officeDesc);
    }

    function changeWarroom(){
        var warroomDesc = $("#warroom").combobox('getText');
        $("#warroomDesc").val(warroomDesc);
    }
    //客户禁用
    function deleteCustomer(){
        var row = $('#dg').datagrid('getSelected');
        var ids = "";
        if(row){
            $.ajax({
                url : '${dynamicURL}/basic/deleteCustomer.action',
                data : {id : row.id},
                dataType : 'json',
                cache : false,
                success : function(result) {
                    $.messager.progress('close');
                    if(result.success){
                        $('#dg').datagrid('unselectAll');
                        $('#dg').datagrid('reload');
                        $.messager.show({
                            title:'成功',
                            msg:'操作成功'
                        });
                    }else{
                        showErrorMsg(result.errorMsg);
                    }
                },
                error: function(){
                    $.messager.progress('close');
                    $.messager.alert('提示', '操作失败！', 'error');
                }
            });
        }else{
            $.messager.alert('提示', '请选择一条记录！', 'warning');
        }

    }

    //新增数据
    function createCustomer() {
        addCustomerDialog.dialog('open');
    }

    $(function(){

        $("#area").combobox({
            valueField:'id',
            textField:'text',
            url:'${dynamicURL}/basic/departmentCombox.action?type=10'
        });

//         	materialDetailDialog = $('#customerDetailDialog').show().dialog({
//         		title : '客户信息',
// 				modal : true,
// 				closed : true
// 			});

        $('#dg').datagrid({
            title:'客户列表',
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
            url:'${dynamicURL}/basic/searchCustomer.action?model.flag=1',
            nowrap : true,
            border : false,
            onDblClickRow:function(rowIndex, rowData){
                //双击行弹出该项目的详细信息。
                //$('#mpricedg').datagrid({url:'${dynamicURL}/basic/searchCustomerDetail.action?mcode='+rowData.cusCode});
                //materialDetailDialog.dialog('open');
            }
        });

        //增加网点
        addCustomerDialog = $("#addCustomerDiv").dialog({
            title: '新增',
            iconCls:'icon-save',
            closed: true,
            resizable:false,
            modal: true,
            buttons:[{
                text:'保存',
                iconCls:'icon-ok',
                handler:function(){
                    submitForm();
                }
            }]
        });

        customerEditDialog = $("#customerEditDialog").dialog({
            title: '修改',
            iconCls:'icon-save',
            closed: true,
            resizable:false,
            modal: true,
            buttons:[{
                text:'保存',
                iconCls:'icon-ok',
                handler:function(){
                    editForm();
                }
            }]
        });
    });
    //错误提示

    function submitForm(){
        $('#createCustomerForm').form('submit', {
            onSubmit : function() {
                var flag = $(this).form('validate')
                if(flag==true){
                    $.messager.progress({
                        text : "正在保存，请稍后...",
                        interval : 100
                    });
                }
                return flag;
            },
            success : function(result) {
                $.messager.progress('close');
                handleActionResult(result, {
                    onSuccess : function() {
                        $.messager.show({
                            title : '提示',
                            msg : '保存成功'
                        });
                        $('#dg').datagrid('reload');
                        $('#createCustomerForm').form('clear');
                        addCustomerDialog.dialog('close');
                    }
                });
            }
        });
    }

    //修改数据
    function updateCustomer() {
        var rows = $('#dg').datagrid('getSelections');
        if(rows.length == 1) {
            var data = {
                'customer.id' : rows[0].id,
                'customer.area' : rows[0].area,
                'customer.areaDesc' : rows[0].areaDesc,
                'customer.office' : rows[0].office,
                'customer.officeDesc' : rows[0].officeDesc,
                'customer.warroom' : rows[0].warroom,
                'customer.warroomDesc' : rows[0].warroomDesc,
                'customer.cusCode' : rows[0].cusCode,
                'customer.cusName' : rows[0].cusName,
                'customer.contact' : rows[0].contact,
                'customer.contactPhone' : rows[0].contactPhone,
                'customer.dealerAddress' : rows[0].dealerAddress
            };
            $('#updateCustomerData').form('load',data);
        }else{
            $.messager.alert('操作提示', '请选择1条要修改的数据！', 'info');
            return;
        }
        customerEditDialog.dialog('open');
    }

    function editForm(){
        $('#updateCustomerData').form('submit', {
            onSubmit : function() {
                var flag = $(this).form('validate');
                if(flag==true){
                    $.messager.progress({
                        text : "正在保存，请稍后...",
                        interval : 100
                    });
                }
                return flag;
            },
            success : function(result) {
                $.messager.progress('close');
                handleActionResult(result, {
                    onSuccess : function() {
                        $.messager.show({
                            title : '提示',
                            msg : '修改成功'
                        });
                        $('#dg').datagrid('reload');
                        customerEditDialog.dialog('close');
                    }
                });
            }
        });
    }

    function showErrorMsg(result){
        if(result.errorMessages && !isEmpty(result.errorMessages)){
            var error = "";
            $.each(result.errorMessages,function(index,value) {//index就是field的name,value就是该filed对应的错误列表，这里取第一个
                error +=(value+"<br/>");
            });
            $.messager.alert('操作失败提示',error,'error');
        }else if(result.fieldErrors && !isEmpty(result.fieldErrors)){
            var error = "";
            $.each(result.fieldErrors,function(index,value) {
                error +=(value+"<br/>");
            });
            $.messager.alert('操作失败提示',error,'error');
        }else if(result.warningMessages && !isEmpty(result.warningMessages)){
            var error = "";
            $.each(result.warningMessages,function(index,value) {
                error +=(value+"<br/>");
            });
            $.messager.alert('操作失败提示',error,'error');
        }
    }
</script>
</body>
</html>
