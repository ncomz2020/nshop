package com.ncomz.nshop.dao.admin.statistics;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.statistics.OrderStatistics;

@Component
public interface OrderStatisticsMapper {

	List<OrderStatistics> getOrderChartStatisticsList(@Param(value = "os")OrderStatistics os);

	List<OrderStatistics> getGridList(@Param(value = "os")OrderStatistics os);

	List<LinkedHashMap<String, Object>> getExcelList(@Param(value = "os")OrderStatistics os);

}
