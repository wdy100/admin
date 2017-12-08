package com.admin.controller.api;

import com.admin.entity.system.UserInfo;
import com.admin.service.system.UserInfoService;
import com.admin.web.util.PasswordUtil;
import com.admin.web.util.SessionSecurityConstants;
import com.admin.web.util.Signatures;
import com.alibaba.fastjson.JSONObject;
import com.google.common.base.Throwables;
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
import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping("/api")
@Slf4j
public class AppLoginController {
    @Resource  
    private UserInfoService userInfoService;
    
    @RequestMapping(value = "/login", method = { RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public void login(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userName",required = true) String userName,
            @RequestParam(value="password",required = true) String password,
            HttpServletRequest request,
			HttpServletResponse response)throws IOException {
        log.info("[AppLoginController][login] /login accepted token:{}, userName:{}, password:{}",
                token, userName, password);
        JSONObject json = new JSONObject();
        json.put("success", true);
        PrintWriter out = response.getWriter();
        try {
            String key = "CRM";
            Boolean signFlag = Signatures.verify(request, key);
            if (!signFlag) {
                log.error("token未通过验证");
                json.put("success", false);
                json.put("error", "103");
                json.put("msg", "token错误");
            }else{
                ServiceResult<UserInfo> result = userInfoService.login(userName, password, "");
                if (!result.getSuccess()) {
                    log.error(result.getMessage());
                    json.put("success", false);
                    json.put("error", "201");
                    json.put("msg", "账号密码不正确");
                }else{
                    UserInfo user = result.getResult();
                    json.put("user", user);
                    request.getSession().setAttribute(SessionSecurityConstants.KEY_USER_ID, user.getId());
                    request.getSession().setAttribute(SessionSecurityConstants.KEY_USER_NAME, user.getUserName());
                    request.getSession().setAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME, user.getNickName());
                }
            }
        }catch (Exception e) {
            log.error("[AppLoginController][login] /login accepted token:{}, userName:{}, password:{}, error:{}",
                    token, userName, password, Throwables.getStackTraceAsString(e));
            json.put("success", false);
            json.put("error", "105");
            json.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(json.toString());
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping(value = "/resetPasswordByApp", method = { RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void resetPasswordByApp(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="id",required = true) String id,
            @RequestParam(value="newPassword",required = true) String newPassword,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppLoginController][resetPasswordByApp] /resetPasswordByApp accepted token:{}, id:{}, newPassword:{}",
                token, id, newPassword);
        JSONObject json = new JSONObject();
        json.put("success", true);
        PrintWriter out = response.getWriter();
        try {
            String key = "CRM";
            Boolean signFlag = Signatures.verify(request, key);
            if (!signFlag) {
                log.error("token未通过验证");
                json.put("success", false);
                json.put("error", "103");
                json.put("msg", "token错误");
            }else{
                UserInfo userInfo = new UserInfo();
                userInfo.setId(Long.parseLong(id));
                userInfo.setPassword(PasswordUtil.encrypt(newPassword));
                //userInfo.setPassword(newPassword);
                ServiceResult<UserInfo> result = userInfoService.updateUserInfo(userInfo);
                if (!result.getSuccess()) {
                    log.error("重置密码失败！");
                    json.put("success", false);
                    json.put("error", "201");
                    json.put("msg", "重置密码失败，" + result.getMessage());
                }
            }
        }catch (Exception e) {
            log.error("[AppLoginController][resetPasswordByApp] /resetPasswordByApp accepted token:{}, id:{}, newPassword:{}, error:{}",
                    token, id, newPassword, Throwables.getStackTraceAsString(e));
            json.put("success", false);
            json.put("error", "105");
            json.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(json.toString());
        response.getWriter().flush();
        response.getWriter().close();
    }

}  