package com.ncomz.nshop.controller.front.mypage.myaccount;

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
import com.ncomz.nshop.service.admin.common.code.CodeService;
import com.ncomz.nshop.service.front.mypage.myaccount.MyAccountService;

@Controller
@RequestMapping(value = "/front/mypage/myaccount")
public class MyAccountController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "front/mypage/myaccount";
	
	@Autowired
	private MyAccountService MyAccountService;

	@Autowired
	private CodeService codeService;

	@RequestMapping(value = "account", method = RequestMethod.POST)
	public  String myaccount(Model model, User user, HttpServletRequest request) throws Exception {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		model.addAttribute("list", MyAccountService.myAccountselect(sessionUser.getUsr_id()));
		return thisUrl + "/account"; 
	}
	
	@RequestMapping(value = "accountAction", method = RequestMethod.POST)
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
		System.out.println("AAAAAAAAAAA + "+user);
		resultMsg = MyAccountService.updateMemberAction(user);
		return resultMsg;
	}
	
	@RequestMapping(value = "modPwd", method = RequestMethod.POST)
	public String update(Model model, MyPage mypage, HttpServletRequest request) throws Exception {
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		return thisUrl + "/modifyPwd"; 
	}
	
	@RequestMapping(value = "modPwdAction", method = RequestMethod.POST)
	public @ResponseBody String modPwdAction(Model model, MyPage myPage,User user,HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		myPage.setUsrId(sessionUser.getUsr_id());
		return MyAccountService.modifyPassword(myPage);
	}
}
