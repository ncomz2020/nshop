package com.ncomz.nshop.service.admin.statistics;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ncomz.nshop.dao.admin.statistics.OrderStatisticsMapper;
import com.ncomz.nshop.domain.admin.statistics.OrderStatistics;


@Service
public class OrderStatisticsService {

	@Autowired
	private OrderStatisticsMapper orderStatisticsMapper;

	public Map<String, Object> getOrderStatisticsList(OrderStatistics os) {
	Map<String,Object> osInfo = new HashMap<String,Object>();
	List chartData = new ArrayList();
	List<OrderStatistics> orderChartStatisticsList = orderStatisticsMapper.getOrderChartStatisticsList(os);
	
	if(orderChartStatisticsList.size() > 0 ){
		chartData.add(Integer.parseInt(orderChartStatisticsList.get(0).getAa().toString()));
		chartData.add(Integer.parseInt(orderChartStatisticsList.get(0).getBa().toString()));
		chartData.add(Integer.parseInt(orderChartStatisticsList.get(0).getCa().toString()));
		chartData.add(Integer.parseInt(orderChartStatisticsList.get(0).getDa().toString()));
		chartData.add(Integer.parseInt(orderChartStatisticsList.get(0).getEa().toString()));
		chartData.add(Integer.parseInt(orderChartStatisticsList.get(0).getFa().toString()));
		chartData.add(Integer.parseInt(orderChartStatisticsList.get(0).getGa().toString()));
		
		orderChartStatisticsList.get(0).setAmt_array(chartData);

		List<OrderStatistics> orderGridStatisticsList = orderStatisticsMapper.getGridList(os);

		osInfo.put("orderGridStatisticsList", orderGridStatisticsList);
		osInfo.put("orderChartStatisticsList", orderChartStatisticsList);
		
	}
	
	return osInfo;
	}

	public Map<String, Object> listExcel(OrderStatistics os) {
		Map<String,Object> info = new HashMap<String,Object>();
		
		List<LinkedHashMap<String, Object>> list = orderStatisticsMapper.getExcelList(os);
		info.put("list", list);

		return info;
	}
	
}
