package com.ncomz.nshop.domain.admin.order;
/*
 * 상품 주문 테이블
 */
public class OrderProductInfo extends OrderCondition {
	String prod_order_seq;
	String prod_name;
	String prod_id;
	String prod_order_no;
	String order_sts_cd;
	String order_sts_name;
	String order_cnt;
	String order_amt;
	String payment_amt;
	String store_id;
	String store_name;
	String store_id_memo;
	public String getProd_order_seq() {
		return prod_order_seq;
	}
	public void setProd_order_seq(String prod_order_seq) {
		this.prod_order_seq = prod_order_seq;
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
	public String getOrder_sts_name() {
		return order_sts_name;
	}
	public void setOrder_sts_name(String order_sts_name) {
		this.order_sts_name = order_sts_name;
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
	
	
	
}
