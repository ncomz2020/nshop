package com.ncomz.nshop.dao.common;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public interface CommonMapper {

	 String getStartDate();
	 String getEndDate();
	List<Map<String, String>> listApprovalState(String grpCd); 
	
}
