package com.ncomz.nshop.service.admin.statistics;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ncomz.nshop.dao.admin.statistics.SalesStatisticsMapper;
import com.ncomz.nshop.domain.admin.statistics.SalesStatistics;


@Service
public class SalesStatisticsService {

	@Autowired
	private SalesStatisticsMapper salesStatisticsMapper;

	public Map<String, Object> getSalesStatisticsList(SalesStatistics ss) {
		Map<String,Object> ssInfo = new HashMap<String,Object>();
		
		List<SalesStatistics> salesStatisticsList = salesStatisticsMapper.getSalesStatisticsList(ss);
		
			List<String> xLine = new ArrayList<String>();
			List<String> yLine = new ArrayList<String>();
			List<String> zLine = new ArrayList<String>();
			
			if(!salesStatisticsList.isEmpty() ){
				for(int i=0; i < salesStatisticsList.size(); i++){
			
					// 차트용 데이터 리스트 적재
					xLine.add(salesStatisticsList.get(i).getPay_fin_datetime().toString());
					yLine.add(salesStatisticsList.get(i).getCalcul_amt().toString());
					zLine.add(salesStatisticsList.get(i).getPayment_amt().toString());
				}

				salesStatisticsList.get(0).setDate_array(xLine);
				salesStatisticsList.get(0).setCal_array(yLine);
				salesStatisticsList.get(0).setPay_array(zLine);
				
				ssInfo.put("salesStatisticsList", salesStatisticsList);
			}
		return ssInfo;
	}

	public Map<String, Object> listExcel(SalesStatistics ss) {
		Map<String,Object> ssInfo = new HashMap<String,Object>();
		
		List<LinkedHashMap<String, Object>> salesStatisticsList = salesStatisticsMapper.getExcelList(ss);
		ssInfo.put("salesStatisticsList", salesStatisticsList);
			
		return ssInfo;
	}
}
