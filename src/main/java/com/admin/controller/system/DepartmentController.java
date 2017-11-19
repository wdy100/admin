package com.admin.controller.system;

import com.admin.entity.system.Department;
import com.admin.entity.system.User;
import com.admin.entity.util.ClosedDepartmentTreeNodeFactory;
import com.admin.service.system.DepartmentService;
import com.admin.service.system.UserService;
import com.admin.web.util.HttpJsonResult;
import net.sf.json.JSONArray;
import com.haier.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 *
 * Created by GaoJingFei on 2017/11/13.
 */

@Controller  
@RequestMapping("/system") 
@Slf4j
public class DepartmentController {
    @Resource  
    private UserService userService;
    @Resource
    private DepartmentService departmentService;

    @RequestMapping(value = "department.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request, Model model) throws Exception {
        String mobile = "18765996558";
        ServiceResult<User> result = this.userService.getByMobile(mobile);
        model.addAttribute("user", result.getResult());
        return "system/department_list";
    }

    @RequestMapping("/departmentList")
    public String departmentList(HttpServletRequest request,Map<String, Object> stack){
        String mobile = request.getParameter("mobile");  
        ServiceResult<User> result = this.userService.getByMobile(mobile); 
        log.info("测试2");
        //model.addAttribute("user", result.getResult());
        stack.put("user", result.getResult());
        return "showUser2";  
    }

    /**
     * 组织架构树
     * @param request
     * @return
     */
    @RequestMapping(value = "/departmentTree", method = RequestMethod.POST)
    @ResponseBody
    public HttpJsonResult<Object> departmentTree(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        List<Department> roots = null;
        roots = departmentService.getAll();
        JSONArray departmentNodes = JSONArray.fromObject(new ClosedDepartmentTreeNodeFactory().buildTreeNodeList(roots));
        jsonResult.setData(departmentNodes);
        return jsonResult;
    }
}  