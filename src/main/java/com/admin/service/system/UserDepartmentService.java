package com.admin.service.system;
import com.admin.entity.system.UserDepartment;
import com.haier.common.ServiceResult;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface UserDepartmentService {
    /**
     * 创建
     * */
    public ServiceResult<Boolean> createUserDepartment(UserDepartment userDepartment);
}
