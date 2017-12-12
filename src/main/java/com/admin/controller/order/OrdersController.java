package com.admin.controller.order;

import com.admin.entity.order.Orders;
import com.admin.service.order.OrdersService;
import com.admin.service.system.ResourceInfoService;
import com.admin.web.util.*;
import com.google.common.base.Throwables;
import com.google.common.collect.Maps;
import com.haier.common.BusinessException;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;
import com.haier.common.util.JsonUtil;
import jxl.biff.DisplayFormat;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.UnderlineStyle;
import jxl.write.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *
 * Created by GaoJingFei on 2017/12/13.
 */

@Controller  
@RequestMapping("/order")
@Slf4j
public class OrdersController {
    private final static org.apache.log4j.Logger logger = LogManager.getLogger(OrdersController.class);

    @Resource
    private ResourceInfoService resourceInfoService;
    @Resource
    private OrdersService ordersService;

    @RequestMapping(value = "order.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        Long userId = (Long)(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_ID));
        if (null == userId) {
            log.error("[OrdersController][index] userId不存在,userId={}", userId);
            return "redirect:/login.html";
        }
        Map<String, String> buttonsMap = resourceInfoService.getButtonCodeByUserId(userId);
//        String showDistributionOrdersButton = "NO";
//        String showCreateOrdersButton = "NO";
//        String showFeedbackOrdersButton = "NO";
//        if(buttonsMap.containsKey(ButtonConstant.CUSTOMER_DISTRIBUTION_CODE)){
//            showDistributionOrdersButton = "YES";
//        }
//        if(buttonsMap.containsKey(ButtonConstant.CUSTOMER_ADD_CODE)){
//            showCreateOrdersButton = "YES";
//        }
//        if(buttonsMap.containsKey(ButtonConstant.CUSTOMER_FEEDBACK_CODE)){
//            showFeedbackOrdersButton = "YES";
//        }
//        dataMap.put("showDistributionOrdersButton", showDistributionOrdersButton);
//        dataMap.put("showCreateOrdersButton", showCreateOrdersButton);
//        dataMap.put("showFeedbackOrdersButton", showFeedbackOrdersButton);
        return "order/order_list";
    }

    @RequestMapping("/orderList")
    public void orderList(HttpServletRequest request, HttpServletResponse response, Map<String, Object> dataMap){
        Map <String, Object> criteria = Maps.newHashMap();
        try {
//            String ordersName = request.getParameter("q_ordersName");
//            if(ordersName != null && !"".equals(ordersName)){
//                criteria.put("ordersName", ordersName);
//            }
            PagerInfo pager = WebUtil.handlerPagerInfo(request, dataMap);
            ServiceResult<Map<String, Object>> serviceResult = ordersService.searchOrders(criteria, pager);
            if(serviceResult.getSuccess()){
                Map<String, Object> map = serviceResult.getResult();
                if(map!=null&&map.size()>0){
                    List<Orders> list = (List<Orders>)map.get("data");
                    int total = (Integer)map.get("total");
                    dataMap.put("total", total);
                    dataMap.put("rows", list);
                    response.setContentType("application/json;charset=UTF-8");
                    response.getWriter().write(JsonUtil.toJson(dataMap));
                    response.getWriter().flush();
                    response.getWriter().close();
                }
            }
        }catch (Exception e) {
            log.error("查询订单列表失败，error={},condition={}", Throwables.getStackTraceAsString(e),criteria);
            throw new BusinessException("查询订单列表失败");
        }
    }

    /**
     * 新增
     * @param request
     * @return
     */
    @RequestMapping(value = "/createOrders", method = RequestMethod.POST)
    @ResponseBody
    public Object createOrders(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String ordersCode = request.getParameter("ordersCode");
        String ordersName = request.getParameter("ordersName");
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
        Orders orders = new Orders();

        orders.setCreatedBy("system");
        orders.setUpdatedBy("system");
        ServiceResult<Orders> result = ordersService.createOrders(orders);
        if (!result.getSuccess()) {
            log.error("新增订单失败！");
            jsonResult.setMessage("新增订单失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }


}  