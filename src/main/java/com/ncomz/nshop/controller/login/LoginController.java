package com.ncomz.nshop.controller.login;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.authorization.User;
import com.ncomz.nshop.domain.common.MailInfo;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.common.code.CodeService;
import com.ncomz.nshop.service.common.SendMail;
import com.ncomz.nshop.service.login.LoginService;
import com.ncomz.nshop.service.login.LoginFrontService;
import com.ncomz.nshop.utillty.SHA256Util;
import com.ncomz.nshop.utillty.SessionUtil;
import com.ncomz.nshop.utillty.StringUtil;


@Controller
@RequestMapping(value = "/login")
public class LoginController {
	
	/** 로그출력. */
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private LoginFrontService loginFrontService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private SendMail sendMail;
	
	private MailInfo mailInfo;
	
	private String thisUrl = "login";
	
    final private static char[] possibleCharacters = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
   	final private static int possibleCharacterCount = possibleCharacters.length;
	   	
	@RequestMapping(value = "admin/login", method = {RequestMethod.POST,RequestMethod.GET})
	public String login(Model model, HttpServletRequest request) {
		Locale locale = null;
		HttpSession session = request.getSession(false);

		if (session == null)
			return thisUrl + "/admin/login";
		
		session.invalidate();
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		
		return thisUrl + "/admin/login";
	}

	
	@RequestMapping(value = "admin/loginAction", method = RequestMethod.POST)
	public @ResponseBody Object loginAction(@RequestParam(required = false) String textId,
											@RequestParam(required = false) String textNm,
											@RequestParam(required = false) String force, Model model, HttpServletRequest request, HttpServletResponse response) {
		
		textId = StringUtil.decode(textId);
		textNm = StringUtil.decode(textNm);
		boolean bForce = Boolean.parseBoolean(force);
		return loginService.login(textId, textNm, bForce, request);
		
	}
	
	@RequestMapping(value = "front/loginAction", method = RequestMethod.POST)
	public @ResponseBody Object loginfrontAction(@RequestParam(required = false) String textId,
											@RequestParam(required = false) String textNm,
											@RequestParam(required = false) String force, Model model, HttpServletRequest request, HttpServletResponse response) {
		
		textId = StringUtil.decode(textId);
		textNm = StringUtil.decode(textNm);
		boolean bForce = Boolean.parseBoolean(force);
		return loginFrontService.loginfront(textId, textNm, bForce, request);
	}
	
	/**
	 * 로그아웃 프로세스.
	 *
	 * @param model Model
	 * @param request HttpServletRequest
	 * @return String
	 */
	@RequestMapping(value = "admin/logoutAction", method = RequestMethod.POST)
	public String logoutAction(Model model, HttpServletRequest request) {
		//String resultUrl = "index";
		String resultUrl = "redirect:/login/admin/login";
		HttpSession session = request.getSession(false);
        
        if (session == null){
            return resultUrl;
        }
//        SessionUser sessionUser = (SessionUser)SessionUtil.getAttribute(Consts.SessionAttr.USER);
//        if (sessionUser == null){
//            return resultUrl;
//        }
//        System.out.println("세션TEST::" + sessionUser.getUsr_nm());
//        SessionUtil.removeAttribute(request, Consts.SessionAttr.USER);
		session.invalidate();
		return resultUrl;
	}
	
	@RequestMapping(value = "logoutActionfront", method = RequestMethod.POST)
	public String logoutActionfront(Model model, HttpServletRequest request) {
		//String resultUrl = "index";
		String resultUrl = "redirect:/front/product/list";
		
		HttpSession session = request.getSession(false);
		
		if (session == null)
	        return resultUrl;

		session.invalidate();
		return resultUrl;
	}
	
