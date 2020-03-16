package com.ncomz.nshop.controller.admin.mypage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.mypage.MyPage;
import com.ncomz.nshop.domain.authorization.User;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.mypage.MyPageService;
import com.ncomz.nshop.utillty.SHA256Util;

@Controller
@RequestMapping(value = "/admin/mypage/")
public class MyPageController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/mypage/";
	
	@Autowired
	private MyPageService myPageService;

	@RequestMapping(value = "modPwd", method = RequestMethod.POST)
	public String update(Model model, MyPage mypage, HttpServletRequest request) throws Exception {
		return thisUrl + "/modifyPwd"; 
	}
	@RequestMapping(value = "myAccount", method = RequestMethod.POST)
	public  String myaccount(Model model, User user, HttpServletRequest request) throws Exception {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		model.addAttribute("list", myPageService.myAccountselect(sessionUser.getUsr_id()));
		return thisUrl + "/myAccount"; 
	}
	
	@RequestMapping(value = "myaccountAction", method = RequestMethod.POST)
	public @ResponseBody String myaccountAction(Model model, User user,HttpServletRequest request) {
		String resultMsg = "";
		
		user.setUsr_id(request.getParameter("usr_id"));
		user.setEmail(request.getParameter("email"));
		user.setTel_no(request.getParameter("tel_no"));
		user.setMobile_no(request.getParameter("mobile_no"));
		user.setBase_addr(request.getParameter("comp_addr"));
		user.setDtl_addr(request.getParameter("comp_addr2"));
		user.setZip_cd(request.getParameter("post_num"));
		user.setGender(request.getParameter("gender"));
		user.setBirth(request.getParameter("birth"));
		resultMsg = myPageService.updateMemberAction(user);
		return resultMsg;
	}
	
	@RequestMapping(value = "modPwdAction", method = RequestMethod.POST)
	public @ResponseBody String modPwdAction(Model model, MyPage myPage,HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		myPage.setUsrId(sessionUser.getUsr_id());
		System.out.println("AAAA+ "+request.getParameter("currentPwd"));
		return myPageService.modifyPassword(myPage);
	}
	
}
