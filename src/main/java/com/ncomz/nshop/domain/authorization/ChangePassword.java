package com.ncomz.nshop.domain.authorization;

import org.hibernate.validator.constraints.NotEmpty;

import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * 비밀번호 변경 Domain
 *
 * <PRE>
 * 1. ClassName: ChangePassword
 * 2. FileName : ChangePassword.java
 * 3. Package  : com.ntels.aem.domain.authorization
 * 4. 작성자   : smyun@ntels.com
 * 5. 작성일   : 2014. 4. 8. 오후 5:02:49
 * 6. 변경이력
 *		이름  :		일자	: 변경내용
 *     ———————————————————————————————————
 *		smyun :	2014. 4. 8.	: 신규 개발.
 * </PRE>
 */
@XStreamAlias("changePassword")
public class ChangePassword {

	/** 사용자ID. */
	private String usrId;

	/** 현재 비밀번호. */
	@NotEmpty
	private String currentPswd;

	/** 신규 비밀번호. */
	@NotEmpty
	private String newPswd;

	/** 신규 비밀번호 확인. */
	@NotEmpty
	private String newPswdRe;

	/** 팝업 구분. */
	private String mode;


	public String getUsrId() {
		return usrId;
	}

	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}


	public String getCurrentPswd() {
		return currentPswd;
	}

	public void setCurrentPswd(String currentPswd) {
		this.currentPswd = currentPswd;
	}

	public String getNewPswd() {
		return newPswd;
	}

	public void setNewPswd(String newPswd) {
		this.newPswd = newPswd;
	}

	public String getNewPswdRe() {
		return newPswdRe;
	}

	public void setNewPswdRe(String newPswdRe) {
		this.newPswdRe = newPswdRe;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}
}
