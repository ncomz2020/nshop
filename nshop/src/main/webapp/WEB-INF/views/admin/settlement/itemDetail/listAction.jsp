<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
	$(document).ready(function() {
		selectBoxSetting();
		$('#checkboxListAll').click(function() {
			var checkedStatus = this.checked;
			$('input[name="checkboxList"]').each(function() {
				$(this).prop('checked', checkedStatus);
			});
		});
	});
	

	function selectBoxSetting() {
		var statusModifySelectBox = [ {
			'codeType' : 'commCode',
			'grp_cd' : 'SETTLEMENT_STAT',
			'selectId' : 'modify_status',
			'defaultName' : '<spring:message code="label.calculation.settlementStatus.select"/>'
		} ];

		// 판매상태 변경조건
		callAajaxJson(statusModifySelectBox);
	}


	function goExcel() {
		if("${count}" == 0){
			swal({
				title: '<spring:message code="label.common.empty.list"/>',
			    type: "error"
			});
			return; 
		}
		
		var param = $('#calculItemListForm').serialize();
		$.download('exportAction.ajax', param, 'post');
	}
	
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<c:if test="${not empty sum }">
		<div class="unitBox" style="">
			<table class="amb_table">
				<colgroup>
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 7%" />
					<col style="width: 10%" />
					<col style="width: 7%" />
					<col style="width: 10%" />
				</colgroup>
				<tbody>
						<tr>
							<th><spring:message code="label.calculation.settlementRequest.date"/>: </span>
							<td colspan="5"  style="text-align: left;">${sum.start_date } ~ ${sum.end_date }</td>
						</tr>
						<tr>
							<th>총 정산금액(A-B)</th>
							<td style="text-align: left;"><fmt:formatNumber value="${sum.calcul_amt}" pattern="#,###" />&nbsp;원</td>
							<th>판매금액(A)</th>
							<td style="text-align: left;"><fmt:formatNumber value="${sum.payment_amt}" pattern="#,###" />&nbsp;원</td>
							<th><spring:message code="label.calculation.settlementFee"/>(B)</th>
							<td style="text-align: left;"><fmt:formatNumber value="${sum.charge_fee}" pattern="#,###" />&nbsp;원</td>
						</tr>
				</tbody>
			</table>
		</div>
		</c:if>
	</div>
</div>
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code="label.calculation.settlementDetailList"/>
			: <em class="pColor_01">&nbsp;&nbsp;총 ${count}건</em>
			</span>
			<div class="fr btnArea middle">
				<a href="javascript:goExcel();" class="amb_btnstyle white middle"><spring:message code="label.common.export.excel"/></a>
			</div>
		</h3>
		<div class="unitBox" style="">
			<table class="amb_table">
				<colgroup>
					<col style="width: 5%" />
					<col style="width: 10%;" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 4%" />
					<col style="width: 10%" />
					<col style="width: 5%" />
					<col style="width: 7%" />
					<col style="width: 7%" />
					<col style="width: 7%" />
				</colgroup>
				<thead>
					<tr>
						<th class="center">no</th>
						<th class="center"><spring:message code="label.store.id"/><br>(<spring:message code="label.store.name"/>)</th>							<!-- 상점명 -->
						<th class="center"><spring:message code="label.order.orderNumber"/></th>
						<th class="center"><spring:message code="label.order.productOrderNumber"/></th>
						<th class="center"><spring:message code="label.calculation.orderClassification"/></th>
						<th class="center"><spring:message code="label.calculation.settlementAmount"/></th>
						<th class="center"><spring:message code="label.calculation.settlementStatus"/></th>
						<th class="center"><spring:message code="label.calculation.settlementRequest.date"/></th>
						<th class="center"><spring:message code="label.calculation.settlementScheduled.date"/></th>
						<th class="center"><spring:message code="label.calculation.settlementCompletion.date"/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="info" varStatus="status">
						<tr>
							<td>${info.rownum}</td>
							<td>${info.store_id}<br>(${info.store_name})</td>
							<%-- <td>${info.order_no}</td> --%>
							<td><a href="#" onclick="javascript:openModal('/admin/order/orderList/detailPopup.ajax' , 'orderDetailPopup' , 'order_seq=${info.order_seq}' , '900');">${info.order_no}</a></td>
							<td>${info.prod_order_no}</td>
							<td>${info.calcul_fee_div_nm}</td>
							<td><a href="#" onclick="javascript:openModal('./calculDetailPopup.ajax' , 'calculDetailPopup' , 'calcul_seq=${info.calcul_seq}' , '700');"><fmt:formatNumber value="${info.calcul_amt}" pattern="#,###" />&nbsp;원</a></td>
							<td>${info.calcul_sts_cd_nm}</td>
							<td>${info.calcul_req_datetime}</td>
							<td>${info.calcul_pre_datetime}</td>
							<td>${info.pay_fin_datetime}</td>
						</tr>
					</c:forEach>
					<c:if test="${empty list}">
						<tr>
							<td colspan="10"><spring:message code="label.common.empty.list"/></td>
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
	</div>
</div>
<!-- rowBox 반복단위 -->