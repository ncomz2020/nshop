package com.ncomz.nshop.service.front.order;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Random;

import javax.swing.text.html.HTMLEditorKit.Parser;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nshop.dao.front.order.OrderMapper;
import com.ncomz.nshop.domain.admin.order.OrderInfoMgmt;
import com.ncomz.nshop.domain.common.FileInfo;
import com.ncomz.nshop.domain.front.mypage.cart.Cart;
import com.ncomz.nshop.domain.front.order.Order;
import com.ncomz.nshop.service.common.FileService;
@Service
public class OrderService {

	@Autowired
	private OrderMapper orderMapper;

	
	@Autowired
	private FileService fileService;
	
	
	public List<Cart> list(Cart cart) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		//storeInfoMgmt.setLanguage(language);
		
		List<String> objectwishSeqList = new ArrayList<String>();
		
		String wish_seq= cart.getWish_seq();
		String[] arrWish_seq = wish_seq.split(",");
		for(String wishSeq : arrWish_seq){
			objectwishSeqList.add(wishSeq);
		}
		cart.setObjectwishSeqList(objectwishSeqList);
		List<Cart> cartList = new ArrayList<Cart>();
		
		if(StringUtils.isEmpty(cart.getDirect_order())){
			cartList = orderMapper.list(cart);
		}else{
			cartList = orderMapper.directList(cart);
		}
		
		
		
		for (Cart cartInfo : cartList) {
		
			FileInfo fileInfo = new FileInfo();
			fileInfo.setKey_id(cartInfo.getProd_id());
			fileInfo.setFile_type("prod");
			cartInfo.setImageFileList(fileService.getFileList(fileInfo));
			cartInfo.setShipping_fee("2500");
		}
		
		for(int i=0; i<cartList.size(); i++){
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
		return cartList;
		
	}
	
	public Cart orderList(Cart cart){
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		//storeInfoMgmt.setLanguage(language);
		
		List<String> objectwishSeqList = new ArrayList<String>();
		
		String wish_seq= cart.getWish_seq();
		String[] arrWish_seq = wish_seq.split(",");
		
		for(String wishSeq : arrWish_seq){
			objectwishSeqList.add(wishSeq);
		}
		cart.setObjectwishSeqList(objectwishSeqList);
		List<Cart> cartList = new ArrayList<Cart>();
		Cart orderCart = new Cart();
		
		if(StringUtils.isEmpty(cart.getDirect_order())){
			cartList = orderMapper.list(cart);
		}else{
			cartList = orderMapper.directList(cart);
		}
		
		List<String> str = new ArrayList<String>();
		List<String> str2 = new ArrayList<String>();
		List<String> str3 = new ArrayList<String>();
		
		for (Cart cartInfo : cartList) {
			str.add(cartInfo.getProd_id());
			str2.add(cartInfo.getOrder_cnt());	
			str3.add(cartInfo.getWish_seq());
		}
		
		String prodId = str.toString();
		String orderCnt = str2.toString();
		String wishSeq = str3.toString();
		
		prodId = prodId.replace("[", "");
		prodId = prodId.replace("]", "");
		
		orderCnt = orderCnt.replace("[", "");
		orderCnt = orderCnt.replace("]", "");
		
		wishSeq = wishSeq.replace("[", "");
		wishSeq = wishSeq.replace("]", "");
		
		orderCart.setProd_id(prodId); //상품 ID 목록
		orderCart.setOrder_cnt(orderCnt); //상품개수 목록
		orderCart.setWish_seq(wishSeq);
		return orderCart;
	}
	 
	@Transactional
	public String insertOrderInfo(Order order) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); //SSS가 밀리세컨드 표시
		Calendar calendar = Calendar.getInstance();
        
		Random random = new Random(); //뒤의 3자리 랜덤수
		int randomNum = random.nextInt(999);
		
		String orderNo = dateFormat.format(calendar.getTime())+""+String.format("%03d", randomNum+1); //주문 번호 생성
		order.setOrder_no(orderNo);
		
		int curOrder = orderMapper.insertOrder(order);//마스터 주문 
		try{
			if(curOrder <= 0){
				throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
			}else{
				try {
					String curDate = dateFormat.format(calendar.getTime());
					if(order.getProd_id().indexOf(",") == -1){ //, 없으면(상품이 1개인 경우) 	
						if(insertProdInfo(order.getOrder_seq(), curDate, order.getProd_id(), order.getOrder_cnt(), order.getUser_id()) <= 0){
							throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
						}						
					}else{ // ,있으면(상품이 2개 이상 인 경우
						String[] arrProdId= order.getProd_id().split(",");
						String[] arrOrderCnt = order.getOrder_cnt().split(",");						
						for(int i = 0; i < arrProdId.length; i++){	
							if(insertProdInfo(order.getOrder_seq(), curDate, arrProdId[i].replaceAll(" ",""), arrOrderCnt[i].replaceAll(" ",""), order.getUser_id()) <= 0){
								throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
							}
						}
					}	
					
					return order.getOrder_seq()+""; //마스터 주문 시퀀스 리턴
				} catch (Exception ex) {
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
					ex.printStackTrace();
					return ex.getMessage();
				}
			}		
		}catch(Exception ex){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();			
		}
	}
	
	@Transactional
	public int insertProdInfo(int orderNo, String curDate, String prodId, String prodCnt, String userId){ //상품 주문 insert
		Random random = new Random(); //뒤의 3자리 랜덤수
		int randomNum = 0;
		int paymentAmt = 0; //상품가격 * 수량

		String prodOrderNo = null; //상품 주문 번호
		
		Order order = new Order();
		Order orderInfo = new Order();
		
		randomNum = random.nextInt(999);
		prodOrderNo = curDate+""+String.format("%03d", randomNum+1); //상품 주문번호 생성
		order.setProd_order_no(prodOrderNo);
		
		order.setOrder_seq(orderNo);
		order.setUser_id(userId);		
		order.setProd_id(prodId);
		order.setOrder_cnt(prodCnt);	
		
		orderInfo = orderMapper.storeInfo(prodId);
		order.setStore_id(orderInfo.getStore_id());
		order.setOrder_amt(orderInfo.getOrder_amt());
		order.setStore_name(orderInfo.getStore_name());		
		paymentAmt = Integer.parseInt(orderInfo.getOrder_amt()) * Integer.parseInt(prodCnt);		
		order.setPayment_amt(paymentAmt+"");
		
		while(orderMapper.prodValidChk(prodOrderNo) >= 1){//같은 번호 존재힐 경우
			randomNum = random.nextInt(999);
			prodOrderNo = curDate+""+String.format("%03d", randomNum+1); //상품 주문번호 다시 생성
			
			if(orderMapper.prodValidChk(prodOrderNo) < 1){
				order.setProd_order_no(prodOrderNo);
				break;
			}
		}
		
		orderMapper.insertProdOrder(order);
		return orderMapper.insertDlvy(order);
	}
	
}
