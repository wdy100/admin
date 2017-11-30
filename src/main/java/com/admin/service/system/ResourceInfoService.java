package com.admin.service.system;
import com.admin.entity.system.ResourceInfo;

import java.util.List;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface ResourceInfoService {
    /**
     * 获取系统中所有
     * @return
     */
    public List<ResourceInfo> getAll();
}
