package com.admin.controller.reports;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;

import org.apache.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.admin.entity.reports.PerformanceReports;
import com.admin.service.reports.ReportsService;
import com.gao.common.BusinessException;
import com.gao.common.ServiceResult;
import com.gao.common.util.JsonUtil;

/**
 * Created by lx on 17-12-24.
 */
@Controller
@RequestMapping("/report")
@Slf4j
public class PerformanceReportsController {
    private final static org.apache.log4j.Logger logger = LogManager.getLogger(PerformanceReportsController.class);

    @Resource
    private ReportsService reportsService;

    @RequestMapping(value = "personalPerformance.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String personalExpense(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        return "reports/personal_performance_list";
    }

    @RequestMapping("/findPersonalPerformanceList")
    public void findPersonalExpenseList(@RequestParam(required = false) Integer year,
                                        @RequestParam(required = false) Integer month,
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
            params.put("year", year);
            params.put("month", month);

            ServiceResult<List<PerformanceReports>> result = reportsService.getPerformanceReportsListByPerson(params);
            if(result == null || !result.getSuccess()) {
                logger.error("人员业绩完成率报表查询失败");
                throw new BusinessException("人员业绩完成率报表查询失败");
            }
            List<PerformanceReports> performanceReportsList = result.getResult();

            //获得条数
            int resultcount = performanceReportsList.size();
            Map<String, Object> retMap = new HashMap<String, Object>();
            retMap.put("total", resultcount);
            retMap.put("rows", performanceReportsList);

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(JsonUtil.toJson(retMap));
            response.getWriter().flush();
            response.getWriter().close();
        } catch (Exception e) {
            logger.error("人员业绩完成率报表查询失败", e);
            throw new BusinessException("人员业绩完成率报表查询失败" + e.getMessage());
        }
    }

    @RequestMapping(value = "monthPerformance.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String monthExpense(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        return "reports/month_performance_list";
    }

    @RequestMapping("/findMonthPerformanceList")
    public void findMonthExpenseList(@RequestParam(required = false) Integer year,
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
            params.put("year", year);

            ServiceResult<List<PerformanceReports>> result = reportsService.getPerformanceReportsListByMonth(params);
            if(result == null || !result.getSuccess()) {
                logger.error("按月业绩完成率报表查询失败");
                throw new BusinessException("按月业绩完成率报表查询失败");
            }
            List<PerformanceReports> performanceReportsList = result.getResult();

            //获得条数
            int resultcount = performanceReportsList.size();
            Map<String, Object> retMap = new HashMap<String, Object>();
            retMap.put("total", resultcount);
            retMap.put("rows", performanceReportsList);

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(JsonUtil.toJson(retMap));
            response.getWriter().flush();
            response.getWriter().close();
        } catch (Exception e) {
            logger.error("按月业绩完成率报表查询失败", e);
            throw new BusinessException("按月业绩完成率报表查询失败" + e.getMessage());
        }
    }
}
