<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<#include "../common/easyui_core.ftl"/>
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
                    <td class="cxlabel">客户名称:</td>
                    <td class="cxinput"><input name="q_customerName" type="text" class="easyui-textbox" style="width:100px;"/></td>
                    <td class="cxlabel">
                        <a id="searchPt" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loaddata()">查询</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div id="tb" >
        <#--<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="false" onclick="deleteCustomer()">删除</a>-->
        <#--<a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="updateCustomer()">修改</a>-->
        <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="createCustomer()">新增</a>
            <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="distributionCustomer()">分配</a>
            <a href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="feedback()">反馈</a>

    </div>
    <div region="center" border="false">
        <table id="dg">
            <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true,formatter : function(value, row, index) {return row.id;}"></th>
                <th data-options="field:'customerName',width:150,halign:'center',align:'left'">客户名称</th>
                <th data-options="field:'phone',width:100,halign:'center',align:'left'">电话</th>
                <th data-options="field:'address',width:250,halign:'center',align:'left'">地址</th>
                <th data-options="field:'corporate',width:100,halign:'center',align:'left'">公司法人</th>
                <th data-options="field:'manager',width:100,halign:'center',align:'left'">总经理</th>
                <th data-options="field:'responsiblePerson',width:100,halign:'center',align:'left'">业务人员</th>
                <th data-options="field:'helpPerson',width:100,halign:'center',align:'left'">协助人</th>
            </tr>
            </thead>
        </table>
    </div>
</div>


<!-- create  -->
<div class="easyui-dialog" id="addCustomerDiv" style="width:320px;height:380px;"
     data-options="modal:true,closed:true,resizable:false" >
    <table>
        <tr>
            <td style="text-align: right;">客户名称<span style="color:red;">*</span>:</td>
            <td>
                <input id="customerName" name="customerName" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">所属行业:</td>
            <td>
                <input id="typeName" name="typeName" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">电话:</td>
            <td>
                <input id="phone" name="phone" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">传真:</td>
            <td>
                <input id="fax" name="fax" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">地址:</td>
            <td>
                <input id="address" name="address" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">网址:</td>
            <td>
                <input id="url" name="url" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">公司法人:</td>
            <td>
                <input id="corporate" name="corporate" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">总经理:</td>
            <td>
                <input id="manager" name="manager" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">联系方式:</td>
            <td>
                <input id="contact" name="contact" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">对接部门:</td>
            <td>
                <input id="dockDepartment" name="dockDepartment" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">对接部门联系人:</td>
            <td>
                <input id="dockPerson" name="dockPerson" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">对接部门联系方式:</td>
            <td>
                <input id="dockContact" name="dockContact" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">关联部门:</td>
            <td>
                <input id="relateDepartment" name="relateDepartment" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">关联部门联系人:</td>
            <td>
                <input id="relatePerson" name="relatePerson" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">关联部门联系方式:</td>
            <td>
                <input id="relateContact" name="relateContact" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
    </table>
</div>


<!-- 修改框 -->
<div class="easyui-dialog" id="customerEditDialog" style="width:320px;height:380px;"
     data-options="modal:true,closed:true,resizable:false" >
    <form id="updateCustomerData" method="post" action="/customer/updateCustomer">
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

<!-- 分配  -->
<div class="easyui-dialog" id="distributionCustomerDiv" style="width:320px;height:280px;"
     data-options="modal:true,closed:true,resizable:false" >
    <table>
        <tr>
            <td style="text-align: right;">业务人员<span style="color:red;">*</span>:</td>
            <td>
                <input id="responsiblePerson" name="responsiblePerson" type="text" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width:200px;"></input>
            </td>
        </tr>

    </table>
</div>

<!-- 反馈  -->
<div class="easyui-dialog" id="addCustomerFeedbackDiv" style="width:320px;height:380px;"
     data-options="modal:true,closed:true,resizable:false" >
    <table>
        <tr>
            <td style="text-align: right;">业务人员:</td>
            <td>
                <input id="f_responsiblePerson" name="f_responsiblePerson" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;">反馈详情:</td>
            <td>
                <input id="f_description" name="f_description" type="text" class="easyui-textbox" style="width:200px;"></input>
            </td>
        </tr>
    </table>
</div>


