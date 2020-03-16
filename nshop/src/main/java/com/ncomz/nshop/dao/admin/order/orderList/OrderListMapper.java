package com.ncomz.nshop.dao.admin.order.orderList;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.order.OrderInfoMgmt;

@Component
public interface OrderListMapper {
	String getStartDate();
	String getEndDate();
	List<OrderInfoMgmt> getOrderlist(OrderInfoMgmt orderInfoMgmt);
	List<OrderInfoMgmt> getCancelOrderlist(OrderInfoMgmt orderInfoMgmt);
	List<OrderInfoMgmt> getOrderInfo(OrderInfoMgmt orderInfoMgmt);
	int getOrderCount(OrderInfoMgmt orderInfoMgmt);
	int insertOrderHist(OrderInfoMgmt orderInfoMgmt);
	int statusModifyAction(OrderInfoMgmt orderInfoMgmt);
	int memoModifyAction(OrderInfoMgmt orderInfoMgmt);
}
