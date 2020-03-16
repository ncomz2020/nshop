<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src='/js/tinymce/tinymce.min.js'></script>
<script src="/js/jquery.form.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>
.mce-edit-area {
	border-width: 0px !important;
}
</style>
<script type="text/javascript">
	var pageType = '';
	$(document).ready(function() {
		IMP.init('imp44626297'); //iamport 대신 자신의 "가맹점 식별코드"를 사용하시면 됩니다
		 
 
	});
 
	function pay(){
		
		IMP.request_pay({
		    pg : 'inicis', // version 1.1.0부터 지원.
			pay_method : 'card',
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : '결제테스트',
			amount : 100,
			escrow : true,
			buyer_email : 'iamport@siot.do',
			buyer_name : '구매자',
			buyer_tel : '010-1234-5678',
			buyer_addr : '서울특별시 강남구 삼성동',
			buyer_postcode : '123-456',
			m_redirect_url : 'https://www.yourdomain.com/payments/complete'   ,// 모바일 결제시 redirect 페이지
				card_quota : [2,3,4,5,6]
		}, function(rsp) {
			console.log(rsp)
			  console.log($('.tit').text())
		       if ( rsp.success ) {
		    	   console.log($('.tit').text())
		           var msg = '결제가 완료되었습니다.';
		           msg += '고유ID : ' + rsp.imp_uid;
		           msg += '상점 거래ID : ' + rsp.merchant_uid;
		           msg += '결제 금액 : ' + rsp.paid_amount;
		           msg += '카드 승인번호 : ' + rsp.apply_num;
		           
		           //폼 action 실행
		      //    $("#_payFrm").attr("action", "afPayView.do").submit();
		       } else {
		           var msg = '결제에 실패하였습니다.';
		           msg += '에러내용 : ' + rsp.error_msg;
		       }
		       //alert(msg);
		   } );
	}
	</script>
</head>
<body>
 	<div id="contentWrap" class="contentWrap">
		<div id="content" class="content wrap productDetail">
			<form id="prodForm" name="prodForm" method="post">
			 	
			</form>
			<div class="rowBox mgT30 data">
				<div class="g_column w_1_1">
					<h3>
						<span class="title">주문정보</span>
						 
					</h3>
					<div class="unitBox">
						<table class="amb_table">
							<colgroup>
								<col style="width: 40%;" />
								<col style="width: 20%;" />
								<col style="width: 10%;" />
								<col style="width: 10%;" />
								<col style="width: 20%;" />  
							</colgroup>
							<thead>
								<tr class="colHeaders">
									<th>상품정보</th>
									<th>상점</th>
									<th>배송비</th>
									<th>수량</th>
									<th>주문금액</th>
								</tr>
							</thead>
							<tbody>
			
								<c:forEach items="${list}" var="storeInfo" varStatus="status">
									<tr>
										<td>${storeInfo.rownum}</td>
										<td style="text-align: left;">
											<div style="width: 50px; height: 50px; overflow: hidden;position:relative;">
												<img src="/common/file/downloadImage/<c:if test="${not empty storeInfo.store_logo}">${storeInfo.store_logo}</c:if><c:if test="${empty storeInfo.store_logo}">noImage</c:if>" 
												onload="javascript:initImage(this);" style="cursor: pointer; height: 50px; width: 50px; margin-left: 0px;">
											</div>
										</td>
										<td>
											<a href="javascript:;" onclick="detailView('${storeInfo.store_id}');">${storeInfo.store_name}<br />(${storeInfo.store_id})</a>
										</td>
										<td>${storeInfo.comp_name}<br />
											<c:if test="${not empty storeInfo.comp_reg_num}">
											(${storeInfo.comp_reg_num})
											</c:if>
										</td>
										<td>${storeInfo.president_name}</td>
										<td>${storeInfo.reg_datetime}</td>
										<td>
											<div class="stateBox2 before2">
												<span class="state">${storeInfo.approval_stat_text}</span>
												<c:if test="${storeInfo.approval_stat eq 'R' and session_user.usr_grp_id eq 1}">
													<button type="button" onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','Y','approval_stat');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.store.approve"/></button>
												</c:if>
												<c:if test="${storeInfo.approval_stat eq 'Y' and session_user.usr_grp_id eq 1}">
													<button type="button" onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','F','approval_stat');" class="amb_btnstyle red middle stateEdit"><spring:message code="label.store.approve.cancel"/></button>
												</c:if>
											</div>
										</td>
										<td>
											<div class="stateBox2 before2">
												<span class="state">${storeInfo.operational_stat_text} </span>
												<c:if test="${storeInfo.approval_stat eq 'Y'}">
													<c:if test="${storeInfo.operational_stat eq 'Y' and session_user.usr_grp_id eq 1}">
														<button type="button" onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','N','operational_stat');" class="amb_btnstyle red middle stateEdit"><spring:message code="label.store.operate.off_2"/></button>
													</c:if>
													<c:if test="${storeInfo.operational_stat eq 'N' and session_user.usr_grp_id eq 1}">
														<button type="button" onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','Y','operational_stat');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.store.operate" /></button>
													</c:if>
												</c:if>
											</div>
										</td>
									</tr>
								</c:forEach>
								<c:if test="${empty list}">
									<tr class="odd" style="cursor: default;">
										<td align="center" colspan="5">
											<spring:message code="label.common.empty.list" />
										</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
			
					<div class="paging center">
						<ul class="paginglist">
							<jsp:include page="/WEB-INF/views/include/paging.jsp" />
						</ul>
					</div>
					<!-- 페이징 end -->
				</div>
			</div>
			
		</div>
	 


	</div> 
	<!-- rowBox 반복단위 -->

</body>