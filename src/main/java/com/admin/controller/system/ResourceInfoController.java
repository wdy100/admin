package com.admin.controller.system;

import com.admin.entity.system.User;
import com.admin.service.system.UserService;
import com.haier.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
@RequestMapping("/system") 
@Slf4j
public class ResourceInfoController {
    @Resource  
    private UserService userService;

    @RequestMapping(value = "resourceInfo.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request, Model model) throws Exception {
        String mobile = "18765996558";
        ServiceResult<User> result = this.userService.getByMobile(mobile);
        model.addAttribute("user", result.getResult());
        return "system/resourceInfo_list";
    }
    
    @RequestMapping("/resourceInfoList")
    public String resourceInfoList(HttpServletRequest request,Map<String, Object> stack){
        String mobile = request.getParameter("mobile");  
        ServiceResult<User> result = this.userService.getByMobile(mobile); 
        log.info("测试2");
        //model.addAttribute("user", result.getResult());
        stack.put("user", result.getResult());
        return "showUser2";  
    }  
}  