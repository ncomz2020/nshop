package com.ncomz.nshop.domain.admin.statistics;

import java.util.List;

import com.ncomz.nshop.domain.common.CommonCondition;

public class OrderStatistics extends CommonCondition {
	
	private String start_dt;
	private String end_dt;
	private String pay_fin_datetime;
	private String store_id;
	private String date_clcd;
	private String prod_id;
	private String order_date;

	private String aa;
	private String ba;
	private String ca;
	private String da;
	private String ea;
	private String fa;
	private String ga;
	
	private String ten;
	private String twenty;
	private String thirty;
	private String forty;
	private String fifty;
	private String sixty;
	private String none;
	
	List<String> date_array;
	List<Integer> amt_array;
	
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getTen() {
		return ten;
	}
	public void setTen(String ten) {
		this.ten = ten;
	}
	public String getTwenty() {
		return twenty;
	}
	public void setTwenty(String twenty) {
		this.twenty = twenty;
	}
	public String getThirty() {
		return thirty;
	}
	public void setThirty(String thirty) {
		this.thirty = thirty;
	}
	public String getForty() {
		return forty;
	}
	public void setForty(String forty) {
		this.forty = forty;
	}
	public String getFifty() {
		return fifty;
	}
	public void setFifty(String fifty) {
		this.fifty = fifty;
	}
	public String getSixty() {
		return sixty;
	}
	public void setSixty(String sixty) {
		this.sixty = sixty;
	}
	public String getNone() {
		return none;
	}
	public void setNone(String none) {
		this.none = none;
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
	public String getPay_fin_datetime() {
		return pay_fin_datetime;
	}
	public void setPay_fin_datetime(String pay_fin_datetime) {
		this.pay_fin_datetime = pay_fin_datetime;
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
	public String getAa() {
		return aa;
	}
	public void setAa(String aa) {
		this.aa = aa;
	}
	public String getBa() {
		return ba;
	}
	public void setBa(String ba) {
		this.ba = ba;
	}
	public String getCa() {
		return ca;
	}
	public void setCa(String ca) {
		this.ca = ca;
	}
	public String getDa() {
		return da;
	}
	public void setDa(String da) {
		this.da = da;
	}
	public String getEa() {
		return ea;
	}
	public void setEa(String ea) {
		this.ea = ea;
	}
	public String getFa() {
		return fa;
	}
	public void setFa(String fa) {
		this.fa = fa;
	}
	public String getGa() {
		return ga;
	}
	public void setGa(String ga) {
		this.ga = ga;
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
