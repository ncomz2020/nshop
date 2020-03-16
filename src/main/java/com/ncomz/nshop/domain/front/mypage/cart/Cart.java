package com.ncomz.nshop.domain.front.mypage.cart;

import java.util.List;

import com.ncomz.nshop.domain.common.CommonCondition;
import com.ncomz.nshop.domain.common.FileInfo;

public class Cart extends CommonCondition {
	String wish_seq;
	String usr_id;
	String prod_id;
	String order_cnt;
	String store_id;
	String prod_name;
	String  prod_price;
	List<FileInfo> imageFileList;
	String shipping_fee;
	Boolean flag;
	
	int store_cnt;
	
	List<String> objectwishSeqList;
	String direct_order;
	
	
	public String getWish_seq() {
		return wish_seq;
	}
	public void setWish_seq(String wish_seq) {
		this.wish_seq = wish_seq;
	}
	public String getUsr_id() {
		return usr_id;
	}
	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id;
	}
	public String getProd_id() {
		return prod_id;
	}
	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}
	public String getOrder_cnt() {
		return order_cnt;
	}
	public void setOrder_cnt(String order_cnt) {
		this.order_cnt = order_cnt;
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public List<FileInfo> getImageFileList() {
		return imageFileList;
	}
	public void setImageFileList(List<FileInfo> imageFileList) {
		this.imageFileList = imageFileList;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public String getProd_price() {
		return prod_price;
	}
	public void setProd_price(String prod_price) {
		this.prod_price = prod_price;
	}
	public String getShipping_fee() {
		return shipping_fee;
	}
	public void setShipping_fee(String shipping_fee) {
		this.shipping_fee = shipping_fee;
	}
	public Boolean getFlag() {
		return flag;
	}
	public void setFlag(Boolean flag) {
		this.flag = flag;
	}
	public int getStore_cnt() {
		return store_cnt;
	}
	public void setStore_cnt(int store_cnt) {
		this.store_cnt = store_cnt;
	}
	
	public List<String> getObjectwishSeqList() {
		return objectwishSeqList;
	}
	public void setObjectwishSeqList(List<String> objectwishSeqList) {
		this.objectwishSeqList = objectwishSeqList;
	}
	public String getDirect_order() {
		return direct_order;
	}
	public void setDirect_order(String direct_order) {
		this.direct_order = direct_order;
	}
	@Override
	public String toString() {
		return "Cart [wish_seq=" + wish_seq + ", usr_id=" + usr_id + ", prod_id=" + prod_id + ", order_cnt=" + order_cnt
				+ ", store_id=" + store_id + ", prod_name=" + prod_name + ", prod_price=" + prod_price
				+ ", imageFileList=" + imageFileList + ", shipping_fee=" + shipping_fee + ", flag=" + flag
				+ ", store_cnt=" + store_cnt + "]";
	}
	
}
