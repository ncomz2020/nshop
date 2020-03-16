package com.ncomz.nshop.dao.admin.statistics;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.statistics.UserAccessStatistics;

@Component
public interface UserAccessStatisticsMapper {

	List<UserAccessStatistics> getList(@Param(value = "ua")UserAccessStatistics ua);

	int insertAccessInfo(UserAccessStatistics ua);

	List<LinkedHashMap<String, Object>> getExcelList(@Param(value = "ua")UserAccessStatistics ua);
}
