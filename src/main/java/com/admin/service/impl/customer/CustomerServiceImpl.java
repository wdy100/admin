package com.admin.service.impl.customer;

import com.admin.dao.system.UserDao;
import com.admin.entity.system.User;
import com.admin.service.customer.CustomerService;
import com.admin.service.system.UserService;
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
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private UserDao userDao;
    @Override
    public ServiceResult<User> getByMobile(String mobile){
        checkNotNull(mobile, "mobile不能为空");
        ServiceResult<User> result = new ServiceResult<User>();
        User user = userDao.getByMobile(mobile);
        log.info("根据手机号查询用户信息,mobile={}", mobile);
        result.setResult(user);
        return result;
    }
}
