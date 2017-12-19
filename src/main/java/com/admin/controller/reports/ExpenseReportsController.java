package com.admin.controller.reports;

import com.admin.entity.reports.ExpenseReports;
import com.admin.service.reports.ExpenseReportsService;
import com.haier.common.BusinessException;
import com.haier.common.ServiceResult;
import com.haier.common.util.JsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2017/12/19.
 */
@Controller
@RequestMapping("/report")
@Slf4j
public class ExpenseReportsController {
    private final static org.apache.log4j.Logger logger = LogManager.getLogger(ExpenseReportsController.class);

    @Resource
    private ExpenseReportsService expenseReportsService;

    @RequestMapping(value = "personalExpense.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String personalExpense(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        return "reports/personal_expense_list";
    }

    @RequestMapping("/findPersonalExpenseList")
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

            ServiceResult<List<ExpenseReports>> result = expenseReportsService.getExpenseReportsListByPerson(params);
            if(result == null || !result.getSuccess()) {
                logger.error("人员费用支出报表查询失败");
                throw new BusinessException("人员费用支出报表查询失败");
            }
            List<ExpenseReports> expenseReportsList = result.getResult();

            //获得条数
            int resultcount = expenseReportsList.size();
            Map<String, Object> retMap = new HashMap<String, Object>();
            retMap.put("total", resultcount);
            retMap.put("rows", expenseReportsList);

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(JsonUtil.toJson(retMap));
            response.getWriter().flush();
            response.getWriter().close();
        } catch (Exception e) {
            logger.error("人员费用支出报表查询失败", e);
            throw new BusinessException("人员费用支出报表查询失败" + e.getMessage());
        }
    }

    @RequestMapping(value = "monthExpense.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String monthExpense(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        return "reports/month_expense_list";
    }

    @RequestMapping("/findMonthExpenseList")
    public void findMonthExpenseList(@RequestParam(required = false) Integer year,
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

            ServiceResult<List<ExpenseReports>> result = expenseReportsService.getExpenseReportsListByMonth(params);
            if(result == null || !result.getSuccess()) {
                logger.error("按月费用支出报表查询失败");
                throw new BusinessException("按月费用支出报表查询失败");
            }
            List<ExpenseReports> expenseReportsList = result.getResult();

            //获得条数
            int resultcount = expenseReportsList.size();
            Map<String, Object> retMap = new HashMap<String, Object>();
            retMap.put("total", resultcount);
            retMap.put("rows", expenseReportsList);

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(JsonUtil.toJson(retMap));
            response.getWriter().flush();
            response.getWriter().close();
        } catch (Exception e) {
            logger.error("按月费用支出报表查询失败", e);
            throw new BusinessException("按月费用支出报表查询失败" + e.getMessage());
        }
    }
}
