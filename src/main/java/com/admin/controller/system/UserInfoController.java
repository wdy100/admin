package com.admin.controller.system;

import com.admin.entity.system.Department;
import com.admin.entity.system.User;
import com.admin.entity.system.UserInfo;
import com.admin.service.system.UserInfoService;
import com.admin.service.system.UserService;
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
import org.springframework.ui.Model;
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
@RequestMapping("/system") 
@Slf4j
public class UserInfoController {
    @Resource
    private UserInfoService userInfoService;

    @RequestMapping(value = "user.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request, Model model) throws Exception {
        return "system/user_list";
    }

    @RequestMapping("/userInfoList")
    public void userInfoList(HttpServletRequest request, HttpServletResponse response, Map<String, Object> dataMap){
        Map <String, Object> criteria = Maps.newHashMap();
        try {
            String nickName = request.getParameter("nickName");
            if(nickName != null && !"".equals(nickName)){
                criteria.put("nickName", nickName);
            }
            PagerInfo pager = WebUtil.handlerPagerInfo(request, dataMap);
            ServiceResult<Map<String, Object>> serviceResult = userInfoService.searchUserInfos(criteria, pager);
            if(serviceResult.getSuccess()){
                Map<String, Object> map = serviceResult.getResult();
                if(map!=null&&map.size()>0){
                    List<UserInfo> list = (List<UserInfo>)map.get("data");
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
            log.error("查询用户列表失败，error={},condition={}", Throwables.getStackTraceAsString(e),criteria);
            throw new BusinessException("查询用户列表失败");
        }
    }

    /**
     * 新增
     * @param request
     * @return
     */
    @RequestMapping(value = "/createUser", method = RequestMethod.POST)
    @ResponseBody
    public Object createUser(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String nickName = request.getParameter("nickName");
        UserInfo userInfo = new UserInfo();
        userInfo.setUserName(userName);
        userInfo.setPassword(password);
        userInfo.setStatus(0);
        userInfo.setMobile(mobile);
        userInfo.setEmail(email);
        userInfo.setNickName(nickName);
        userInfo.setCreatedBy("system");
        userInfo.setUpdatedBy("system");
        ServiceResult<UserInfo> result = userInfoService.createUserInfo(userInfo);
        if (!result.getSuccess()) {
            log.error("新增部门失败！");
            jsonResult.setMessage("新增部门失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 更新
     * @param request
     * @return
     */
    @RequestMapping(value = "/updateUser", method = RequestMethod.POST)
    @ResponseBody
    public Object updateUser(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String userId = request.getParameter("userId");
        UserInfo userInfo = new UserInfo();
        userInfo.setId(Long.parseLong(userId));
        userInfo.setStatus(1);
        ServiceResult<UserInfo> result = userInfoService.updateUserInfo(userInfo);
        if (!result.getSuccess()) {
            log.error("审核通过失败！");
            jsonResult.setMessage("审核通过失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 重置密码
     * @param request
     * @return
     */
    @RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
    @ResponseBody
    public Object resetPassword(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String userId = request.getParameter("userId");
        UserInfo userInfo = new UserInfo();
        userInfo.setId(Long.parseLong(userId));
        userInfo.setStatus(1);
        ServiceResult<UserInfo> result = userInfoService.updateUserInfo(userInfo);
        if (!result.getSuccess()) {
            log.error("审核通过失败！");
            jsonResult.setMessage("审核通过失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

}  