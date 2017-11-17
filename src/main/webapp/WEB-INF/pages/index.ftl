<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>淼盾CRM客户管理系统</title>
<link href="assets/css/login_index.css"  rel="stylesheet" />
<script type="text/javascript" src="assets/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="js/main.js"></script>
   
</head>
<body>
    <!---TOP S--->
     <div class="top">
      <div class="logotitle">
       <div class="to3dcbd"> &nbsp;</div>
       <div class="nav">
           <ul>
              <li class="current"><a href="#">首页</a></li>            
              <li><a href="#">新增客户</a></li>
              <li><a href="#">合同签订</a></li>
              <li><a href="#">客户接入</a></li>
              <li><a href="#"></a></li>
              <li><a href="#"></a></li>                               
           </ul>
           <div class="clear"></div>           
       </div>
       <div class="welcomequit">您好，<strong id="User" >admin</strong><a href="#"> [退出]</a> <a href="#"> [网站首页]</a></div>
       </div>
      <div class="clear"></div>     
    </div>
    <!---TOP END--->
     <div class="main">
     <!--LEFT S--->
        <div class="left">        
	        <dl>
		        <dt>系统管理</dt>
		            <dd><a href="#">角色管理</a></dd>
		            <dd><a href="#">权限管理</a></dd>   
		            <dd><a href="#">用户管理</a></dd>        
		        <dt>客户管理</dt>
		             <dd><a href="#">客户接入</a></dd>
		             <dd><a href="#">客户反馈</a></dd>	                       
		        <dt>订单管理</dt>
		            <dd><a href="#">订单执行</a></dd>
		             <dd><a href="#">订单执行-工程部</a></dd> 
		            <dd><a href="#">订单查询</a></dd>
		            <dd><a href="#">订单查询-总监</a></dd>           
		        <dt>合同管理</dt>
		             <dd><a href="#">合同签订</a></dd>                
		             <dd><a href="#">合同变更</a></dd>
		             <dd><a href="#">合同查询</a></dd>	                           
		        <dt>财务管理</dt>                             
	        </dl>
        </div> 
     <!--LEFT END--->
       <div class="right" id="right" >
            <div class="location">
                             当前位置：首页  &gt;
				<a href="customer.html">合同签订</a> &gt;
				
            </div>
            <div class="mcontent">
					
                <div class="newedit">
					<strong style="color: #1361a6;line-height:30px">合同新增:</strong>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					  	
					   	<tr>
					    <td class="tdright" width="130">选择客户：</td>
					    <td> <select name="" style="width:170px;height: 24px;">
					           <option value="0">客户1</option>
					           <option value="1">客户2</option>
					           <option value="2">客户3</option>
					        </select>       
					    </td>
					  	</tr>
					  	<tr>
					    	<td class="tdright">合同签署单位：</td>
					    	<td><input name="" type="text" placeholder=""/></td>
					  	</tr>
					  	<tr>
					    	<td class="tdright">合同金额：</td>
					    	<td><input name="" type="text" placeholder=""/></td>
					  	</tr>
					  	<tr>
					    	<td class="tdright">合同年限：</td>
					    	<td><input name="" type="text" placeholder="" style="width:50px; text-align: center;"/>  年</td>
					  	</tr>
					  	<tr>
					    	<td class="tdright">合同起止时间：</td>
					    	<td>
					    		<input name="" type="text" placeholder=""/>
					    		——
					    		<input name="" type="text" placeholder=""/>
					    	</td>
					  	</tr>
					   	<tr>
					    	<td class="tdright">合同标的：</td>
					    	<td>
					    		<textarea name="" rows="" cols="" style="width: 500px;height: 100px;margin: 10px 0;" ></textarea>
					    		
					    	</td>
					  	</tr>
					  	
					</table>
					<div  class="naebtn">
					    <input id="Button1" type="submit"  Text="暂存" value="暂存" onclick="AddEdit_Click" OnClientClick=" return  test()" /> 
					    &nbsp;&nbsp;     
					    <input name="" type="reset" value="下一步"/>
					 	<div class="clear"></div>             
					</div>
				</div>            
            </div>
      </div>    
   </div>    
</body>
</html>
