package com.admin.controller.agreement;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;  
  







import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;  
  







import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.admin.entity.agreement.AgreementGoods;
import com.admin.entity.agreement.AgreementInfo;
import com.admin.service.agreement.AgreementService;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.WebUtil;
import com.google.common.collect.Maps;
import com.haier.common.BusinessException;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;
import com.haier.common.util.JsonUtil;

@Controller
@RequestMapping("/agreementInfo") 
@Slf4j
public class AgreementController {  
    @Resource  
    private AgreementService agreementService;  

    /** mvc 将string类型转换为 Date*/
    @InitBinder
    public void bindingPreparation(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        CustomDateEditor orderDateEditor = new CustomDateEditor(dateFormat, true);
        binder.registerCustomEditor(Date.class, orderDateEditor);
    }
    
    @RequestMapping(value = "agreement.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request, Model model) throws Exception {
        return "agreement/agreementList";
    }
    
    @RequestMapping(value = { "agreementList" })
    public void roleList(HttpServletRequest request, HttpServletResponse response,
                              Map<String, Object> modelMap) {
        Map <String, Object> criteria = Maps.newHashMap();
        try {
        	//查询参数
            String q_firstParty = request.getParameter("q_firstParty");
            if(q_firstParty != null && !"".equals(q_firstParty)){
                criteria.put("firstParty", q_firstParty);
            }
            String q_approvalStatus = request.getParameter("q_approvalStatus");
            if(q_approvalStatus != null && !"".equals(q_approvalStatus)){
            	criteria.put("approvalStatus", q_approvalStatus);
            }
            
            String q_agreeDate = request.getParameter("q_agreeDate");
            if(q_agreeDate != null && !"".equals(q_agreeDate)){
            	criteria.put("agreeDate", q_agreeDate);
            }
            
            
            PagerInfo pager = WebUtil.handlerPagerInfo(request, modelMap);
            ServiceResult<Map<String, Object>> serviceResult = agreementService.getAgreementList(criteria, pager);
            if(serviceResult.getSuccess()){
                Map<String, Object> map = serviceResult.getResult();
                if(map!=null&&map.size()>0){
                    List<AgreementInfo> list = (List<AgreementInfo>)map.get("data");
                    int total = (Integer)map.get("total");
                    modelMap.put("total", total);
                    modelMap.put("rows", list);
                    response.setContentType("application/json;charset=UTF-8");
                    response.getWriter().write(JsonUtil.toJson(modelMap));
                    response.getWriter().flush();
                    response.getWriter().close();
                }
            }
        } catch (IOException e) {
            log.error("合同列表查询失败", e);
            throw new BusinessException("合同列表查询失败" + e.getMessage());
        }
    }
    
    @RequestMapping("/toAdd")  
    public String toAdd(HttpServletRequest request,Map<String, Object> stack){  
    	return "agreement/agreementAdd";
    }  
    
    @RequestMapping( value ="/add", method = { RequestMethod.POST })
    public String add(HttpServletRequest request,AgreementInfo agreementInfo,
    				Map<String, Object> stack){  
    	
    	List<AgreementGoods> goodsList = new ArrayList<AgreementGoods>();
    	
    	String[] systemNames = request.getParameterValues("systemName");
    	String[] hardwareNames = request.getParameterValues("hardwareName");
    	String[] goodsNums = request.getParameterValues("goodsNum");
    	String[] prices = request.getParameterValues("price");
    	String[] hardwareAmounts = request.getParameterValues("hardwareAmount");
    	String[] serviceAmounts = request.getParameterValues("serviceAmount");
    	String[] allAmounts = request.getParameterValues("allAmount");
    	 for(int i = 0; i < systemNames.length; i++){
    		 if(systemNames[i]!=null && systemNames[i].length()>0){//输入框有值
    			 AgreementGoods agreementGoods = new AgreementGoods();
    			 agreementGoods.setSystemName(systemNames[i]);
    			 agreementGoods.setHardwareName(hardwareNames[i]);
    			 agreementGoods.setGoodsNum(Integer.valueOf(goodsNums[i]));
    			 agreementGoods.setPrice(new BigDecimal(prices[i]));
    			 agreementGoods.setHardwareAmount(new BigDecimal(hardwareAmounts[i]));
    			 agreementGoods.setServiceAmount(new BigDecimal(serviceAmounts[i]));
    			 agreementGoods.setAllAmount(new BigDecimal(allAmounts[i]));
    			 
    			 goodsList.add(agreementGoods);
    		 }
    	 }
    	try {
	    	if(agreementInfo.getId() == null ){
	    		ServiceResult<Integer> resultId = agreementService.insertAgreementInfo(agreementInfo,goodsList);
	    	}else{
	    		agreementService.deleteAgreementGoods(agreementInfo.getId());
	    		agreementService.updateAgreementInfo(agreementInfo,goodsList);
	    	}
    	} catch (Exception e) {
             log.error("合同信息保存失败", e);
             throw new BusinessException("合同信息保存失败" + e.getMessage());
        }
    	
        return "redirect:agreement.html";
    }
    
    @RequestMapping("/toEdit")  
    public String toEdit(HttpServletRequest request,
    		AgreementInfo agreementInfo,Map<String, Object> stack){ 
    	ServiceResult<AgreementInfo> agreementInfoResult= agreementService.selectAgreementInfoById(agreementInfo);
    	if(agreementInfoResult!=null && agreementInfoResult.getSuccess() && agreementInfoResult.getResult()!=null){
    		ServiceResult<List<AgreementGoods>> agreementGoodsListResult = agreementService.selectAgreementGoodsByAgreementInfoId(agreementInfo.getId());
    		stack.put("agreementInfo", agreementInfoResult.getResult());
    		stack.put("agreementGoodsList", agreementGoodsListResult.getResult());
    	}
    	return "agreement/agreementEdit";
    }  
    
    @RequestMapping("/toApproval")  
    public String toApproval(HttpServletRequest request,AgreementInfo agreementInfo,Map<String, Object> stack){  
    	ServiceResult<AgreementInfo> result = agreementService.selectAgreementInfoById(agreementInfo);
    	stack.put("agreementInfo", result.getResult());
    	return "agreement/agreementApproval";
    }  
    
    @RequestMapping("/approval")  
    @ResponseBody
    public HttpJsonResult<Map<String,Object>> approval(HttpServletRequest request,AgreementInfo agreementInfo,Map<String, Object> stack){  
    	HttpJsonResult<Map<String,Object>> result=new HttpJsonResult<Map<String, Object>>();
    	Map<String,Object> resultMap=new HashMap<String, Object>();
		
    	//agreementService.updateAgreementInfo(agreementInfo);
    	//保存到审核信息表
    	
		resultMap.put("id", agreementInfo.getId());
		
    	result.setData(resultMap);
        return result;  
    }  
    
    @RequestMapping("/delete")  
    @ResponseBody
    public HttpJsonResult<Map<String,Object>> delete(HttpServletRequest request,String id,Map<String, Object> stack){  
    	HttpJsonResult<Map<String,Object>> result=new HttpJsonResult<Map<String, Object>>();
    	Map<String,Object> resultMap=new HashMap<String, Object>();
    		ServiceResult<Boolean> resultId = agreementService.deleteAgreementInfo(Long.valueOf(id));
    		resultMap.put("id", resultId.getResult());
    	result.setData(resultMap);
        return result;  
    }  
}  