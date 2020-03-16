<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<script>
	$(document).ready(function() {
		searchList(1);
		selectBoxSetting();
	});
	
	function searchList(page) {
	
		if(!checkParam()){
			return;
		}
		
		$("#page").val(page);
		var param = $('#calcRequestListForm').serialize();
		console.log(param);
		$.ajax({
			url : "listAction.ajax",
			type : "POST",
			data : param,
			success : function(data) {
				$("#listActionDiv").html(data);
			},
			error : function() {
				$.alertable.alert('<spring:message code="label.common.fail.action"/>');
			}
		});
	}
	
	function selectBoxSetting() {
		var statusSelectBox = [ {
			'codeType' : 'commCode',
			'grp_cd' : 'SETTLEMENT_STAT',
			'selectId' : 'search_status',
			'defaultName' : '<spring:message code="label.common.all"/>'
		} ];
		

		// 판매상태 조회조건
		callAajaxJson(statusSelectBox);
		
	}
	
	function setStartDate(period){
		var reg = new RegExp("m$", "g");
		var monthFlag = reg.test(period);
		var endDate = $("#end_date").val();
		var startDate = new Date(endDate);
		
		if(monthFlag){
			var month = period.split('m')[0];
			
			startDate.setMonth(startDate.getMonth()-month);
			$("#start_date").val(startDate.toISOString().substring(0, 10));
		}
		else{
			if(period=="0"){
				$("#start_date").val('<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />');
				$("#end_date").val('<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />');
			}else{
				startDate.setDate(startDate.getDate()-period);
				$("#start_date").val(startDate.toISOString().substring(0, 10));
			}
		}
	}
	
	function checkParam(){
		if(isEmpty($("#start_date").val())){
			$("#start_date").focus();
			swal('<spring:message code="label.common.chk.startdate"/>', "", "error");
			return false;
		}else if(isEmpty($("#end_date").val())){
			$("#end_date").focus();
			swal('<spring:message code="label.common.chk.enddate"/>', "", "error");
			return false;
		}
		return true;
	}

</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<form id="calcRequestListForm" name="calcRequestListForm">
			<input type="hidden" id="page" name="page">
			<div class="unitBox searchBox" style="">
				<table class="amb_form_table">
					<colgroup>
						<col style="width: 5%;" />
						<col style="width: 25%;" />
						<col style="width: 5%;" />
						<col style="width: 25%;" />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="label.calculation.settlementStatus"/></th>
							<td colspan="3">
								<select id="search_status" name="search_status"></select>
							</td>
						</tr>
						<tr>
							<th><spring:message code="label.calculation.settlementRequest.date"/><i class="bullet mandatory"></i>
								<input type="hidden" id="search_date_type" name="search_date_type" value="S_RD"> 
							</th>
							<td colspan="2">
								<span class="datepickerRange">
									<input type="text" id="start_date" name="start_date" class="inp datepicker startDate" readonly="readonly" value="<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />" style="width: 120px;" placeholder="date" />
									~
									<input type="text" id="end_date" name="end_date" class="inp datepicker endDate" readonly="readonly" value="<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />" style="width: 120px;" placeholder="date" />
								</span>
								<span>
									<button type="button" class="amb_btnstyle gray middle" onclick="setStartDate(0);">오늘</button>
									<button type="button" class="amb_btnstyle gray middle" onclick="setStartDate(3);">3일</button>
									<button type="button" class="amb_btnstyle gray middle" onclick="setStartDate(7);">1주일</button>
									<button type="button" class="amb_btnstyle gray middle" onclick="setStartDate('1m');">1개월</button>
								</span>
							</td>
							<td>
							</td>
						</tr>
						<tr>
							<th><spring:message code="label.common.search"/></th>
							<td colspan="3">
								<select id="search_type" name="search_type">
									<option value="ALL"><spring:message code="label.common.all"/></option>
									<option value="SN"><spring:message code="label.store.id"/></option>
									<option value="P">상품주문번호</option>
									<option value="ID">구매자ID</option>
								</select>
								&nbsp;&nbsp;
								<input type="text" id="search_txt" name="search_txt" class="inp" style="width: 68%;" placeholder='<spring:message code="label.product.prod.input.search"/>' />
							</td>
						</tr>
					</tbody>
				</table>
				<span class="searchFormBtn">
					<a href="javascript:searchList(1);" class="amb_btnstyle black middle"><spring:message code="label.common.search"/></a>
				</span>
			</div>
		</form>
	</div>
</div>
<div id="listActionDiv" class="nh_conBox"></div>