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
    public ServiceResult<Boolean> insertAgreementInfo(AgreementInfo agreementInfo){
        checkNotNull(agreementInfo, "agreementInfo不能为空");
        ServiceResult<Boolean> result = new ServiceResult<Boolean>();
        try{
            int count = agreementInfoDao.insert(agreementInfo);
            result.setResult(true);
        }catch(Exception e){
        	result.setResult(false);
        	log.error("合同信息插入失败:" + Throwables.getStackTraceAsString(e) );
        }
        return result;
    }
}
