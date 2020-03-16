package com.ncomz.nshop.domain.admin.statistics;

import java.util.List;

import com.ncomz.nshop.domain.common.CommonCondition;

public class UserAccessStatistics extends CommonCondition {
	
	private String start_dt;
	private String end_dt;
	private String access_date;
	private String store_id;
	private String prod_id;
	private String user_id;
	private String date_clcd;
	private int count_user_id;
	
	List<String> date_array;
	List<Integer> amt_array;
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getCount_user_id() {
		return count_user_id;
	}
	public void setCount_user_id(int count_user_id) {
		this.count_user_id = count_user_id;
	}
	public String getProd_id() {
		return prod_id;
	}
	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}
	public String getStart_dt() {
		return start_dt;
	}
	public void setStart_dt(String start_dt) {
		this.start_dt = start_dt;
	}
	public String getEnd_dt() {
		return end_dt;
	}
	public void setEnd_dt(String end_dt) {
		this.end_dt = end_dt;
	}
	public String getAccess_date() {
		return access_date;
	}
	public void setAccess_date(String access_date) {
		this.access_date = access_date;
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public String getDate_clcd() {
		return date_clcd;
	}
	public void setDate_clcd(String date_clcd) {
		this.date_clcd = date_clcd;
	}
	public List<String> getDate_array() {
		return date_array;
	}
	public void setDate_array(List<String> date_array) {
		this.date_array = date_array;
	}
	public List<Integer> getAmt_array() {
		return amt_array;
	}
	public void setAmt_array(List<Integer> amt_array) {
		this.amt_array = amt_array;
	}
	
	
}
