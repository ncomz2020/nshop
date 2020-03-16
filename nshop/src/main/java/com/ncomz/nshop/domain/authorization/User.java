package com.ncomz.nshop.domain.authorization;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.ncomz.nshop.domain.common.CommonCondition;
import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * 사용자 Domain.
 *
 * <PRE>
 * 1. ClassName: User
 * 2. FileName : User.java
 * 3. Package  : com.ntels.aem.domain.authorization
 * 4. 작성자   : smyun@ntels.com
 * 5. 작성일   : 2014. 4. 8. 오후 5:02:49
 * 6. 변경이력
 *		이름  :		일자	: 변경내용
 *     ———————————————————————————————————
 *		smyun :	2014. 4. 8.	: 신규 개발.
 * </PRE>
 */
@XStreamAlias("user")
public class User extends CommonCondition {

	/** 사용자 ID. */
	@NotEmpty
	@Length(min=4,max=20)
	private String usr_id;
	
	private String login_usr_id;

	/** 사용자seq. */
	private String usr_seq;
	
	/** 비밀번호. */
	private String pwd;

	/** 비밀번호 확인. */
	private String chk_pwd;

	/** 사용자 명. */
	@NotEmpty
	private String usr_nm;

	/** 사용자 그룹 ID. */
	@NotEmpty
	private String usr_grp_id;

	/** 사용자 그룹 명. */
	private String usr_grp_nm;
	
	/** 사용자 전화번호. */
	private String tel_no;
	
	private String mobile_no;

	/** 사용자 Email. */
	@Email
	private String email;

	/** IP 대역. */
	@NotEmpty
	private String ip_band;

	/** 로그인 실패 횟수. */
	private int    login_fail_cnt = 0;

	/** 비밀번호 만료 일자. */
	private String pswd_due_dt;

	/** 비밀번호 변경 기간. */
	@NotEmpty
	private String pswd_chng_cycl = "30";

	/** 최종 로그인 일자. */
	private String lst_login_dt;

	/** 최종 로그인 시간. */
	private String lst_login_tm;

	/** 계좌 잠김 여부. */
	private String acnt_lock_yn;

	/** 로그인 IP. */
	private String login_gw_ip;


	/** 비밀번호. */
	private String old_pwd_no1;

	/** 비밀번호 확인.*/
	private String old_pwd_no2;

	/** 우편번호.*/
	private String zip_cd;

	/** 주소.*/
	private String base_addr;

	/** 상세 주소.*/
	private String dtl_addr;
	
	/** 성별. */
	private String gender;

	/** 태어난년도. */
	private String birth;

	/** 태어난년도. */
	private String join_date;

	/** 사용자 그룹 level.  */
	private String usr_grp_lv;
	
	/** 변경 사용자 그룹. */
	private String usr_grp_id_c;

	/** 국가코드. */
	private String cntry_cd;
	
	/** 언어코드 */
	private String lang_cd;
	
	/** PES / RES 계정구분 */
	private String usr_type;
	
	private String date_format;
	
	/** SMS 알림 구분  */
	private String sms_notice_tp;
	private String smsNoticeTp;
	
	/** SMS 알림 구분명  */
	private String sms_notice_nm;
	
	/** 승인자 아이디 */
	private String appr_id;
	private String perm_tsk_tp;
	
	private String sms_txt;
	
	private String store_id;
	private String store_name;


