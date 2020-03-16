package com.ncomz.nshop.domain.admin.common;

import java.io.Serializable;
import java.util.List;

@SuppressWarnings("serial")
public class Menu implements Serializable {

	String menu_id;
	String parent_id;
	String title;
	String url;
	String icon;
	String display_order;
	List<Menu> children;
	boolean active;
	String auth_tp;
	String[] languageCode;
	String[] languageTitle;
	String language;
	String usrGrpId;
	public String getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getDisplay_order() {
		return display_order;
	}
	public void setDisplay_order(String display_order) {
		this.display_order = display_order;
	}
	public List<Menu> getChildren() {
		return children;
	}
	public void setChildren(List<Menu> children) {
		this.children = children;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}
	public String getAuth_tp() {
		return auth_tp;
	}
	public void setAuth_tp(String auth_tp) {
		this.auth_tp = auth_tp;
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
	public void setusrGrpId(String usrGrpId) {
		this.usrGrpId = usrGrpId;
	}
	
	
	
}
