package com.admin.service.system;
import com.admin.entity.system.UserRole;
import com.haier.common.ServiceResult;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface UserRoleService {
    /**
     * 根据手机号获取用户信息
     * */
    public ServiceResult<UserRole> getByMobile(String mobile);
}
