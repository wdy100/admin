package com.admin.controller.customer;

import com.admin.entity.system.User;
import com.admin.service.system.UserService;
import com.admin.web.util.WebUtil;
import com.haier.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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
    private UserService userService;

    @RequestMapping(value = "customer.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        String mobile = "18765996558";
        ServiceResult<User> result = this.userService.getByMobile(mobile);
        dataMap.put("user", result.getResult());
        return "customer/customer_list";
    }
    
    @RequestMapping("/customerList")
    public String customerList(HttpServletRequest request,Map<String, Object> dataMap){
        String mobile = request.getParameter("mobile");  
        ServiceResult<User> result = this.userService.getByMobile(mobile); 
        log.info("测试2");
        //model.addAttribute("user", result.getResult());
        dataMap.put("user", result.getResult());
        return "showUser2";  
    }  
}  