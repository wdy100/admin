package com.admin.service.system;
import com.admin.entity.system.UserDepartment;
import com.haier.common.ServiceResult;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface UserDepartmentService {
    /**
     * 根据手机号获取用户信息
     * */
    public ServiceResult<UserDepartment> getByMobile(String mobile);
}
