package com.admin.service.system;
import com.admin.entity.system.Role;
import com.admin.entity.system.User;
import com.haier.common.ServiceResult;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface RoleService {

    public ServiceResult<User> getByMobile(String mobile);

    public ServiceResult<Role> getByName(String name);

    public ServiceResult<List<Role>> getRoleList(Map<String, Object> paramMap);

    public ServiceResult<Integer> insert(Role role);
}
