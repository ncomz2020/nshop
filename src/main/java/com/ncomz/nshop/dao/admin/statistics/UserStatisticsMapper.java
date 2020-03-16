package com.ncomz.nshop.dao.admin.statistics;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.domain.admin.statistics.SalesStatistics;
import com.ncomz.nshop.domain.admin.statistics.UserStatistics;

@Component
public interface UserStatisticsMapper {

	List<UserStatistics> getUserStatisticsList(@Param(value = "us")UserStatistics us);

	List<LinkedHashMap<String, Object>> getExcelList(@Param(value = "us")UserStatistics us);

}
