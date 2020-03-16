package com.ncomz.nshop.controller.admin.statistics;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.statistics.OrderStatistics;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.statistics.OrderStatisticsService;

@Controller
@RequestMapping(value = "/admin/statistics/")
public class OrderStatisticsController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/statistics/";

	@Autowired
	private OrderStatisticsService orderStatisticsService;

	@RequestMapping(value = "orderStatistics", method = RequestMethod.POST)
	public String orderStatistics(Model model, HttpServletRequest request) throws Exception {
		
		String sessionStoreId = "";
		String sessionGrpNm = "";
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		sessionStoreId = sessionUser.getStore_id();
		sessionGrpNm = sessionUser.getUsr_grp_nm();

		model.addAttribute("sessionStoreId", sessionStoreId);
		model.addAttribute("sessionGrpNm", sessionGrpNm);
		
		return thisUrl + "/orderStatistics"; 
	}
	
	@RequestMapping(value = "getOrderStatisticsListAction", method = RequestMethod.POST)
	public String getOrderStatisticsListAction(Model model, OrderStatistics os,
			HttpServletRequest request){

		Map<String, Object> osInfo = orderStatisticsService.getOrderStatisticsList(os);
		model.addAttribute("chartData", osInfo.get("orderChartStatisticsList"));
		model.addAttribute("gridData", osInfo.get("orderGridStatisticsList"));

		return thisUrl + "/orderStatistics";
	}
	
	@RequestMapping(value = "orderExportAction", method = RequestMethod.POST)
	public String exportAction(OrderStatistics os, Model model) {
		
		Map<String, Object> info = orderStatisticsService.listExcel(os);
		model.addAttribute("list", info.get("list"));

		return "excelViewer";
	}
}
