package com.ncomz.nshop.domain.admin.common;

import com.ncomz.nshop.domain.common.Paging;

public class UserGroup extends Paging {

	String usr_grp_id;
	String usr_grp_nm;
	String expln;
	String prt_ord;
	String user_group_auth_string;
	String language;
	
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
	public String getExpln() {
		return expln;
	}
	public void setExpln(String expln) {
		this.expln = expln;
	}
	public String getPrt_ord() {
		return prt_ord;
	}
	public void setPrt_ord(String prt_ord) {
		this.prt_ord = prt_ord;
	}
	public String getUser_group_auth_string() {
		return user_group_auth_string;
	}
	public void setUser_group_auth_string(String user_group_auth_string) {
		this.user_group_auth_string = user_group_auth_string;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}

}
