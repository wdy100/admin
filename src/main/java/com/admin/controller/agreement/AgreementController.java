package com.admin.controller.agreement;
import java.util.Map;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;  
  
import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.RequestMapping;  
  



import com.admin.entity.system.User;  
import com.admin.service.system.UserService;  
import com.haier.common.ServiceResult;
  
@Controller  
@RequestMapping("/agreement") 
@Slf4j
public class AgreementController {  
    @Resource  
    private UserService userService;  
      
    @RequestMapping("/showUser")  
    public String toIndex(HttpServletRequest request,Model model){  
        String mobile = request.getParameter("mobile");  
        ServiceResult<User> result = this.userService.getByMobile(mobile);  
        model.addAttribute("user", result.getResult());  
        return "showUser";  
    }  
    
    @RequestMapping("/showUser2")  
    public String showUser2(HttpServletRequest request,Model model,Map<String, Object> stack){  
        String mobile = request.getParameter("mobile");  
        ServiceResult<User> result = this.userService.getByMobile(mobile); 
        log.info("测试2");
        //model.addAttribute("user", result.getResult());
        stack.put("user", result.getResult());
        return "showUser2";  
    }  
}  