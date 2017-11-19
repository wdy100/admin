package com.admin.dao.system;

import com.admin.entity.system.Role;
import org.springframework.stereotype.Repository;

import com.admin.dao.BaseDao;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class RoleDao   extends BaseDao{

    public List<Role> getRoleList(Map<String, Object> paramMap){
        return this.getSqlSession().selectList(namespace + "getRoleList", paramMap);
    }

    public Integer insert(Role role){
        return this.getSqlSession().insert(namespace + "insert", role);
    }
}