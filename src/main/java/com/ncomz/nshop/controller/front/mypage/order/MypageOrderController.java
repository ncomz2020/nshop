package com.ncomz.nshop.controller.front.mypage.order;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nshop.dao.front.mypage.order.MypageOrderMapper;
import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.order.OrderInfoMgmt;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.common.code.CodeService;
import com.ncomz.nshop.service.front.mypage.order.MypageOrderService;


@Controller
@RequestMapping(value = "/front/mypage/order")
public class MypageOrderController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "front/mypage/order";
	
	@Autowired
	private MypageOrderService mypageOrderService;
	
	@Autowired
	private MypageOrderMapper mypageOrderMapper;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = "list")
	public String list( HttpServletRequest request
			           ,Model model) throws Exception {
		
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		String startDate 	= mypageOrderService.getStartDate();  // 한달전
		String endDate = mypageOrderService.getEndDate();   // 오늘
		
		model.addAttribute( "start_date"	, startDate );
		model.addAttribute( "end_date"	, endDate );
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		
		String resultUrl ="/list";
		
		return thisUrl + resultUrl; 
	}
	
	
	/** 리스트 조회
	 */
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction( OrderInfoMgmt orderInfoMgmt, Model model, HttpServletRequest request) throws Exception {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		orderInfoMgmt.setUser_id(sessionUser.getUsr_id());
		model.addAttribute("pagingObject", orderInfoMgmt);
		model.addAttribute("count", mypageOrderService.getFrontOrderCount(orderInfoMgmt));
		model.addAttribute("list", mypageOrderService.getFrontOrderInfoList(orderInfoMgmt));
		return thisUrl + "/listAction";
		
	}
	/**
	 * 주문상세정보
	 */
	@RequestMapping(value = "detail", method = RequestMethod.POST)
	public String detail(OrderInfoMgmt orderInfoMgmt, Model model, HttpServletRequest request) throws Exception {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);

		model.addAttribute("userGrup", sessionUser.getUsr_grp_id());
		model.addAttribute("orderInfo", mypageOrderService.getOrderInfo(orderInfoMgmt));
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		model.addAttribute("refundInfo", mypageOrderService.getRefundCalc(orderInfoMgmt));
		//pageType 으로 상품관리 페이지인지 파일관리 페이지에서 온것인지 확인.
		model.addAttribute("pageType", request.getParameter("pageType"));
		
		return thisUrl + "/detail"; 
	}	
	
	/**
	 * 배송지 변경 팝업
	 */
	@RequestMapping(value = "modifyAddr", method = RequestMethod.POST)
	public String modify(Model model, OrderInfoMgmt orderInfoMgmt) {
		model.addAttribute("orderSeq", orderInfoMgmt.getOrder_seq());
		model.addAttribute("popupType", orderInfoMgmt.getPopupType());
		model.addAttribute("info", mypageOrderMapper.getOrderDtlInfo(orderInfoMgmt));		
		return thisUrl + "/modifyAddr";
	}
	
	/**
	 * 배송지 변경 Action
	 */
	@RequestMapping(value = "addrModifyAction", method = RequestMethod.POST)
	public void useStatusAction(Model model, HttpSession session, OrderInfoMgmt orderInfoMgmt, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		orderInfoMgmt.setUser_id(sessionUser.getUsr_id());
		model.addAttribute("result", mypageOrderService.modifyAddrAction(orderInfoMgmt));
	}
	
	/**
	 * 구매확정 화면
	 */
	@RequestMapping(value = "confirmation", method = RequestMethod.POST)
	public String confirmation(Model model, OrderInfoMgmt orderInfoMgmt) {
		model.addAttribute("sts_cd", orderInfoMgmt.getSts_cd());
		model.addAttribute("list", mypageOrderMapper.getOrderInfo(orderInfoMgmt));
		return thisUrl + "/confirmation";
	}
	
	/**
	 * 구매확정 Action
	 */
	@RequestMapping(value = "confirmationAction", method = RequestMethod.POST)
	public String confirmationAction(Model model, HttpSession session, OrderInfoMgmt orderInfoMgmt, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		orderInfoMgmt.setUser_id(sessionUser.getUsr_id());
		model.addAttribute("result", mypageOrderService.confirmationAction(orderInfoMgmt));
		return thisUrl + "/confirmation";
	}
	
	/**
	 * 교환반품, 취소 신청 화면
	 * */
	@RequestMapping(value = "applyPopup", method = RequestMethod.POST)
	public String applyPopup(Model model, OrderInfoMgmt orderInfoMgmt) {
		model.addAttribute("sts_cd", orderInfoMgmt.getSts_cd());
		model.addAttribute("list", mypageOrderMapper.getOrderInfo(orderInfoMgmt));
		return thisUrl + "/applyPopup";
	}
	
	/**
	 * 교환반품, 취소 신청 Action
	 */
	@RequestMapping(value = "applyPopupAction", method = RequestMethod.POST)
	public String applyPopupAction(Model model, HttpSession session, OrderInfoMgmt orderInfoMgmt, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		orderInfoMgmt.setUser_id(sessionUser.getUsr_id());
		model.addAttribute("result", mypageOrderService.statusModifyAction(orderInfoMgmt));
		return thisUrl + "/applyPopupAction";
	}
	
}
