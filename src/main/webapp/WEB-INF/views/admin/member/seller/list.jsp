<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<script>
	$(document).ready(function() {
		searchList(1);
	});
	
	function searchList(page) {
		$("#page").val(page);
		var param = $('#calculDailyListForm').serialize();
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
	
	function setStartDate(period){
		if(period=="0"){
			$("#start_date").val('<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />');
			$("#end_date").val('<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />');
		}else{
			var endDate = $("#end_date").val();
			var startDate = new Date(endDate);
			startDate.setDate(startDate.getDate()-period);
			$("#start_date").datepicker("setDate",startDate.toISOString().substring(0, 10));
			$("#start_date").val(startDate.toISOString().substring(0, 10));
		}
	}

</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<form id="calculDailyListForm" name="calculDailyListForm">
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
							<th><spring:message code="label.member.management.registration.date"/>
								<input type="hidden" id="search_date_type" name="search_date_type" value="S_CD"> 
							</th>
							<td colspan="2">
								<span class="datepickerRange">
								<input type="text" id="start_date" name="start_date" class="inp datepicker startDate" readonly="readonly" value="<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />" style="width: 120px;" placeholder="date" />
								~
								<input type="text" id="end_date" name="end_date" class="inp datepicker endDate" readonly="readonly" value="<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />" style="width: 120px;" placeholder="date" />
								</span>
								<span>
									<button type="button" class="amb_btnstyle gray middle" onclick="setStartDate(0);"><spring:message code="label.order.period.today"/></button>
									<button type="button" class="amb_btnstyle gray middle" onclick="setStartDate(3);"><spring:message code="label.order.period.3day"/></button>
									<button type="button" class="amb_btnstyle gray middle" onclick="setStartDate(7);"><spring:message code="label.order.period.1week"/></button>
									<button type="button" class="amb_btnstyle gray middle" onclick="setStartDate(30);"><spring:message code="label.order.period.1month"/></button>
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
									<option value="N"><spring:message code="label.member.join.name"/></option>
									<option value="I"><spring:message code="label.member.join.id"/></option>
									<option value="T"><spring:message code="label.member.join.telno"/></option>
									<option value="M"><spring:message code="label.member.join.mobileno"/></option>
									<option value="E"><spring:message code="label.member.join.email"/></option>
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