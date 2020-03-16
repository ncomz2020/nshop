package com.ncomz.nshop.domain.admin.product;

import java.util.List;

import com.ncomz.nshop.domain.common.FileInfo;
import com.ncomz.nshop.domain.common.Paging;

public class ProductInfo extends Paging {

	String prod_id;
	String store_id;
	String store_nm;
	String prod_name;
	String prod_price;
	String prod_stat;
	String prod_stat_name;
	String file_id;
	String delete_yn;
	String create_user_id;
	String create_datetime;
	String create_user_name;
	String update_user_id;
	String update_user_name;
	String update_datetime;
	String delete_datetime;
	String delete_user_id;
	String delete_user_name;
	String user_type;
	String login_user_id;
	
	String file_info;
	String prod_detail;
	String prod_delivery_info;
	String prod_refund_info;
	
	String category_1;
	String category_2;
	String category_3;
	String category_4;
	String category_id;
	String path;
	String category_info;
	String search_status;
	String start_date;
	String end_date;
	String start_price;
	String end_price;
	String search_type;
	String search_txt;
	
	List<String> objectFileList;
	List<String> objectCategoryList;
	String file_type;
	
	List<FileInfo> imageFileList;
	
	String dateFormat;
	
	String language;
	
	public String getStore_nm() {
		return store_nm;
	}
	public void setStore_nm(String store_nm) {
		this.store_nm = store_nm;
	}
	public String getDateFormat() {
		return dateFormat;
	}
	public void setDateFormat(String dateFormat) {
		this.dateFormat = dateFormat;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public List<String> getObjectFileList() {
		return objectFileList;
	}
	public void setObjectFileList(List<String> objectFileList) {
		this.objectFileList = objectFileList;
	}
	public List<String> getObjectCategoryList() {
		return objectCategoryList;
	}
	public void setObjectCategoryList(List<String> objectCategoryList) {
		this.objectCategoryList = objectCategoryList;
	}
	public String getFile_info() {
		return file_info;
	}
	public void setFile_info(String file_info) {
		this.file_info = file_info;
	}
	public String getProd_detail() {
		return prod_detail;
	}
	public void setProd_detail(String prod_detail) {
		this.prod_detail = prod_detail;
	}
	public String getProd_delivery_info() {
		return prod_delivery_info;
	}
	public void setProd_delivery_info(String prod_delivery_info) {
		this.prod_delivery_info = prod_delivery_info;
	}
	public String getProd_refund_info() {
		return prod_refund_info;
	}
	public void setProd_refund_info(String prod_refund_info) {
		this.prod_refund_info = prod_refund_info;
	}
	public String getCategory_info() {
		return category_info;
	}
	public void setCategory_info(String category_info) {
		this.category_info = category_info;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public String getLogin_user_id() {
		return login_user_id;
	}
	public void setLogin_user_id(String login_user_id) {
		this.login_user_id = login_user_id;
	}
	public String getDelete_yn() {
		return delete_yn;
	}
	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}
	public String getDelete_datetime() {
		return delete_datetime;
	}
	public void setDelete_datetime(String delete_datetime) {
		this.delete_datetime = delete_datetime;
	}
	public String getDelete_user_id() {
		return delete_user_id;
	}
	public void setDelete_user_id(String delete_user_id) {
		this.delete_user_id = delete_user_id;
	}
	public String getDelete_user_name() {
		return delete_user_name;
	}
	public void setDelete_user_name(String delete_user_name) {
		this.delete_user_name = delete_user_name;
	}
	public String getSearch_status() {
		return search_status;
	}
	public void setSearch_status(String search_status) {
		this.search_status = search_status;
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
	public String getStart_price() {
		return start_price;
	}
	public void setStart_price(String start_price) {
		this.start_price = start_price;
	}
	public String getEnd_price() {
		return end_price;
	}
	public void setEnd_price(String end_price) {
		this.end_price = end_price;
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
	public String getCategory_1() {
		return category_1;
	}
	public void setCategory_1(String category_1) {
		this.category_1 = category_1;
	}
	public String getCategory_2() {
		return category_2;
	}
	public void setCategory_2(String category_2) {
		this.category_2 = category_2;
	}
	public String getCategory_3() {
		return category_3;
	}
	public void setCategory_3(String category_3) {
		this.category_3 = category_3;
	}
	public String getCategory_4() {
		return category_4;
	}
	public void setCategory_4(String category_4) {
		this.category_4 = category_4;
	}
	public String getProd_stat_name() {
		return prod_stat_name;
	}
	public void setProd_stat_name(String prod_stat_name) {
		this.prod_stat_name = prod_stat_name;
	}
	public String getProd_id() {
		return prod_id;
	}
	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
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
	public String getProd_stat() {
		return prod_stat;
	}
	public void setProd_stat(String prod_stat) {
		this.prod_stat = prod_stat;
	}
	public String getFile_id() {
		return file_id;
	}
	public void setFile_id(String file_id) {
		this.file_id = file_id;
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
	public String getCreate_user_name() {
		return create_user_name;
	}
	public void setCreate_user_name(String create_user_name) {
		this.create_user_name = create_user_name;
	}
	public String getUpdate_user_id() {
		return update_user_id;
	}
	public void setUpdate_user_id(String update_user_id) {
		this.update_user_id = update_user_id;
	}
	public String getUpdate_user_name() {
		return update_user_name;
	}
	public void setUpdate_user_name(String update_user_name) {
		this.update_user_name = update_user_name;
	}
	public String getUpdate_datetime() {
		return update_datetime;
	}
	public void setUpdate_datetime(String update_datetime) {
		this.update_datetime = update_datetime;
	}
	public List<FileInfo> getImageFileList() {
		return imageFileList;
	}
	public void setImageFileList(List<FileInfo> imageFileList) {
		this.imageFileList = imageFileList;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	@Override
	public String toString() {
		return String.format(
				"ProductInfo [prod_id=%s, store_id=%s, prod_name=%s, prod_price=%s, prod_stat=%s, prod_stat_name=%s, file_id=%s, delete_yn=%s, create_user_id=%s, create_datetime=%s, create_user_name=%s, update_user_id=%s, update_user_name=%s, update_datetime=%s, delete_datetime=%s, delete_user_id=%s, delete_user_name=%s, user_type=%s, login_user_id=%s, file_info=%s, prod_detail=%s, prod_delivery_info=%s, prod_refund_info=%s, category_1=%s, category_2=%s, category_3=%s, category_4=%s, category_id=%s, path=%s, category_info=%s, search_status=%s, start_date=%s, end_date=%s, start_price=%s, end_price=%s, search_type=%s, search_txt=%s, objectFileList=%s, objectCategoryList=%s, file_type=%s, imageFileList=%s, language=%s]",
				prod_id, store_id, prod_name, prod_price, prod_stat, prod_stat_name, file_id, delete_yn, create_user_id,
				create_datetime, create_user_name, update_user_id, update_user_name, update_datetime, delete_datetime,
				delete_user_id, delete_user_name, user_type, login_user_id, file_info, prod_detail, prod_delivery_info,
				prod_refund_info, category_1, category_2, category_3, category_4, category_id, path, category_info,
				search_status, start_date, end_date, start_price, end_price, search_type, search_txt, objectFileList,
				objectCategoryList, file_type, imageFileList, language);
	}
}
