package com.admin.service.impl.reports;

import com.admin.dao.reports.ExpenseReportsDao;
import com.admin.entity.reports.ExpenseReports;
import com.admin.service.reports.ExpenseReportsService;
import com.haier.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2017/12/19.
 */
@Slf4j
@Service
public class ExpenseReportsServiceImpl implements ExpenseReportsService {
    @Autowired
    private ExpenseReportsDao expenseReportsDao;

    @Override
    public ServiceResult<List<ExpenseReports>> getExpenseReportsListByPerson(Map<String, Object> paramMap) {
        ServiceResult<List<ExpenseReports>> result = new ServiceResult<List<ExpenseReports>>();
        result.setResult(expenseReportsDao.getExpenseReportsListByPerson(paramMap));

        return result;
    }

    @Override
    public ServiceResult<List<ExpenseReports>> getExpenseReportsListByMonth(Map<String, Object> paramMap) {
        ServiceResult<List<ExpenseReports>> result = new ServiceResult<List<ExpenseReports>>();
        result.setResult(expenseReportsDao.getExpenseReportsListByMonth(paramMap));

        return result;
    }
}
