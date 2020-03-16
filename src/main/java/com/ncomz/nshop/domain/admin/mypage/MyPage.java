package com.ncomz.nshop.domain.admin.mypage;

import com.ncomz.nshop.domain.common.CommonCondition;

public class MyPage extends CommonCondition {
	String usrId;
	String currentPwd;
	String newPwd;
	String newPwdConfirm;
	
	public String getUsrId() {
		return usrId;
	}
	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}
	public String getCurrentPwd() {
		return currentPwd;
	}
	public void setCurrentPwd(String currentPwd) {
		this.currentPwd = currentPwd;
	}
	public String getNewPwd() {
		return newPwd;
	}
	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}
	public String getNewPwdConfirm() {
		return newPwdConfirm;
	}
	public void setNewPwdConfirm(String newPwdConfirm) {
		this.newPwdConfirm = newPwdConfirm;
	}
}