	/** 검색조건 */
	private String search_date_type;
	private String start_date;
	private String end_date;
	private String search_type;
	private String search_txt;
	
	
	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}
	public String getSearch_date_type() {
		return search_date_type;
	}

	public void setSearch_date_type(String search_date_type) {
		this.search_date_type = search_date_type;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getSearch_type() {
		return search_type;
	}

	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}

	public String getSearch_txt() {
		return search_txt;
	}

	public void setSearch_txt(String search_txt) {
		this.search_txt = search_txt;
	}

	public String getUsr_id() {
		return usr_id;
	}

	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id;
	}

	public String getLogin_usr_id() {
		return login_usr_id;
	}

	public void setLogin_usr_id(String login_usr_id) {
		this.login_usr_id = login_usr_id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getChk_pwd() {
		return chk_pwd;
	}

	public void setChk_pwd(String chk_pwd) {
		this.chk_pwd = chk_pwd;
	}

	public String getUsr_nm() {
		return usr_nm;
	}

	public void setUsr_nm(String usr_nm) {
		this.usr_nm = usr_nm;
	}

	public String getUsr_grp_id() {
		return usr_grp_id;
	}

	public void setUsr_grp_id(String usr_grp_id) {
		this.usr_grp_id = usr_grp_id;
	}

	public String getUsr_grp_nm() {
		return usr_grp_nm;
	}

	public void setUsr_grp_nm(String usr_grp_nm) {
		this.usr_grp_nm = usr_grp_nm;
	}

	public String getTel_no() {
		return tel_no;
	}

	public void setTel_no(String tel_no) {
		this.tel_no = tel_no;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIp_band() {
		return ip_band;
	}

	public void setIp_band(String ip_band) {
		this.ip_band = ip_band;
	}

	public int getLogin_fail_cnt() {
		return login_fail_cnt;
	}

	public void setLogin_fail_cnt(int login_fail_cnt) {
		this.login_fail_cnt = login_fail_cnt;
	}

	public String getPswd_due_dt() {
		return pswd_due_dt;
	}

	public void setPswd_due_dt(String pswd_due_dt) {
		this.pswd_due_dt = pswd_due_dt;
	}

	public String getPswd_chng_cycl() {
		return pswd_chng_cycl;
	}

	public void setPswd_chng_cycl(String pswd_chng_cycl) {
		this.pswd_chng_cycl = pswd_chng_cycl;
	}

	public String getLst_login_dt() {
		return lst_login_dt;
	}

	public void setLst_login_dt(String lst_login_dt) {
		this.lst_login_dt = lst_login_dt;
	}

	public String getLst_login_tm() {
		return lst_login_tm;
	}

	public void setLst_login_tm(String lst_login_tm) {
		this.lst_login_tm = lst_login_tm;
	}

	public String getAcnt_lock_yn() {
		return acnt_lock_yn;
	}

	public void setAcnt_lock_yn(String acnt_lock_yn) {
		this.acnt_lock_yn = acnt_lock_yn;
	}

	public String getLogin_gw_ip() {
		return login_gw_ip;
	}

	public void setLogin_gw_ip(String login_gw_ip) {
		this.login_gw_ip = login_gw_ip;
	}

	public String getOld_pwd_no1() {
		return old_pwd_no1;
	}

	public void setOld_pwd_no1(String old_pwd_no1) {
		this.old_pwd_no1 = old_pwd_no1;
	}

	public String getOld_pwd_no2() {
		return old_pwd_no2;
	}

	public void setOld_pwd_no2(String old_pwd_no2) {
		this.old_pwd_no2 = old_pwd_no2;
	}

	public String getUsr_grp_lv() {
		return usr_grp_lv;
	}

	public void setUsr_grp_lv(String usr_grp_lv) {
		this.usr_grp_lv = usr_grp_lv;
	}

	public String getUsr_grp_id_c() {
		return usr_grp_id_c;
	}

	public void setUsr_grp_id_c(String usr_grp_id_c) {
		this.usr_grp_id_c = usr_grp_id_c;
	}

	public String getCntry_cd() {
		return cntry_cd;
	}

	public void setCntry_cd(String cntry_cd) {
		this.cntry_cd = cntry_cd;
	}

	public String getLang_cd() {
		return lang_cd;
	}

	public void setLang_cd(String lang_cd) {
		this.lang_cd = lang_cd;
	}

	public String getUsr_type() {
		return usr_type;
	}

	public void setUsr_type(String usr_type) {
		this.usr_type = usr_type;
	}

	public String getDate_format() {
		return date_format;
	}

	public void setDate_format(String date_format) {
		this.date_format = date_format;
	}

	public String getSms_notice_tp() {
		return sms_notice_tp;
	}

	public void setSms_notice_tp(String sms_notice_tp) {
		this.sms_notice_tp = sms_notice_tp;
	}

	public String getSmsNoticeTp() {
		return smsNoticeTp;
	}

	public void setSmsNoticeTp(String smsNoticeTp) {
		this.smsNoticeTp = smsNoticeTp;
	}

	public String getSms_notice_nm() {
		return sms_notice_nm;
	}

	public void setSms_notice_nm(String sms_notice_nm) {
		this.sms_notice_nm = sms_notice_nm;
	}

	public String getAppr_id() {
		return appr_id;
	}

	public void setAppr_id(String appr_id) {
		this.appr_id = appr_id;
	}

	public String getPerm_tsk_tp() {
		return perm_tsk_tp;
	}

	public void setPerm_tsk_tp(String perm_tsk_tp) {
		this.perm_tsk_tp = perm_tsk_tp;
	}

	public String getSms_txt() {
		return sms_txt;
	}

	public void setSms_txt(String sms_txt) {
		this.sms_txt = sms_txt;
	}

	/**
	 * @return the mobile_no
	 */
	public String getMobile_no() {
		return mobile_no;
	}

	/**
	 * @param mobile_no the mobile_no to set
	 */
	public void setMobile_no(String mobile_no) {
		this.mobile_no = mobile_no;
	}

	/**
	 * @return the store_id
	 */
	public String getStore_id() {
		return store_id;
	}

	/**
	 * @param store_id the store_id to set
	 */
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	
	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	
	public String getZip_cd() {
		return zip_cd;
	}

	public void setZip_cd(String zip_cd) {
		this.zip_cd = zip_cd;
	}

	public String getBase_addr() {
		return base_addr;
	}

	public void setBase_addr(String base_addr) {
		this.base_addr = base_addr;
	}

	public String getDtl_addr() {
		return dtl_addr;
	}

	public void setDtl_addr(String dtl_addr) {
		this.dtl_addr = dtl_addr;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getUsr_seq() {
		return usr_seq;
	}

	public void setUsr_seq(String usr_seq) {
		this.usr_seq = usr_seq;
	}

}
