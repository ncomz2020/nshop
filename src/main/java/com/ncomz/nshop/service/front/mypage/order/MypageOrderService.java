package com.ncomz.nshop.service.front.mypage.order;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nshop.dao.front.mypage.order.MypageOrderMapper;
import com.ncomz.nshop.domain.admin.order.OrderInfoMgmt;

@Service
public class MypageOrderService {
	@Autowired
	private MypageOrderMapper mypageOrderMapper;
	
	/**한달전
	 * @return
	 */
	public String getStartDate() {
		return mypageOrderMapper.getStartDate();
	}
	
	/**오늘날짜
	 * @return
	 */
	public String getEndDate() {
		return mypageOrderMapper.getEndDate();
	}
	
	/**주문내역 총 갯수 
	 * @return
	 */	
	public int getFrontOrderCount(OrderInfoMgmt orderInfoMgmt){
		setFrontObjectStsList(orderInfoMgmt);
		return mypageOrderMapper.getFrontOrderCount(orderInfoMgmt);
	}
	
	/**주문내역 목록
	 * @return
	 */
	public List<OrderInfoMgmt> getFrontOrderInfoList(OrderInfoMgmt orderInfoMgmt){
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		orderInfoMgmt.setLanguage(language);
			
		setFrontObjectStsList(orderInfoMgmt);
		
		return mypageOrderMapper.getFrontOrderlist(orderInfoMgmt);
	}
	
	/**주문상태 조건 설정 영역
	 * @return
	 */
	public OrderInfoMgmt setFrontObjectStsList(OrderInfoMgmt orderInfoMgmt){
		
		List<String> objectList = new ArrayList<String>();
		
		String order_sts_cd = orderInfoMgmt.getSts_cd();
		
		if(order_sts_cd.equals("100"))
			order_sts_cd = "110,120";
		else if(order_sts_cd.equals("200"))
			order_sts_cd = "210,220,230,240,250,260,270";
		else if(order_sts_cd.equals("300"))
			order_sts_cd = "310,320,330,340,350";
			
		if(StringUtils.isNotEmpty(order_sts_cd)){
			String[] arrStsList = order_sts_cd.split(",");
			for(String sts_cd : arrStsList){
				objectList.add(sts_cd);
			}
			orderInfoMgmt.setObjectList(objectList);
		}
		return orderInfoMgmt;
	}
	
