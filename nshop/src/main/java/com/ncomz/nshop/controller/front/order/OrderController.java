package com.ncomz.nshop.controller.front.order;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ncomz.nshop.dao.front.order.OrderMapper;
import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.domain.front.mypage.cart.Cart;
import com.ncomz.nshop.domain.front.order.Order;
import com.ncomz.nshop.service.admin.common.code.CodeService;
import com.ncomz.nshop.service.front.mypage.cart.CartService;
import com.ncomz.nshop.service.front.order.OrderService;

@Controller
@RequestMapping(value = "/front/order")
public class OrderController {

	private String thisUrl = "front/order";

	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private OrderMapper orderMapper;

 
 
	
	@RequestMapping(value = "list", method = RequestMethod.POST)
	public String list(Model model, Cart cart) {
		System.out.println("orderController List");
		System.out.println(cart.getWish_seq());
		model.addAttribute("wish_seq",cart.getWish_seq());
		model.addAttribute("info", cart);
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		return thisUrl + "/list";
	}
	
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(Model model, Cart cart, Order order, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		cart.setUsr_id(sessionUser.getUsr_id());
		order.setUser_id(sessionUser.getUsr_id());
		
		
		System.out.println("orderController ListAction");
		System.out.println(cart.getWish_seq());
		//model.addAttribute("pagingObject", userGroup);
		//model.addAttribute("count", userGroupService.getUserGroupCount(userGroup));
		model.addAttribute("list", orderService.list(cart));
		model.addAttribute("orderList", orderService.orderList(cart));		
		model.addAttribute("info", orderMapper.userInfo(order));
		return thisUrl + "/listAction";
	}
	
	@RequestMapping(value = "payAction", method = RequestMethod.POST)
	public void payAction(Model model, Cart cart, Order order, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		cart.setUsr_id(sessionUser.getUsr_id());
		order.setUser_id(sessionUser.getUsr_id());
		
		System.out.println("orderController payAction");
		model.addAttribute("result",orderService.insertOrderInfo(order));
		model.addAttribute("cartResult", cartService.deleteAction(cart));
	}
	
	@RequestMapping(value = "mobilePay", method = RequestMethod.GET)
	public String mobilePay(Model model, Cart cart, Order order, String imp_uid, String merchant_uid, String imp_success, HttpServletRequest request,RedirectAttributes redirectAttributes) {
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		cart.setUsr_id(sessionUser.getUsr_id());
		order.setUser_id(sessionUser.getUsr_id());
		System.out.println("!!"+imp_uid);
		if(imp_success.equals("true")){
			model.addAttribute("orderSeq",orderService.insertOrderInfo(order));
			model.addAttribute("cartResult", cartService.deleteAction(cart));
			return thisUrl +"/finish";
		}else{
			return "front/product/list";
		}
	}
	
	@RequestMapping(value = "finish", method = RequestMethod.POST)
	public String finish(Model model, Order order) {
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		model.addAttribute("orderSeq", order.getOrder_seq());
		return thisUrl + "/finish";
	}
	
}