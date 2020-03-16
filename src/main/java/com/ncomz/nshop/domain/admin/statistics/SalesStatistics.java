package com.ncomz.nshop.domain.admin.statistics;

import java.util.List;

import com.ncomz.nshop.domain.common.CommonCondition;

public class SalesStatistics extends CommonCondition {
	
	private String start_dt;
	private String end_dt;
	private String pay_fin_datetime;
	private String store_id;
	private String date_clcd;
	private String calcul_amt;
	private String payment_amt;
	private String calcul_differnce_amt;
	private int	row_no;
	List<String> date_array;
	List<String> cal_array;
	List<String> pay_array;
	
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
	public String getPayment_amt() {
		return payment_amt;
	}
	public void setPayment_amt(String payment_amt) {
		this.payment_amt = payment_amt;
	}
	public String getCalcul_differnce_amt() {
		return calcul_differnce_amt;
	}
	public void setCalcul_differnce_amt(String calcul_differnce_amt) {
		this.calcul_differnce_amt = calcul_differnce_amt;
	}
	public int getRow_no() {
		return row_no;
	}
	public void setRow_no(int row_no) {
		this.row_no = row_no;
	}
	public List<String> getDate_array() {
		return date_array;
	}
	public void setDate_array(List<String> date_array) {
		this.date_array = date_array;
	}
	public String getCalcul_amt() {
		return calcul_amt;
	}
	public void setCalcul_amt(String calcul_amt) {
		this.calcul_amt = calcul_amt;
	}
	public List<String> getCal_array() {
		return cal_array;
	}
	public void setCal_array(List<String> cal_array) {
		this.cal_array = cal_array;
	}
	public List<String> getPay_array() {
		return pay_array;
	}
	public void setPay_array(List<String> pay_array) {
		this.pay_array = pay_array;
	}
	
}
