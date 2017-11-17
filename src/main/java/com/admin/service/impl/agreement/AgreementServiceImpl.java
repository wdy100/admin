package com.admin.service.impl.agreement;

import com.admin.dao.agreement.AgreementInfoDao;
import com.admin.dao.system.UserDao;
import com.admin.entity.agreement.AgreementInfo;
import com.admin.entity.system.User;
import com.admin.service.agreement.AgreementService;
import com.admin.service.system.UserService;
import com.google.common.base.Throwables;
import com.haier.common.ServiceResult;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static com.google.common.base.Preconditions.checkNotNull;

/**
 * Created by wangss
 */
@Slf4j
@Service
public class AgreementServiceImpl implements AgreementService {
    
	@Autowired
    private AgreementInfoDao agreementInfoDao;
    
    @Override
    public ServiceResult<Integer> insertAgreementInfo(AgreementInfo agreementInfo){
        checkNotNull(agreementInfo, "agreementInfo不能为空");
        ServiceResult<Integer> result = new ServiceResult<Integer>();
        try{
            int id = agreementInfoDao.insert(agreementInfo);
            result.setResult( agreementInfo.getId().intValue());
        }catch(Exception e){
        	result.setError("error","合同信息插入失败");
        	log.error("合同信息插入失败:" + Throwables.getStackTraceAsString(e) );
        }
        return result;
    }
    
    @Override
    public ServiceResult<Boolean> updateAgreementInfo(AgreementInfo agreementInfo){
    	checkNotNull(agreementInfo, "agreementInfo不能为空");
    	ServiceResult<Boolean> result = new ServiceResult<Boolean>();
    	try{
    		int id = agreementInfoDao.updateById(agreementInfo);
    		result.setResult(true);
    	}catch(Exception e){
    		result.setError("error","合同信息更新失败");
    		log.error("合同信息更新失败:" + Throwables.getStackTraceAsString(e) );
    	}
    	return result;
    }
    
    @Override
    public ServiceResult<AgreementInfo> selectByIdAgreementInfo(AgreementInfo agreementInfo){
    	checkNotNull(agreementInfo, "agreementInfo不能为空");
    	ServiceResult<AgreementInfo> result = new ServiceResult<AgreementInfo>();
    	try{
    		AgreementInfo agreement = agreementInfoDao.selectById(agreementInfo.getId());
    		result.setResult(agreement);
    	}catch(Exception e){
    		result.setError("error","合同信息更新失败");
    		log.error("合同信息更新失败:" + Throwables.getStackTraceAsString(e) );
    	}
    	return result;
    }
}
