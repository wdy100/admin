package com.admin.controller.system;

import com.admin.entity.system.Role;
import com.admin.entity.system.User;
import com.admin.service.system.RoleService;
import com.admin.service.system.UserService;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.WebUtil;
import com.google.common.base.Throwables;
import com.haier.common.BusinessException;
import com.haier.common.ServiceResult;
import com.haier.common.util.JsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
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
public class RoleController {
    private final static org.apache.log4j.Logger logger = LogManager.getLogger(RoleController.class);

    @Resource  
    private UserService userService;
    @Resource
    private RoleService roleService;

    @RequestMapping(value = { "roleList.html" }, method = { RequestMethod.GET })
    public String invoicePost(@RequestParam(required = false) String name,
                              @RequestParam(required = false) Integer description,
                              @RequestParam(required = false) Integer rows,
                              @RequestParam(required = false) Integer page,
                              HttpServletRequest request, HttpServletResponse response,
                              Map<String, Object> modelMap) {
        try {
            if (rows == null)
                rows = 20;
            if (page == null)
                page = 1;
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("m", (page - 1) * rows);
            params.put("n", rows);
            //参数加入params里
            params.put("name", name);
            params.put("description", description);

            ServiceResult<List<Role>> result = roleService.getRoleList(params);
            if(result == null || !result.getSuccess()) {
                logger.error("角色列表查询失败");
                throw new BusinessException("角色列表查询失败");
            }
            List<Role> roleList = result.getResult();

            //获得条数
            int resultcount = roleList.size();
            Map<String, Object> retMap = new HashMap<String, Object>();
            retMap.put("total", resultcount);
            retMap.put("rows", roleList);
            response.getWriter().write(JsonUtil.toJson(retMap));
            response.getWriter().flush();
            response.getWriter().close();
        } catch (IOException e) {
            logger.error("角色列表查询失败", e);
            throw new BusinessException("角色列表查询失败" + e.getMessage());
        }

        return "/system/role_list";
    }

    @RequestMapping(value = { "saveRole.html" }, method = { RequestMethod.GET })
    @ResponseBody
    HttpJsonResult<Boolean> saveInvoicePostExpress(@RequestParam(required = false) String code,
                                                   @RequestParam(required = false) String name,
                                                   @RequestParam(required = false) String description,
                                                   @RequestParam(required = false) String createdBy,
                                                   HttpServletRequest request, HttpServletResponse response) {
        HttpJsonResult<Boolean> result = new HttpJsonResult<Boolean>();

        ServiceResult<Role> seResult = roleService.getByName(name.trim());
        if(seResult.getSuccess() && seResult != null && seResult.getResult() != null) {
            logger.error("该角色名称已存在");
            throw new BusinessException("该角色名称已存在");
        }
        Role role = new Role();
        role.setCode(code);
        role.setName(name);
        role.setDescription(description);
        role.setCreatedBy(createdBy);
        role.setUpdatedBy(createdBy);

        try {
            ServiceResult<Integer> roleResult = roleService.insert(role);
            if (!roleResult.getSuccess()) {
                result.setMessage("保存失败，请稍后重试！");
            }
        } catch (Exception e) {
            result.setMessage("保存失败，请稍后重试！");
            logger.error("保存失败，请稍后重试！" + Throwables.getStackTraceAsString(e));
        }
        return result;
    }
}  