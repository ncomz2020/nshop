package com.ncomz.nshop.controller.admin.statistics;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nshop.domain.admin.mypage.MyPage;
import com.ncomz.nshop.service.admin.statistics.StatisticsService;

@Controller
@RequestMapping(value = "/admin/statistics/")
public class StatisticsController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/statistics/";
	
	@Autowired
	private StatisticsService statisticsService;

	@RequestMapping(value = "chartStatistics", method = RequestMethod.POST)
	public String update(Model model, MyPage mypage, HttpServletRequest request) throws Exception {
		return thisUrl + "/chartStatistics"; 
	}
}
