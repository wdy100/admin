<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta property="wb:webmaster" content="6ffdc657eef2403e" />
<title>合同审核</title>
<meta name="generator" content="PEC" />
	<script type="text/javascript" src="${domainUrlUtil.staticURL}/portal/js/jquery-1.8.3.min.js"></script>
</head>
<body id="ehaiertop">

<div id="loading"></div>
<#assign form=JspTaglibs["/WEB-INF/tld/spring-form.tld"]>
<div class="bigwrapper">
	<div class="wrapper clearfix container-40">
		<!--位置导航-->
		<div class="">
			<a href=""><i class="icon-font icon-crumb"></i>首页</a> &gt;
				<span>合同管理</span> &gt;<strong class="now">合同审核</strong>
		</div>
		<div class="">
			
			<br/>
			<#if agreementInfo?? >
				<span style="margin-left:55px;">${agreementInfo.projectName}<em style="font-style:normal;color:#c7003a"></span>
	            <br/>
			</#if>
            
            <span style="margin-left:55px;">审核信息：<em style="font-style:normal;color:#c7003a">*</em></span>
				<textarea class="inl260" name="refuseInfo" id="refuseInfo" ></textarea>&nbsp;
			<span id="mainBankId_mes"></span>
            <br/>
            <input type="hidden" id="agreementId" name="agreementId" value="${(agreementInfo.agreementId)!''}"/>
            
            <button class="saveAgreement"  onclick="javascript:saveAgreement('1');" >通过</button>
            <button class="saveAgreement"  onclick="javascript:saveAgreement('2');" >不通过</button>
		</div>
  
	<!--主要内容-->
	<div class="wrapper_protocol">

	</div>
</div>
</div>

</form>
<input type="hidden" value="${(productId)!''}" name="productId" id="productId"/>
<#noescape>${footer!}</#noescape>
<script type="text/javascript">
    var rrs= rrs||{};
    rrs.domainUrl = {
    	baseDomain : '${domainUrlUtil.staticURL}'
    }
</script>
<script type="text/javascript">
	var dataJson1 = {};
	var dataJson2 = {};
	//function saveAgreement(){}
	// 保存用户信息
	function saveAgreement(approvalStatus){
		var approvalStatus = approvalStatus;
		var agreementId = $('#agreementId').val();
		var dataJson  = {id: agreementId,refuseInfo:refuseInfo,approvalStatus:approvalStatus};
		$.ajax({
			url:'/agreementInfo/approval?',
			type:'get',
			dataType:'json',
			data:dataJson,
			success:function(data){
				
			}
		});
	}
</script>

</body>
</html>