package com.ncomz.nshop.domain.admin.common;

import java.io.Serializable;
import java.util.List;

@SuppressWarnings("serial")
public class Code implements Serializable {

	String grp_cd;
	String dtl_cd;
	String dtl_nm;
	String algn_ord;
	List<Code> children;
	String use_yn;
	String create_user_id;
	String create_datetime;
	String update_user_id;
	String update_datetime;
	String depth;
	String[] languageCode;
	String[] languageTitle;
	String language;
	
	public String getGrp_cd() {
		return grp_cd;
	}
	public void setGrp_cd(String grp_cd) {
		this.grp_cd = grp_cd;
	}
	public String getDtl_cd() {
		return dtl_cd;
	}
	public void setDtl_cd(String dtl_cd) {
		this.dtl_cd = dtl_cd;
	}
	public String getDtl_nm() {
		return dtl_nm;
	}
	public void setDtl_nm(String dtl_nm) {
		this.dtl_nm = dtl_nm;
	}
	public String getAlgn_ord() {
		return algn_ord;
	}
	public void setAlgn_ord(String algn_ord) {
		this.algn_ord = algn_ord;
	}
	public List<Code> getChildren() {
		return children;
	}
	public void setChildren(List<Code> children) {
		this.children = children;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getCreate_user_id() {
		return create_user_id;
	}
	public void setCreate_user_id(String create_user_id) {
		this.create_user_id = create_user_id;
	}
	public String getCreate_datetime() {
		return create_datetime;
	}
	public void setCreate_datetime(String create_datetime) {
		this.create_datetime = create_datetime;
	}
	public String getUpdate_user_id() {
		return update_user_id;
	}
	public void setUpdate_user_id(String update_user_id) {
		this.update_user_id = update_user_id;
	}
	public String getUpdate_datetime() {
		return update_datetime;
	}
	public void setUpdate_datetime(String update_datetime) {
		this.update_datetime = update_datetime;
	}
	public String getDepth() {
		return depth;
	}
	public void setDepth(String depth) {
		this.depth = depth;
	}
	public String[] getLanguageCode() {
		return languageCode;
	}
	public void setLanguageCode(String[] languageCode) {
		this.languageCode = languageCode;
	}
	public String[] getLanguageTitle() {
		return languageTitle;
	}
	public void setLanguageTitle(String[] languageTitle) {
		this.languageTitle = languageTitle;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	
}
