package com.ncomz.nshop.service.login;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nshop.dao.admin.store.StoreMapper;
import com.ncomz.nshop.dao.login.LoginHistoryMapper;
import com.ncomz.nshop.dao.login.LoginMapper;
import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.authorization.User;
import com.ncomz.nshop.domain.common.MailInfo;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.domain.login.LoginHistory;
import com.ncomz.nshop.service.common.SendMail;
import com.ncomz.nshop.utillty.LoginManager;
import com.ncomz.nshop.utillty.NumberUtil;
import com.ncomz.nshop.utillty.SHA256Util;

@Service
public class LoginService {
	
	/** 로그 출력. */
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private LoginMapper loginMapper;
	
	@Autowired
	private LoginHistoryMapper loginHistoryMapper;
	
	@Autowired
	private StoreMapper storeMapper;
	
	@Autowired
	private SendMail sendMail;
	
	/** 로그인 실패 제한 횟수. */
	private String limit = "9";
	
	/**
	 * Ryu
	 * 
	 * @return
	 */
	public String login(String textId, String textNm, boolean bForce, HttpServletRequest request){
		
		String resultMsg = "";
		
		if(loginMapper.countPresenceId(textId)>0){
			// input data null check
			if ("".equals(StringUtils.defaultString(textId)) || "".equals(StringUtils.defaultString(textNm))) {
				
				return "ERROR_INPUT_NULL";
			}
			
			// 로그인 실패 횟수 초과로 계정이 잠겨있는지 검사
			if (isAccountLock(textId)) {
				logger.info("==>> account lock!!! : {}", textId);
				
				return "LOCK_ACCOUNT";
			}
			
			String remoteAddress = request.getRemoteAddr();
			//login check
			SessionUser sessionUser = getSessionUser(textId, textNm, remoteAddress);
			
			if (sessionUser != null) { //로그인 성공
				logger.info("==>> login success!!! : {}", textId);
				
				// IP 접속 확인
				if (!isPassIP_Bandwidth(sessionUser, remoteAddress)) {
					return "FAIL_PASS_IP_BANDWIDTH";
				}
				
				//session create
				HttpSession session = request.getSession(true);
				session.removeAttribute(Consts.SessionAttr.USER);
				session.setAttribute(Consts.SessionAttr.USER, sessionUser);
				System.out.println("testtesttest"+session.getAttribute("session_user"));
				String userId = sessionUser.getUsr_id();
				LoginManager loginManager = LoginManager.getInstance();
				if (bForce) {
					if (loginManager.isUsing(userId)) {
						loginManager.getUserSession(userId).invalidate();;
					}
				} else {
					if (loginManager.isUsing(userId)) {
						return "ALREADY_LOGGED_IN";
					}
				}
				loginManager.setSession(session);
				
				
				
				//최고 상점 or 그냥 상점
				if(("1").equals(sessionUser.getUsr_grp_id())){
					resultMsg = "GO_MAIN";
				}
				else if(("2").equals(sessionUser.getUsr_grp_id())){
					if(storeMapper.countStore(sessionUser.getStore_id())>0){
						resultMsg = "GO_MAIN";
					}else{
						resultMsg = "GO_STORE_JOIN";
					}
				}
				else {
					resultMsg = "NORMAL_MEMBER";
				}
				
			} else { //로그인 실패
				logger.info("==>> login fail!!! : " + textId);
				
				if (isOverLoginFailCount(textId)) {
					logger.info("==>> over login fail count!!! : {}", textId);
					
					setAccountLock(textId);
					
					return "OVER_LOGIN_FAIL_COUNT";
				}
				
				resultMsg = "LOGIN_FAIL";
			}
			
		}else{
			resultMsg = "ID_DOES_NOT_EXIST";
		}
		
		return resultMsg;
		
	}	
	
	/**
	 * 사용자 계정 잠금 설정.
	 *
	 * @param usrId 사용자ID
	 */
	private void setAccountLock(String usrId) {
		loginMapper.setAccountLock(usrId);
	}
	
