package com.ncomz.nshop.dao.admin.statistics;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.domain.admin.statistics.SalesStatistics;

@Component
public interface SalesStatisticsMapper {

	List<SalesStatistics> getSalesStatisticsList(@Param(value = "ss")SalesStatistics ss);

	List<LinkedHashMap<String, Object>> getExcelList(@Param(value = "ss")SalesStatistics ss);
}
