package com.ncomz.nshop.domain.admin.popup;

import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nshop.domain.common.CommonCondition;

public class PopupInfo extends CommonCondition {

	String popup_id     ;
	String popup_title  ;
	String top          ;
	String left_p       ;
	String width        ;
	String height       ;
	String file_id      ;
	String image_path   ;
	String start_dttm   ;
	String end_dttm     ;
	String reg_dttm     ;
	String use_yn       ;
	
	MultipartFile file1 = null;
	
	
	
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
	 * @return the popup_id
	 */
	public String getPopup_id() {
		return popup_id;
	}
	/**
	 * @param popup_id the popup_id to set
	 */
	public void setPopup_id(String popup_id) {
		this.popup_id = popup_id;
	}
	/**
	 * @return the popup_title
	 */
	public String getPopup_title() {
		return popup_title;
	}
	/**
	 * @param popup_title the popup_title to set
	 */
	public void setPopup_title(String popup_title) {
		this.popup_title = popup_title;
	}
	/**
	 * @return the top
	 */
	public String getTop() {
		return top;
	}
	/**
	 * @param top the top to set
	 */
	public void setTop(String top) {
		this.top = top;
	}
	/**
	 * @return the width
	 */
	public String getWidth() {
		return width;
	}
	/**
	 * @param width the width to set
	 */
	public void setWidth(String width) {
		this.width = width;
	}
	/**
	 * @return the height
	 */
	public String getHeight() {
		return height;
	}
	/**
	 * @param height the height to set
	 */
	public void setHeight(String height) {
		this.height = height;
	}
	/**
	 * @return the file_id
	 */
	public String getFile_id() {
		return file_id;
	}
	/**
	 * @param file_id the file_id to set
	 */
	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}
	/**
	 * @return the image_path
	 */
	public String getImage_path() {
		return image_path;
	}
	/**
	 * @param image_path the image_path to set
	 */
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	/**
	 * @return the start_dttm
	 */
	public String getStart_dttm() {
		return start_dttm;
	}
	/**
	 * @param start_dttm the start_dttm to set
	 */
	public void setStart_dttm(String start_dttm) {
		this.start_dttm = start_dttm;
	}
	/**
	 * @return the end_dttm
	 */
	public String getEnd_dttm() {
		return end_dttm;
	}
	/**
	 * @param end_dttm the end_dttm to set
	 */
	public void setEnd_dttm(String end_dttm) {
		this.end_dttm = end_dttm;
	}
	/**
	 * @return the reg_dttm
	 */
	public String getReg_dttm() {
		return reg_dttm;
	}
	/**
	 * @param reg_dttm the reg_dttm to set
	 */
	public void setReg_dttm(String reg_dttm) {
		this.reg_dttm = reg_dttm;
	}
	/**
	 * @return the use_yn
	 */
	public String getUse_yn() {
		return use_yn;
	}
	/**
	 * @param use_yn the use_yn to set
	 */
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	/**
	 * @return the left_p
	 */
	public String getLeft_p() {
		return left_p;
	}
	/**
	 * @param left_p the left_p to set
	 */
	public void setLeft_p(String left_p) {
		this.left_p = left_p;
	}
	
	
	
}
