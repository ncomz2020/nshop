package com.ncomz.nshop.domain.common;

import java.util.List;
import java.util.Map;

import com.thoughtworks.xstream.annotations.XStreamAlias;

public class CommonCondition extends Paging {
	
	private String title;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String toString() {
		return "CommonCondition [title=" + title + "]";
	}
	
}
