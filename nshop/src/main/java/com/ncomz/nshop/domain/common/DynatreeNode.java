package com.ncomz.nshop.domain.common;

import java.util.List;

public class DynatreeNode {

	String title;
	boolean expand;
	boolean isFolder;
	String key;
	List<DynatreeNode> children;
	String auth_tp;
	String addClass;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public boolean isExpand() {
		return expand;
	}
	public void setExpand(boolean expand) {
		this.expand = expand;
	}
	public boolean getIsFolder() {
		return isFolder;
	}
	public void setIsFolder(boolean isFolder) {
		this.isFolder = isFolder;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public List<DynatreeNode> getChildren() {
		return children;
	}
	public void setChildren(List<DynatreeNode> children) {
		this.children = children;
	}
	public String getAuth_tp() {
		return auth_tp;
	}
	public void setAuth_tp(String auth_tp) {
		this.auth_tp = auth_tp;
	}
	public String getAddClass() {
		return addClass;
	}
	public void setAddClass(String addClass) {
		this.addClass = addClass;
	}
	
}
