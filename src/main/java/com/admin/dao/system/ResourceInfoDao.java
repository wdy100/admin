package com.admin.dao.system;

import com.admin.entity.system.ResourceInfo;
import org.springframework.stereotype.Repository;

import com.admin.dao.BaseDao;

import java.util.List;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class ResourceInfoDao   extends BaseDao{
    /**
     * 获取所有
     *
     */
    public List<ResourceInfo> getAll(){
        return this.getSqlSession().selectList(namespace+"getAll");
    }
}