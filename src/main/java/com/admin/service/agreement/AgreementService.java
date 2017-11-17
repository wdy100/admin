package com.admin.service.agreement;
import com.admin.entity.agreement.AgreementInfo;
import com.haier.common.ServiceResult;

/**
 * Created by wangss
 */

public interface AgreementService {
   
    public ServiceResult<Boolean> insertAgreementInfo(AgreementInfo agreementInfo);
    
}