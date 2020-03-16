package com.ncomz.nshop.domain.common;

import org.springframework.web.multipart.MultipartFile;

public class FileInfo {

	String file_id;
	String org_filename;
	String phy_filename;
	String temp_yn;
	String file_type;
	String key_id;
	byte[] file_data;
	
	public String getFile_id() {
		return file_id;
	}
	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}
	public String getOrg_filename() {
		return org_filename;
	}
	public void setOrg_filename(String org_filename) {
		this.org_filename = org_filename;
	}
	public String getPhy_filename() {
		return phy_filename;
	}
	public void setPhy_filename(String phy_filename) {
		this.phy_filename = phy_filename;
	}
	public String getTemp_yn() {
		return temp_yn;
	}
	public void setTemp_yn(String temp_yn) {
		this.temp_yn = temp_yn;
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
	
}
