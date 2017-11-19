package com.admin.service.impl.customer;

import com.admin.dao.customer.CustomerDao;
import com.admin.dao.system.UserDao;
import com.admin.entity.system.User;
import com.admin.entity.customer.Customer;
import com.admin.service.customer.CustomerService;
import com.admin.service.system.UserService;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.google.common.base.Preconditions.checkNotNull;

/**
 * Created by GaoJingFei on 2017/11/13.
 */
@Slf4j
@Service
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerDao customerDao;

    @Override
    public ServiceResult<Map<String, Object>> searchCustomers(Map<String, Object> params, PagerInfo pagerInfo) {
        ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        // 记录总数
        int rowsCount = customerDao.queryCountBy(params);
        int start = pagerInfo.getStart();
        int size = pagerInfo.getPageSize();
        if (rowsCount > 0) {
            int totalPage = (rowsCount + size - 1) / size;// 总页数
            int pageIndex = pagerInfo.getPageIndex();// 当前页码
            if (pageIndex > totalPage) {
                // 总页数作为当前页
                start = (totalPage - 1) * size;
            }
        }
        params.put("start", start);
        params.put("size", size);
        List<Customer> customers = customerDao.queryListBy(params);
        map.put("data", customers);
        map.put("total", rowsCount);
        result.setResult(map);
        return result;
    }

    @Override
    public ServiceResult<Customer> createCustomer(Customer customer) {
        ServiceResult<Customer> executeResult = new ServiceResult<Customer>();
        customer.setCreatedAt(new Date());
        customer.setUpdatedAt(new Date());
        customerDao.insert(customer);
        executeResult.setResult(customer);
        return executeResult;
    }
    @Override
    public ServiceResult<Customer> updateCustomer(Customer customer) {
        ServiceResult<Customer> executeResult = new ServiceResult<Customer>();
        Customer dbCustomer = customerDao.getById(customer.getId());
        if(dbCustomer == null){
            executeResult.setMessage("该客户不存在或已经被删除。");
            return executeResult;
        }
//        dbCustomer.setStatus(customer.getStatus());
//        dbCustomer.setPassword(customer.getPassword());
        dbCustomer.setUpdatedBy(customer.getUpdatedBy());
        dbCustomer.setUpdatedAt(new Date());
        customerDao.update(dbCustomer);
        return executeResult;
    }
}