<script type="text/javascript">
    var addCustomerDialog;
    var customerEditDialog;
    var distributionCustomerDialog;
    var customerFeedbackDialog;
    function loaddata(){
        <#--$('#dg').datagrid({url:'${dynamicURL}/basic/searchCustomer.action?'+$("#searchForm").form().serialize()});-->
        $('#dg').datagrid('load',sy.serializeObject($("#searchForm").form()));
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

    //客户禁用
    function deleteCustomer(){
        var row = $('#dg').datagrid('getSelected');
        var ids = "";
        if(row){
            $.ajax({
                url : '/customer/deleteCustomer',
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

    //分配
    function distributionCustomer() {
        distributionCustomerDialog.dialog('open');
    }

    //反馈
    function feedback() {
        customerFeedbackDialog.dialog('open');
    }

    $(function(){
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
            url:'/customer/customerList',
            nowrap : true,
            border : false
        });

        //增加网点
        addCustomerDialog = $("#addCustomerDiv").dialog({
            title: '新增',
            width: 400,
            height: 450,
            top: 30,
            closed: true,
            cache: false,
            modal: true,
            buttons:[{
                text:'保存',
                iconCls:'icon-ok',
                handler:function(){
                    submitForm();
                }
            },{
                text:'取消',
                iconCls:'icon-cancel',
                handler:function(){
                    addCustomerDialog.dialog('close');
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

        //分配
        distributionCustomerDialog = $("#distributionCustomerDiv").dialog({
            title: '分配',
            width: 400,
            height: 250,
            top: 30,
            closed: true,
            cache: false,
            modal: true,
            buttons:[{
                text:'保存',
                iconCls:'icon-ok',
                handler:function(){
                    submitDistribution();
                }
            },{
                text:'取消',
                iconCls:'icon-cancel',
                handler:function(){
                    distributionCustomerDialog.dialog('close');
                }
            }]
        });

        //反馈
        customerFeedbackDialog = $("#addCustomerFeedbackDiv").dialog({
            title: '反馈',
            width: 400,
            height: 250,
            top: 30,
            closed: true,
            cache: false,
            modal: true,
            buttons:[{
                text:'保存',
                iconCls:'icon-ok',
                handler:function(){
                    submitFeedback();
                }
            },{
                text:'取消',
                iconCls:'icon-cancel',
                handler:function(){
                    customerFeedbackDialog.dialog('close');
                }
            }]
        });
    });
    //错误提示

    function submitForm(){
        var customerCode = $('#customerCode').val();
        var customerName = $('#customerName').val();
        var typeCode = $('#typeCode').val();
        var typeName = $('#typeName').val();
        var phone = $('#phone').val();
        var fax = $('#fax').val();
        var address = $('#address').val();
        var url = $('#url').val();
        var corporate = $('#corporate').val();
        var manager = $('#manager').val();
        var contact = $('#contact').val();
        var dockDepartment = $('#dockDepartment').val();
        var dockPerson = $('#dockPerson').val();
        var dockContact = $('#dockContact').val();
        var relateDepartment = $('#relateDepartment').val();
        var relatePerson = $('#relatePerson').val();
        var relateContact = $('#relateContact').val();
        $.ajax({
            type:'post',
            url:'/customer/createCustomer',
            dataType : "json",
            data:{customerCode:customerCode, customerName:customerName, typeCode:typeCode,
                typeName:typeName, phone:phone, fax:fax, address:address,
                url:url, corporate:corporate, manager:manager,
                contact:contact, dockDepartment:dockDepartment, dockPerson:dockPerson,
                dockContact:dockContact, relateDepartment:relateDepartment, relatePerson:relatePerson,
                relateContact:relateContact},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                $('#createCustomerForm').form('clear');
                addCustomerDialog.dialog('close');
                $.messager.alert('提示',"新增客户成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
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

    function submitDistribution(){
        var row = $('#dg').datagrid('getSelected');
        var customeId = row.id;
        var responsiblePerson = $('#responsiblePerson').val();
        $.ajax({
            type:'post',
            url:'/customer/distributionCustomer',
            dataType : "json",
            data:{customeId:customeId, responsiblePerson:responsiblePerson},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                distributionCustomerDialog.dialog('close');
                $.messager.alert('提示',"客户分配成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
            }
        });

    }

    function submitFeedback(){
        var row = $('#dg').datagrid('getSelected');
        var customerCode = row.customerCode;
        var customerName = row.customerName;
        var responsiblePerson = $('#f_responsiblePerson').val();
        var description = $('#f_description').val();
        $.ajax({
            type:'post',
            url:'/customer/createCustomerFeedback',
            dataType : "json",
            data:{customerCode:customerCode, customerName:customerName, responsiblePerson:responsiblePerson, description:description},
            cache:false,
            async:false,
            success:function(data){
                $.messager.progress('close');
                if(!data.success){
                    $.messager.alert('提示',data.message);
                }
                $('#dg').datagrid('reload');
                customerFeedbackDialog.dialog('close');
                $.messager.alert('提示',"客户反馈成功");
            },
            error:function(d){
                $.messager.alert('提示',"请刷新重试");
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
