package com.admin.controller.customer;

import com.admin.entity.customer.Customer;
import com.admin.service.customer.CustomerService;
import com.admin.service.system.ResourceInfoService;
import com.admin.web.util.ButtonConstant;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.SessionSecurityConstants;
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
public class CustomerController {
    @Resource
    private ResourceInfoService resourceInfoService;
    @Resource  
    private CustomerService customerService;

    @RequestMapping(value = "customer.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        Long userId = (Long)(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_ID));
        if (null == userId) {
            log.error("[CustomerController][index] userId不存在,userId={}", userId);
            return "redirect:/login.html";
        }
        Map<String, String> buttonsMap = resourceInfoService.getButtonCodeByUserId(userId);
        String showDistributionCustomerButton = "NO";
        String showCreateCustomerButton = "NO";
        String showFeedbackCustomerButton = "NO";
        if(buttonsMap.containsKey(ButtonConstant.CUSTOMER_DISTRIBUTION_CODE)){
            showDistributionCustomerButton = "YES";
        }
        if(buttonsMap.containsKey(ButtonConstant.CUSTOMER_ADD_CODE)){
            showCreateCustomerButton = "YES";
        }
        if(buttonsMap.containsKey(ButtonConstant.CUSTOMER_FEEDBACK_CODE)){
            showFeedbackCustomerButton = "YES";
        }
        dataMap.put("showDistributionCustomerButton", showDistributionCustomerButton);
        dataMap.put("showCreateCustomerButton", showCreateCustomerButton);
        dataMap.put("showFeedbackCustomerButton", showFeedbackCustomerButton);
        return "customer/customer_list";
    }

    @RequestMapping("/customerList")
    public void customerList(HttpServletRequest request, HttpServletResponse response, Map<String, Object> dataMap){
        Map <String, Object> criteria = Maps.newHashMap();
        try {
            String customerName = request.getParameter("q_customerName");
            if(customerName != null && !"".equals(customerName)){
                criteria.put("customerName", customerName);
            }
            PagerInfo pager = WebUtil.handlerPagerInfo(request, dataMap);
            ServiceResult<Map<String, Object>> serviceResult = customerService.searchCustomers(criteria, pager);
            if(serviceResult.getSuccess()){
                Map<String, Object> map = serviceResult.getResult();
                if(map!=null&&map.size()>0){
                    List<Customer> list = (List<Customer>)map.get("data");
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
    @RequestMapping(value = "/createCustomer", method = RequestMethod.POST)
    @ResponseBody
    public Object createCustomer(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String customerCode = request.getParameter("customerCode");
        String customerName = request.getParameter("customerName");
        String typeCode = request.getParameter("typeCode");
        String typeName = request.getParameter("typeName");
        String phone = request.getParameter("phone");
        String fax = request.getParameter("fax");
        String address = request.getParameter("address");
        String url = request.getParameter("url");
        String corporate = request.getParameter("corporate");
        String manager = request.getParameter("manager");
        String contact = request.getParameter("contact");
        String dockDepartment = request.getParameter("dockDepartment");
        String dockPerson = request.getParameter("dockPerson");
        String dockContact = request.getParameter("dockContact");
        String relateDepartment = request.getParameter("relateDepartment");
        String relatePerson = request.getParameter("relatePerson");
        String relateContact = request.getParameter("relateContact");
        Customer customer = new Customer();
        customer.setCustomerCode(customerCode);
        customer.setCustomerName(customerName);
        customer.setTypeCode(typeCode);
        customer.setTypeName(typeName);
        customer.setPhone(phone);
        customer.setFax(fax);
        customer.setAddress(address);
        customer.setUrl(url);
        customer.setCorporate(corporate);
        customer.setManager(manager);
        customer.setContact(contact);
        customer.setDockDepartment(dockDepartment);
        customer.setDockPerson(dockPerson);
        customer.setDockContact(dockContact);
        customer.setRelateDepartment(relateDepartment);
        customer.setRelatePerson(relatePerson);
        customer.setRelateContact(relateContact);
        customer.setCreatedBy("system");
        customer.setUpdatedBy("system");
        ServiceResult<Customer> result = customerService.createCustomer(customer);
        if (!result.getSuccess()) {
            log.error("新增客户失败！");
            jsonResult.setMessage("新增客户失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 分配
     * @param request
     * @return
     */
    @RequestMapping(value = "/distributionCustomer", method = RequestMethod.POST)
    @ResponseBody
    public Object distributionCustomer(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String customeId = request.getParameter("customeId");
        String responsiblePerson = request.getParameter("responsiblePerson");
        Customer customer = new Customer();
        customer.setId(Long.parseLong(customeId));
        customer.setResponsiblePerson(responsiblePerson);
        ServiceResult<Customer> result = customerService.updateCustomer(customer);
        if (!result.getSuccess()) {
            log.error("客户分配失败！");
            jsonResult.setMessage("客户分配失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

}  