package com.admin.dao.system;

import com.admin.dao.BaseDao;
import com.admin.entity.system.User;

import org.springframework.stereotype.Repository;

/**
 * Created by GaoJingFei on 2017/11/13.
 */
@Repository
public class UserDao extends BaseDao {
    public User getByMobile(String mobile){
    	return this.getSqlSession().selectOne(namespace+"getByMobile", mobile);
    }
}
