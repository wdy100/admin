package com.admin.service.system;

import com.admin.entity.system.UserRole;
import com.haier.common.ServiceResult;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface UserRoleService {
    /**
     * 创建
     * */
    public ServiceResult<Boolean> createUserRole(UserRole userRole);
}
