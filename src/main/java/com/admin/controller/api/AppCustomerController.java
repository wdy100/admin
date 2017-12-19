package com.admin.controller.api;

import com.admin.entity.customer.Customer;
import com.admin.entity.customer.CustomerContact;
import com.admin.entity.system.Department;
import com.admin.entity.system.Role;
import com.admin.entity.system.UserInfo;
import com.admin.service.customer.CustomerService;
import com.admin.service.system.DepartmentService;
import com.admin.service.system.RoleService;
import com.admin.service.system.UserInfoService;
import com.admin.web.util.PasswordUtil;
import com.admin.web.util.SessionSecurityConstants;
import com.admin.web.util.Signatures;
import com.admin.web.util.WebUtil;
import com.google.common.base.Throwables;
import com.google.common.collect.Maps;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;
import com.haier.common.util.JsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/api")
@Slf4j
public class AppCustomerController {
    @Resource  
    private UserInfoService userInfoService;

    @Resource
    private RoleService roleService;

    @Resource
    private DepartmentService departmentService;

    @Resource
    private CustomerService customerService;
    
    @RequestMapping(value = "/createCustomer", method = { RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public void createCustomer(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="customerName",required = true) String customerName,
            @RequestParam(value="typeName",required = false) String typeName,
            @RequestParam(value="phone",required = false) String phone,
            @RequestParam(value="fax",required = false) String fax,
            @RequestParam(value="address",required = false) String address,
            @RequestParam(value="url",required = false) String url,
            @RequestParam(value="manager",required = false) String manager,
            @RequestParam(value="contact",required = false) String contact,
            @RequestParam(value="dockDepartment",required = false) String dockDepartment,
            @RequestParam(value="dockPerson",required = false) String dockPerson,
            @RequestParam(value="dockContact",required = false) String dockContact,
            @RequestParam(value="relateDepartment",required = false) String relateDepartment,
            @RequestParam(value="relatePerson",required = false) String relatePerson,
            @RequestParam(value="relateContact",required = false) String relateContact,
            @RequestParam(value="electricContactName",required = false) String electricContactName,
            @RequestParam(value="electricContactPost",required = false) String electricContactPost,
            @RequestParam(value="electricPhone",required = false) String electricPhone,
            @RequestParam(value="electricMobile",required = false) String electricMobile,
            @RequestParam(value="waterContactName",required = false) String waterContactName,
            @RequestParam(value="waterContactPost",required = false) String waterContactPost,
            @RequestParam(value="waterPhone",required = false) String waterPhone,
            @RequestParam(value="waterMobile",required = false) String waterMobile,
            @RequestParam(value="safeContactName",required = false) String safeContactName,
            @RequestParam(value="safeContactPost",required = false) String safeContactPost,
            @RequestParam(value="safePhone",required = false) String safePhone,
            @RequestParam(value="safeMobile",required = false) String safeMobile,
            @RequestParam(value="visualContactName",required = false) String visualContactName,
            @RequestParam(value="visualContactPost",required = false) String visualContactPost,
            @RequestParam(value="visualPhone",required = false) String visualPhone,
            @RequestParam(value="visualMobile",required = false) String visualMobile,
            @RequestParam(value="emergencyContactName",required = false) String emergencyContactName,
            @RequestParam(value="emergencyContactPost",required = false) String emergencyContactPost,
            @RequestParam(value="emergencyPhone",required = false) String emergencyPhone,
            @RequestParam(value="emergencyMobile",required = false) String emergencyMobile,
            @RequestParam(value="draft",required = false) String draft,
            HttpServletRequest request,
			HttpServletResponse response)throws IOException {
        log.info("[AppCustomerController][createCustomer] /createCustomer accepted token:{}, userId:{}, customerName:{}",
                token, userId, customerName);
        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("success", true);
        try {
            dataMap = VerifyTokenUtil.verify(request, dataMap);
            if (VerifyTokenUtil.VERIFY_SUCCESS.equals(dataMap.get("verifyPassed").toString())) {
                ServiceResult<UserInfo> userResult = userInfoService.getById(Long.parseLong(userId));
                if (!userResult.getSuccess()) {
                    log.error(userResult.getMessage());
                    dataMap.put("success", false);
                    dataMap.put("error", "");
                    dataMap.put("msg", "获取当前登录用户异常");
                }else{
                    UserInfo user = userResult.getResult();
                    Customer customer = new Customer();
                    //customer.setCustomerCode(customerCode);
                    customer.setCustomerName(customerName);
                    //customer.setTypeCode(typeCode);
                    customer.setTypeName(typeName);
                    customer.setPhone(phone);
                    customer.setFax(fax);
                    customer.setAddress(address);
                    customer.setUrl(url);
                    customer.setManager(manager);
                    customer.setContact(contact);
                    customer.setDockDepartment(dockDepartment);
                    customer.setDockPerson(dockPerson);
                    customer.setDockContact(dockContact);
                    customer.setRelateDepartment(relateDepartment);
                    customer.setRelatePerson(relatePerson);
                    customer.setRelateContact(relateContact);
                    customer.setCreatedBy(user.getNickName());
                    customer.setUpdatedBy(user.getNickName());
                    if(electricContactName != null && !"".equals(electricContactName)){
                        CustomerContact electric = new CustomerContact();
                        electric.setContactName(electricContactName);
                        electric.setContactPost(electricContactPost);
                        electric.setPhone(electricPhone);
                        electric.setMobile(electricMobile);
                        electric.setCreatedBy(user.getNickName());
                        electric.setUpdatedBy(user.getNickName());
                        customer.setElectric(electric);
                    }
                    if(waterContactName != null && !"".equals(waterContactName)){
                        CustomerContact water = new CustomerContact();
                        water.setContactName(waterContactName);
                        water.setContactPost(waterContactPost);
                        water.setPhone(waterPhone);
                        water.setMobile(waterMobile);
                        water.setCreatedBy(user.getNickName());
                        water.setUpdatedBy(user.getNickName());
                        customer.setWater(water);
                    }
                    if(safeContactName != null && !"".equals(safeContactName)){
                        CustomerContact safe = new CustomerContact();
                        safe.setContactName(safeContactName);
                        safe.setContactPost(safeContactPost);
                        safe.setPhone(safePhone);
                        safe.setMobile(safeMobile);
                        safe.setCreatedBy(user.getNickName());
                        safe.setUpdatedBy(user.getNickName());
                        customer.setSafe(safe);
                    }
                    if(visualContactName != null && !"".equals(visualContactName)){
                        CustomerContact visual = new CustomerContact();
                        visual.setContactName(visualContactName);
                        visual.setContactPost(visualContactPost);
                        visual.setPhone(visualPhone);
                        visual.setMobile(visualMobile);
                        visual.setCreatedBy(user.getNickName());
                        visual.setUpdatedBy(user.getNickName());
                        customer.setVisual(visual);
                    }
                    if(emergencyContactName != null && !"".equals(emergencyContactName)){
                        CustomerContact emergency = new CustomerContact();
                        emergency.setContactName(emergencyContactName);
                        emergency.setContactPost(emergencyContactPost);
                        emergency.setPhone(emergencyPhone);
                        emergency.setMobile(emergencyMobile);
                        emergency.setCreatedBy(user.getNickName());
                        emergency.setUpdatedBy(user.getNickName());
                        customer.setEmergency(emergency);
                    }
                    ServiceResult<Customer> result = customerService.createCustomer(customer);
                    if (!result.getSuccess()) {
                        log.error("新增客户失败！");
                        dataMap.put("success", false);
                        dataMap.put("error", "");
                        dataMap.put("msg", "新增客户失败" + result.getMessage());
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppCustomerController][createCustomer] /createCustomer accepted token:{}, userId:{}, customerName:{}, error:{}",
                    token, userId, customerName, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping(value = "/searchCustomer", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void searchCustomer(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="customerName",required = false) String customerName,
            @RequestParam(value="startAt",required = false) String startAt,
            @RequestParam(value="endAt",required = false) String endAt,
            @RequestParam(value="status",required = false) String status,
            @RequestParam(value="draft",required = false) String draft,
            @RequestParam(value="pageSize",required = true) String pageSize,
            @RequestParam(value="pageIndex",required = true) String pageIndex,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppCustomerController][searchCustomer] /searchCustomer accepted token:{}, userId:{}, customerName:{}, startAt:{}, endAt:{}, status:{}, draft:{}",
                token, userId, customerName, startAt, endAt, status, draft);
        Map<String, Object> dataMap = new HashMap<String, Object>();
        Map <String, Object> criteria = Maps.newHashMap();
        dataMap.put("success", true);
        try {
            dataMap = VerifyTokenUtil.verify(request, dataMap);
            if (VerifyTokenUtil.VERIFY_SUCCESS.equals(dataMap.get("verifyPassed").toString())) {
                ServiceResult<UserInfo> userResult = userInfoService.getById(Long.parseLong(userId));
                if (!userResult.getSuccess()) {
                    log.error(userResult.getMessage());
                    dataMap.put("success", false);
                    dataMap.put("error", "");
                    dataMap.put("msg", "获取当前登录用户异常");
                }else{
                    UserInfo user = userResult.getResult();
                    if(customerName != null && !"".equals(customerName)){
                        criteria.put("customerName", customerName);
                    }
                    if(startAt != null && !"".equals(startAt)){
                        criteria.put("createdAtStart", startAt);
                    }
                    if(endAt != null && !"".equals(endAt)){
                        criteria.put("createdAtEnd", endAt);
                    }
                    if(status != null && !"".equals(status)){
                        criteria.put("status", status);
                    }
                    if(draft != null && !"".equals(draft)){
                        criteria.put("draft", draft);
                    }
                    PagerInfo pager = new PagerInfo(Integer.parseInt(pageSize), Integer.parseInt(pageIndex));
                    ServiceResult<Map<String, Object>> serviceResult = customerService.searchCustomers(criteria, pager);
                    if(serviceResult.getSuccess()){
                        Map<String, Object> map = serviceResult.getResult();
                        if(map!=null&&map.size()>0){
                            List<Customer> list = (List<Customer>)map.get("data");
                            List< Map<String, Object>> customerList = new ArrayList<Map<String, Object>>();
                            for(Customer cus : list){
                                Map<String, Object> customer = new HashMap<String, Object>();
                                customer.put("id", cus.getId());
                                customer.put("customerName", cus.getCustomerName());
                                customer.put("status", "");//TODO
                                customer.put("draft", "");//TODO
                                customerList.add(customer);
                            }
                            int total = (Integer)map.get("total");
                            dataMap.put("total", total);
                            dataMap.put("customerList", customerList);
                        }
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppCustomerController][searchCustomer] /searchCustomer accepted token:{}, userId:{}, customerName:{}, error:{}",
                    token, userId, customerName, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

}  