package com.admin.dao.agreement;

import com.admin.dao.BaseDao;
import com.admin.entity.agreement.AgreementInfo;
import com.admin.entity.system.User;

import org.springframework.stereotype.Repository;

/**
 * Created by wangss on 2017/11/17.
 */
@Repository
public class AgreementInfoDao extends BaseDao{
	
	public AgreementInfo selectById(Long id){
    	return this.getSqlSession().selectOne(namespace+"selectById", id);
    }
	
	public int deleteById(Long id){
    	return this.getSqlSession().delete(namespace+"deleteById", id);
    }
	
	public int insert(AgreementInfo agreementInfo){
		return this.getSqlSession().insert(namespace+"insert", agreementInfo);
	}
	
	public int updateById(Long id){
		return this.getSqlSession().update(namespace+"updateById", id);
	}
}