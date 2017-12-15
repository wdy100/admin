package com.admin.service.system;
import com.admin.entity.system.Role;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface RoleService {

    public ServiceResult<Role> getByName(String name);

    public ServiceResult<Map<String, Object>> getRoleList(Map<String, Object> paramMap, PagerInfo pagerInfo);

    public ServiceResult<Integer> insert(Role role);

    /**
     * 获取系统中所有的角色
     * @return
     */
    public List<Role> getAll();

    /**
     * 获取用户的角色信息
     * @param userId
     * @return
     */
    public List<Role> getUserRoles(Long userId);
}
