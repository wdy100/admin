package com.admin.controller.agreement;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;  
  







import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.RequestMapping;  
  







import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.admin.entity.agreement.AgreementInfo;
import com.admin.entity.system.Role;
import com.admin.entity.system.User;  
import com.admin.service.agreement.AgreementService;
import com.admin.service.system.UserService;  
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