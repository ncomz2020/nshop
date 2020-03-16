
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	$(document).ready(function() {
		fnFeeCalculation();
	});
	
	function fnFeeCalculation(){
		var paymentWayCd = '${info.payment_way_cd}';
		var cahrgeFee ='${info.charge_fee}';
		var calculAmt ='${info.calcul_amt}';
		var calculFeeDiv = '${info.calcul_fee_div}';
		var percent = 0;
		var totalFee = 0;
		
		// 결제수단에따른 수수료 계산, 결제수수료는 배송비/상품 구분없이 계산된다.
		if(paymentWayCd == '10'){
			totalFee += fnCalculationFee("결제수수료", '3.74');
		}else if(paymentWayCd == '20'){
			totalFee += fnCalculationFee("결제수수료", '3.83');
		}
		if(calculFeeDiv == 'prod'){
			totalFee += fnCalculationFee("서비스수수료", '5');
		}
		
		$("#totalFee").text(number_format(totalFee)+' 원');
	}
	
	function fnCalculationFee(feeDivStr,percent){
		var paymentAmt ='${info.payment_amt}';
		var html="";
		var result = Math.floor(paymentAmt*(percent/100));
		html += '<tr>';
		html += '<td>'+feeDivStr;
		html += '</td>';
		html += '<td>'+percent+"%";
		html += '</td>';
		html += '<td>'+ number_format(result) + ' 원';
		html += '</td>';
		html += '</tr>';
		$("#feeBody").append(html);
		return result;
	}
	function number_format(x){
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
</script>

<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">

	<div class="modal-content">

		<!-- 실제 컨텐츠 작업부분 -->
		<h1 class="popupHeader">
			<span class="title">정산 상세내역</span>
			<a href="#" class="close" onClick="javascript:closeModal(this);"><i class="ambicon-015_mark_times"></i></a>
		</h1>

		<div class="content">		
			<div class="rowBox">
				<h3>
					<span class="title">정산상세내역</span>
				</h3>
				<div class="unitBox">
					<table class="amb_form_table lineAll">
						
					</table>
				</div>
				<div class="g_column w_2_1">
					<div class="unitBox">
						<table class="amb_table lineAll">
							<colgroup>
								<col style="width:15%;" /> 
								<col style="width:35%;" /> 
							</colgroup>
							<tr>
								<th>주문번호</th>
								<td>${info.order_no}</td>
							</tr>
							<tr>
								<th>상품주문번호</th>
								<td>${info.prod_order_no}</td>
							</tr>
							<tr>
								<th>주문일시</th>
								<td>${info.order_datetime}</td>
							</tr>
							<tr>
								<th>결제수단</th>
								<td>${info.payment_way_cd_nm}</td>
							</tr>
							<tr>
								<th>정산구분</th>
								<td>${info.calcul_fee_div_nm}</td>
							</tr>
							<tr>
								<th>결제금액(A)</th>
								<td><fmt:formatNumber value="${info.payment_amt}" pattern="#,###" />원</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="g_column w_2_1">
					<div class="unitBox">
						<table class="amb_table lineAll">
							<colgroup>
								<col style="width:15%;" /> 
								<col style="width:10%;" /> 
								<col style="width:20%;" /> 
							</colgroup>
							<thead>
								<tr>
									<th>수수료항목</th>
									<th>수수료율</th>
									<th>수수료 금액</th>
								</tr>
							</thead>
							<tbody id="feeBody">
							
							</tbody>
							<tfoot>
								<tr>
									<th colspan="2">
										수수료합계 (B)
									</th>
									<td id="totalFee"></td>
								</tr>
								<tr>
									<th colspan="2">정산금액 (A-B)</th>
									<td><fmt:formatNumber value="${info.calcul_amt}" pattern="#,###" />원</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			</div>
			<div class="rowBox mgT30">
				<div class="unitBox">
					<h3>
						<span class="title">정산상태 변경이력</span>
					</h3>
					<div class="tableWrapBox" style="height: 200px;">
						<table class="amb_table theadFix" data-role-height="100%">
							<colgroup>
								<col style="width:10%;" /> 
								<col style="width:10%;" /> 
								<col style="width:10%;" /> 
								<col style="width:40%;" /> 
							</colgroup>
							<thead>
								<tr>
									<th>변경일시</th>
									<th>변경자</th>
									<th>변경상태</th>
									<th>메모</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${info.calcul_req_datetime}</td>
									<td>${info.store_id}</td>
									<td>정산요청</td>
									<td class="left"></td>
								</tr>
								<c:forEach items="${histList}" var="hist" varStatus="status">
									<tr>
										<td>${hist.sts_update_datetime}</td>
										<td>${hist.updater_id}</td>
										<td>${hist.calcul_sts_cd_nm}</td>
										<td class="left">${hist.calcul_memo}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
				<div class="fr btnArea middle">
					<a href="#" id="btnCloseFoot" class="amb_btnstyle gray middle" onclick="javascript:closeModal(this);">닫기</a>
				</div>
		</div>
	</div>
</div>