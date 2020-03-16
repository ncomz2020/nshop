<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
	$(document).ready(function() {
		$('#checkboxListAll').click(function() {
			var checkedStatus = this.checked;
			$('input[name="checkboxList"]').each(function() {
				$(this).prop('checked', checkedStatus);
			});
		});
		
		
	});
	
	function itemDetailView(date, store_id){
		
		var param = new Object();
		param.start_date = date;
		param.end_date = date;
		param.search_type = 'SN';
		param.search_txt = store_id;
		
		movePage('/admin/settlement/itemDetail/list',param);
	};

	function goExcel() {
		if("${count}" == 0){
			swal({
				title: '<spring:message code="label.common.empty.list"/>',
			    type: "error"
			});
			return; 
		}
		
		var param = $('#calculDailyListForm').serialize();
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
							<th><spring:message code="label.calculation.settlementRequest.date"/></th>
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
					<col style="width: 5%;" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 5%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<%-- <col style="width: 10%" /> --%>
					<col style="width: 7%" />
					<col style="width: 10%" />
				</colgroup>
				<thead>
					<tr>
						<th rowspan="2" class="center">no</th>
						<th rowspan="2" class="center"><spring:message code="label.store.id"/><br>(<spring:message code="label.store.name"/>)</th>							<!-- 상점명 -->
						<th rowspan="2" class="center"><spring:message code="label.calculation.settlementCompletion.date"/></th>
						<th rowspan="2" class="center"><spring:message code="label.calculation.settlementCount"/></th>
						<th rowspan="2" class="center"><spring:message code="label.calculation.settlementAmount"/></th>
						<th colspan="2" class="center"><spring:message code="label.calculation.settlementDetail"/></th>
						<th rowspan="2" class="center"><spring:message code="label.calculation.settlementMethod"/></th>
						<th rowspan="2" class="center"><spring:message code="label.calculation.settlementAccount"/></th>
					</tr>
					<tr>
						<th class="center">주문금액</th>
						<th class="center"><spring:message code="label.calculation.settlementFee"/></th>
						<%-- <th ><spring:message code="label.calculation.settlementRefund"/></th> --%>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="info" varStatus="status">
						<tr>
							<td>${info.rownum}</td>
							<td>
								${info.store_id}<br>(${info.store_name})
							</td>
							<%-- <td>
								<a href="javascript:;" onclick="itemDetailView('${info.calcul_pre_datetime}','${info.store_id}');">${info.calcul_pre_datetime}</a>
							</td> --%>
							<td>
								<a href="javascript:;" onclick="itemDetailView('${info.pay_fin_datetime}','${info.store_id}');">${info.pay_fin_datetime}</a>
							</td>
							<td>${info.settlement_count}</td>
							<td><fmt:formatNumber value="${info.calcul_amt}" pattern="#,###" />&nbsp;원</td>
							<td><fmt:formatNumber value="${info.payment_amt}" pattern="#,###" />&nbsp;원</td>
							<td><fmt:formatNumber value="${info.charge_fee}" pattern="#,###" />&nbsp;원</td>
							<!-- <td>0</td> -->
							<td>계좌이체</td>
							<td>${info.bank_cd_nm}/${info.account_no}</td>
						</tr>
					</c:forEach>
					<c:if test="${empty list}">
						<tr>
							<td colspan="9"><spring:message code="label.common.empty.list"/></td>
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