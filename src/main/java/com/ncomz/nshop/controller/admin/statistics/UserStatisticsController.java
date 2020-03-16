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
import com.ncomz.nshop.domain.admin.statistics.UserStatistics;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.statistics.UserStatisticsService;

@Controller
@RequestMapping(value = "/admin/statistics/")
public class UserStatisticsController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/statistics/";

	@Autowired
	private UserStatisticsService userStatisticsService;

	@RequestMapping(value = "userStatistics", method = RequestMethod.POST)
	public String userStatistics(Model model, HttpServletRequest request) throws Exception {
		
		String sessionStoreId = "";
		String sessionGrpNm = "";
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		sessionStoreId = sessionUser.getStore_id();
		sessionGrpNm = sessionUser.getUsr_grp_nm();

		model.addAttribute("sessionStoreId", sessionStoreId);
		model.addAttribute("sessionGrpNm", sessionGrpNm);
		
		return thisUrl + "/userStatistics"; 
	}
	
	@RequestMapping(value = "getUserStatisticsListAction", method = RequestMethod.POST)
	public String getUserStatisticsListAction(Model model, UserStatistics us,
			HttpServletRequest request){

		Map<String, Object> usInfo = userStatisticsService.getUserStatisticsList(us);
		model.addAttribute("data", usInfo.get("userStatisticsList"));

		return thisUrl + "/userStatistics";
	}
	
	@RequestMapping(value = "userExportAction", method = RequestMethod.POST)
	public String exportAction(UserStatistics us, Model model) {
		
		Map<String, Object> info = userStatisticsService.listExcel(us);
		model.addAttribute("list", info.get("list"));

		return "excelViewer";
	}
}
