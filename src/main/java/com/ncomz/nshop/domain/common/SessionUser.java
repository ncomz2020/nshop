package com.ncomz.nshop.domain.common;

import java.io.Serializable;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("sessionUser")
public class SessionUser implements Serializable{
	
	/** Serializable serialVersionUID.  */
	private static final long serialVersionUID = 3682840049882805288L;

	/** 사용자 ID. */
	private String usr_id;

	/** 사용자 이름. */
	private String usr_nm;

	/** 사용자 그룹 ID. */
	private String usr_grp_id;

	/** 사용자 그룹명. */
	private String usr_grp_nm;

	/** 사용자 그룹 래벨. */
	private String usr_grp_lv;

	/** IP대역. */
	private String ip_band;

	/** Login Gateway IP. */
	private String login_gw_ip;

	/** 최종 로그인 일자. */
	private String lst_login_dt;

	/** 최종 로그인 시간. */
	private String lst_login_tm;

	/** 로그인 실패 횟수. */
	private Integer login_fail_cnt;
	
	/**	상점 ID	*/
	private String store_id;

	
	public String getUsr_id() {
		return usr_id;
	}

	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id;
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

	public String getUsr_grp_lv() {
		return usr_grp_lv;
	}

	public void setUsr_grp_lv(String usr_grp_lv) {
		this.usr_grp_lv = usr_grp_lv;
	}

	public String getIp_band() {
		return ip_band;
	}

	public void setIp_band(String ip_band) {
		this.ip_band = ip_band;
	}

	public String getLogin_gw_ip() {
		return login_gw_ip;
	}

	public void setLogin_gw_ip(String login_gw_ip) {
		this.login_gw_ip = login_gw_ip;
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

	public Integer getLogin_fail_cnt() {
		return login_fail_cnt;
	}

	public void setLogin_fail_cnt(Integer login_fail_cnt) {
		this.login_fail_cnt = login_fail_cnt;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "SessionUser [usr_id=" + usr_id + ", usr_nm=" + usr_nm + ", usr_grp_id=" + usr_grp_id + ", usr_grp_nm=" + usr_grp_nm
				+ ", usr_grp_lv=" + usr_grp_lv + ", ip_band=" + ip_band + ", login_gw_ip=" + login_gw_ip + ", lst_login_dt="
				+ lst_login_dt + ", lst_login_tm=" + lst_login_tm + ", login_fail_cnt=" + login_fail_cnt + ", store_id="+ store_id + "]";
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
	
}
