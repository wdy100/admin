package com.admin.controller.system;
import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;  
  

import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.RequestMapping;  
  

import com.admin.entity.system.User;  
import com.admin.service.system.UserService;  
import com.haier.common.ServiceResult;
  
@Controller  
@RequestMapping("/system")  
public class UserController {  
    @Resource  
    private UserService userService;  
      
    @RequestMapping("/showUser")  
    public String toIndex(HttpServletRequest request,Model model){  
        String mobile = request.getParameter("mobile");  
        ServiceResult<User> result = this.userService.getByMobile(mobile);  
        model.addAttribute("user", result.getResult());  
        return "showUser";  
    }  
}  