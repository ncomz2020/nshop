package com.ncomz.nshop.service.admin.statistics;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ncomz.nshop.dao.admin.statistics.UserStatisticsMapper;
import com.ncomz.nshop.domain.admin.statistics.UserStatistics;


@Service
public class UserStatisticsService {

	@Autowired
	private UserStatisticsMapper userStatisticsMapper;

	public Map<String, Object> getUserStatisticsList(UserStatistics us) {
		
		Map<String,Object> usInfo = new HashMap<String,Object>();
		List<UserStatistics> userStatisticsList = userStatisticsMapper.getUserStatisticsList(us);

		List<String> dateLine = new ArrayList<String>();
		List<Integer> joinLine = new ArrayList<Integer>();
		List<Integer> withLine = new ArrayList<Integer>();
		
		
		if(!userStatisticsList.isEmpty() ){
			for(int i=0; i < userStatisticsList.size(); i++){
				
				// 차트용 데이터 리스트 적재
				dateLine.add(userStatisticsList.get(i).getJoin_date().toString());
				joinLine.add(userStatisticsList.get(i).getJoin_count());
				withLine.add(userStatisticsList.get(i).getWithdrawal_count());
			}
			
		}

		userStatisticsList.get(0).setDate_array(dateLine);
		userStatisticsList.get(0).setJoin_array(joinLine);
		userStatisticsList.get(0).setWith_array(withLine);
		
		usInfo.put("userStatisticsList", userStatisticsList);
		
		return usInfo;
	}

	public Map<String, Object> listExcel(UserStatistics us) {

		Map<String,Object> info = new HashMap<String,Object>();
		List<LinkedHashMap<String, Object>> list = userStatisticsMapper.getExcelList(us);
		info.put("list", list);
		return info;
	}
}
