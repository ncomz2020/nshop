package com.ncomz.nshop.dao.front.mypage.order;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.order.OrderInfoMgmt;

@Component
public interface MypageOrderMapper {	
	/* 날짜 설정 */
	String getEndDate();
	String getStartDate();

	int getFrontOrderCount(OrderInfoMgmt orderInfoMgmt);//주문내역 개수 조회
	List<OrderInfoMgmt> getFrontOrderlist(OrderInfoMgmt orderInfoMgmt); //주문 내역 리스트 조회	
	List<OrderInfoMgmt> getOrderInfo(OrderInfoMgmt orderInfoMgmt); //주문상세정보 조회
	List<OrderInfoMgmt> getOrderDtlInfo(OrderInfoMgmt orderInfoMgmt); //주문배송지 정보 조회	
	int statusChangeCount(OrderInfoMgmt orderInfoMgmt); //교환반품 횟수 조회
	
	int insertOrderHist(OrderInfoMgmt orderInfoMgmt); //주문상태 변경내역 저장(취소신청, 교환반품 신청)
	int insertConfOrderHist(OrderInfoMgmt orderInfoMgmt); //주문상태 변경내역 저장(구매확정, 교환반품 철회)
	int insertChangeRsn(OrderInfoMgmt orderInfoMgmt); //취소,교환,반품 사유 저장
	
	int addrModifyAction(OrderInfoMgmt orderInfoMgmt); //배송지 변경
	int statusModifyAction(OrderInfoMgmt orderInfoMgmt); //주문상태 변경(취소신청, 교환반품 신청)
	int confirmationAction(OrderInfoMgmt orderInfoMgmt); //주문상태 변경(구매확정, 교환반품 철회)
}