	/**주문내역 상세
	 * @return
	 */
	public List<OrderInfoMgmt> getOrderInfo(OrderInfoMgmt orderInfoMgmt) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		orderInfoMgmt.setLanguage(language);
		return mypageOrderMapper.getOrderInfo(orderInfoMgmt);
	}
	
	/**환불금액 계산
	 * @return
	 */
	public OrderInfoMgmt getRefundCalc(OrderInfoMgmt orderInfoMgmt) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		orderInfoMgmt.setLanguage(language);
		List<OrderInfoMgmt> list = new ArrayList<OrderInfoMgmt>();
		int price = 0;
		int dlvy = 0;
		String refundChk = "";
		
		list = mypageOrderMapper.getOrderInfo(orderInfoMgmt);
		
		if(list.size() > 0){
			String preSeq = list.get(0).getStore_id();
			String curSeq = "";
			int cnt = 1;
			int dlvyCnt = 1;
			
			for(int i = 0; i < list.size(); i++){
				if(i == 0){
					cnt++;
					if(statusChk(list.get(i).getOrder_sts_cd())){
							price += Integer.parseInt(list.get(i).getPayment_amt());
							dlvyCnt++;
							refundChk="R";
						}
				}else{
					curSeq = list.get(i).getStore_id();
					if(preSeq.equals(curSeq)){ 
						cnt++;
						if(statusChk(list.get(i).getOrder_sts_cd())){
								price += Integer.parseInt(list.get(i).getPayment_amt());
								dlvyCnt++;
								refundChk="R";
							}
						
					}else{
						if(cnt == dlvyCnt)
							dlvy += 2500;
						
						cnt = 1;
						dlvyCnt = 1;
						preSeq = curSeq;
						
						cnt++;
						if(statusChk(list.get(i).getOrder_sts_cd())){
								price += Integer.parseInt(list.get(i).getPayment_amt());
								dlvyCnt++;
								refundChk="R";
							}
					}
				}
			}
			if(cnt == dlvyCnt)
				dlvy += 2500;

			orderInfoMgmt.setList_sts_cd(refundChk);
			orderInfoMgmt.setDlvy_amt(dlvy+"");
			orderInfoMgmt.setPayment_amt(price+"");
		}
		
		return orderInfoMgmt;
	}
	
	/**
	 * 주문상태 체크
	 * */
	public boolean statusChk(String code){
		if(code.equals("110") || code.equals("120") ||  code.equals("310") ||  code.equals("320") ||  code.equals("330"))
			return true;
		else
			return false;
	}
	
	
	/**
	 * 배송지 변경Action
	 * @param 
	 * @return
	 */
	@Transactional
	public String modifyAddrAction(OrderInfoMgmt orderInfoMgmt) {
		try {
			if (mypageOrderMapper.addrModifyAction(orderInfoMgmt) <= 0) {
				throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
			}
			
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	/**
	 * 주문상태 변경 저장
	 * @param 
	 * @return
	 */
	@Transactional
	public String statusModifyAction(OrderInfoMgmt orderInfoMgmt) {
		try {
			if(!StringUtils.isEmpty(orderInfoMgmt.getProd_order_seq()))
			{
				List<String> objectOrderSeqList = new ArrayList<String>();
				
				String prod_order_seq = orderInfoMgmt.getProd_order_seq();
				if(StringUtils.isNotEmpty(prod_order_seq))
				{
					String[] arrOrderSeq = prod_order_seq.split(",");
					for(String order_id : arrOrderSeq){
						objectOrderSeqList.add(order_id);
					}
					orderInfoMgmt.setObjectOrderSeqList(objectOrderSeqList);
				}
				
				if(mypageOrderMapper.statusChangeCount(orderInfoMgmt) >= 1)
					throw new Exception("교환 및 반품 이력이 존재합니다.\n 교환 및 반품은 각 1회씩 가능합니다.");
				
				if (mypageOrderMapper.statusModifyAction(orderInfoMgmt) <= 0) {
					throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
				}else{
					mypageOrderMapper.insertOrderHist(orderInfoMgmt);	
					if(StringUtils.isNotEmpty(orderInfoMgmt.getChng_rsn())){ //취소,교환,반품시 insert
						mypageOrderMapper.insertChangeRsn(orderInfoMgmt);
					}
				}
			}
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	/**
	 * 구매확정 저장
	 * 배송완료->구매완료, 교환배송완료->교환완료
	 * @param 
	 * @return
	 */
	@Transactional
	public String confirmationAction(OrderInfoMgmt orderInfoMgmt) {
		try {
			if(!StringUtils.isEmpty(orderInfoMgmt.getProd_order_seq()))
			{
				List<String> objectOrderSeqList = new ArrayList<String>();
				
				String prod_order_seq = orderInfoMgmt.getProd_order_seq();
				int updateCnt = 0;
				if(StringUtils.isNotEmpty(prod_order_seq))
				{
					String[] arrOrderSeq = prod_order_seq.split(",");
					for(String order_id : arrOrderSeq){
						objectOrderSeqList.add(order_id);
					}
					orderInfoMgmt.setObjectOrderSeqList(objectOrderSeqList);
				}
				
				if(orderInfoMgmt.getPopupType().equals("C")){//구매확정일 경우
					orderInfoMgmt.setOrder_sts_cd("050");//배송완료->구매완료
					orderInfoMgmt.setOrder_sts_name("040");
					updateCnt += mypageOrderMapper.confirmationAction(orderInfoMgmt);
					
					orderInfoMgmt.setOrder_sts_cd("250");//교환배송완료->교환완료
					orderInfoMgmt.setOrder_sts_name("240");
					updateCnt += mypageOrderMapper.confirmationAction(orderInfoMgmt);
				}else if(orderInfoMgmt.getPopupType().equals("R")){//교환/반품 철회인 경우
					orderInfoMgmt.setOrder_sts_cd("050");
					updateCnt += mypageOrderMapper.statusModifyAction(orderInfoMgmt);
				}
				
				if (updateCnt <= 0) {
					throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
				}else{
					mypageOrderMapper.insertConfOrderHist(orderInfoMgmt);	
				}
			}
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
}
