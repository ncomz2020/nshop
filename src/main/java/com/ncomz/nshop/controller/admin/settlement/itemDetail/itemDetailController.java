package com.ncomz.nshop.controller.admin.settlement.itemDetail;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.List;

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
@RequestMapping(value = "/admin/settlement/itemDetail")
public class itemDetailController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/settlement/itemDetail";

	@Autowired
	private SettlementInfoService settlementInfoService;
	
	@RequestMapping(value = "list")
	public String list(Model model, SettlementInfo settlementInfo, HttpServletRequest request){
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		model.addAttribute("userGrup", sessionUser.getUsr_grp_id());
		model.addAttribute("info", settlementInfo);
		model.addAttribute("pagingObject", settlementInfo);
		return thisUrl + "/list";
	}
	
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(Model model, SettlementInfo settlementInfo, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		settlementInfo.setStore_id(sessionUser.getStore_id());
		
		List<SettlementInfo> list = settlementInfoService.getSettlementByItemList(settlementInfo);

		model.addAttribute("pagingObject", settlementInfo);
		model.addAttribute("count", settlementInfoService.getSettlementByItemCount(settlementInfo));
		model.addAttribute("list", list);
		
		if(list.size()>0){
			model.addAttribute("sum", settlementInfoService.getSumByItem(settlementInfo));
		}
		return thisUrl + "/listAction";
	}
	
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(SettlementInfo settlementInfo, Model model) throws ParseException, UnsupportedEncodingException {

		model.addAttribute("list", settlementInfoService.itemDetailListExcel(settlementInfo));

		return "excelViewer";
	}
	
	@RequestMapping(value="calculDetailPopup", method = RequestMethod.POST)
	public String calculDetailPopup(Model model, SettlementInfo settlementInfo, HttpServletRequest request){
		
		
		// 상태변경이력 데이터 불러오기
		model.addAttribute("histList", settlementInfoService.getCalculHistList(settlementInfo));
		model.addAttribute("info", settlementInfoService.getCalculDetail(settlementInfo));
		
		return thisUrl + "/calculDetailPopup";
	}
}
