package com.admin.controller.system;

import com.admin.entity.system.Prospect;
import com.admin.service.system.ProspectService;
import com.haier.common.BusinessException;
import com.haier.common.ServiceResult;
import com.haier.common.util.JsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/prospect")
@Slf4j
public class prospectController {
    private final static org.apache.log4j.Logger logger = LogManager.getLogger(prospectController.class);

    @Resource
    private ProspectService prospectService;

    @RequestMapping(value = { "/findProspectList.html" }, method = { RequestMethod.GET })
    void findWaterVatInvoiceList(@RequestParam(required = false) String customerName,
                                 @RequestParam(required = false) Integer customerStatus,
                                 @RequestParam(required = false) Integer prospectStatus,
                                 @RequestParam(required = false) Integer rows,
                                 @RequestParam(required = false) Integer page,
                                 HttpServletRequest request, HttpServletResponse response) {
        try {
            if (rows == null)
                rows = 20;
            if (page == null)
                page = 1;
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("m", (page - 1) * rows);
            params.put("n", rows);
            //��������params��
            params.put("customerName", customerName);
            params.put("customerStatus", customerStatus);
            params.put("prospectStatus", prospectStatus);

            ServiceResult<List<Prospect>> result = prospectService.getProspectList(params);
            if(result == null || !result.getSuccess()) {
                logger.error("����ȷ�ϵ��б��ѯʧ��");
                throw new BusinessException("����ȷ�ϵ��б��ѯʧ��");
            }
            List<Prospect> prospectList = result.getResult();

            //�������
            int resultcount = prospectList.size();
            Map<String, Object> retMap = new HashMap<String, Object>();
            retMap.put("total", resultcount);
            retMap.put("rows", prospectList);
            response.getWriter().write(JsonUtil.toJson(retMap));
            response.getWriter().flush();
            response.getWriter().close();
        } catch (IOException e) {
            logger.error("����ȷ�ϵ��б��ѯʧ��", e);
            throw new BusinessException("����ȷ�ϵ��б��ѯʧ��" + e.getMessage());
        }
    }

    @RequestMapping(value = { "/uploadReportFile.html" }, method = { RequestMethod.POST })
    public String upload(@RequestParam(value = "file", required = false) MultipartFile file,
                         @RequestParam(value = "id", required = false) Integer id,
                         HttpServletRequest request, ModelMap model) {
        ServiceResult<Prospect> result = prospectService.getById(id);
        if(result == null || !result.getSuccess()) {
            logger.error("����id��ѯ����ȷ�ϵ���Ϣ�������쳣");
            throw new BusinessException("����id��ѯ����ȷ�ϵ���Ϣ�������쳣");
        }
        Prospect prospect = result.getResult();

        String path = request.getSession().getServletContext().getRealPath("upload");
        String fileName = file.getOriginalFilename();
        File targetFile = new File(path, fileName);
        if(!targetFile.exists()){
            targetFile.mkdirs();
        }

        //����
        try {
            file.transferTo(targetFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("fileUrl", request.getContextPath() + "/upload/" + fileName);

        return "result";
    }
}
