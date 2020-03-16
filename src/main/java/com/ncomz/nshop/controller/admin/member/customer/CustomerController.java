package com.ncomz.nshop.controller.admin.member.customer;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.cache.TransactionalCacheManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.order.OrderInfoMgmt;
import com.ncomz.nshop.domain.admin.settlement.SettlementInfo;
import com.ncomz.nshop.domain.authorization.User;
import com.ncomz.nshop.domain.common.MailInfo;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.member.MemberInfoService;
import com.ncomz.nshop.service.admin.settlement.SettlementInfoService;
import com.ncomz.nshop.service.common.SendMail;
import com.ncomz.nshop.service.login.LoginService;

@Controller
@RequestMapping(value = "/admin/member/customer")
public class CustomerController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/member/customer";

    final private static char[] possibleCharacters = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
   	final private static int possibleCharacterCount = possibleCharacters.length;

	@Autowired
	private MemberInfoService memberInfoService;
	
	@Autowired
	private LoginService loginService;
	
	//비밀번호 초기화 시 메일 전송
	@Autowired
	private SendMail sendMail;
	
	private MailInfo mailInfo;
	
	@RequestMapping(value = "list")
	public String list(Model model){
		return thisUrl + "/list";
	}
	
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(Model model, User user, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		int count = memberInfoService.getUserListCount(user);

		model.addAttribute("pagingObject", user);
		model.addAttribute("count", count);
		model.addAttribute("user", memberInfoService.getUserList(user));
		//if(count > 0){
		//	model.addAttribute("sum", settlementInfoService.getSettlementByDailyInfo(user));
		//}
		return thisUrl + "/listAction";
	}
	
	@RequestMapping(value = "customerPopup", method = RequestMethod.POST)
	public String customerPopup(User user, Model model, HttpServletRequest request) throws Exception {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		
		model.addAttribute("user", memberInfoService.getUserInfo(user));
		
		return thisUrl + "/customerPopup"; 
	}
	
	@RequestMapping(value = "deleteAction", method = RequestMethod.POST)
	public @ResponseBody String deleteAction(Model model, User user, HttpServletRequest request) {
		String resultMsg = "";
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		model.addAttribute("user", request.getAttribute("user"));

			if(memberInfoService.deleteUser(user.getUsr_id()) == "success"){
				
				resultMsg = "success";
			}
			else{
				resultMsg = "error";
			}
		System.out.println("delete data check : "+resultMsg);
		return resultMsg;
	}
	
	//비밀번호 초기화
	@RequestMapping(value = "initializePwAction", method = RequestMethod.POST)
	public @ResponseBody String initializePwAction(@RequestParam(required = false) String email,@RequestParam(required = false) String usr_nm, HttpServletRequest request, HttpServletResponse response){
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
					System.out.println("AAAAAINORNOTIN");
					sendMail.sendMail(mailInfo, true);
					
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				resultMsg = "success";
				//resultMsg="ALREADY_EMAIL"; 메일 기능
			}else{
				resultMsg="error";
			}
			
			
		}else if(countEmail==0){
			resultMsg="error";
		}
		
		return resultMsg;
//		return loginService.searchIdPwAction(email);
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
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(User user, Model model) throws ParseException, UnsupportedEncodingException {

		model.addAttribute("list", memberInfoService.listcustomerExcel(user));

		return "excelViewer";
	}
}
