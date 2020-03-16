package com.ncomz.nshop.dao.front.mypage.cart;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.store.StoreInfoMgmt;
import com.ncomz.nshop.domain.front.mypage.cart.Cart;

@Component
public interface CartMapper {
	List<Cart> list(Cart cart);
	int insertAction(Cart cart);
	int deleteAction(Cart cart);
	Cart checkCart(Cart cart);
	int updateCart(Cart cart);
}
