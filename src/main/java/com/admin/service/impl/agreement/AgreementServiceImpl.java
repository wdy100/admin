package com.admin.service.impl.agreement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.admin.dao.agreement.AgreementInfoDao;
import com.admin.entity.agreement.AgreementInfo;
import com.admin.service.agreement.AgreementService;
import com.google.common.base.Throwables;
import com.haier.common.PagerInfo;
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
	public ServiceResult<Map<String, Object>> getAgreementList(
			Map<String, Object> paramMap, PagerInfo pagerInfo) {
		ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        try{
        	// 记录总数
            int rowsCount = agreementInfoDao.getAgreementListCount(paramMap);
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
            paramMap.put("start", start);
            paramMap.put("size", size);
            List<AgreementInfo> roles = agreementInfoDao.getAgreementList(paramMap);
            map.put("data", roles);
            map.put("total", rowsCount);
            result.setResult(map);
        }catch(Exception e){
        	result.setError("error","合同信息查询失败");
        	log.error("合同信息查询失败:" + Throwables.getStackTraceAsString(e) );
        }
		return result;
	}
	
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
    
    @Override
    public ServiceResult<Boolean> deleteAgreementInfo(Long agreementInfoId){
    	checkNotNull(agreementInfoId, "agreementInfoId不能为空");
    	ServiceResult<Boolean> result = new ServiceResult<Boolean>();
    	try{
    		int id = agreementInfoDao.deleteAgreementInfo(agreementInfoId);
    		result.setResult(true);
    	}catch(Exception e){
    		result.setError("error","删除合同信息失败");
    		log.error("删除合同信息失败:" + Throwables.getStackTraceAsString(e) );
    	}
    	return result;
    }
}
