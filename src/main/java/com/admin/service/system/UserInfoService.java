package com.admin.service.system;
import com.admin.entity.system.Department;
import com.admin.entity.system.User;
import com.admin.entity.system.UserInfo;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;

import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface UserInfoService {
    /**
     * 根据手机号获取用户信息
     * */
    public ServiceResult<User> getByMobile(String mobile);

    /**
     * 分页查询
     * @param params
     * @param pagerInfo
     * @return
     */
    public ServiceResult<Map<String, Object>> searchUserInfos(Map<String, Object> params, PagerInfo pagerInfo);

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
}