	@RequestMapping(value = "admin/searchIdPw", method = RequestMethod.POST)
	public String searchIdPw(Model model, HttpServletRequest request) {
		return thisUrl + "/admin/searchIdPw";
	}
	@RequestMapping(value = "front/searchId", method = RequestMethod.POST)
	public String searchId(Model model, HttpServletRequest request) {
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		return thisUrl + "/front/searchId";
	}	
	@RequestMapping(value = "searchIdPwAction", method = RequestMethod.POST)
	public @ResponseBody String searchIdPwAction(@RequestParam(required = false) String email, HttpServletRequest request, HttpServletResponse response){
		String resultMsg = "";
		
		int countEmail = loginService.countEmail(email);
		
		if(countEmail>0){
		
			//임시 비밀번호 생성 (0~9까지 숫자)
			String pswd = randomNumber(8);
			
			if(loginService.updatePswd(email,pswd)){
				try {
					mailInfo = new MailInfo();
					mailInfo.setSubject("nshop 임시 비밀번호 입니다.");
					mailInfo.setFrom("ncomzdev@gmail.com");
					mailInfo.setTo(email);
					
					mailInfo.setMsg("임시 비밀번호는 "+pswd+" 입니다.");
					mailInfo.setUserName("User Name");
					mailInfo.setFileName("");
					
					sendMail.sendMail(mailInfo, true);
					
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				resultMsg="ALREADY_EMAIL";
			}else{
				resultMsg="UPDATE_FAIL";
			}
			
			
		}else if(countEmail==0){
			resultMsg="NO_EMAIL";
		}
		
		return resultMsg;
//		return loginService.searchIdPwAction(email);
	}
	@RequestMapping(value = "searchPwAction", method = RequestMethod.POST)
	public @ResponseBody String searchPwAction(@RequestParam(required = false) String email,@RequestParam(required = false) String usr_nm, HttpServletRequest request, HttpServletResponse response){
		String resultMsg = "";
		
		int countEmail = loginService.countEmail(email);
		
		if(countEmail>0){
		
			//임시 비밀번호 생성 (0~9까지 숫자)
			String pswd = randomNumber(8);
			
			if(loginService.updatePsw(email,usr_nm,pswd)){
				try {
					mailInfo = new MailInfo();
					mailInfo.setSubject("nshop 임시 비밀번호 입니다.");
					mailInfo.setFrom("ncomzdev@gmail.com");
					mailInfo.setTo(email);
					
					mailInfo.setMsg("임시 비밀번호는 "+pswd+" 입니다.");
					mailInfo.setUserName(usr_nm);
					mailInfo.setFileName("");
					
					sendMail.sendMail(mailInfo, true);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				resultMsg ="success";
				//resultMsg="ALREADY_EMAIL"; 메일 기능
			}else{
				resultMsg="error";
			}
			
			
		}else if(countEmail==0){
			resultMsg="NO_EMAIL";
		}
		
		return resultMsg;
//		return loginService.searchIdPwAction(email);
	}
	@RequestMapping(value = "searchIdAction", method = RequestMethod.POST)
	public @ResponseBody String searchIdAction(@RequestParam(required = false) String email,@RequestParam(required = false)String usr_nm, HttpServletRequest request, HttpServletResponse response){
		String resultMsg = "";
		resultMsg = loginService.searchIdAction(usr_nm, email);
		
		return resultMsg;
	}
	@RequestMapping(value = "/admin/goSignIn", method = RequestMethod.POST)
	public String goSignIn(Model model, HttpServletRequest request){
		return thisUrl + "/admin/goSignIn";
	}
	
	@RequestMapping(value = "/front/goSignInfront", method = RequestMethod.POST)
	public String goSignInfront(Model model, HttpServletRequest request){
		return thisUrl + "/front/goSignInfront";
	}
	@RequestMapping(value = "chkId", method = RequestMethod.POST)
	public @ResponseBody String chkId(@RequestParam(required = false)String usr_id, HttpServletRequest request){
		String chkId = "";
		
		chkId = loginService.chkId(usr_id);
		
		return chkId;
	}
	
	@RequestMapping(value = "chkEmail", method = RequestMethod.POST)
	public @ResponseBody String chkEmail(@RequestParam(required = false)String email, HttpServletRequest request){
		String chkEmail = "";
		
		chkEmail = loginService.chkEmail(email);
		
		return chkEmail;
	}
	
	@RequestMapping(value = "joinMemberAction", method = RequestMethod.POST)
	public @ResponseBody String joinMemberAction(User user, HttpServletRequest request){
		String resultMsg = "";
		
		user.setUsr_id(request.getParameter("usr_id"));
		user.setPwd(SHA256Util.getEncrypt(request.getParameter("pwd")));
		user.setChk_pwd(request.getParameter("chk_pwd"));
		user.setUsr_nm(request.getParameter("usr_nm"));
		user.setEmail(request.getParameter("email"));
		user.setTel_no(request.getParameter("tel_no"));
		user.setMobile_no(request.getParameter("mobile_no"));
		user.setBase_addr(request.getParameter("comp_addr"));
		user.setDtl_addr(request.getParameter("comp_addr2"));
		user.setZip_cd(request.getParameter("post_num"));
		user.setGender(request.getParameter("gender"));
		user.setBirth(request.getParameter("birth"));
		user.setUsr_grp_id(request.getParameter("usr_grp_id"));
		
		String usrId = request.getParameter("usr_id");
		String storeId = usrId;
		
		user.setStore_id(storeId);
		
		resultMsg = loginService.joinMemeberAction(user);
		
		return resultMsg;
	}
	
	/**
	 * @param numberLength 	랜덤으로 생성할 길이
	 */
	private String randomNumber(int numberLength) {
		Random rnd = new Random();
		StringBuffer randomBuf = new StringBuffer(numberLength);

		for (int i = numberLength; i > 0; i -- ) {
			randomBuf.append(possibleCharacters[rnd.nextInt(possibleCharacterCount)]);
		}

		return randomBuf.toString();
	}
	
}
