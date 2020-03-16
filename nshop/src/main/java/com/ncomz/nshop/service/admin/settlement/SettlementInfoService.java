package com.ncomz.nshop.service.admin.settlement;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nshop.dao.admin.settlement.SettlementHistMapper;
import com.ncomz.nshop.dao.admin.settlement.SettlementMapper;
import com.ncomz.nshop.domain.admin.order.OrderInfoMgmt;
import com.ncomz.nshop.domain.admin.settlement.SettlementHistInfo;
import com.ncomz.nshop.domain.admin.settlement.SettlementInfo;
import com.ncomz.nshop.utillty.HolidayUtil;

@Service
public class SettlementInfoService {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private SettlementMapper settlementMapper;
	@Autowired
	private SettlementHistMapper settlementHistMapper;
	
	public List<SettlementInfo> getSettlementList(SettlementInfo settlementInfo){
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		settlementInfo.setLanguage(language);
		
		List<SettlementInfo> settlementList = settlementMapper.getSettlementList(settlementInfo);
		//logger.debug("JY LOG :::::: "+settlementList.size());
		//logger.debug("JY LOG :::::: "+settlementList.get(0).getProd_order_seq());
		return settlementList;
	}
	
	public int getSettlementInfoCount(SettlementInfo settlementInfo) {
		return settlementMapper.getSettlementInfoCount(settlementInfo);
	}

	@Transactional
	public Object statusModifyAction(SettlementInfo settlementInfo, SettlementHistInfo histInfo) {
		
		try {
			String[] arrCalculSeq = null;
			if(!StringUtils.isEmpty(settlementInfo.getCalcul_seq())){
				List<String> calculSeqList = new ArrayList<String>();
				
				arrCalculSeq = settlementInfo.getCalcul_seq().split(",");
				for(String calcul_seq : arrCalculSeq){
					calculSeqList.add(calcul_seq);
				}
				settlementInfo.setCalculSeqList(calculSeqList);
			}
			
			// 여러상태를 한번에 변경 방지 (ex: 정산요청, 정산철회를 한꺼번에 지급완료상태로 변경할 수 없다)
			if(settlementMapper.getSettlementStsCdCount(settlementInfo) > 1){
				throw new Exception("여러 정산상태를 동시에 변경할 수 없습니다.");
			}
			
			
			if(settlementMapper.statusModifyAction(settlementInfo) <= 0){
				throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
			}
			
			// 정산히스토리에 추가
			SettlementHistInfo insertHistInfo = new SettlementHistInfo();
			for(String calcul_seq : arrCalculSeq){
				logger.debug("JY LOG calcul_seq:::::: "+calcul_seq);
				insertHistInfo.setCalcul_seq(calcul_seq);
				insertHistInfo.setUpdater_id(histInfo.getUpdater_id());
				insertHistInfo.setCalcul_sts_cd(settlementInfo.getCalcul_sts_cd());
				insertHistInfo.setCalcul_memo(histInfo.getCalcul_memo());
				if(settlementHistMapper.insertCalCulHistAction(insertHistInfo) <= 0){
					throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
				}
			}
			return "succ";
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return e.getMessage();
		}
	}
	
	public List<LinkedHashMap<String, String>> listExcel(SettlementInfo settlementInfo) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		settlementInfo.setLanguage(language);
		