	/**
	 * 로그인 실패 횟수 초과 여부 확인.
	 *
	 * @param usrId 사용자ID
	 * @return boolean
	 */
	private boolean isOverLoginFailCount(String usrId) {
		return (Integer.parseInt(NumberUtil.getDefaultZero(loginMapper.getLoginFailCount(usrId)))
					>= Integer.parseInt(limit));
	}
	
	
	/**
	 * 로그인 검증 및 세션정보 생성.
	 *
	 * @param usrId 사용자ID
	 * @param password 비밀번호
	 * @param loginGatewayIp 로그인IP
	 * @return SessionUser
	 */
	private SessionUser getSessionUser(String usrId, String password, String loginGatewayIp) {
		SessionUser sessionUser = loginMapper.login(usrId, SHA256Util.getEncrypt(password));
		
		if (sessionUser != null) {
			/**
			 * DB에서 처리 가능하나, 여러 종류의 DBMS와의 일관성을 위해서 프로그램에서 처리
			 * 프로젝트 성격에 맞도록 SQL을 수정해서 사용 가능
			 *
			 */
			if (sessionUser.getLst_login_dt() != null && sessionUser.getLst_login_dt().indexOf("|") > -1) {
				sessionUser.setLst_login_dt(sessionUser.getLst_login_dt().substring(sessionUser.getLst_login_dt().indexOf("|")+1));
			}
			if (sessionUser.getLst_login_tm() != null && sessionUser.getLst_login_tm().indexOf("|") > -1) {
				sessionUser.setLst_login_tm(sessionUser.getLst_login_tm().substring(sessionUser.getLst_login_tm().indexOf("|")+1));
			}
			
			//set client ip
			sessionUser.setLogin_gw_ip(loginGatewayIp);
			
			logger.debug("{}", sessionUser);

			//로그인 시간 저장(비밀번호 변경주기를 위한...)
			loginMapper.updateLastLoginDateTime(sessionUser);
			
			//로그인 이력처리
			loginHistoryMapper.insert(setLoginHistory(sessionUser));
		} else {
			loginMapper.updateLoginFailCount(usrId);
		}
		
		return sessionUser;
	}
	
	/**
	 * 로그인 이력 저장.
	 *
	 * @param sessionUser 세션정보
	 * @return LoginHistory
	 */
	private LoginHistory setLoginHistory(SessionUser sessionUser) {
		LoginHistory loginhistory = new LoginHistory();

		loginhistory.setUsrId(sessionUser.getUsr_id());

		Map<String, String> mapLoginDate = loginMapper.getLoginDate(sessionUser.getUsr_id());

		if (mapLoginDate == null) {
			loginhistory.setLoginDt("");
			loginhistory.setLoginTm("");
		} else {
			loginhistory.setLoginDt(mapLoginDate.get("LOGIN_DATE") == null ? "" : mapLoginDate.get("LOGIN_DATE"));
			loginhistory.setLoginTm(mapLoginDate.get("LOGIN_TIME") == null ? "" : mapLoginDate.get("LOGIN_TIME"));

			if (loginhistory.getLoginDt().indexOf("|") > -1) {
				loginhistory.setLoginDt(loginhistory.getLoginDt().substring(loginhistory.getLoginDt().indexOf("|")));
			}
			if (loginhistory.getLoginTm().indexOf("|") > -1) {
				loginhistory.setLoginTm(loginhistory.getLoginTm().substring(loginhistory.getLoginTm().indexOf("|")));
			}
		}

		loginhistory.setLoginGwIp(sessionUser.getLogin_gw_ip());

		return loginhistory;
	}

	/**
	 * 사용자 잠김 여부 확인.
	 *
	 * @param usrId 사용자ID
	 * @return boolean
	 */
	private boolean isAccountLock(String usrId) {
		String accountLock = loginMapper.getAccountLock(usrId);

		return "Y".equals(accountLock);
	}
	
