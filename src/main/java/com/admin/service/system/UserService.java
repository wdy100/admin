package com.admin.service.system;
import com.admin.entity.system.User;
import com.haier.common.ServiceResult;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface UserService {
    /**
     * 根据手机号获取用户信息
     * */
    public ServiceResult<User> getByMobile(String mobile);
}
