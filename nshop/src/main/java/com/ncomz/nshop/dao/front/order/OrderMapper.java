package com.ncomz.nshop.dao.front.order;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.store.StoreInfoMgmt;
import com.ncomz.nshop.domain.front.mypage.cart.Cart;
import com.ncomz.nshop.domain.front.order.Order;

@Component
public interface OrderMapper {
	List<Cart> list(Cart cart);
	List<Cart> directList(Cart cart);
	Order userInfo(Order order);
	Order storeInfo(String prodId);
	int prodValidChk(String prodOrderNo);
	int insertOrder(Order order);
	int insertProdOrder(Order order);
	int insertDlvy(Order order);
}
