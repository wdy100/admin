<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>淼盾CRM系统</title>
<link href="assets/css/login_index.css"  rel="stylesheet" />
<script type="text/javascript" src="assets/js/jquery-1.8.3.min.js"></script>
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
		            <li style="text-align: right;padding-top:0 ;"><a href="#" /> 注册账号</a></li>
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
    
</body>
</html>
