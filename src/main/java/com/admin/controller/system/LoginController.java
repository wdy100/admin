package com.admin.controller.system;
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

import com.admin.entity.system.User;  
import com.admin.service.system.UserService;  
import com.admin.web.util.HttpJsonResult;
import com.haier.common.ServiceResult;
  
@Controller
@Slf4j
public class LoginController {  
    @Resource  
    private UserService userService;  
    
    @RequestMapping(value = "/loginCommit", method = { RequestMethod.POST })
	@ResponseBody
	public HttpJsonResult<Object> loginCommit(HttpServletRequest request,
			HttpServletResponse response){
    	HttpJsonResult<Object> result = new HttpJsonResult<Object>();
//		String statusStr = StringUtils.defaultIfEmpty(request.getParameter("status"), "");
//		String id = StringUtils.defaultIfEmpty(request.getParameter("id"), "");
    	result.setData(true);
        return result;  
    }
    
    @RequestMapping("/index.html")
    public String index(HttpServletRequest request,Map<String, Object> stack){  
//        String mobile = request.getParameter("mobile");  
//        ServiceResult<User> result = this.userService.getByMobile(mobile); 
//        stack.put("user", result.getResult());
        return "index";
    }  
}  