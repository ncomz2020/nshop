package com.ncomz.nshop.domain.admin.common;

import java.util.Arrays;
import com.ncomz.nshop.domain.common.Paging;

/**
 * 이미지 파일 관리 domain class
 *
 * <PRE>
 * 1. ClassName: FileMgmt
 * 2. FileName : admin/common/FileMgmt.java
 * 3. Package  : com.ncomz.nshop.controller.admin.common.file
 * 4. 작성자   : gckim@ncomz.com
 * 5. 작성일   : 2014. 7. 6. 오후 2:02:49
 * 6. 변경이력
 *		이름  :		일자	: 변경내용
 *     ———————————————————————————————————
 *		gckim :	2017. 7. 6.	: 신규 개발.
 * </PRE>
*/

public class FileMgmt extends Paging{
	
	String file_id;							//파일 아이디
	String phy_filename;					//변경 파일명
	String org_filename;					//실제파일명
	String display_ord;						//순서
	String temp_yn;							//임시저장 여부
	String create_datetime;					//생성일
	String update_datetime;					//변경일
	String file_type;						//파일 유형
	String file_type_text;					//파일 유형 텍스트
	String key_id;							//key id
	byte[] file_data;						//file data
	String file_size;						//file data size
	String startDate;						//시작시간
	String endDate;							//종료시간
	
	String prod_id;							//상품 아이디
	String store_id;						//상점 아이디
	String prod_name;						//상품명
	String prod_price;						//상품 가격
	String prod_stat;						//판매상태
	String prod_stat_text;					//판매상태 텍스트
	String prod_detail;						//상품 설명
	String prod_delivery_info;				//상품 배송정보
	String prod_refund_info;				//상품 환불정보
	String create_user_id;					//등록자 아이디
	String delete_user_id;					//삭제 아이디
	String delete_datetime;					//삭제시간
	
	String STORE_NAME;						//상점명
	String lang_type;						//언어 유형
	
	String language;						//언어
	
	public String getFile_id() {
		return file_id;
	}
	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}
	public String getPhy_filename() {
		return phy_filename;
	}
	public void setPhy_filename(String phy_filename) {
		this.phy_filename = phy_filename;
	}
	public String getOrg_filename() {
		return org_filename;
	}
	public void setOrg_filename(String org_filename) {
		this.org_filename = org_filename;
	}
	public String getDisplay_ord() {
		return display_ord;
	}
	public void setDisplay_ord(String display_ord) {
		this.display_ord = display_ord;
	}
	public String getTemp_yn() {
		return temp_yn;
	}
	public void setTemp_yn(String temp_yn) {
		this.temp_yn = temp_yn;
	}
	public String getCreate_datetime() {
		return create_datetime;
	}
	public void setCreate_datetime(String create_datetime) {
		this.create_datetime = create_datetime;
	}
	public String getUpdate_datetime() {
		return update_datetime;
	}
	public void setUpdate_datetime(String update_datetime) {
		this.update_datetime = update_datetime;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public String getKey_id() {
		return key_id;
	}
	public void setKey_id(String key_id) {
		this.key_id = key_id;
	}
	public byte[] getFile_data() {
		return file_data;
	}
	public void setFile_data(byte[] file_data) {
		this.file_data = file_data;
	}
	public String getProd_id() {
		return prod_id;
	}
	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
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
	public String getCreate_user_id() {
		return create_user_id;
	}
	public void setCreate_user_id(String create_user_id) {
		this.create_user_id = create_user_id;
	}
	public String getDelete_user_id() {
		return delete_user_id;
	}
	public void setDelete_user_id(String delete_user_id) {
		this.delete_user_id = delete_user_id;
	}
	public String getDelete_datetime() {
		return delete_datetime;
	}
	public void setDelete_datetime(String delete_datetime) {
		this.delete_datetime = delete_datetime;
	}
	public String getProd_detail() {
		return prod_detail;
	}
	public void setProd_detail(String prod_detail) {
		this.prod_detail = prod_detail;
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
	public String getProd_stat_text() {
		return prod_stat_text;
	}
	public void setProd_stat_text(String prod_stat_text) {
		this.prod_stat_text = prod_stat_text;
	}
	public String getFile_type_text() {
		return file_type_text;
	}
	public void setFile_type_text(String file_type_text) {
		this.file_type_text = file_type_text;
	}
	public String getSTORE_NAME() {
		return STORE_NAME;
	}
	public void setSTORE_NAME(String sTORE_NAME) {
		STORE_NAME = sTORE_NAME;
	}
	public String getFile_size() {
		return file_size;
	}
	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}
	public String getLang_type() {
		return lang_type;
	}
	public void setLang_type(String lang_type) {
		this.lang_type = lang_type;
	}
	
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	
	@Override
	public String toString() {
		return "FileMgmt [file_id=" + file_id + ", phy_filename=" + phy_filename + ", org_filename=" + org_filename
				+ ", display_ord=" + display_ord + ", temp_yn=" + temp_yn + ", create_datetime=" + create_datetime
				+ ", update_datetime=" + update_datetime + ", file_type=" + file_type + ", file_type_text="
				+ file_type_text + ", key_id=" + key_id + ", file_data=" + Arrays.toString(file_data) + ", file_size="
				+ file_size + ", startDate=" + startDate + ", endDate=" + endDate + ", prod_id=" + prod_id
				+ ", store_id=" + store_id + ", prod_name=" + prod_name + ", prod_price=" + prod_price + ", prod_stat="
				+ prod_stat + ", prod_stat_text=" + prod_stat_text + ", prod_detail=" + prod_detail
				+ ", prod_delivery_info=" + prod_delivery_info + ", prod_refund_info=" + prod_refund_info
				+ ", create_user_id=" + create_user_id + ", delete_user_id=" + delete_user_id + ", delete_datetime="
				+ delete_datetime + ", STORE_NAME=" + STORE_NAME + ", lang_type=" + lang_type + ", language=" + language
				+ "]";
	}
	
}
