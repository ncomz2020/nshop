package com.ncomz.nshop.domain.admin.store;

import java.util.ArrayList;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nshop.domain.common.CommonCondition;

public class StoreInfoMgmt extends CommonCondition {

	
	String store_id           ;
	String store_name         ;
	String comp_name          ;
	String president_name     ;
	String post_num           ;
	String comp_addr          ;
	String comp_addr2         ;
	String main_phone_num     ;
	String fax_num            ;
	String comp_reg_num       ;
	String approval_stat      ;
	String operational_stat   ;
	String approval_stat_text ;
	String operational_stat_text;
	String reg_datetime       ;
	String approval_datetime  ;
	String startDate          ;
	String endDate            ;
	ArrayList<String> store_id_array = new ArrayList<String>()  ;
	String language;

//	@JsonIgnore
	MultipartFile file1 = null;
	MultipartFile file2 = null;
	String comp_reg_copy;
	String store_logo;
	String org_filename1;
	String org_filename2;
	
	String product_cnt; // 상품수
	
	public String getPost_num() {
		return post_num;
	}
	public void setPost_num(String post_num) {
		this.post_num = post_num;
	}
	public String getComp_addr2() {
		return comp_addr2;
	}
	public void setComp_addr2(String comp_addr2) {
		this.comp_addr2 = comp_addr2;
	}
	public String getProduct_cnt() {
		return product_cnt;
	}
	public void setProduct_cnt(String product_cnt) {
		this.product_cnt = product_cnt;
	}
	/**
	 * @return the store_id_array
	 */
	public ArrayList<String> getStore_id_array() {
		return store_id_array;
	}
	/**
	 * @param store_id_array the store_id_array to set
	 */
	public void setStore_id_array(ArrayList<String> store_id_array) {
		this.store_id_array = store_id_array;
	}
	public String getApproval_stat_text() {
		return approval_stat_text;
	}
	public void setApproval_stat_text(String approval_stat_text) {
		this.approval_stat_text = approval_stat_text;
	}
	public String getOperational_stat_text() {
		return operational_stat_text;
	}
	public void setOperational_stat_text(String operational_stat_text) {
		this.operational_stat_text = operational_stat_text;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	/**
	 * @return the store_id
	 */
	public String getStore_id() {
		return store_id;
	}
	/**
	 * @param store_id the store_id to set
	 */
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	/**
	 * @return the store_name
	 */
	public String getStore_name() {
		return store_name;
	}
	/**
	 * @param store_name the store_name to set
	 */
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	/**
	 * @return the comp_name
	 */
	public String getComp_name() {
		return comp_name;
	}
	/**
	 * @param comp_name the comp_name to set
	 */
	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}
	/**
	 * @return the president_name
	 */
	public String getPresident_name() {
		return president_name;
	}
	/**
	 * @param president_name the president_name to set
	 */
	public void setPresident_name(String president_name) {
		this.president_name = president_name;
	}
	/**
	 * @return the comp_addr
	 */
	public String getComp_addr() {
		return comp_addr;
	}
	/**
	 * @param comp_addr the comp_addr to set
	 */
	public void setComp_addr(String comp_addr) {
		this.comp_addr = comp_addr;
	}
	/**
	 * @return the main_phone_num
	 */
	public String getMain_phone_num() {
		return main_phone_num;
	}
	/**
	 * @param main_phone_num the main_phone_num to set
	 */
	public void setMain_phone_num(String main_phone_num) {
		this.main_phone_num = main_phone_num;
	}
	/**
	 * @return the fax_num
	 */
	public String getFax_num() {
		return fax_num;
	}
	/**
	 * @param fax_num the fax_num to set
	 */
	public void setFax_num(String fax_num) {
		this.fax_num = fax_num;
	}
	/**
	 * @return the comp_reg_num
	 */
	public String getComp_reg_num() {
		return comp_reg_num;
	}
	/**
	 * @param comp_reg_num the comp_reg_num to set
	 */
	public void setComp_reg_num(String comp_reg_num) {
		this.comp_reg_num = comp_reg_num;
	}
	/**
	 * @return the approval_stat
	 */
	public String getApproval_stat() {
		return approval_stat;
	}
	/**
	 * @param approval_stat the approval_stat to set
	 */
	public void setApproval_stat(String approval_stat) {
		this.approval_stat = approval_stat;
	}
	/**
	 * @return the operational_stat
	 */
	public String getOperational_stat() {
		return operational_stat;
	}
	/**
	 * @param operational_stat the operational_stat to set
	 */
	public void setOperational_stat(String operational_stat) {
		this.operational_stat = operational_stat;
	}
	/**
	 * @return the reg_datetime
	 */
	public String getReg_datetime() {
		return reg_datetime;
	}
	/**
	 * @param reg_datetime the reg_datetime to set
	 */
	public void setReg_datetime(String reg_datetime) {
		this.reg_datetime = reg_datetime;
	}
	/**
	 * @return the approval_datetime
	 */
	public String getApproval_datetime() {
		return approval_datetime;
	}
	/**
	 * @param approval_datetime the approval_datetime to set
	 */
	public void setApproval_datetime(String approval_datetime) {
		this.approval_datetime = approval_datetime;
	}



	
	
	
	
	
	
	
	
	
	/**
	 * @return the file1
	 */
	public MultipartFile getFile1() {
		return file1;
	}
	/**
	 * @param file1 the file1 to set
	 */
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
	/**
	 * @return the file2
	 */
	public MultipartFile getFile2() {
		return file2;
	}
	/**
	 * @param file2 the file2 to set
	 */
	public void setFile2(MultipartFile file2) {
		this.file2 = file2;
	}
	/**
	 * @return the comp_reg_copy
	 */
	public String getComp_reg_copy() {
		return comp_reg_copy;
	}
	/**
	 * @param comp_reg_copy the comp_reg_copy to set
	 */
	public void setComp_reg_copy(String comp_reg_copy) {
		this.comp_reg_copy = comp_reg_copy;
	}
	/**
	 * @return the store_logo
	 */
	public String getStore_logo() {
		return store_logo;
	}
	/**
	 * @param store_logo the store_logo to set
	 */
	public void setStore_logo(String store_logo) {
		this.store_logo = store_logo;
	}
	/**
	 * @return the org_filename1
	 */
	public String getOrg_filename1() {
		return org_filename1;
	}
	/**
	 * @param org_filename1 the org_filename1 to set
	 */
	public void setOrg_filename1(String org_filename1) {
		this.org_filename1 = org_filename1;
	}
	/**
	 * @return the org_filename2
	 */
	public String getOrg_filename2() {
		return org_filename2;
	}
	/**
	 * @param org_filename2 the org_filename2 to set
	 */
	public void setOrg_filename2(String org_filename2) {
		this.org_filename2 = org_filename2;
	}
	
	
	
	
	
	
	
	
	
	
	
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	@Override
	public String toString() {
		return "StoreInfoMgmt [store_id=" + store_id + ", store_name=" + store_name + ", comp_name=" + comp_name
				+ ", president_name=" + president_name + ", post_num=" + post_num + ", comp_addr=" + comp_addr
				+ ", comp_addr2=" + comp_addr2 + ", main_phone_num=" + main_phone_num + ", fax_num=" + fax_num
				+ ", comp_reg_num=" + comp_reg_num + ", approval_stat=" + approval_stat + ", operational_stat="
				+ operational_stat + ", approval_stat_text=" + approval_stat_text + ", operational_stat_text="
				+ operational_stat_text + ", reg_datetime=" + reg_datetime + ", approval_datetime=" + approval_datetime
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", store_id_array=" + store_id_array
				+ ", file1=" + file1 + ", file2=" + file2 + ", comp_reg_copy=" + comp_reg_copy + ", store_logo="
				+ store_logo + ", org_filename1=" + org_filename1 + ", org_filename2=" + org_filename2
				+ ", product_cnt=" + product_cnt + "]";
	}
	
	

	
}
