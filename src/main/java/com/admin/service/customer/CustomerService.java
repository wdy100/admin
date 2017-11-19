package com.admin.service.customer;
import com.admin.entity.system.User;
import com.admin.entity.customer.Customer;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;

import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface CustomerService {

    /**
     * 分页查询
     * @param params
     * @param pagerInfo
     * @return
     */
    public ServiceResult<Map<String, Object>> searchCustomers(Map<String, Object> params, PagerInfo pagerInfo);

    /**
     * 创建
     * @param customer
     */
    public ServiceResult<Customer> createCustomer(Customer customer);

    /**
     * 更新
     * @param customer
     */
    public ServiceResult<Customer> updateCustomer(Customer customer);
}
