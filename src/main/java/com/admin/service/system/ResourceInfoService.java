package com.admin.service.system;
import com.admin.entity.system.ResourceInfo;
import com.haier.common.ServiceResult;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface ResourceInfoService {
    /**
     * 根据手机号获取用户信息
     * */
    public ServiceResult<ResourceInfo> getByMobile(String mobile);
}
