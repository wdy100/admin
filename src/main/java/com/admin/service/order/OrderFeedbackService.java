package com.admin.service.order;
import com.admin.entity.order.OrderFeedback;
import com.haier.common.PagerInfo;
import com.haier.common.ServiceResult;

import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface OrderFeedbackService {

    /**
     * 分页查询
     * @param params
     * @param pagerInfo
     * @return
     */
    public ServiceResult<Map<String, Object>> searchOrderFeedbacks(Map<String, Object> params, PagerInfo pagerInfo);

    /**
     * 创建
     * @param orderFeedback
     */
    public ServiceResult<OrderFeedback> createOrderFeedback(OrderFeedback orderFeedback);

    /**
     * 更新
     * @param orderFeedback
     */
    public ServiceResult<OrderFeedback> updateOrderFeedback(OrderFeedback orderFeedback);
}
