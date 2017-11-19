package com.admin.service.impl.system;

import com.admin.dao.system.RoleDao;
import com.admin.dao.system.UserDao;
import com.admin.entity.system.Role;
import com.admin.entity.system.User;
import com.admin.service.system.RoleService;
import com.admin.service.system.UserService;
import com.haier.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import static com.google.common.base.Preconditions.checkNotNull;

/**
 * Created by GaoJingFei on 2017/11/13.
 */
@Slf4j
@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;

    @Override
    public ServiceResult<User> getByMobile(String mobile){
        checkNotNull(mobile, "mobile不能为空");
        ServiceResult<User> result = new ServiceResult<User>();
        User user = userDao.getByMobile(mobile);
        result.setResult(user);
        return result;
    }

    @Override
    public ServiceResult<Role> getByName(String name) {
        ServiceResult<Role> result = new ServiceResult<Role>();
        result.setResult(roleDao.getByName(name));

        return result;
    }

    @Override
    public ServiceResult<List<Role>> getRoleList(Map<String, Object> paramMap) {
        ServiceResult<List<Role>> result = new ServiceResult<List<Role>>();
        result.setResult(roleDao.getRoleList(paramMap));

        return result;
    }

    @Override
    public ServiceResult<Integer> insert(Role role) {
        ServiceResult<Integer> result = new ServiceResult<Integer>();
        result.setResult(roleDao.insert(role));

        return result;
    }
}
