<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta property="wb:webmaster" content="6ffdc657eef2403e" />
	<title>合同签订</title>
	<#include "../common/easyui_core.ftl"/>
	<link href="${domainUrlUtil.staticURL}/css/styleAgreement.css"  rel="stylesheet" />
	
	<meta name="generator" content="PEC" />
</head>
<body id="ehaiertop">

<div id="loading"></div>
<#assign form=JspTaglibs["/WEB-INF/tld/spring-form.tld"]>
<#noescape>${header!}</#noescape>
<div class="bigwrapper">
	<div class="wrapper clearfix container-40">
		<!--位置导航-->
		<input id="printbtn" type="button" value="打印" style="margin:20px 0 0 200px;">
		<!--startprint1-->
		 <div class="newedit">
					<strong style="color: #1361a6;line-height:30px">合同详情:</strong>
					<div class="details">
						<div class="contract">
                            <div class="page1">
                                <p style="font-size: 30px">智慧消防安全服务云平台</p>
                                <p style="font-size: 30px;margin-bottom:100px;">服务合同</p>
                                <img src="${domainUrlUtil.staticURL}/images/image002.gif"/>
                                <strong style=" display:block;font-size: 50px">淼盾物联</strong>
                                <p style="font-size: 20px;margin-top:100px;">青岛淼盾八哥网络科技有限公司</p>
                                <p style="font-size: 20px;">二0一七年<span style="width:70px;display: inline-block"></span>月</p>
                            </div>
                            <p style="text-align: right">编号：2017010 </p>
                            <p class="patop20px">甲方：<span class="spanborbm" style="width:300px;">${(agreementInfo.firstParty)!''}</span>（以下简称甲方）</p>
                            <p class="patop20px">乙方：<span class="spanborbm" style="width:300px;"> 青岛淼盾八哥网络科技有限公司 </span>（以下简称乙方）</p>

                            <table class="contract-table" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="10%">合同编号</td>
                                    <td width="40%">${(agreementInfo.agreeSn)!''}</td>
                                    <td width="10%">业务类型</td>
                                    <td width="40%">产品销售</td>
                                </tr>
                                <tr>
                                    <td>甲方名称</td>
                                    <td></td>
                                    <td>乙方名称</td>
                                    <td>青岛淼盾八哥网络科技有限公司</td>
                                </tr>
                                <tr>
                                    <td>地址</td>
                                    <td></td>
                                    <td>地址</td>
                                    <td>山东省青岛市高新区同顺路8号青岛网谷2号楼7层703-2室</td>
                                </tr>
                                <tr>
                                    <td>联络人</td>
                                    <td></td>
                                    <td>联络人</td>
                                    <td>带出销售经理</td>
                                </tr>
                                <tr>
                                    <td>传真</td>
                                    <td></td>
                                    <td>传真</td>
                                    <td>0532-55678811</td>
                                </tr>
                                <tr>
                                    <td>电话</td>
                                    <td></td>
                                    <td>电话</td>
                                    <td>0532-55678812</td>
                                </tr>
                                <tr>
                                    <td>电子邮箱</td>
                                    <td></td>
                                    <td>电子邮箱</td>
                                    <td>qdmiaodun@163.com</td>
                                </tr>
                            </table>
                            <p></p>
                            <dl class="tc">
                                <dd> 就乙方为甲方提供火灾隐患巡查系统、电气火灾隐患监管服务系统，建筑消防用水监测系统，联网报警可视化系统，为明确双方权益，本着互惠互利，更好的服务甲方，经甲乙双方协商一致，签订以下协议条款，共同遵守：</dd>
                                <dt>一、服务内容和服务期限</dt>
                                <dd>
                                    1.1乙方依托智慧消防安全服务云平台监管服务系统（简称“监管系统”）为甲方安全数据，实时传输，隐患预警等服务，以便于甲方查看安装有乙方产品的电气线路运行情况，人员巡查情况，建筑用水信息，消
                                    防控制室和消防通道情况及相关的传感数据、统计管理数据和其他分析数据。为甲方提供实时信息传输。
                                </dd>
                                <dd>1.2乙方向甲方提供自数据生成之日起合同期内3年内被监测设备运行数据的保存和查询服务。</dd>
                                <dd>1.3乙方向甲方提供电气火灾隐患/故障分析在线支持服务。</dd>
                                <dd>1.4乙方发现安装产品的线路有异常情况，将立即通过APP及短信方式通知甲方指定的通讯联络人，如发现重大问题时将直接电话通知。</dd>
                                <dd>
                                    1.5甲乙双方约定上述服务的期限为3年（简称“服务期限”）。自设备安装调试完成之日起算。在服务期限届满之后，甲方同意继续由乙方提供服务，
                                    甲方按原合同约定内的定价服务费给乙方，若甲方对乙方的设备及服务满意，甲乙双方按原合同执行或重新签署服务协议。
                                </dd>
                                <dd>1.6乙方将电气火灾隐患监管服务系统的设备安装至甲方指定的地点并安装调试正常运转后，向甲方发出书面通知，若无异议，监管平台正式运行。</dd>
                                <dd>1.7甲方接到报警信息未及时处理，造成火灾与乙方无关；</dd>
                                <dd>1.8甲方不准私自拆除或者断掉网络，如因甲方人为造成网络信号掉线等甲方负责一切损失。</dd>
                            </dl>
                            <p class="patop20px">项目名称：<span class="spanborbm" style="width:300px;">在线编辑</span>消防安全服务云平台服务</p>
                            <p>货品清单、价款及支付</p>
                            <table class="contract-one" width="100%" border="0" cellspacing="0" cellpadding="0" id="listtable" style="text-align: center;margin-top: 30px">
                                <thead bgcolor="#eef3f7">
                                <tr>
                                    <td>系统名称</td>
                                    <td>硬件名称</td>
                                    <td>数量</td>
                                    <td>单价</td>
                                    <td>设备费合计(元）</td>
                                    <td>服务费（元/年）</td>
                                    <td>安装费及辅材费用合计（元/套）</td>
                                </tr>
                                </thead>
                                <tr>
                                    <td rowspan="2"><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>

                                </tr>
                                <tr>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                    <td><input type="checkbox" value="值" name="名称" checked="checked"/></td>
                                </tr>
                                <tr>
                                    <td>设备费合计</td>
                                    <td colspan="6">¥.00元</td>
                                </tr>
                                <tr>
                                    <td>安装费合计</td>
                                    <td colspan="6">¥.00元</td>
                                </tr>
                                <tr>
                                    <td>服务费合计</td>
                                    <td colspan="6">¥.00元</td>
                                </tr>
                                <tr>
                                    <td>费用总合计</td>
                                    <td colspan="6">¥.00元</td>
                                </tr>
                                <tr>
                                    <td>服务费</td>
                                    <td colspan="6">第二年√  月 √ 日起付 ¥.00元（每年）</td>
                                </tr>
                                <tr>
                                    <td>合同应付款总额：</td>
                                    <td colspan="6">√圆整  人民币小写：¥.00元</td>
                                </tr>
                                <tr>
                                    <td colspan="7" align="left" style="padding:10px">
                                        备注：<br/>
                                        1、上述费用包含设备的包装、运输费用；<br/>
                                        2、合同中的设备数量按实结算，设备如有增减，设备价格按照合同单价进行结算；<br/>
                                        3、退换货设备根据实际情况收取一定比例的调试费，且退换设备自收到之日起不能超过三个月。<br/>
                                        4、合同签订一星期后开始安装，总工程期限为十五天。<br/>
                                        5、支付方式：转账或支票。<br/>
                                        6、付款方式：合同签订后三日内全款支付 。<br/>
                                        7、税费：本报价为未税报价，如需开具发票，税费另计。<br/>
                                    </td>
                                </tr>
                            </table>
                            <dl class="tc">
                                <dt></dt>
                                <dd></dd>
                                <dt> 二、安全平台设置及使用的约定</dt>
                                <dd> 2.1安全平台的设置目的：依托智慧消防安全服务云平台，便于甲方实时监管自有设备的安全使用情况、监督检查执行人员工作情况，通过数据的反馈更简便的掌握监管数据和查询功能。</dd>
                                <dd>
                                    2.2服务内容：乙方定期（每周）通过电子邮件方式，向甲方指定的联系人发送指定主干线路的用电安全报告、电气火灾隐患/故障分析在线支持服务，监督检查执行人员的工作进展。
                                    乙方向甲方提供自数据生成之日起3年内被监测设备运行数据的保存和查询服务。
                                </dd>
                                <dd>
                                    2.3乙方拥有监管系统服务平台的所有权，给甲方提供的安全平台设置、开通后一次性收取第一年服务费，乙方开据正式发票，以后每年的服务费在相关年度年终前30日内支付。
                                    若在服务期限届满之后，甲方愿意继续由乙方提供服务，则由双方另行签署相关协议，并在到期前30日续交次年平台服务费。如没有变动项，也可按合同制定的服务费标准执行。
                                </dd>
                                <dd>
                                    2.4在服务期限内，乙方有权对监管系统及服务系统进行维护、更新和升级，甲方对此予以认可。乙方提供给甲方的监管系统服务账户和密码，是乙方在提供服务过程中识别甲方的唯一依据
                                    ，甲方应当严格保密并指定专人妥善保管。甲方及指定保管人均不得将账户和密码提供给除甲方指定的监管系统操作人员以外的任何第三方使用。因甲方及指定保管人泄露账户密码造成的损失后果，由甲方承担。
                                </dd>
                                <dd>
                                    2.5在服务期限内，乙方负责对甲方指定的监管系统操作人员进行培训，培训至操作人员达到熟练操作系统的水平，甲方予以协助和配合。
                                </dd>

                                <dt>三、设备检验标准、方法及质保期限约定</dt>
                                <dd>
                                    3.1 在签署本合同后，乙方有义务为甲方进行安装点的勘测、评估，并出具初步的勘
                                    测报告以及建议；甲方应予以安排人员配合并确认；
                                </dd>
                                <dd>3.2 乙方接到甲方安装同意意见书后15个工作日内进入现场安装、调试设备，甲方应为乙方提供安装、调试的便利；</dd>
                                <dd>3.3 安装过程中，乙方应严格按照现行的《中华人民共和国安全生产法》及《施工现场临时用电安全技术规范》中的有关安全操作规程施工，甲方应予配合；</dd>
                                <dd>
                                    3.4 乙方将设备安装至甲方指定的地点并调试正常运转后，向甲方发出书面通知，由甲方进行验收。甲方应在收到通知后3日内安排人员前往现场进行验收。若无异议，甲方应当当场签署验收合格文件；
                                    如甲方对产品质量存有异议，也亦于当日书面提出异议。《设备安装调试合格单》作为验收合格的依据，设备质保期自验收合格之日起12个月内。
                                </dd>
                                <dt>四、质量负责的条件及期限：</dt>
                                <dd>
                                    甲、乙双方交易产品自交（提）货之日起一年内，因产品本身的质量原因引起的故障，乙方免费更换，若因非产品本身的质量原因所引起的故障，甲方需根据乙方的收费标准支付必要的费用。
                                    乙方仅负责所提供货物的自身价值，而不承担超越货物自身价值的其他任何责任。
                                </dd>
                                <dt> 五、货物所有权及风险转移：</dt>
                                <dd>货物的所有权及货物的灭失、损毁的风险责任自甲方收到货物之日起转移至甲方。但甲方未履行支付价款义务的,货物所有权不发生转移，乙方有权自行处理货物而无须通知甲方。</dd>
                                <dt>六、免责和责任限制条款</dt>
                                <dd>因下列原因导致设备或监管平台无法正常运作的，乙方不承担责任：</dd>
                                <dd>6.1乙方预先通知的监管平台停机维护期间；</dd>
                                <dd>6.2因台风、地震、海啸、洪水、恐怖袭击等不可抗力之因素，造成乙方设备或监管平台故障不能提供服务的；</dd>
                                <dd>
                                    6.3安装过程中，若由甲方原因导致安装过程中发生人身、财产的损害事故的，甲
                                    方自行承担全部责任或者损失，与乙方无关。
                                </dd>
                                <dt>七、保密</dt>
                                <dd>甲方有对其获取的任何乙方保密信息（包括但不限于技术信息、价格等）承担保密义务，乙方有权自行保有、使用、处置服务平台监测到的信息；但未经甲方同意不得对外公布。</dd>
                                <dt>八、违约责任</dt>
                                <dd>
                                    甲方未按合同约定付款或未履行合同约定的其他相关义务致使提供服务时间推迟，乙方不承担任何责任，同时有权停止后期服务。若甲方未按照合同约定的义务使用产品，履行合同约定的相关义务，
                                    乙方有权解除合同，还应向乙方支付合同金额20%的违约金。给乙方造成损失的，甲方应予以赔偿。
                                </dd>
                                <dd>
                                    乙方未按照合同约定期限按期交货的、乙方交付的产品不符合合同约定质量的、乙方未及时维修设备、系统故障的，甲方有权解除合同，已支付的款项乙方应当退还，还应向甲方支付合同金额20%的违约金。
                                    给甲方造成损失的，乙方应予以赔偿。
                                </dd>
                                <dt>九、合同争议的解决方式</dt>
                                <dd>
                                    本合同在履行过程中发生争议，由双方协商解决。协商不成，任何一方均可向双方所在地或合同签订地人民法院诉讼解决。
                                </dd>
                                <dt>十、协议的生效</dt>
                                <dd> 10.1本合同自双方授权代表签字或加盖公章后生效。</dd>
                                <dd>10.2本合同壹式叁份，甲、乙双方各持壹份，消防支队留存壹份，具有同等的法律效力。协议附件及因本协议未尽事宜而签订的补充协议与本协议具有同等法律效力。</dd>
                            </dl>
                            <table class="gz" width="100%" border="0" cellspacing="0" cellpadding="0" style="text-align:left;margin-top: 30px;border: 1px solid #000">
                                <tr>
                                    <td width="50%">甲方（章）：</td>
                                    <td width="50%"> 乙方（章）青岛淼盾八哥网络科技有限公司</td>
                                </tr>
                                <tr>
                                    <td>住所：</td>
                                    <td>住所:山东省青岛市高新区同顺路青岛网谷2号楼703室</td>
                                </tr>
                                <tr>
                                    <td>法定代表人：</td>
                                    <td>法定代表人：孙素朋</td>
                                </tr>
                                <tr>
                                    <td>委托代理人：          （签字）</td>
                                    <td>委托代理人：             （签字）</td>
                                </tr>
                                <tr>
                                    <td> 电话：</td>
                                    <td> 电话：0532-55678816</td>
                                </tr>
                                <tr>
                                    <td>手机：</td>
                                    <td>手机：15318789168</td>
                                </tr>
                                <tr>
                                    <td>开户银行：</td>
                                    <td>开户行：交通银行青岛高新区支行</td>
                                </tr>
                                <tr>
                                    <td>帐号：</td>
                                    <td>账号：372005573018000012558</td>
                                </tr>
                                <tr>
                                    <td> 日期：2017年  月  日</td>
                                    <td> 日期：2017年  月  日</td>
                                </tr>

                            </table>



                            <p></p>
                            <p></p>
                        </div>

					</div>
				</div>
        <!--endprint1-->
	<!--主要内容-->
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
	
	var regex = /^\d+\.?\d{0,2}$/;
	var regex2= /^[1-9]\d*$/;
	
	$("#printbtn").click(function(){
		var bdhtml=window.document.body.innerHTML;//获取当前页的html代码
		var sprnstr="<!--startprint1-->";//设置打印开始区域
		var eprnstr="<!--endprint1-->";//设置打印结束区域
		var prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html
		var prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html
		window.document.body.innerHTML=prnhtml;
		window.print();
		window.document.body.innerHTML=bdhtml;
	});
	
</script>

</body>
</html>