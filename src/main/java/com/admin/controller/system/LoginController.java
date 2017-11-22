package com.admin.controller.system;
import java.util.Map;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;  
  






import javax.servlet.http.HttpServletResponse;

import com.admin.entity.customer.Customer;
import com.admin.entity.system.UserInfo;
import com.admin.service.system.UserInfoService;
import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.RequestMapping;  
  



import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.admin.entity.system.User;  
import com.admin.service.system.UserService;  
import com.admin.web.util.HttpJsonResult;
import com.haier.common.ServiceResult;
  
@Controller
@Slf4j
public class LoginController {  
    @Resource  
    private UserInfoService userInfoService;
    
    @RequestMapping(value = "/loginCommit", method = { RequestMethod.POST })
	@ResponseBody
	public Object loginCommit(HttpServletRequest request,
			HttpServletResponse response){
    	HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        ServiceResult<UserInfo> result = userInfoService.login(userName, password, "");
        if (!result.getSuccess()) {
            log.error(result.getMessage());
            jsonResult.setMessage(result.getMessage());
            jsonResult.setData(false);
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }
    
    @RequestMapping("/index.html")
    public String index(HttpServletRequest request,Map<String, Object> stack){  
//        String mobile = request.getParameter("mobile");  
//        ServiceResult<User> result = this.userService.getByMobile(mobile); 
//        stack.put("user", result.getResult());
        return "index";
    }  
}  