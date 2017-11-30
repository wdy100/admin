package com.admin.controller.system;

import com.admin.entity.system.ResourceInfo;
import com.admin.entity.util.ModuleResourceInfoTreeNodeFactory;
import com.admin.entity.util.TreeNode;
import com.admin.service.system.ResourceInfoService;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 *
 * Created by GaoJingFei on 2017/11/13.
 */

@Controller  
@RequestMapping("/system") 
@Slf4j
public class ResourceInfoController {
    @Resource
    private ResourceInfoService resourceInfoService;

    @RequestMapping(value = "resourceInfo.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request, Model model) throws Exception {
       
        return "system/resourceInfo_list";
    }
    
    @RequestMapping("/resourceInfoList")
    public String resourceInfoList(HttpServletRequest request,Map<String, Object> stack){
        
        return "showUser2";  
    }

    /**
     * 资源树
     * @param request
     * @return
     */
    @RequestMapping(value = "/allModuleResourceTree", method = RequestMethod.POST)
    @ResponseBody
    public Object allModuleResourceTree(HttpServletRequest request) {
        List<ResourceInfo> rs = resourceInfoService.getAll();
        List<TreeNode> treeNodeList = new ModuleResourceInfoTreeNodeFactory().buildTreeNodeList(rs);
        JSONArray treeNodes = JSONArray.fromObject(treeNodeList);
        return treeNodes;
    }

}  