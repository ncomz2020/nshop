package com.ncomz.nshop.controller.admin.settlement.management;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;


import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.domain.admin.settlement.SettlementHistInfo;
import com.ncomz.nshop.domain.admin.settlement.SettlementInfo;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.settlement.SettlementInfoService;
import com.ncomz.nshop.service.common.CommonService;
import com.ncomz.nshop.utillty.MessageUtil;

@Controller
@RequestMapping(value = "/admin/settlement/management")
public class SettlementManagementController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/settlement/management";

	@Autowired
	private SettlementInfoService settlementInfoService;

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
//
//		productInfo.setDateFormat(MessageUtil.getMessage("label.common.date.pattern"));
		model.addAttribute("userGrup", sessionUser.getUsr_grp_id());
		model.addAttribute("pagingObject", settlementInfo);
		model.addAttribute("count", settlementInfoService.getSettlementInfoCount(settlementInfo));
		model.addAttribute("list", settlementInfoService.getSettlementList(settlementInfo));
		return thisUrl + "/listAction";
	}
	
	@RequestMapping(value = "statusModifyAction", method = RequestMethod.POST)
	public void statusModifyAction(Model model, SettlementInfo settlementInfo, HttpServletRequest request){
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		
		SettlementHistInfo histInfo = new SettlementHistInfo();
		histInfo.setUpdater_id(sessionUser.getUsr_id());
		// 변경 메모 내용 설정필요
		histInfo.setCalcul_memo(settlementInfo.getCalcul_memo());
		
		model.addAttribute("result", settlementInfoService.statusModifyAction(settlementInfo, histInfo));
	}
	
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(SettlementInfo settlementInfo, Model model) throws ParseException, UnsupportedEncodingException {

		model.addAttribute("list", settlementInfoService.listExcel(settlementInfo));

		return "excelViewer";
	}
	
	@RequestMapping(value = "stateModifyPopup", method = RequestMethod.POST)
	public String stateModifyPopup(Model model, SettlementInfo settlementInfo, HttpServletRequest request){
		model.addAttribute("param", request.getAttribute("param"));
		return thisUrl + "/stateModifyPopup";
	}
	
}
