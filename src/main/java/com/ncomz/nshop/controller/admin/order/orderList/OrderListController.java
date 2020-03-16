package com.ncomz.nshop.controller.admin.order.orderList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.order.OrderInfoMgmt;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.order.orderList.OrderListService;


@Controller
@RequestMapping(value = "/admin/order/orderList")
public class OrderListController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/order/orderList";
	
	@Autowired
	private OrderListService orderListService;
	
	
	@RequestMapping(value = "list", method = RequestMethod.POST)
	public String list( HttpServletRequest request
			           ,Model model) throws Exception {
		
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		String startDate 	= orderListService.getStartDate();  // 한달전
		String endDate = orderListService.getEndDate();   // 오늘
		
		model.addAttribute( "start_date"	, startDate );
		model.addAttribute( "end_date"	, endDate );
		model.addAttribute("userGrup", sessionUser.getUsr_grp_id());
		
		String resultUrl ="/list";
		
		return thisUrl + resultUrl; 
	}
	
	
	/** 리스트 조회
	 */
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction( OrderInfoMgmt orderInfoMgmt, Model model, HttpServletRequest request) throws Exception {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);

		orderInfoMgmt.setStore_id(sessionUser.getStore_id());
		model.addAttribute("userGrup", sessionUser.getUsr_grp_id());
		model.addAttribute("pagingObject", orderInfoMgmt);
		model.addAttribute("rowCount", orderListService.getOrderRowCount(orderInfoMgmt));
		model.addAttribute("count", orderListService.getOrderInfoCount(orderInfoMgmt));
		model.addAttribute("list", orderListService.getOrderInfoList(orderInfoMgmt));
		return thisUrl + "/listAction";
		
	}
	
	/**
	 * 상품정보 다중 상태변경 처리
	 */
	@RequestMapping(value = "statusModifyAction", method = RequestMethod.POST)
	public void useStatusAction(Model model, HttpSession session, OrderInfoMgmt orderInfoMgmt, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		orderInfoMgmt.setStore_id(sessionUser.getStore_id());
		model.addAttribute("result", orderListService.statusModifyAction(orderInfoMgmt));
	}
	
	/**
	 * 요구사항 저장 처리
	 */
	@RequestMapping(value = "memoModifyAction", method = RequestMethod.POST)
	public void useMemoAction(Model model, HttpSession session, OrderInfoMgmt orderInfoMgmt, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		orderInfoMgmt.setStore_id(sessionUser.getStore_id());
		model.addAttribute("result", orderListService.memoModifyAction(orderInfoMgmt));
	}
	
	/**
	 * 주문상세정보
	 */
	@RequestMapping(value = "detail", method = RequestMethod.POST)
	public String detail(OrderInfoMgmt orderInfoMgmt, Model model, HttpServletRequest request) throws Exception {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);

		orderInfoMgmt.setStore_id(sessionUser.getStore_id());
		model.addAttribute("userGrup", sessionUser.getUsr_grp_id());
		model.addAttribute("orderInfo", orderListService.getOrderInfo(orderInfoMgmt));
		model.addAttribute("refundInfo", orderListService.getRefundCalc(orderInfoMgmt));
		//pageType 으로 상품관리 페이지인지 파일관리 페이지에서 온것인지 확인.
		model.addAttribute("pageType", request.getParameter("pageType"));		
		
		return thisUrl + "/detail"; 
	}
	
	/**
	 * 주문상세정보
	 */
	@RequestMapping(value = "detailPopup", method = RequestMethod.POST)
	public String detailPopup(OrderInfoMgmt orderInfoMgmt, Model model, HttpServletRequest request) throws Exception {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		
		orderInfoMgmt.setStore_id(sessionUser.getStore_id());
		model.addAttribute("userGrup", sessionUser.getUsr_grp_id());
		model.addAttribute("orderInfo", orderListService.getOrderInfo(orderInfoMgmt));
		
		return thisUrl + "/detailPopup"; 
	}
}
