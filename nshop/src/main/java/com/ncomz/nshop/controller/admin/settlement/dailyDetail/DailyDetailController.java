package com.ncomz.nshop.controller.admin.settlement.dailyDetail;

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
import com.ncomz.nshop.domain.admin.settlement.SettlementInfo;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.settlement.SettlementInfoService;

@Controller
@RequestMapping(value = "/admin/settlement/dailyDetail")
public class DailyDetailController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/settlement/dailyDetail";

	@Autowired
	private SettlementInfoService settlementInfoService;
	
	@RequestMapping(value = "list")
	public String list(Model model, HttpServletRequest request){
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		model.addAttribute("userGrup", sessionUser.getUsr_grp_id());
		return thisUrl + "/list";
	}
	
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(Model model, SettlementInfo settlementInfo, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		settlementInfo.setStore_id(sessionUser.getStore_id());
		int count = settlementInfoService.getSettlementByDailyCount(settlementInfo);

		model.addAttribute("pagingObject", settlementInfo);
		model.addAttribute("count", count);
		model.addAttribute("list", settlementInfoService.getSettlementByDailyList(settlementInfo));
		if(count > 0){
			model.addAttribute("sum", settlementInfoService.getSettlementByDailyInfo(settlementInfo));
		}
		return thisUrl + "/listAction";
	}
	
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(SettlementInfo settlementInfo, Model model) throws ParseException, UnsupportedEncodingException {

		model.addAttribute("list", settlementInfoService.dailyListExcel(settlementInfo));

		return "excelViewer";
	}
}
