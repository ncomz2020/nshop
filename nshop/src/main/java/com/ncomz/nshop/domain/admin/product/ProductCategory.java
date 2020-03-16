package com.ncomz.nshop.domain.admin.product;

public class ProductCategory {
	
	String category_id;
	String parent_id;
	String title;
	String display_order;
	String expand;
	String[] languageCode;
	String[] languageTitle;
	String language;
	
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDisplay_order() {
		return display_order;
	}
	public void setDisplay_order(String display_order) {
		this.display_order = display_order;
	}
	public String getExpand() {
		return expand;
	}
	public void setExpand(String expand) {
		this.expand = expand;
	}
	public String[] getLanguageCode() {
		return languageCode;
	}
	public void setLanguageCode(String[] languageCode) {
		this.languageCode = languageCode;
	}
	public String[] getLanguageTitle() {
		return languageTitle;
	}
	public void setLanguageTitle(String[] languageTitle) {
		this.languageTitle = languageTitle;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	
}
