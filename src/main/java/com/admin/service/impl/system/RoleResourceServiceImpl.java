package com.admin.service.impl.system;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.admin.dao.system.RoleResourceDao;
import com.admin.entity.system.User;
import com.admin.service.system.RoleResourceService;
import com.haier.common.ServiceResult;

/**
 * Created by GaoJingFei on 2017/11/13.
 */
@Slf4j
@Service
public class RoleResourceServiceImpl implements RoleResourceService {
    @Autowired
    private RoleResourceDao roleResourceDao;
    @Override
    public ServiceResult<User> getByMobile(String mobile){
        ServiceResult<User> result = new ServiceResult<User>();
        return result;
    }
}
