package com.admin.service.agreement;
import com.admin.entity.agreement.AgreementInfo;
import com.haier.common.ServiceResult;

/**
 * Created by wangss
 */

public interface AgreementService {
   
    public ServiceResult<Integer> insertAgreementInfo(AgreementInfo agreementInfo);
    
    public ServiceResult<Boolean> updateAgreementInfo(AgreementInfo agreementInfo);
    
    public ServiceResult<AgreementInfo> selectByIdAgreementInfo(AgreementInfo agreementInfo);
    
}