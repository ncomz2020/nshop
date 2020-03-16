package com.ncomz.nshop.controller.admin.order.cancelList;

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
import com.ncomz.nshop.service.admin.order.cancelList.CancelListService;


@Controller
@RequestMapping(value = "/admin/order/cancelList")
public class CancelListController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/order/cancelList";
	
	@Autowired
	private CancelListService cancelListService;
	
	@RequestMapping(value = "list", method = RequestMethod.POST)
	public String list( HttpServletRequest request
			           ,Model model) throws Exception {
		
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		String startDate 	= cancelListService.getStartDate();  // 한달전
		String endDate = cancelListService.getEndDate();   // 오늘
		
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
		model.addAttribute("rowCount", cancelListService.getCancelOrderRowCount(orderInfoMgmt));
		model.addAttribute("count", cancelListService.getOrderInfoCount(orderInfoMgmt));
		model.addAttribute("list", cancelListService.getCancelOrderInfoList(orderInfoMgmt));
		return thisUrl + "/listAction";
		
	}
	
	/**
	 * 취소/교환/반품 상태변경 처리
	 */
	@RequestMapping(value = "statusModifyAction", method = RequestMethod.POST)
	public void statusModifyAction(Model model, HttpSession session, OrderInfoMgmt orderInfoMgmt, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		model.addAttribute("result", cancelListService.statusModifyAction(orderInfoMgmt));
	}
	
	/**
	 * 철회 사유 팝업
	 */
	@RequestMapping(value = "refuse", method = RequestMethod.POST)
	public String refuse(Model model, OrderInfoMgmt orderInfoMgmt) {
		model.addAttribute("info", orderInfoMgmt);	
		return thisUrl + "/refuse";
	}
	
	/**
	 * 철회/불가 상태 변경
	 */
	@RequestMapping(value = "refuseAction", method = RequestMethod.POST)
	public void refuseAction(Model model, HttpSession session, OrderInfoMgmt orderInfoMgmt, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		model.addAttribute("result", cancelListService.statusModifyAction(orderInfoMgmt));
	}
	
}
