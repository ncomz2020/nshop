package com.ncomz.nshop.domain.admin.delivery;

import com.ncomz.nshop.domain.common.Paging;

public class DeliveryInfoMgmt extends Paging {
   
	String store_id;
	String store_nm;
	int rownum;  
	String prod_order_no;
	int prod_order_seq;
	int order_seq;
	String ordr_create_datetime;
	String prod_name;
	String prod_id;
	String user_id;
	String user_nm;
	String base_addr;
	String dtl_addr;
	String zip_cd;
	String mobile_no;
	String store_id_memo;
	String waybil_no;
	String echn_waybil_no;
	String dlvy_create_datetime;
	String dlvy_update_datetime;
	String dtl_nm;
	String dtl_cd;
	String dateFormat;
	
	String period_opt;
	String start_date;
	String end_date;
	String order_opt;
	String search_opt;
	String search_txt;
	String listType;
	
	String language;
	
	
	
	public String getDtl_cd() {
		return dtl_cd;
	}
	public void setDtl_cd(String dtl_cd) {
		this.dtl_cd = dtl_cd;
	}
	public int getProd_order_seq() {
		return prod_order_seq;
	}
	public void setProd_order_seq(int prod_order_seq) {
		this.prod_order_seq = prod_order_seq;
	}
	public String getListType() {
		return listType;
	}
	public void setListType(String listType) {
		this.listType = listType;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public DeliveryInfoMgmt() {
		super();
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public String getStore_nm() {
		return store_nm;
	}
	public void setStore_nm(String store_nm) {
		this.store_nm = store_nm;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public String getProd_order_no() {
		return prod_order_no;
	}
	public void setProd_order_no(String prod_order_no) {
		this.prod_order_no = prod_order_no;
	}
	public int getOrder_seq() {
		return order_seq;
	}
	public void setOrder_seq(int order_seq) {
		this.order_seq = order_seq;
	}
	public String getOrdr_create_datetime() {
		return ordr_create_datetime;
	}
	public void setOrdr_create_datetime(String ordr_create_datetime) {
		this.ordr_create_datetime = ordr_create_datetime;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public String getProd_id() {
		return prod_id;
	}
	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
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
	public String getZip_cd() {
		return zip_cd;
	}
	public void setZip_cd(String zip_cd) {
		this.zip_cd = zip_cd;
	}
	public String getMobile_no() {
		return mobile_no;
	}
	public void setMobile_no(String mobile_no) {
		this.mobile_no = mobile_no;
	}
	public String getStore_id_memo() {
		return store_id_memo;
	}
	public void setStore_id_memo(String store_id_memo) {
		this.store_id_memo = store_id_memo;
	}
	public String getWaybil_no() {
		return waybil_no;
	}
	public void setWaybil_no(String waybil_no) {
		this.waybil_no = waybil_no;
	}
	public String getEchn_waybil_no() {
		return echn_waybil_no;
	}
	public void setEchn_waybil_no(String echn_waybil_no) {
		this.echn_waybil_no = echn_waybil_no;
	}
	public String getDlvy_create_datetime() {
		return dlvy_create_datetime;
	}
	public void setDlvy_create_datetime(String dlvy_create_datetime) {
		this.dlvy_create_datetime = dlvy_create_datetime;
	}
	public String getDlvy_update_datetime() {
		return dlvy_update_datetime;
	}
	public void setDlvy_update_datetime(String dlvy_update_datetime) {
		this.dlvy_update_datetime = dlvy_update_datetime;
	}
	public String getDtl_nm() {
		return dtl_nm;
	}
	public void setDtl_nm(String dtl_nm) {
		this.dtl_nm = dtl_nm;
	}
	public String getDateFormat() {
		return dateFormat;
	}
	public void setDateFormat(String dateFormat) {
		this.dateFormat = dateFormat;
	}
	public String getPeriod_opt() {
		return period_opt;
	}
	public void setPeriod_opt(String period_opt) {
		this.period_opt = period_opt;
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
	public String getOrder_opt() {
		return order_opt;
	}
	public void setOrder_opt(String order_opt) {
		this.order_opt = order_opt;
	}
	public String getSearch_opt() {
		return search_opt;
	}
	public void setSearch_opt(String search_opt) {
		this.search_opt = search_opt;
	}
	public String getSearch_txt() {
		return search_txt;
	}
	public void setSearch_txt(String search_txt) {
		this.search_txt = search_txt;
	}
	
	
	@Override
	public String toString() {
		return "DeliveryInfoMgmt [store_id=" + store_id + ", store_nm=" + store_nm + ", rownum=" + rownum
				+ ", prod_order_no=" + prod_order_no + ", prod_order_seq=" + prod_order_seq + ", order_seq=" + order_seq
				+ ", ordr_create_datetime=" + ordr_create_datetime + ", prod_name=" + prod_name + ", prod_id=" + prod_id
				+ ", user_id=" + user_id + ", user_nm=" + user_nm + ", base_addr=" + base_addr + ", dtl_addr="
				+ dtl_addr + ", zip_cd=" + zip_cd + ", mobile_no=" + mobile_no + ", store_id_memo=" + store_id_memo
				+ ", waybil_no=" + waybil_no + ", echn_waybil_no=" + echn_waybil_no + ", dlvy_create_datetime="
				+ dlvy_create_datetime + ", dlvy_update_datetime=" + dlvy_update_datetime + ", dtl_nm=" + dtl_nm
				+ ", dtl_cd=" + dtl_cd + ", dateFormat=" + dateFormat + ", period_opt=" + period_opt + ", start_date="
				+ start_date + ", end_date=" + end_date + ", order_opt=" + order_opt + ", search_opt=" + search_opt
				+ ", search_txt=" + search_txt + ", listType=" + listType + ", language=" + language + "]";
	}
	
}