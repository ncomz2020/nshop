package com.ncomz.nshop.dao.admin.settlement;

import java.util.LinkedHashMap;
import java.util.List;
import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.order.OrderInfoMgmt;
import com.ncomz.nshop.domain.admin.settlement.SettlementHistInfo;
import com.ncomz.nshop.domain.admin.settlement.SettlementInfo;

@Component
public interface SettlementMapper {
	
	// 정산관리
	List<SettlementInfo> getSettlementList(SettlementInfo settlementInfo);
	int getSettlementInfoCount(SettlementInfo settlementInfo);
	int statusModifyAction(SettlementInfo settlementInfo);
	int getSettlementStsCdCount(SettlementInfo settlementInfo);
	List<LinkedHashMap<String, String>> listExcel(SettlementInfo settlementInfo);
	int getSettlementByDailyCount(SettlementInfo settlementInfo);
	
	// 일별정산내역
	List<SettlementInfo> getSettlementByDailyList(SettlementInfo settlementInfo);
	SettlementInfo getSettlementByDailyInfo(SettlementInfo settlementInfo);
	List<LinkedHashMap<String, String>> dailyListExcel(SettlementInfo settlementInfo);
	
	// 건별정산내역
	int getSettlementByItemCount(SettlementInfo settlementInfo);
	List<SettlementInfo> getSettlementByItemList(SettlementInfo settlementInfo);
	SettlementInfo getSumByItem(SettlementInfo settlementInfo);
	List<LinkedHashMap<String, String>> itemDetailListExcel(SettlementInfo settlementInfo);
	
	// 정산요청
	int getSettlementReqCount(SettlementInfo settlementInfo);
	List<OrderInfoMgmt> getSettlementReqList(SettlementInfo settlementInfo);
	int insertCalculInfo(SettlementInfo settlementInfo);
	String getPaymentWayCode(String prodOrderSeq);
	int chkDlvyInCalcul(SettlementInfo settlementInfo);
	SettlementInfo getCalculDetail(SettlementInfo settlementInfo);
	
}
