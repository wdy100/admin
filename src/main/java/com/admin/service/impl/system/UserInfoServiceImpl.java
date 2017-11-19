package com.admin.service.impl.system;

import com.admin.dao.system.UserDao;
import com.admin.dao.system.UserInfoDao;
import com.admin.entity.system.UserInfo;
import com.admin.entity.system.User;
import com.admin.service.system.UserInfoService;
import com.admin.service.system.UserService;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.google.common.base.Preconditions.checkNotNull;

/**
 * Created by GaoJingFei on 2017/11/13.
 */
@Slf4j
@Service
public class UserInfoServiceImpl implements UserInfoService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private UserInfoDao userInfoDao;
    @Override
    public ServiceResult<User> getByMobile(String mobile){
        checkNotNull(mobile, "mobile不能为空");
        ServiceResult<User> result = new ServiceResult<User>();
        User user = userDao.getByMobile(mobile);
        log.info("根据手机号查询用户信息,mobile={}", mobile);
        result.setResult(user);
        return result;
    }

    @Override
    public ServiceResult<Map<String, Object>> searchUserInfos(Map<String, Object> params, PagerInfo pagerInfo) {
        ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        // 记录总数
        int rowsCount = userInfoDao.queryCountBy(params);
        int start = pagerInfo.getStart();
        int size = pagerInfo.getPageSize();
        if (rowsCount > 0) {
            int totalPage = (rowsCount + size - 1) / size;// 总页数
            int pageIndex = pagerInfo.getPageIndex();// 当前页码
            if (pageIndex > totalPage) {
                // 总页数作为当前页
                start = (totalPage - 1) * size;
            }
        }
        params.put("start", start);
        params.put("size", size);
        List<UserInfo> userInfos = userInfoDao.queryListBy(params);
        map.put("data", userInfos);
        map.put("total", rowsCount);
        result.setResult(map);
        return result;
    }

    @Override
    public ServiceResult<UserInfo> createUserInfo(UserInfo userInfo) {
        ServiceResult<UserInfo> executeResult = new ServiceResult<UserInfo>();
        userInfo.setCreatedAt(new Date());
        userInfo.setUpdatedAt(new Date());
        userInfoDao.insert(userInfo);
        executeResult.setResult(userInfo);
        return executeResult;
    }
    @Override
    public ServiceResult<UserInfo> updateUserInfo(UserInfo userInfo) {
        ServiceResult<UserInfo> executeResult = new ServiceResult<UserInfo>();
        UserInfo dbUserInfo = userInfoDao.getById(userInfo.getId());
        if(dbUserInfo == null){
            executeResult.setMessage("该用户不存在或已经被删除。");
            return executeResult;
        }
        dbUserInfo.setUpdatedBy(userInfo.getUpdatedBy());
        dbUserInfo.setUpdatedAt(new Date());
        userInfoDao.update(dbUserInfo);
        return executeResult;
    }
}
