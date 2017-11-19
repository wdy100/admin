package com.admin.controller.system;

import com.admin.entity.system.Department;
import com.admin.entity.system.User;
import com.admin.entity.util.ClosedDepartmentTreeNodeFactory;
import com.admin.service.system.DepartmentService;
import com.admin.service.system.UserService;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.WebUtil;
import com.google.common.base.Throwables;
import com.google.common.collect.Maps;
import com.haier.common.BusinessException;
import com.haier.common.PagerInfo;
import com.haier.common.util.JsonUtil;
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
public class DepartmentController {
    @Resource  
    private UserService userService;
    @Resource
    private DepartmentService departmentService;

    @RequestMapping(value = "department.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request, Model model) throws Exception {
        return "system/department_list";
    }

    @RequestMapping("/departmentList")
    public void departmentList(HttpServletRequest request, HttpServletResponse response, Map<String, Object> dataMap){
        Map <String, Object> criteria = Maps.newHashMap();
        try {
            String parentId = request.getParameter("parentId");
            if(parentId != null && !"".equals(parentId) && !"0".equals(parentId)){
                criteria.put("parentId", parentId);
            }
            PagerInfo pager = WebUtil.handlerPagerInfo(request, dataMap);
            ServiceResult<Map<String, Object>> serviceResult = departmentService.searchDepartments(criteria, pager);
            if(serviceResult.getSuccess()){
                Map<String, Object> map = serviceResult.getResult();
                if(map!=null&&map.size()>0){
                    List<Department> list = (List<Department>)map.get("data");
                    int total = (Integer)map.get("total");
                    dataMap.put("total", total);
                    dataMap.put("rows", list);
                    response.getWriter().write(JsonUtil.toJson(dataMap));
                    response.getWriter().flush();
                    response.getWriter().close();
                }
            }
        }catch (Exception e) {
            log.error("查询部门列表失败，error={},condition={}", Throwables.getStackTraceAsString(e),criteria);
            throw new BusinessException("查询部门列表失败");
        }
    }

    /**
     * 组织架构树
     * @param request
     * @return
     */
    @RequestMapping(value = "/departmentTree", method = RequestMethod.POST)
    @ResponseBody
    public Object departmentTree(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        List<Department> roots = null;
        roots = departmentService.getAll();
        JSONArray departmentNodes = JSONArray.fromObject(new ClosedDepartmentTreeNodeFactory().buildTreeNodeList(roots));
        jsonResult.setData(departmentNodes);
        return departmentNodes;
    }

//    @RequestMapping("/departmentTree")
//    public void departmentTree(HttpServletRequest request, HttpServletResponse response, Map<String, Object> dataMap){
//        Map <String, Object> criteria = Maps.newHashMap();
//        try {
//            List<Department> roots = departmentService.getAll();
//            JSONArray departmentNodes = JSONArray.fromObject(new ClosedDepartmentTreeNodeFactory().buildTreeNodeList(roots));
//            dataMap.put("rows", departmentNodes);
//            response.getWriter().write(JsonUtil.toJson(dataMap));
//            response.getWriter().flush();
//            response.getWriter().close();
//        }catch (Exception e) {
//            log.error("查询部门树失败，error={}", Throwables.getStackTraceAsString(e));
//            throw new BusinessException("查询部门树失败");
//        }
//    }
}  