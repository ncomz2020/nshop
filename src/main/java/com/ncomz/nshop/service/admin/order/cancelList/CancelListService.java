package com.ncomz.nshop.service.admin.order.cancelList;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nshop.dao.admin.order.orderList.OrderListMapper;
import com.ncomz.nshop.domain.admin.order.OrderInfoMgmt;

@Service
public class CancelListService {
	@Autowired
	private OrderListMapper orderListMapper;
	
	/**한달전
	 * @return
	 */
	public String getStartDate() {
		return orderListMapper.getStartDate();
	}
	
	/**오늘날짜
	 * @return
	 */
	public String getEndDate() {
		return orderListMapper.getEndDate();
	}
	
	/**주문내역 총 갯수 
	 * @return
	 */
	public int getOrderInfoCount(OrderInfoMgmt orderInfoMgmt){
		setObjectStsList(orderInfoMgmt);
		return orderListMapper.getOrderCount(orderInfoMgmt);
	}
	
	
	/**주문취소내역 row 수
	 * @return
	 */
	public List<String> getCancelOrderRowCount(OrderInfoMgmt orderInfoMgmt){
		List<OrderInfoMgmt> list = getCancelOrderInfoList(orderInfoMgmt);
		List<String> str = new ArrayList<String>();
		if(list.size() > 0){
			String preSeq = list.get(0).getOrder_seq();
			String curSeq = "";
			int cnt = 1;
			
			for(int i = 1; i < list.size(); i++){
				curSeq = list.get(i).getOrder_seq();
				if(preSeq.equals(curSeq)){
					cnt++;
				}else{
					str.add(cnt+"");
					cnt = 1;
					preSeq = curSeq;
				}
			}
			str.add(cnt+"");
		}
		return str;
	}
	
	/**취소주문내역 목록
	 * @return
	 */
	public List<OrderInfoMgmt> getCancelOrderInfoList(OrderInfoMgmt orderInfoMgmt){
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		orderInfoMgmt.setLanguage(language);

		setObjectStsList(orderInfoMgmt);
		
		return orderListMapper.getCancelOrderlist(orderInfoMgmt);
	}
	
	/**주문상태 조건 설정 영역
	 * @return
	 */
	public OrderInfoMgmt setObjectStsList(OrderInfoMgmt orderInfoMgmt){
		
		List<String> objectList = new ArrayList<String>();
			
		String order_sts_cd = orderInfoMgmt.getSts_cd();
		if(StringUtils.isNotEmpty(order_sts_cd)){
			String[] arrStsList = order_sts_cd.split(",");
			for(String sts_cd : arrStsList){
				objectList.add(sts_cd);
			}
			orderInfoMgmt.setObjectList(objectList);
		}
		return orderInfoMgmt;
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
				
				if (orderListMapper.statusModifyAction(orderInfoMgmt) <= 0) {
					throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
				}else{
					orderListMapper.insertOrderHist(orderInfoMgmt);	
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
