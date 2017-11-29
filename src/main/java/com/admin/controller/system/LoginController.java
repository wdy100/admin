package com.admin.controller.system;
import com.admin.entity.system.UserInfo;
import com.admin.service.system.UserInfoService;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.SessionSecurityConstants;
import com.haier.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;
  
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
        UserInfo user = result.getResult();
        request.getSession().setAttribute(SessionSecurityConstants.KEY_USER_ID, user.getId());
        request.getSession().setAttribute(SessionSecurityConstants.KEY_USER_NAME, user.getUserName());
        request.getSession().setAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME, user.getNickName());

        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }
    
    @RequestMapping("/index.html")
    public String index(HttpServletRequest request,Map<String, Object> stack){
        Long userId = (Long)(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_ID));
        if (null == userId) {
            log.error("[LoginController][index] userId不存在,userId={}", userId);
            return "redirect:/login.html";
        }
        ServiceResult<UserInfo> result = userInfoService.getById(userId);
        if (!result.getSuccess() || result.getResult() == null) {
            log.error("[LoginController][index] 根据userId查不到用户信息,userId={}", userId);
            return "redirect:/login.html";
        }
        UserInfo user = result.getResult();
        stack.put("user", user);
        return "index";
    }  
}  