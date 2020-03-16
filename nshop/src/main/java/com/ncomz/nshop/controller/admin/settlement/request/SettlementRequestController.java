package com.ncomz.nshop.controller.admin.settlement.request;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.settlement.SettlementInfo;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.settlement.SettlementInfoService;
import com.ncomz.nshop.service.admin.store.StoreService;
import com.ncomz.nshop.service.common.CommonService;
import com.ncomz.nshop.utillty.MessageUtil;

@Controller
@RequestMapping(value = "/admin/settlement/request")
public class SettlementRequestController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/settlement/request";

	@Autowired
	private SettlementInfoService settlementService;

	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value = "list")
	public String list(Model model){
		return thisUrl + "/list";
	}
	
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(Model model, SettlementInfo settlementInfo, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		settlementInfo.setStore_id(sessionUser.getStore_id());

		//settlementInfo.setDateFormat(MessageUtil.getMessage("label.common.date.pattern"));
		model.addAttribute("pagingObject", settlementInfo);
		model.addAttribute("count", settlementService.getSettlementReqCount(settlementInfo));
		model.addAttribute("list", settlementService.getSettlementReqList(settlementInfo));
		model.addAttribute("userGrup", sessionUser.getUsr_grp_id());
		return thisUrl + "/listAction";
	}
	
	@RequestMapping(value="statusModifyAction", method = RequestMethod.POST )
	public void statusModifyAction(Model model, SettlementInfo settlementInfo, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		settlementInfo.setStore_id(sessionUser.getStore_id());
		String result = "";
		
		// PROD_ORDER_SEQ 정보로 정산내역데이터 생성
		result = settlementService.insertCalculInfo(settlementInfo);
		
		model.addAttribute("result", result);
	}
	
}
