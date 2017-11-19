﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>淼盾CRM系统</title>
<link href="assets/css/login_index.css"  rel="stylesheet" />
<#include "./common/easyui_core.ftl"/>
<script type="text/javascript">
        function loginCommit() {
        	var userName = $("#userName").val();
        	var password = $("#password").val();
            if (userName == "") {
                $("#userName").focus();
                alert("用户名不能为空");
                return false;
            }
            if (password == "") {
                $("#password").focus();
                alert("密码不能为空");
                return false;
            }
           $.ajax({
		        url:'/loginCommit',
		        dataType : 'json',
		        type : 'POST',
		        async:false,
		        data:{userName:userName, password:password},
		        success: function (data){
					if(data.data){
	            		window.location.href = "/index.html";
	                }else{
	                	window.location.href = "/index.html";
	                }
		        }
			});
        }

        function apply(){
            $("#applyDiv").dialog({
                title: '新增部门',
                width: 340,
                height: 250,
                top: 100,
                closed: true,
                cache: false,
                modal: true,
                buttons:[{
                    text:'保存',
                    iconCls:'icon-ok',
                    handler:function(){
                        applyCommit();
                    }
                },{
                    text:'取消',
                    iconCls:'icon-cancel',
                    handler:function(){
                        $('#applyDiv').dialog('close');
                    }
                }]
            });
            $('#duserName').textbox("setValue","");
            $('#dpassword').textbox("setValue","");
            $('#dmobile').textbox("setValue","");
            $('#demail').textbox("setValue","");
            $('#dnickName').textbox("setValue","");
            $("#applyDiv").dialog("open");
        }

        function applyCommit(){
            var userName = $('#duserName').val();
            var password = $('#dpassword').val();
            var mobile = $('#dmobile').val();
            var email = $('#demail').val();
            var nickName = $('#dnickName').val();
            $.ajax({
                type:'post',
                url:'/system/createUser',
                dataType : "json",
                data:{userName:userName, password:password, mobile:mobile, email:email, nickName:nickName},
                cache:false,
                async:false,
                success:function(data){
                    $.messager.progress('close');
                    if(!data.success){
                        $.messager.alert('提示',data.message);
                    }
                    $('#applyDiv').dialog('close');
                    $.messager.alert('提示',"您的注册信息已提交成功，审核通过后即可登录使用系统");
                },
                error:function(d){
                    $.messager.alert('提示',"请刷新重试");
                }
            });
        }

    </script>
</head>
<body>   
    <div class="login-all">   	    
	    <div class="login">
	     	<img src="assets/images/loginlong.png" width="342" height="95" alt="" />
		    <div class="loginfrom">
		        <ul>
		            <li>用 &nbsp;&nbsp;户：  <input type="text" id="userName" name="userName" ></input></li>
		            <li>密 &nbsp;&nbsp;码：   <input id="password" id="password"  type="password" ></input></li>
		            <li style="text-align: right;padding-top:0 ;"><a href="#" onclick="apply();"/> 注册账号</a></li>
		        </ul>
		    </div>
		    <div class="loginbtn">
		    	<input ID="ImageButton1"  type="image" 
		    		src="assets/images/login.png" width="275" height="33" 
		    		onclick="loginCommit()" 
		    	/>               
	       </div>	        
	    </div> 
	    <div class="logincopy">版权所有 @ 淼盾物联 Copyright &copy; 2015 </div>
		    
	    
    </div>

    <!-- 注册 -->
    <div id="applyDiv"  class="easyui-dialog" title=""   closed="true"
         data-options="resizable:true,modal:true" >
        <table style="font-weight: 400;" border="0">
            <tr>
                <td style="text-align: right;">用户名<span class="star">*</span>:</td>
                <td>
                    <input id="duserName" name="duserName" size="54" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width: 200px;"/></td>
            </tr>
            <tr>
                <td style="text-align: right;">密码<span class="star">*</span>:</td>
                <td><input id="dpassword" name="dpassword" size="54" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width: 200px;"/></td>
            </tr>

            <tr>
                <td style="text-align: right;">手机号<span class="star">*</span>:</td>
                <td><input id="dmobile" name="dmobile" size="54" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width: 200px;"/></td>
            </tr>

            <tr>
                <td style="text-align: right;">邮箱:</td>
                <td><input id="demail" name="demail" size="54" class="easyui-textbox" style="width: 200px;"/></td>
            </tr>

            <tr>
                <td style="text-align: right;">真实姓名<span class="star">*</span>:</td>
                <td><input id="dnickName" name="dnickName" size="54" class="easyui-textbox" data-options="required:true,missingMessage:'该输入项为必输项'" style="width: 200px;"/></td>
            </tr>

        </table>

    </div>
    
</body>
</html>