		List<LinkedHashMap<String, String>> excelList = settlementMapper.listExcel(settlementInfo);
		return excelList;
	}

	public int getSettlementByDailyCount(SettlementInfo settlementInfo) {
		return settlementMapper.getSettlementByDailyCount(settlementInfo);
	}

	public List<SettlementInfo> getSettlementByDailyList(SettlementInfo settlementInfo) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		settlementInfo.setLanguage(language);
		
		List<SettlementInfo> settlementList = settlementMapper.getSettlementByDailyList(settlementInfo);
		return settlementList;
	}

	/*
	 *   해당 검색 결과의 총 합을 가져온다.
	 */
	public SettlementInfo getSettlementByDailyInfo(SettlementInfo settlementInfo) {
		SettlementInfo sInfo =  settlementMapper.getSettlementByDailyInfo(settlementInfo);
		sInfo.setStart_date(settlementInfo.getStart_date());
		sInfo.setEnd_date(settlementInfo.getEnd_date());
		return sInfo;
	}

	public List<SettlementInfo> getSettlementByItemList(SettlementInfo settlementInfo) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		settlementInfo.setLanguage(language);
		
		List<SettlementInfo> settlementList = settlementMapper.getSettlementByItemList(settlementInfo);
		return settlementList;
	}

	public int getSettlementByItemCount(SettlementInfo settlementInfo) {
		return settlementMapper.getSettlementByItemCount(settlementInfo);
	}

	public SettlementInfo getSumByItem(SettlementInfo settlementInfo) {
		SettlementInfo sInfo = settlementMapper.getSumByItem(settlementInfo);
		sInfo.setStart_date(settlementInfo.getStart_date());
		sInfo.setEnd_date(settlementInfo.getEnd_date());
		return sInfo;
	}

	public int getSettlementReqCount(SettlementInfo settlementInfo) {
		return settlementMapper.getSettlementReqCount(settlementInfo);
	}

	public List<OrderInfoMgmt> getSettlementReqList(SettlementInfo settlementInfo) {
		return settlementMapper.getSettlementReqList(settlementInfo);
	}

	public String insertCalculInfo(SettlementInfo settlementInfo) {
		// PROD_ORDER_SEQ 정보로 정산내역데이터 생성
		int successNum = 0;
		List<String> prodOrderSeqList = settlementInfo.getProdOrderSeq();
		for(String prodOrderSeq:prodOrderSeqList){
			SettlementInfo sInfo = new SettlementInfo();
			sInfo.setProd_order_seq(prodOrderSeq);
			sInfo.setCalcul_fee_div("prod");
			sInfo.setCalcul_sts_cd("SR");
			sInfo.setCalcul_pre_datetime(HolidayUtil.getBusinessDay(2, "yyyy-MM-dd"));
			successNum += settlementMapper.insertCalculInfo(sInfo);
			logger.debug("INSERT CALCUL INFO :::::");
			
			// 현재 prodOderSeq로 주문순번을 가져와서 정산정보에 배송비항목이 있는지 체크
			settlementInfo.setProd_order_seq(prodOrderSeq);
			if(settlementMapper.chkDlvyInCalcul(settlementInfo) < 1){
				// 배송비 항목이 존재하지 않으면
				// 같은 상품 주문 순번을 사용하여 정산항목 생성
				SettlementInfo sDlvyInfo = new SettlementInfo();
				sDlvyInfo.setProd_order_seq(prodOrderSeq);
				sDlvyInfo.setCalcul_fee_div("deliv");
				sDlvyInfo.setCalcul_sts_cd("SR");
				sDlvyInfo.setCalcul_pre_datetime(HolidayUtil.getBusinessDay(2, "yyyy-MM-dd"));
				successNum += settlementMapper.insertCalculInfo(sDlvyInfo);
				logger.debug("INSERT CALCUL INFO DELIVERY :::::");
			}
		}
		
		if(successNum >= prodOrderSeqList.size()){
			return "success";			
		}else
			return "fail";
	}

	public List<LinkedHashMap<String, String>> itemDetailListExcel(SettlementInfo settlementInfo) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		settlementInfo.setLanguage(language);
		return settlementMapper.itemDetailListExcel(settlementInfo);
	}

	public List<LinkedHashMap<String, String>>  dailyListExcel(SettlementInfo settlementInfo) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		settlementInfo.setLanguage(language);
		return settlementMapper.dailyListExcel(settlementInfo);
	}

	public List<SettlementHistInfo> getCalculHistList(SettlementInfo settlementInfo) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		settlementInfo.setLanguage(language);
		return settlementHistMapper.getCalculHistList(settlementInfo);
	}

	public SettlementInfo getCalculDetail(SettlementInfo settlementInfo) {
		return settlementMapper.getCalculDetail(settlementInfo);
	}
}
