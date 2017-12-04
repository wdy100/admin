package com.admin.controller.system;

import com.admin.entity.system.Role;
import com.admin.entity.system.RoleResource;
import com.admin.entity.util.TreeNode;
import com.admin.service.system.RoleResourceService;
import com.admin.service.system.RoleService;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.SessionSecurityConstants;
import com.google.common.base.Throwables;
import com.haier.common.BusinessException;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;
import com.haier.common.util.JsonUtil;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * Created by GaoJingFei on 2017/11/13.
 */

@Controller  
@RequestMapping("/system") 
@Slf4j
public class RoleResourceController {
    
    @Resource
    private RoleResourceService roleResourceService;
    
    @RequestMapping(value = "roleResource.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(@RequestParam(required = false)
            HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> modelMap) throws Exception {

        return "system/roleResource_list";
    }

    /**
     * 角色拥有的所有资源
     * @param request
     * @return
     */
    @RequestMapping(value = "/getResourcesByRoleId", method = RequestMethod.POST)
    @ResponseBody
    public Object getResourcesByRoleId(HttpServletRequest request) {
        List<Integer> resourceIdList = new ArrayList<Integer>();
        String roleId = request.getParameter("roleId");
        if(roleId != null && !"".equals(roleId)){
            ServiceResult<List<RoleResource>> result = roleResourceService.selectAllByRoleId(Integer.parseInt(roleId));
            if(result.getSuccess() && result.getResult() != null){
                List<RoleResource> roleResourceList = result.getResult();
                for(RoleResource rr : roleResourceList){
                    resourceIdList.add(rr.getResourceId());
                }
            }
        }
        JSONArray resourceIds = JSONArray.fromObject(resourceIdList.toArray());
        return resourceIds;
    }

    @RequestMapping(value = { "saveRoleResource" }, method = { RequestMethod.POST })
    @ResponseBody
    public HttpJsonResult<Object> saveRoleResource(HttpServletRequest request, HttpServletResponse response) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String roleId = request.getParameter("roleId");
        String[] resourceIds = request.getParameterValues("resourceIds[]");
        if(roleId == null || "".equals(roleId) || resourceIds == null || resourceIds.length == 0){
            log.error("roleId或resourceIds为空！roleId={},resourceIds={}", roleId, resourceIds);
            jsonResult.setMessage("设置权限失败：参数不能为空！");
            return jsonResult;
        }
        Integer rid = Integer.parseInt(roleId);
        roleResourceService.deleteByRoleId(rid);
        for(String resourceId : resourceIds){
            if(resourceId == null || "".equals(resourceId)){
                continue;
            }
            RoleResource roleResource = new RoleResource();
            roleResource.setRoleId(rid);
            roleResource.setResourceId(Integer.parseInt(resourceId));
            roleResourceService.insert(roleResource);
        }

        return jsonResult;
    }


}  