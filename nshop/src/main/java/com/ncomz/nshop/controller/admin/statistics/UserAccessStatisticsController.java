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
import com.ncomz.nshop.domain.admin.statistics.UserAccessStatistics;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.statistics.UserAccessStatisticsService;

@Controller
@RequestMapping(value = "/admin/statistics/")
public class UserAccessStatisticsController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/statistics/";

	@Autowired
	private UserAccessStatisticsService userAccessStatisticsService;

	@RequestMapping(value = "userAccessStatistics", method = RequestMethod.POST)
	public String userAccessStatistics(Model model, HttpServletRequest request) throws Exception {
		
		String sessionStoreId = "";
		String sessionGrpNm = "";
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		sessionStoreId = sessionUser.getStore_id();
		sessionGrpNm = sessionUser.getUsr_grp_nm();

		model.addAttribute("sessionStoreId", sessionStoreId);
		model.addAttribute("sessionGrpNm", sessionGrpNm);
		
		return thisUrl + "/userAccessStatistics"; 
	}
	
	@RequestMapping(value = "getListAction", method = RequestMethod.POST)
	public String getListAction(Model model, UserAccessStatistics ua,
			HttpServletRequest request){

		Map<String, Object> uaInfo = userAccessStatisticsService.getList(ua);
		model.addAttribute("data", uaInfo.get("list"));

		return thisUrl + "/userAccessStatistics";
	}
	
	@RequestMapping(value = "accessExportAction", method = RequestMethod.POST)
	public String exportAction(UserAccessStatistics ua, Model model) {
		
		Map<String, Object> info = userAccessStatisticsService.listExcel(ua);
		model.addAttribute("list", info.get("list"));

		return "excelViewer";
	}
}
