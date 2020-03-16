package com.ncomz.nshop.domain.admin.order;

import com.ncomz.nshop.domain.common.CommonCondition;

/*
 * 주문관리 조회 조건
 */
public class OrderCondition extends CommonCondition{
	String start_date;
	String end_date;
	String sts_cd;
	String list_sts_cd;
	String search_type;
	String search_txt;
	
	String update_receiver;
	String update_phone;
	String update_zip_code;
	String update_addr;
	String update_dtl_addr;
	String update_memo;
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
	public String getSts_cd() {
		return sts_cd;
	}
	public void setSts_cd(String sts_cd) {
		this.sts_cd = sts_cd;
	}
	public String getList_sts_cd() {
		return list_sts_cd;
	}
	public void setList_sts_cd(String list_sts_cd) {
		this.list_sts_cd = list_sts_cd;
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
	public String getUpdate_receiver() {
		return update_receiver;
	}
	public void setUpdate_receiver(String update_receiver) {
		this.update_receiver = update_receiver;
	}
	public String getUpdate_phone() {
		return update_phone;
	}
	public void setUpdate_phone(String update_phone) {
		this.update_phone = update_phone;
	}
	public String getUpdate_zip_code() {
		return update_zip_code;
	}
	public void setUpdate_zip_code(String update_zip_code) {
		this.update_zip_code = update_zip_code;
	}
	public String getUpdate_addr() {
		return update_addr;
	}
	public void setUpdate_addr(String update_addr) {
		this.update_addr = update_addr;
	}
	public String getUpdate_dtl_addr() {
		return update_dtl_addr;
	}
	public void setUpdate_dtl_addr(String update_dtl_addr) {
		this.update_dtl_addr = update_dtl_addr;
	}
	public String getUpdate_memo() {
		return update_memo;
	}
	public void setUpdate_memo(String update_memo) {
		this.update_memo = update_memo;
	}
	

}
