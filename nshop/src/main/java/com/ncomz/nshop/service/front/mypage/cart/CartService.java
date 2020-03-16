package com.ncomz.nshop.service.front.mypage.cart;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nshop.dao.front.mypage.cart.CartMapper;
import com.ncomz.nshop.dao.front.product.ProductListMapper;
import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.common.Code;
import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.domain.admin.store.StoreInfoMgmt;
import com.ncomz.nshop.domain.common.FileInfo;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.domain.front.mypage.cart.Cart;
import com.ncomz.nshop.service.common.FileService;
import com.ncomz.nshop.utillty.StringUtil;
@Service
public class CartService {

	@Autowired
	private CartMapper cartMapper;

	@Autowired
	private FileService fileService;
	
	
	public int insertAction(Cart cart) {
		
		return cartMapper.insertAction(cart);
	}
	
	public List<Cart> list(Cart cart) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		//storeInfoMgmt.setLanguage(language);
		List<Cart> cartList = cartMapper.list(cart);
		
		System.out.println("===============================");
		System.out.println(cartList.toString());
		System.out.println(cartList.size());
		for (Cart cartInfo : cartList) {
			System.out.println("for 1 === >> >");
		
			FileInfo fileInfo = new FileInfo();
			fileInfo.setKey_id(cartInfo.getProd_id());
			fileInfo.setFile_type("prod");
			cartInfo.setImageFileList(fileService.getFileList(fileInfo));
			cartInfo.setShipping_fee("2500");
		}
		
		for(int i=0; i<cartList.size(); i++){
			System.out.println("for 2 === >> >"); 
			if(i+1 < cartList.size()){
				String storeId = cartList.get(i).getStore_id();
				String nextStoreId = cartList.get(i+1).getStore_id();
				if(storeId.equals(nextStoreId) ||cartList.get(i).getStore_cnt() ==1){
					cartList.get(i).setFlag(true);
					i = i+ cartList.get(i).getStore_cnt()-1;
				}
			}	
		}
		
		if(cartList.size() != 0){
			if(1 == cartList.get(cartList.size()-1).getStore_cnt()){
				
				cartList.get(cartList.size()-1).setFlag(true);
			}
		}
		/*
		for(int i =0; i<cartList.size(); i++){
			String storeId = cartList.get(i).getStore_id();
			for(int j=i+1; j<cartList.get(i).getStore_cnt(); j++){
				if(storeId == cartList.get(j).getStore_id()){
					if(cartList.get(i).getFlag() != true){
						cartList.get(i).setFlag(true);
						i=i+cartList.get(i).getStore_cnt();
						break;
					}
				}
				
			}
		}*/
		System.out.println("===========================");
		System.out.println(cartList.toString());
		return cartList;
	}
	@Transactional
	public String deleteAction(Cart cart) {
		try {
			if(cart.getWish_seq().indexOf(",") == -1){ //, 없으면 
				cartMapper.deleteAction(cart);
			}else{ // ,있으면
				String[] arrWishSeq= cart.getWish_seq().split(",");
				
				for(String wish_seq : arrWishSeq){
					cart.setWish_seq(wish_seq);
					cartMapper.deleteAction(cart);
				}
			}
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}

	public Cart checkCart(Cart cart) {
		// TODO Auto-generated method stub
		return cartMapper.checkCart(cart);
	}

	public Object updateCart(Cart cart) {
		// TODO Auto-generated method stub
		return cartMapper.updateCart(cart);
	}
	
	
}
