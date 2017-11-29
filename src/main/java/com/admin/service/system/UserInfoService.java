package com.admin.service.system;

import com.admin.entity.system.UserInfo;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;

import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface UserInfoService {

    /**
     * 分页查询
     * @param params
     * @param pagerInfo
     * @return
     */
    public ServiceResult<Map<String, Object>> searchUserInfos(Map<String, Object> params, PagerInfo pagerInfo);

    /**
     * getById
     * @param id
     */
    public ServiceResult<UserInfo> getById(Long id);


    /**
     * 创建
     * @param userInfo
     */
    public ServiceResult<UserInfo> createUserInfo(UserInfo userInfo);

    /**
     * 更新
     * @param userInfo
     */
    public ServiceResult<UserInfo> updateUserInfo(UserInfo userInfo);

    /**
     * 登录
     * @param userName
     * @param password
     */
    public ServiceResult<UserInfo> login(String userName, String password,
                                                  String ipAddress);
}
