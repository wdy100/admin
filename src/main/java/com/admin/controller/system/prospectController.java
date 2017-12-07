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
                                 @RequestParam(required = false) Integer status,
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
            params.put("status", status);

            ServiceResult<List<Prospect>> result = prospectService.getProspectList(params);
            if(result == null || !result.getSuccess()) {
                logger.error("勘察确认单列表查询失败");
                throw new BusinessException("勘察确认单列表查询失败");
            }
            List<Prospect> prospectList = result.getResult();
            for(Prospect prospect: prospectList) {
                String content = "";
                String[] contentNo = prospect.getProspectContent().split(",");
                for(String no: contentNo) {
                    if("1".equals(no)) {
                        content = content.concat("电气火灾监测系统，");
                    }
                    if("2".equals(no)) {
                        content = content.concat("安全隐患巡查系统，");
                    }
                    if("3".equals(no)) {
                        content = content.concat("建筑消防用水监测系统，");
                    }
                    if("4".equals(no)) {
                        content = content.concat("重点部位可视化监管系统，");
                    }
                    if("5".equals(no)) {
                        content = content.concat("火灾在线联网报警系统，");
                    }
                }
                if(!"".equals(content)) {
                    content = content.substring(0, content.length()-1);
                }
                prospect.setProspectContent(content);
            }

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

    /**
     * 新增
     * @param request
     * @return
     */
    @RequestMapping(value = "/createProspect", method = RequestMethod.POST)
    @ResponseBody
    public Object createProspect(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String customerCode = request.getParameter("customerCode");
        String customerName = request.getParameter("customerName");
        String typeCode = request.getParameter("typeCode");
        String typeName = request.getParameter("typeName");
        String phone = request.getParameter("phone");
        String fax = request.getParameter("fax");
        String address = request.getParameter("address");
        String url = request.getParameter("url");
        String corporate = request.getParameter("corporate");
        String manager = request.getParameter("manager");
        String contact = request.getParameter("contact");
        String dockDepartment = request.getParameter("dockDepartment");
        String dockPerson = request.getParameter("dockPerson");
        String dockContact = request.getParameter("dockContact");
        String relateDepartment = request.getParameter("relateDepartment");
        String relatePerson = request.getParameter("relatePerson");
        String relateContact = request.getParameter("relateContact");
        Customer customer = new Customer();
        customer.setCustomerCode(customerCode);
        customer.setCustomerName(customerName);
        customer.setTypeCode(typeCode);
        customer.setTypeName(typeName);
        customer.setPhone(phone);
        customer.setFax(fax);
        customer.setAddress(address);
        customer.setUrl(url);
        customer.setCorporate(corporate);
        customer.setManager(manager);
        customer.setContact(contact);
        customer.setDockDepartment(dockDepartment);
        customer.setDockPerson(dockPerson);
        customer.setDockContact(dockContact);
        customer.setRelateDepartment(relateDepartment);
        customer.setRelatePerson(relatePerson);
        customer.setRelateContact(relateContact);
        customer.setCreatedBy("system");
        customer.setUpdatedBy("system");
        ServiceResult<Customer> result = customerService.createCustomer(customer);
        if (!result.getSuccess()) {
            log.error("新增客户失败！");
            jsonResult.setMessage("新增客户失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 勘查反馈
     * @param request
     * @return
     */
    @RequestMapping(value = "/uploadReportFile", method = RequestMethod.POST)
    @ResponseBody
    public Object createCustomerFeedback(@RequestParam(value = "file", required = false) MultipartFile file,
                                         HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();

        String id = request.getParameter("id");
        String prospectName = request.getParameter("prospectName");
        String prospectStartName = request.getParameter("prospectStartName");
        String prospectEndName = request.getParameter("prospectEndName");
        String remark = request.getParameter("remark");

        ServiceResult<Prospect> result = prospectService.getById(Integer.parseInt(id));

        if(result == null || !result.getSuccess()) {
            logger.error("根据id查询勘察确认单信息，发生异常");
            throw new BusinessException("根据id查询勘察确认单信息，发生异常");
        }
        Prospect prospect = result.getResult();

        String path = request.getSession().getServletContext().getRealPath("/WEB-INF/upload");
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

        prospect.setProspectFileAddress(fileUrl);
        ServiceResult<Integer> upResult = prospectService.update(prospect);
        
        if (!upResult.getSuccess()) {
            logger.error("新增勘查反馈失败！");
            jsonResult.setMessage("新增勘查反馈失败！");
            return jsonResult;
        }
        Boolean flag = false;
        if(upResult.getResult() == 1) {
            flag = true;
        }
        jsonResult.setData(flag);
        return jsonResult;
    }

    @RequestMapping(value = { "/uploadReportFile.html" }, method = { RequestMethod.POST })
    public String upload(@RequestParam(value = "file", required = false) MultipartFile file,
                        HttpServletRequest request, ModelMap model) {
        String id = request.getParameter("id");
        ServiceResult<Prospect> result = prospectService.getById(Integer.parseInt(id));

        if(result == null || !result.getSuccess()) {
            logger.error("根据id查询勘察确认单信息，发生异常");
            throw new BusinessException("根据id查询勘察确认单信息，发生异常");
        }
        Prospect prospect = result.getResult();

        String path = request.getSession().getServletContext().getRealPath("/WEB-INF/upload");
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

        prospect.setProspectFileAddress(fileUrl);
        prospectService.update(prospect);

        return "/prospect/prospectList";
    }
}
