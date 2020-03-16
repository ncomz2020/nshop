package com.ncomz.nshop.controller.front.mypage.cart;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.common.UserGroup;
import com.ncomz.nshop.domain.admin.order.OrderInfoMgmt;
import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.domain.front.mypage.cart.Cart;
import com.ncomz.nshop.service.admin.common.code.CodeService;
import com.ncomz.nshop.service.admin.product.ProductService;
import com.ncomz.nshop.service.front.mypage.cart.CartService;
import com.ncomz.nshop.utillty.MessageUtil;

@Controller
@RequestMapping(value = "/front/mypage/cart")
public class CartController {

	private String thisUrl = "front/mypage/cart";

	@Autowired
	private CartService cartService;
	
	@Autowired
	private CodeService codeService;
	

	@Autowired
	private ProductService productService;

	@RequestMapping(value = "list", method = RequestMethod.POST)
	public String list(Model model) {
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		return thisUrl + "/list";
	}
	
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(Model model, Cart cart, HttpServletRequest request) {
		
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		cart.setUsr_id(sessionUser.getUsr_id());
		//model.addAttribute("pagingObject", userGroup);
		//model.addAttribute("count", userGroupService.getUserGroupCount(userGroup));
		model.addAttribute("list", cartService.list(cart));
		return thisUrl + "/listAction";
	}
	
	
	
	@RequestMapping(value = "detail")
	public String detail(ProductInfo productInfo, Model model, HttpServletRequest request) throws Exception {
		
		System.out.println("====2");
		productInfo.setFile_type(Consts.FILE_TYPE_GROUP.PRODUCT);
		productInfo.setLanguage(MessageUtil.getMessage("label.common.language"));
		
		/*
		model.addAttribute("productInfo", productListService.getProductInfo(productInfo));
		model.addAttribute("categoryInfo", productListService.getProductCategoryList(productInfo));
		model.addAttribute("fileList", productListService.getFileList(productInfo));
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		*/
		//pageType 으로 상품관리 페이지인지 파일관리 페이지에서 온것인지 확인.
		model.addAttribute("pageType", request.getParameter("pageType"));
		return thisUrl + "/detail";
	}
	
	@RequestMapping(value = "countPopup", method = RequestMethod.POST)
	public String countPopup(Model model, Cart cart, HttpServletRequest request) {
		System.out.println("cartCont====================================");
		
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		cart.setUsr_id(sessionUser.getUsr_id());
		model.addAttribute("list", cartService.list(cart));
		return thisUrl + "/countPopup";
	}
	
 
	@RequestMapping(value = "insertAction", method = RequestMethod.POST)
	public void insertAction(Model model, Cart cart,  HttpServletRequest request) {
		System.out.println("cartInsert");
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		cart.setUsr_id(sessionUser.getUsr_id());
		//cart.setUsr_id("doyz");
		System.out.println("Cart order_cnt : "+cart.getOrder_cnt());
		System.out.println("Cart prod_id : "+cart.getProd_id());
		System.out.println("Cart store_id : "+cart.getStore_id());
		// 이미 장바구니에 존재하는 상품인지 확인
		Cart existCart = cartService.checkCart(cart);
		
		// 이미있는상품이면 수량 업데이트
		if(existCart != null){
			System.out.println("exist cnt ::::: "+existCart.getOrder_cnt());
			int totalCnt = Integer.parseInt(existCart.getOrder_cnt())+Integer.parseInt(cart.getOrder_cnt());
			existCart.setOrder_cnt(String.valueOf(totalCnt));
			model.addAttribute("result", cartService.updateCart(existCart));
		}else{
			// 없는상품이면 장바구니에 추가
			model.addAttribute("result", cartService.insertAction(cart));
		}
			
	}
	
	

	@RequestMapping(value = "deleteCartAction", method = RequestMethod.POST)
	public void deleteAction(Model model, Cart cart,  HttpServletRequest request) {
		System.out.println("cartDelete");
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		cart.setUsr_id(sessionUser.getUsr_id());
		System.out.println("Cart wish_seq : "+cart.getWish_seq());
		
		model.addAttribute("result", cartService.deleteAction(cart));
	}
	
	@RequestMapping(value = "updateCartAction", method = RequestMethod.POST)
	public void updateCartAction(Model model, Cart cart,  HttpServletRequest request) {
		System.out.println("cartUpdate");
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		cart.setUsr_id(sessionUser.getUsr_id());
		System.out.println("Cart wish_seq : "+cart.getWish_seq());
		
		model.addAttribute("result", cartService.updateCart(cart));
	}
	
}