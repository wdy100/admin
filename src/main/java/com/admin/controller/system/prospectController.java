package com.admin.controller.system;

import com.admin.entity.system.Prospect;
import com.admin.service.system.ProspectService;
import com.haier.common.BusinessException;
import com.haier.common.ServiceResult;
import com.haier.common.util.JsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;

@Controller
@RequestMapping("/prospect")
@Slf4j
public class prospectController {
    private final static org.apache.log4j.Logger logger = LogManager.getLogger(prospectController.class);

    @Resource
    private ProspectService prospectService;

    @RequestMapping(value = "prospect.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        return "prospect/prospectList";
    }

    @RequestMapping("/findProspectList.html")
    public void findWaterVatInvoiceList(@RequestParam(required = false) String customerName,
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
            //参数加入params里
            params.put("customerName", customerName);
            params.put("customerStatus", customerStatus);
            params.put("prospectStatus", prospectStatus);

            ServiceResult<List<Prospect>> result = prospectService.getProspectList(params);
            if(result == null || !result.getSuccess()) {
                logger.error("勘察确认单列表查询失败");
                throw new BusinessException("勘察确认单列表查询失败");
            }
            List<Prospect> prospectList = result.getResult();

            //获得条数
            int resultcount = prospectList.size();
            Map<String, Object> retMap = new HashMap<String, Object>();
            retMap.put("total", resultcount);
            retMap.put("rows", prospectList);

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(JsonUtil.toJson(retMap));
            response.getWriter().flush();
            response.getWriter().close();
        } catch (Exception e) {
            logger.error("勘察确认单列表查询失败", e);
            throw new BusinessException("勘察确认单列表查询失败" + e.getMessage());
        }
    }

    @RequestMapping(value = { "/uploadReportFile.html" }, method = { RequestMethod.POST })
    public String upload(@RequestParam(value = "file", required = false) MultipartFile file,
                        HttpServletRequest request, ModelMap model) {
        String id = null;
        DiskFileItemFactory dff = new DiskFileItemFactory();
        ServletFileUpload fu = new ServletFileUpload(dff);
        try{
            List li = fu.parseRequest(request);
            Iterator iter = li.iterator();
            while(iter.hasNext()){
                FileItem item = (FileItem)iter.next();
                if(item.isFormField()){  //此处是判断非文件域，即不是<inputtype="file"/>的标签
                    String name=item.getFieldName(); //获取form表单中name的id
                    if("id".equals(name)){
                        id = item.getString("utf-8"); //item是指定id的value值，此处用      item.getString("utf-8")是把item用utf-8解析，根据你的需要可以用其他的，如：gbk；
                    }
                }
            }
        } catch(FileUploadException e1) {
            e1.printStackTrace();
        } catch (UnsupportedEncodingException e2) {
            e2.printStackTrace();
        }
        String id2 = id;
        ServiceResult<Prospect> result = prospectService.getById(1);

        if(result == null || !result.getSuccess()) {
            logger.error("根据id查询勘察确认单信息，发生异常");
            throw new BusinessException("根据id查询勘察确认单信息，发生异常");
        }
        Prospect prospect = result.getResult();

        String path = request.getSession().getServletContext().getRealPath("upload");
        String fileName = file.getOriginalFilename();
        File targetFile = new File(path, fileName);
        if(!targetFile.exists()){
            targetFile.mkdirs();
        }
        //保存
        try {
            file.transferTo(targetFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String fileUrl = path + "\\" + fileName;
//        model.addAttribute("fileUrl", fileUrl);

        prospect.setProspectFileAddress(fileUrl);
        prospectService.update(prospect);

        return "/prospect/prospectList";
    }
}
