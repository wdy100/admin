package com.admin.service.impl.system;

import com.admin.entity.system.UserDepartment;
import com.admin.service.system.UserDepartmentService;
import com.haier.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static com.google.common.base.Preconditions.checkNotNull;

/**
 * Created by GaoJingFei on 2017/11/13.
 */
@Slf4j
@Service
public class UserDepartmentServiceImpl implements UserDepartmentService {
    @Override
    public ServiceResult<UserDepartment> getByMobile(String mobile){
        checkNotNull(mobile, "mobile不能为空");
        ServiceResult<UserDepartment> result = new ServiceResult<UserDepartment>();
        return result;
    }
}
