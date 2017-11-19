package com.admin.service.customer;
import com.admin.entity.system.User;
import com.haier.common.ServiceResult;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface CustomerService {
    /**
     * 根据手机号获取用户信息
     * */
    public ServiceResult<User> getByMobile(String mobile);
}
