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
	
	
function statusModifyAction(){
		
		if ($("input[name=checkboxList]:checkbox:checked").length < 1) {
			swal({
				title: '<spring:message code="label.calculation.settlement.stat.valid.check"/>',
			    type: "error"
			});
			return;
		}
		
		if (isEmpty($("#modify_status option:selected").val())) {
			swal({
				title: '<spring:message code="label.product.prod.valid.check.state"/>',
			    type: "error"
			});
			return;
		}
		
		
		var statChk = false;
		var arrCalcSeq = [];
		$('input[name="checkboxList"]').each(function() {
			var checkedStatus = this.checked;
			if (checkedStatus) {
				var calcul_seq = $(this).val();
				arrCalcSeq.push(calcul_seq);
				
				var lastStsCd = $("#trCalcSeq_"+calcul_seq).find("#calcul_sts_cd").val();
				if(lastStsCd == $("#modify_status option:selected").val()){
					statChk = true;
				}
			}
		});
		
		if(statChk){
			swal({
				title: '이전 주문상태와 변경할 주문상태가 같은 내역이 존재합니다.',
			    type: "error"
			});
			return;
		}
		
		
		var param = new Object();
		param.calcul_seq = arrCalcSeq.join();
		param.calcul_sts_cd = $("#modify_status option:selected").val();
		param.calcul_sts_nm = $("#modify_status>option:selected").html();
		
		openModal('./stateModifyPopup' , 'stateModifyPopup' , param , '');
	}

	function goExcel() {
		if("${count}" == 0){
			swal({
				title: '<spring:message code="label.common.empty.list"/>',
			    type: "error"
			});
			return; 
		}
		
		var param = $('#calcRequestListForm').serialize();
		$.download('exportAction.ajax', param, 'post');
	}
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code="label.calculation.settlementManagementList"/>
			: <em class="pColor_01">&nbsp;&nbsp;총 ${count}건</em>
			</span>
			<div class="fr btnArea middle">
				<a href="javascript:goExcel();" class="amb_btnstyle white middle"><spring:message code="label.common.export.excel"/></a>
			</div>
		</h3>
		<div class="unitBox" style="">
			<table class="amb_table">
				<colgroup>
					<col style="width: 3%" />
					<col style="width: 5%;" />
					<col style="width: 10%" />
					<col style="width: 15%" />
					<col style="width: 10%" />
					<col style="width: 7%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 7%" />
				</colgroup>
				<thead>
					<tr>
						<th class="center"><input type="checkbox" id="checkboxListAll" name="checkboxListAll"><label for="checkboxListAll" class="inp_func"></label></th>
						<th class="center">no</th>
						<th class="center"><spring:message code="label.store.id"/><br>(<spring:message code="label.store.name"/>)</th>							<!-- 상점명 -->
						<th class="center"><spring:message code="label.order.productOrderNumber"/></th>
						<th class="center">주문금액</th>
						<th class="center">구매자ID<br>(구매자명)</th>
						<th class="center"><spring:message code="label.calculation.settlementRequest.date"/></th>
						<th class="center"><spring:message code="label.calculation.settlementScheduled.date"/></th>
						<th class="center"><spring:message code="label.calculation.settlementCompletion.date"/></th>
						<th class="center"><spring:message code="label.calculation.settlementStatus"/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="info" varStatus="status">
						<tr id="trCalcSeq_${info.calcul_seq}">
							<td>
								<c:if test="${info.calcul_sts_cd eq 'SPC'}">
									<%-- <input type="checkbox" id="check_${info.rownum}" name="checkboxList" value="${info.calcul_seq}" >
									<label for="check_${info.rownum}" class="inp_func"></label> --%>
								</c:if>
								<c:if test="${info.calcul_sts_cd ne 'SPC'}">
									<input type="checkbox" id="check_${info.rownum}" name="checkboxList" value="${info.calcul_seq}">
									<label for="check_${info.rownum}" class="inp_func"></label>
								</c:if>
							</td>
							<td>${info.rownum}</td>
							<td>
								${info.store_id}<br>(${info.store_name})
							</td>
							<td>
								${info.prod_order_no}
							</td>
							<td><fmt:formatNumber value="${info.payment_amt}" pattern="#,###" />&nbsp;원
							</td>
							<td>${info.user_id}<br>(${info.user_nm})</td>
							<td>
								${info.calcul_req_datetime}
							</td>
							<td>
								${info.calcul_pre_datetime}
							</td>
							<td>
								${info.pay_fin_datetime}
							</td>
							<td>
								${info.calcul_sts_cd_nm}
								<input type="hidden" id="calcul_sts_cd" value="${info.calcul_sts_cd}">
							</td>
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
			<c:if test="${userGrup eq 1}">
				<div class="fl btnArea middle">
					<select id="modify_status"></select>
					<a href="javascript:statusModifyAction();" class="amb_btnstyle blue middle"><spring:message code="label.common.change"/></a>
				</div>
			</c:if>
		</div>
	</div>
</div>
<!-- rowBox 반복단위 -->