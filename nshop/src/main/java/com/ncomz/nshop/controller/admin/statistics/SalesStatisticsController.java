package com.ncomz.nshop.controller.admin.statistics;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.statistics.SalesStatistics;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.statistics.SalesStatisticsService;

@Controller
@RequestMapping(value = "/admin/statistics/")
public class SalesStatisticsController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/statistics/";

	@Autowired
	private SalesStatisticsService salesStatisticsService;

	@RequestMapping(value = "salesStatistics", method = RequestMethod.POST)
	public String salesStatistics(Model model, HttpServletRequest request) throws Exception {
		
		String sessionStoreId = "";
		String sessionGrpNm = "";
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		sessionStoreId = sessionUser.getStore_id();
		sessionGrpNm = sessionUser.getUsr_grp_nm();

		model.addAttribute("sessionStoreId", sessionStoreId);
		model.addAttribute("sessionGrpNm", sessionGrpNm);
		
		return thisUrl + "/salesStatistics"; 
	}
	
	@RequestMapping(value = "getSalesStatisticsListAction", method = RequestMethod.POST)
	public String getSalesStatisticsListAction(Model model, SalesStatistics ss,
			HttpServletRequest request){

		Map<String, Object> ssInfo = salesStatisticsService.getSalesStatisticsList(ss);
		model.addAttribute("data", ssInfo.get("salesStatisticsList"));

		return thisUrl + "/salesStatistics";
	}
	
	@RequestMapping(value = "salesExportAction", method = RequestMethod.POST)
	public String exportAction(SalesStatistics ss, Model model) throws ParseException, UnsupportedEncodingException {
		
		Map<String, Object> ssInfo = salesStatisticsService.listExcel(ss);
		model.addAttribute("list", ssInfo.get("salesStatisticsList"));

		return "excelViewer";
	}
}
