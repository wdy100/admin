package com.admin.service.impl.system;

import com.admin.entity.system.Attachment;
import com.admin.service.system.AttachmentService;
import com.gao.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static com.google.common.base.Preconditions.checkNotNull;

/**
 * Created by GaoJingFei on 2017/11/13.
 */
@Slf4j
@Service
public class AttachmentServiceImpl implements AttachmentService {
    @Override
    public ServiceResult<Attachment> getByMobile(String mobile){
        checkNotNull(mobile, "mobile不能为空");
        ServiceResult<Attachment> result = new ServiceResult<Attachment>();
        return result;
    }
}
