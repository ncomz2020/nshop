package com.ncomz.nshop.service.admin.statistics;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ncomz.nshop.dao.admin.statistics.StatisticsMapper;


@Service
public class StatisticsService {

	@Autowired
	private StatisticsMapper statisticsMapper;
}
