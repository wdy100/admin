package com.admin.controller.customer;

import com.admin.entity.customer.Customer;
import com.admin.entity.customer.CustomerFeedback;
import com.admin.service.customer.CustomerFeedbackService;
import com.admin.service.customer.CustomerService;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.WebUtil;
import com.google.common.base.Throwables;
import com.google.common.collect.Maps;
import com.haier.common.BusinessException;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;
import com.haier.common.util.JsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 *
 * Created by GaoJingFei on 2017/11/13.
 */

@Controller  
@RequestMapping("/customer")
@Slf4j
public class CustomerFeedbackController {
    @Resource  
    private CustomerFeedbackService customerFeedbackService;

    @RequestMapping(value = "customerFeedback.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        return "customer/customerFeedback_list";
    }

    @RequestMapping("/customerFeedbackList")
    public void customerFeedbackList(HttpServletRequest request, HttpServletResponse response, Map<String, Object> dataMap){
        Map <String, Object> criteria = Maps.newHashMap();
        try {
            String customerName = request.getParameter("q_customerName");
            if(customerName != null && !"".equals(customerName)){
                criteria.put("customerName", customerName);
            }
            PagerInfo pager = WebUtil.handlerPagerInfo(request, dataMap);
            ServiceResult<Map<String, Object>> serviceResult = customerFeedbackService.searchCustomerFeedbacks(criteria, pager);
            if(serviceResult.getSuccess()){
                Map<String, Object> map = serviceResult.getResult();
                if(map!=null&&map.size()>0){
                    List<CustomerFeedback> list = (List<CustomerFeedback>)map.get("data");
                    int total = (Integer)map.get("total");
                    dataMap.put("total", total);
                    dataMap.put("rows", list);
                    response.setContentType("application/json;charset=UTF-8");
                    response.getWriter().write(JsonUtil.toJson(dataMap));
                    response.getWriter().flush();
                    response.getWriter().close();
                }
            }
        }catch (Exception e) {
            log.error("查询客户列表失败，error={},condition={}", Throwables.getStackTraceAsString(e),criteria);
            throw new BusinessException("查询客户列表失败");
        }
    }

    /**
     * 新增
     * @param request
     * @return
     */
    @RequestMapping(value = "/createCustomerFeedback", method = RequestMethod.POST)
    @ResponseBody
    public Object createCustomerFeedback(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String customerCode = request.getParameter("customerCode");
        String customerName = request.getParameter("customerName");
        String responsiblePerson = request.getParameter("responsiblePerson");
        String description = request.getParameter("description");

        CustomerFeedback customerFeedback = new CustomerFeedback();
        customerFeedback.setCustomerCode(customerCode);
        customerFeedback.setCustomerName(customerName);
        customerFeedback.setResponsiblePerson(responsiblePerson);
        customerFeedback.setDescription(description);
        customerFeedback.setCreatedBy("system");
        customerFeedback.setUpdatedBy("system");
        ServiceResult<CustomerFeedback> result = customerFeedbackService.createCustomerFeedback(customerFeedback);
        if (!result.getSuccess()) {
            log.error("新增客户反馈失败！");
            jsonResult.setMessage("新增客户反馈失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }



}  