	/**
	 * IP 허용 영역 확인.
	 *
	 * @param sessionUser 세션정보
	 * @param remoteAddress 원격주소
	 * @return boolean
	 */
	private boolean isPassIP_Bandwidth(SessionUser sessionUser, String remoteAddress) {
		String ipBandwidth[] = null;
		String ip[] = null;
		if(StringUtils.isNotEmpty(sessionUser.getIp_band())){
			ipBandwidth = sessionUser.getIp_band().split("\\.");	
			logger.debug("ip bandwidth : {}", sessionUser.getIp_band());
			logger.debug("ip bandwidth : {}", ipBandwidth.length);
		}
		
		logger.debug("remoteAddress : {}", remoteAddress);

		// localhost 접속이면 건너뜀
		if (remoteAddress.equals("127.0.0.1") || remoteAddress.equals("localhost") || remoteAddress.equals("0:0:0:0:0:0:0:1")) {
			return true;
		}else if (remoteAddress.indexOf(".") < 0) {		// ip에 '.'이 있는지 확인
			return false;
		}

		if(StringUtils.isNotEmpty(remoteAddress))
		{
			ip = remoteAddress.split("\\.");
			logger.debug("ip : {}", ip.length);
			// '.'이 세개인지 확인
			if (ip.length > 4) {
				return false;
			}
		}

		boolean result = true;
		for(int i = 0; i < ipBandwidth.length; i++) {
			logger.debug("ipBandwidth[{}] : {}", i, ipBandwidth[i]);

			if (!"*".equals(ipBandwidth[i])) {
				logger.debug("ipBandwidth[i] : !*", i);

				if (!ip[i].equals(ipBandwidth[i])) {
					logger.debug("ip not equal ipBandwidth");

					result = false;
					break;
				}
			}
		}

		return result;
	}

	public void logout(SessionUser sessionUser) {
		
	}

	public int countEmail(String email) {
		return loginMapper.countEmail(email);
	}

	public String searchIdPwAction(String email) {
		String resultMsg = "";
		
		if(countEmail(email)>0){
			
			try {
				MailInfo mailInfo = new MailInfo();
				mailInfo.setSubject("Test");
				mailInfo.setFrom("ncomzdev@gmail.com");
				mailInfo.setTo(email);
				mailInfo.setMsg("Test Msg");
				mailInfo.setUserName("User Name");
				
				logger.debug(mailInfo.getFrom());
				logger.debug(mailInfo.getMsg());
				logger.debug(mailInfo.getTo());
				logger.debug(mailInfo.getUserName());
				logger.debug(mailInfo.getFrom());
				
				sendMail.sendMail(mailInfo, true);
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			resultMsg="ALREADY_EMAIL";
		}else if(countEmail(email)==0){
			resultMsg="NO_EMAIL";
		}
		
		return resultMsg;
	}
	
	//아이디찾기
	public String searchIdAction(String usr_nm, String email) {
		String resultMsg = "";
		
		
		if(loginMapper.searchId(usr_nm, email) == null){
			resultMsg = "CHECK_DATA";
		}
		else if(loginMapper.searchId(usr_nm, email) == ""){
			resultMsg = "CHECK_DATA";
		}
		else{
			resultMsg = loginMapper.searchId(usr_nm, email);
		}
		return resultMsg;
	}
	//비밀번호찾기
	public String searchPwAction(String usr_nm, String email) {
		String resultMsg = "";
		
		
		if(loginMapper.searchId(usr_nm, email) == null){
			resultMsg = "CHECK_DATA";
		}
		else if(loginMapper.searchId(usr_nm, email) == ""){
			resultMsg = "CHECK_DATA";
		}
		else{
			resultMsg = loginMapper.searchId(usr_nm, email);
		}
		return resultMsg;
	}
	public String chkId(String usr_id) {
		String resultMsg = "";
		
		if(loginMapper.chkId(usr_id)>0){
			resultMsg = "previousId";
		}else{
			resultMsg = "newId";
		}
		
		return resultMsg;		
	}
	
	public String chkEmail(String email) {
		String resultMsg = "";
		
		if(loginMapper.chkEmail(email)>0){
			resultMsg = "previousEmail";
		}else{
			resultMsg = "newEmail";
		}
		
		return resultMsg;		
	}

	@Transactional
	public String joinMemeberAction(User user) {
		String resultMsg = "";
		try {
			if(loginMapper.insertNewMember(user)){
				resultMsg = "successNewMember";
			}else{
				resultMsg = "failNewMember";
			}
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			return e.getMessage();
		}
		return resultMsg;
	}

	@Transactional
	public boolean updatePswd(String email, String pswd) {
		String newPswd = SHA256Util.getEncrypt(pswd);
		try {
			User user = new User();
			user.setEmail(email);
			user.setPwd(newPswd);
			return loginMapper.updatePswd(user);
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			return false;
		}
	}
	@Transactional
	public boolean updatePsw(String email, String usr_nm, String pswd) {
		String newPswd = SHA256Util.getEncrypt(pswd);
		try {
			User user = new User();
			user.setUsr_nm(usr_nm);
			user.setEmail(email);
			user.setPwd(newPswd);
			return loginMapper.updatePsw(user);
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			return false;
		}
	}
}
