package com.ncomz.nshop.domain.login;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("loginHistory")
public class LoginHistory {

	/** The userGroupName. */
	private String usrGrpNm;

	/** The usrId. */
	private String usrId;

	/** The userName. */
	private String usrNm;

	/** The loginDate. */
	private String loginDt;

	/** The loginTime. */
	private String loginTm;

	/** The loginGatewayIp. */
	private String loginGwIp;

	/** The logoutDate. */
	private String logoutDt;

	/** The logoutTime. */
	private String logoutTm;

	/** The logoutStatus. */
	private String logoutSt;

	/** The remark. */
	private String remark;

	public String getUsrGrpNm() {
		return usrGrpNm;
	}

	public void setUsrGrpNm(String usrGrpNm) {
		this.usrGrpNm = usrGrpNm;
	}

	public String getUsrId() {
		return usrId;
	}

	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}

	public String getUsrNm() {
		return usrNm;
	}

	public void setUsrNm(String usrNm) {
		this.usrNm = usrNm;
	}

	public String getLoginDt() {
		return loginDt;
	}

	public void setLoginDt(String loginDt) {
		this.loginDt = loginDt;
	}

	public String getLoginTm() {
		return loginTm;
	}

	public void setLoginTm(String loginTm) {
		this.loginTm = loginTm;
	}

	public String getLoginGwIp() {
		return loginGwIp;
	}

	public void setLoginGwIp(String loginGwIp) {
		this.loginGwIp = loginGwIp;
	}

	public String getLogoutDt() {
		return logoutDt;
	}

	public void setLogoutDt(String logoutDt) {
		this.logoutDt = logoutDt;
	}

	public String getLogoutTm() {
		return logoutTm;
	}

	public void setLogoutTm(String logoutTm) {
		this.logoutTm = logoutTm;
	}

	public String getLogoutSt() {
		return logoutSt;
	}

	public void setLogoutSt(String logoutSt) {
		this.logoutSt = logoutSt;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
