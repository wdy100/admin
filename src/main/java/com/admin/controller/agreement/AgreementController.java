package com.admin.controller.agreement;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;  
  






import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.RequestMapping;  
  







import org.springframework.web.bind.annotation.ResponseBody;

import com.admin.entity.agreement.AgreementInfo;
import com.admin.entity.system.User;  
import com.admin.service.agreement.AgreementService;
import com.admin.service.system.UserService;  
import com.admin.web.util.HttpJsonResult;
import com.haier.common.ServiceResult;

@Controller
@RequestMapping("/agreementInfo") 
@Slf4j
public class AgreementController {  
    @Resource  
    private AgreementService agreementService;  

    @RequestMapping("/toAdd")  
    public String toAdd(HttpServletRequest request,Map<String, Object> stack){  
    	return "agreement/agreementAdd";
    }  
    
    @RequestMapping("/add")  
    @ResponseBody
    public HttpJsonResult<Map<String,Object>> add(HttpServletRequest request,AgreementInfo agreementInfo,Map<String, Object> stack){  
    	HttpJsonResult<Map<String,Object>> result=new HttpJsonResult<Map<String, Object>>();
    	Map<String,Object> resultMap=new HashMap<String, Object>();
    	if(agreementInfo.getId() == null ){
    		ServiceResult<Integer> resultId = agreementService.insertAgreementInfo(agreementInfo);
    		resultMap.put("id", resultId.getResult());
    	}else{
    		agreementService.updateAgreementInfo(agreementInfo);
    		resultMap.put("id", agreementInfo.getId());
    	}
    	result.setData(resultMap);
        return result;  
    }  
    
    @RequestMapping("/toApproval")  
    public String toApproval(HttpServletRequest request,AgreementInfo agreementInfo,Map<String, Object> stack){  
    	ServiceResult<AgreementInfo> result = agreementService.selectByIdAgreementInfo(agreementInfo);
    	stack.put("agreementInfo", result.getResult());
    	return "agreement/agreementApproval";
    }  
    
    @RequestMapping("/approval")  
    @ResponseBody
    public HttpJsonResult<Map<String,Object>> approval(HttpServletRequest request,AgreementInfo agreementInfo,Map<String, Object> stack){  
    	HttpJsonResult<Map<String,Object>> result=new HttpJsonResult<Map<String, Object>>();
    	Map<String,Object> resultMap=new HashMap<String, Object>();
		
    	agreementService.updateAgreementInfo(agreementInfo);
    	//保存到审核信息表
    	
		resultMap.put("id", agreementInfo.getId());
		
    	result.setData(resultMap);
        return result;  
    }  
}  