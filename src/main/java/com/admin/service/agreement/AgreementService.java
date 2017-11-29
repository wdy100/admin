package com.admin.service.agreement;
import java.util.List;
import java.util.Map;

import com.admin.entity.agreement.AgreementGoods;
import com.admin.entity.agreement.AgreementInfo;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;

/**
 * Created by wangss
 */

public interface AgreementService {
   
	public ServiceResult<Map<String, Object>> getAgreementList(Map<String, Object> paramMap,PagerInfo pagerInfo);
	
    public ServiceResult<Integer> insertAgreementInfo(AgreementInfo agreementInfo,List<AgreementGoods> agreementGoodsList);
    
    public ServiceResult<Boolean> updateAgreementInfo(AgreementInfo agreementInfo,List<AgreementGoods> agreementGoodsList);
    
    public ServiceResult<AgreementInfo> selectByIdAgreementInfo(AgreementInfo agreementInfo);
    
    public ServiceResult<Boolean> deleteAgreementInfo(Long agreementInfoId);
    
    public ServiceResult<Boolean> deleteAgreementGoods(Long agreementInfoId);
    
}