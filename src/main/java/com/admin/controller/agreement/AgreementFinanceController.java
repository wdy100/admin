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

import com.admin.entity.agreement.AgreementApproval;
import com.admin.entity.agreement.AgreementGoods;
import com.admin.entity.agreement.AgreementInfo;
import com.admin.service.agreement.AgreementService;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.Util;
import com.admin.web.util.WebUtil;
import com.google.common.collect.Maps;
import com.haier.common.BusinessException;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;
import com.haier.common.util.JsonUtil;

@Controller
@RequestMapping("/agreementFinance") 
@Slf4j
public class AgreementFinanceController {  
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
        return "agreement/agreementFinanceList";
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
            criteria.put("approvalStatus", "4");//合同签订完成！
            
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
    
}  