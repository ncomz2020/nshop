package com.ncomz.nshop.domain.admin.statistics;

import java.util.List;

import com.ncomz.nshop.domain.common.CommonCondition;

public class UserStatistics extends CommonCondition {
	
	private String start_dt;
	private String end_dt;
	private String date_clcd;
	private String usr_grp_id;
	
	private String join_date;
	private int join_count;
	private String withdrawal_date;
	private int withdrawal_count;

	private List<String> date_array;
	private List<Integer> join_array;
	private List<Integer> with_array;
	
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
	public String getDate_clcd() {
		return date_clcd;
	}
	public void setDate_clcd(String date_clcd) {
		this.date_clcd = date_clcd;
	}
	public String getUsr_grp_id() {
		return usr_grp_id;
	}
	public void setUsr_grp_id(String usr_grp_id) {
		this.usr_grp_id = usr_grp_id;
	}
	public String getJoin_date() {
		return join_date;
	}
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}
	public String getWithdrawal_date() {
		return withdrawal_date;
	}
	public void setWithdrawal_date(String withdrawal_date) {
		this.withdrawal_date = withdrawal_date;
	}
	public int getJoin_count() {
		return join_count;
	}
	public void setJoin_count(int join_count) {
		this.join_count = join_count;
	}
	public int getWithdrawal_count() {
		return withdrawal_count;
	}
	public void setWithdrawal_count(int withdrawal_count) {
		this.withdrawal_count = withdrawal_count;
	}
	public List<String> getDate_array() {
		return date_array;
	}
	public void setDate_array(List<String> date_array) {
		this.date_array = date_array;
	}
	public List<Integer> getJoin_array() {
		return join_array;
	}
	public void setJoin_array(List<Integer> join_array) {
		this.join_array = join_array;
	}
	public List<Integer> getWith_array() {
		return with_array;
	}
	public void setWith_array(List<Integer> withdrawal_array) {
		this.with_array = withdrawal_array;
	}
	
}
