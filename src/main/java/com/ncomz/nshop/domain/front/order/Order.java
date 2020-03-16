package com.ncomz.nshop.domain.front.order;

import java.util.List;

import com.ncomz.nshop.domain.common.CommonCondition;
import com.ncomz.nshop.domain.common.FileInfo;

public class Order extends CommonCondition {
	int prod_order_seq; //상품주문순번 key
	String prod_id; // 상품아이디
	int order_seq; //wnanstnsqjs
	String prod_order_no;//상품주문번호
	String order_sts_cd;//주문상태코드
	String order_cnt; // 주문수량
	String order_amt; //주문금액
	String payment_amt; //결제금액
	String store_id; 
	String store_name;
	String store_id_memo;
	String create_user_id;
	String create_datetime;
	String update_user_id;
	String update_datetime;
	
	String order_no;
	String order_datetime;
	String user_id;
	String order_way_cd; //주문수단코드
	String payment_way_cd;//결제수단코드
	String payment_no;//결제번호
	String dlvy_amt;//배송금액
	String memo;
	String email;
	String user_nm;
	String mobile_no;
	String tel_no;
	String base_addr;
	String dtil_aar;
	String zip_cd;
	public int getProd_order_seq() {
		return prod_order_seq;
	}
	public void setProd_order_seq(int prod_order_seq) {
		this.prod_order_seq = prod_order_seq;
	}
	public String getProd_id() {
		return prod_id;
	}
	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}
	public int getOrder_seq() {
		return order_seq;
	}
	public void setOrder_seq(int order_seq) {
		this.order_seq = order_seq;
	}
	public String getProd_order_no() {
		return prod_order_no;
	}
	public void setProd_order_no(String prod_order_no) {
		this.prod_order_no = prod_order_no;
	}
	public String getOrder_sts_cd() {
		return order_sts_cd;
	}
	public void setOrder_sts_cd(String order_sts_cd) {
		this.order_sts_cd = order_sts_cd;
	}
	public String getOrder_cnt() {
		return order_cnt;
	}
	public void setOrder_cnt(String order_cnt) {
		this.order_cnt = order_cnt;
	}
	public String getOrder_amt() {
		return order_amt;
	}
	public void setOrder_amt(String order_amt) {
		this.order_amt = order_amt;
	}
	public String getPayment_amt() {
		return payment_amt;
	}
	public void setPayment_amt(String payment_amt) {
		this.payment_amt = payment_amt;
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public String getStore_id_memo() {
		return store_id_memo;
	}
	public void setStore_id_memo(String store_id_memo) {
		this.store_id_memo = store_id_memo;
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
	public String getOrder_way_cd() {
		return order_way_cd;
	}
	public void setOrder_way_cd(String order_way_cd) {
		this.order_way_cd = order_way_cd;
	}
	public String getPayment_way_cd() {
		return payment_way_cd;
	}
	public void setPayment_way_cd(String payment_way_cd) {
		this.payment_way_cd = payment_way_cd;
	}
	public String getPayment_no() {
		return payment_no;
	}
	public void setPayment_no(String payment_no) {
		this.payment_no = payment_no;
	}
	public String getDlvy_amt() {
		return dlvy_amt;
	}
	public void setDlvy_amt(String dlvy_amt) {
		this.dlvy_amt = dlvy_amt;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getMobile_no() {
		return mobile_no;
	}
	public void setMobile_no(String mobile_no) {
		this.mobile_no = mobile_no;
	}
	public String getTel_no() {
		return tel_no;
	}
	public void setTel_no(String tel_no) {
		this.tel_no = tel_no;
	}
	public String getBase_addr() {
		return base_addr;
	}
	public void setBase_addr(String base_addr) {
		this.base_addr = base_addr;
	}
	public String getDtil_aar() {
		return dtil_aar;
	}
	public void setDtil_aar(String dtil_aar) {
		this.dtil_aar = dtil_aar;
	}
	public String getZip_cd() {
		return zip_cd;
	}
	public void setZip_cd(String zip_cd) {
		this.zip_cd = zip_cd;
	}
	@Override
	public String toString() {
		return "Order [prod_order_seq=" + prod_order_seq + ", prod_id=" + prod_id + ", order_seq=" + order_seq
				+ ", prod_order_no=" + prod_order_no + ", order_sts_cd=" + order_sts_cd + ", order_cnt=" + order_cnt
				+ ", order_amt=" + order_amt + ", payment_amt=" + payment_amt + ", store_id=" + store_id
				+ ", store_name=" + store_name + ", store_id_memo=" + store_id_memo + ", create_user_id="
				+ create_user_id + ", create_datetime=" + create_datetime + ", update_user_id=" + update_user_id
				+ ", update_datetime=" + update_datetime + ", order_no=" + order_no + ", order_datetime="
				+ order_datetime + ", user_id=" + user_id + ", order_way_cd=" + order_way_cd + ", payment_way_cd="
				+ payment_way_cd + ", payment_no=" + payment_no + ", dlvy_amt=" + dlvy_amt + ", memo=" + memo
				+ ", email=" + email + ", user_nm=" + user_nm + ", mobile_no=" + mobile_no + ", tel_no=" + tel_no
				+ ", base_addr=" + base_addr + ", dtil_aar=" + dtil_aar + ", zip_cd=" + zip_cd + ", getProd_order_seq()=" + getProd_order_seq()
				+ ", getProd_id()=" + getProd_id() + ", getOrder_seq()=" + getOrder_seq() + ", getProd_order_no()="
				+ getProd_order_no() + ", getOrder_sts_cd()=" + getOrder_sts_cd() + ", getOrder_cnt()=" + getOrder_cnt()
				+ ", getOrder_amt()=" + getOrder_amt() + ", getPayment_amt()=" + getPayment_amt() + ", getStore_id()="
				+ getStore_id() + ", getStore_name()=" + getStore_name() + ", getStore_id_memo()=" + getStore_id_memo()
				+ ", getCreate_user_id()=" + getCreate_user_id() + ", getCreate_datetime()=" + getCreate_datetime()
				+ ", getUpdate_user_id()=" + getUpdate_user_id() + ", getUpdate_datetime()=" + getUpdate_datetime()
				+ ", getOrder_no()=" + getOrder_no() + ", getOrder_datetime()=" + getOrder_datetime()
				+ ", getUser_id()=" + getUser_id() + ", getOrder_way_cd()=" + getOrder_way_cd()
				+ ", getPayment_way_cd()=" + getPayment_way_cd() + ", getPayment_no()=" + getPayment_no()
				+ ", getDlvy_amt()=" + getDlvy_amt() + ", getMemo()=" + getMemo() + ", getEmail()=" + getEmail()
				+ ", getUser_nm()=" + getUser_nm() + ", getMobile_no()=" + getMobile_no() + ", getTel_no()="
				+ getTel_no() + ", getBase_addr()=" + getBase_addr() + ", getDtil_aar()=" + getDtil_aar()
				+ ", getZip_cd()=" + getZip_cd() + ", getTitle()=" + getTitle() + ", toString()=" + super.toString()
				+ ", getPage()=" + getPage() + ", getPerPage()=" + getPerPage() + ", getRownum()=" + getRownum()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + "]";
	}
	
	
}
