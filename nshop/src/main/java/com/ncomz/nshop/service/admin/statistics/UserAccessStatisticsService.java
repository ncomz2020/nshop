package com.ncomz.nshop.service.admin.statistics;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ncomz.nshop.dao.admin.statistics.UserAccessStatisticsMapper;
import com.ncomz.nshop.domain.admin.statistics.UserAccessStatistics;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.utillty.SessionUtil;


@Service
public class UserAccessStatisticsService {

	@Autowired
	private UserAccessStatisticsMapper userAccessStatisticsMapper;

	public Map<String, Object> getList(UserAccessStatistics ua) {
		Map<String,Object> uaInfo = new HashMap<String,Object>();
		
		List<UserAccessStatistics> list = userAccessStatisticsMapper.getList(ua);
		
		List<String> xLine = new ArrayList<String>();
		List<Integer> yLine = new ArrayList<Integer>();
		if(!list.isEmpty() ){
			for(int i=0; i < list.size(); i++){
		
				// 차트용 데이터 리스트 적재
				xLine.add(list.get(i).getAccess_date().toString());
				yLine.add(list.get(i).getCount_user_id());
			}
			
			list.get(0).setAmt_array(yLine);
			list.get(0).setDate_array(xLine);
			
			uaInfo.put("list", list);
		}
		return uaInfo;
	}

	
	public int insertAccessInfo(UserAccessStatistics ua) {
		return userAccessStatisticsMapper.insertAccessInfo(ua);
	}

	
	public Map<String, Object> listExcel(UserAccessStatistics ua) {
		Map<String,Object> info = new HashMap<String,Object>();
		List<LinkedHashMap<String, Object>> list = userAccessStatisticsMapper.getExcelList(ua);
		info.put("list", list);
			
		return info;
	}
	
}
