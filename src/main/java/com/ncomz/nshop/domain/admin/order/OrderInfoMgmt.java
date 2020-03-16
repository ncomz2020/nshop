package com.ncomz.nshop.domain.admin.order;
/*
 * 
 */
import java.util.List;

import com.ncomz.nshop.domain.common.CommonCondition;

public class OrderInfoMgmt extends OrderProductInfo{
	/* 주문정보 테이블 */
	int cnt;
	String order_seq;
	String order_no;
	String order_datetime;
	String user_id;
	String user_nm;
	String payment_way_cd;
	String payment_way_name;
	String dlvy_amt;
	String dlvy_memo;
	String r_mobile_no;
	String base_addr;
	String dtl_addr;
	String zip_cd;
	
	/* 주문자 정보  */
	String s_mobile_no;
	String email;
	String usr_nm;
	
	/* 상품 이미지 테이블 */
	String key_id;
	String file_id;
	
	/* 배송 정보 테이블 */
	String waybil_no;
	String echn_waybil_no;
	
	/* 주문이력 */
	String sts_update_datetime;
	
	/* 주문변경 테이블 */
	String chng_cd;
	String chng_rsn;
	String chng_dtl_rsn;
	
	/* anti 테이블 */
	String chng_aply_datetime;
	
	String language;
	String popupType;
	List<String> objectOrderSeqList;
	List<String> objectList;
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getOrder_seq() {
		return order_seq;
	}
	public void setOrder_seq(String order_seq) {
		this.order_seq = order_seq;
	}
	public String getOrder_no() {
		return order_no;
	}
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}
	public String getOrder_datetime() {
		return order_datetime;
	}
	public void setOrder_datetime(String order_datetime) {
		this.order_datetime = order_datetime;
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
	public String getPayment_way_cd() {
		return payment_way_cd;
	}
	public void setPayment_way_cd(String payment_way_cd) {
		this.payment_way_cd = payment_way_cd;
	}
	public String getPayment_way_name() {
		return payment_way_name;
	}
	public void setPayment_way_name(String payment_way_name) {
		this.payment_way_name = payment_way_name;
	}
	public String getDlvy_amt() {
		return dlvy_amt;
	}
	public void setDlvy_amt(String dlvy_amt) {
		this.dlvy_amt = dlvy_amt;
	}
	public String getDlvy_memo() {
		return dlvy_memo;
	}
	public void setDlvy_memo(String dlvy_memo) {
		this.dlvy_memo = dlvy_memo;
	}
	public String getR_mobile_no() {
		return r_mobile_no;
	}
	public void setR_mobile_no(String r_mobile_no) {
		this.r_mobile_no = r_mobile_no;
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
	public String getS_mobile_no() {
		return s_mobile_no;
	}
	public void setS_mobile_no(String s_mobile_no) {
		this.s_mobile_no = s_mobile_no;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUsr_nm() {
		return usr_nm;
	}
	public void setUsr_nm(String usr_nm) {
		this.usr_nm = usr_nm;
	}
	public String getKey_id() {
		return key_id;
	}
	public void setKey_id(String key_id) {
		this.key_id = key_id;
	}
	public String getFile_id() {
		return file_id;
	}
	public void setFile_id(String file_id) {
		this.file_id = file_id;
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
	public String getSts_update_datetime() {
		return sts_update_datetime;
	}
	public void setSts_update_datetime(String sts_update_datetime) {
		this.sts_update_datetime = sts_update_datetime;
	}
	public String getChng_cd() {
		return chng_cd;
	}
	public void setChng_cd(String chng_cd) {
		this.chng_cd = chng_cd;
	}
	public String getChng_rsn() {
		return chng_rsn;
	}
	public void setChng_rsn(String chng_rsn) {
		this.chng_rsn = chng_rsn;
	}
	public String getChng_dtl_rsn() {
		return chng_dtl_rsn;
	}
	public void setChng_dtl_rsn(String chng_dtl_rsn) {
		this.chng_dtl_rsn = chng_dtl_rsn;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getPopupType() {
		return popupType;
	}
	public void setPopupType(String popupType) {
		this.popupType = popupType;
	}
	public List<String> getObjectOrderSeqList() {
		return objectOrderSeqList;
	}
	public void setObjectOrderSeqList(List<String> objectOrderSeqList) {
		this.objectOrderSeqList = objectOrderSeqList;
	}
	public List<String> getObjectList() {
		return objectList;
	}
	public void setObjectList(List<String> objectList) {
		this.objectList = objectList;
	}
	public String getChng_aply_datetime() {
		return chng_aply_datetime;
	}
	public void setChng_aply_datetime(String chng_aply_datetime) {
		this.chng_aply_datetime = chng_aply_datetime;
	}
	
	
}
