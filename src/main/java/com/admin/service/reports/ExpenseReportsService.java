package com.admin.service.reports;

import com.admin.entity.reports.ExpenseReports;
import com.haier.common.ServiceResult;

import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2017/12/19.
 */
public interface ExpenseReportsService {

    public ServiceResult<List<ExpenseReports>> getExpenseReportsListByPerson(Map<String, Object> paramMap);

    public ServiceResult<List<ExpenseReports>> getExpenseReportsListByMonth(Map<String, Object> paramMap);
}
