<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">
	$(document).ready(function() {
		
		selectBoxSetting();
		//버튼 클릭시
	    $("#btn_search").click(function() {
	    	searchList(1);
	    });
	    $('#title').val($('.title').text());
	    searchList(1);
	});	
	
	
	function fnInit() {
		var param = $("#myForm").serialize();
		fnShowLoading();
		$.post('listAction.ajax', param, function(data) {
			$('#dataTable').html(data);
		});
	}

	function searchInit() {
		var str =[];
		
		$('input[type="checkbox"]:checked').each(function(){ 
			str.push($(this).val());
		});
		
		$("#sts_cd").val(str);
		$("#list_sts_cd").val("O");
	}

	function searchList(page) {
		$("#page").val(page);
		$("#perPage").val(10);
		
		searchInit();
		var param = $("#myForm").serialize();
		fnShowLoading();
		
		$.ajax({
		url : "listAction.ajax",
		type : "POST",
		data : param,
		success : function(data) {
			$("#dataTable").html(data);
		},
		});
	}
	
	function selectBoxSetting() {
		var statusSelectBox = [ {
		'codeType' : 'commCode',
		'grp_cd' : 'OS001',
		'selectId' : 'search_opt'
		} ];

		// 판매상태 조회
		callAajaxJson(statusSelectBox);
	}
	
	function setPeriod(period){ 
		var reg = new RegExp("m$", "g");
		var monthFlag = reg.test(period);
		var startDate = new Date();
		var endDate = new Date();
		
		if(monthFlag){
			startDate.setMonth(endDate.getMonth() - (period.split('m')[0]));
		}else{
			startDate.setDate(endDate.getDate() - period);
		}
		
		$("#start_date").datepicker("setDate",startDate.toISOString().substring(0, 10));
		$("#start_date").datepicker().val(startDate.toISOString().substring(0, 10));
		
		$("#end_date").datepicker("setDate",endDate.toISOString().substring(0, 10));
		$("#end_date").datepicker().val(endDate.toISOString().substring(0, 10));
	}
</script>
	<!-- 검색영역  -->
	<!-- rowBox 반복단위 -->
	<div class="rowBox mgT30">
		<div class="g_column w_1_1">
		<form id="myForm" name="myForm" method="post">
			<input type="hidden" id="title" name="title" />		
			<input type="hidden" id="pageType" name="pageType" />
			<input type="hidden" id="page" name="page" />
			<input type="hidden" id="perPage" name="perPage" />
			<input type="hidden" id="list_sts_cd" name="list_sts_cd" />
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
							<th><spring:message code="label.order.period" /></th>
							<td colspan="3">
								<span class="datepickerRange">
									<input type="text" id="start_date" name="start_date" value="${start_date}" class="inp datepicker startDate" style="width: 120px;" placeholder="date" />
									~
									<input type="text" id="end_date" name="end_date" value="${end_date}" class="inp datepicker endDate" style="width: 120px;" placeholder="date" />
								</span>
								<span>
									<a href="javascript:setPeriod(0);" ><button type="button" class="amb_btnstyle gray middle"><spring:message code="label.order.period.today" /></button></a>
									<a href="javascript:setPeriod(3);" ><button type="button" class="amb_btnstyle gray middle"><spring:message code="label.order.period.3day" /></button></a>
									<a href="javascript:setPeriod(7);" ><button type="button" class="amb_btnstyle gray middle"><spring:message code="label.order.period.1week" /></button></a>
									<a href="javascript:setPeriod('1m');" ><button type="button" class="amb_btnstyle gray middle"><spring:message code="label.order.period.1month" /></button></a>
									<a href="javascript:setPeriod('3m');" ><button type="button" class="amb_btnstyle gray middle"><spring:message code="label.order.period.3month" /></button></a>
								</span>
							</td>
						</tr>
						
						<tr>
							<th><spring:message code="label.order.status"/></th>
							<td colspan="3">
								<input type="checkbox" id="check_01" value="010" checked><label for="check_01" class="inp_func"><spring:message code="label.order.status.paymentComplete" /></label>
								<input type="checkbox" id="check_02" value="020" checked><label for="check_02" class="inp_func"><spring:message code="label.order.status.preparingProduct" /></label>
								<input type="checkbox" id="check_03" value="030" checked><label for="check_03" class="inp_func"><spring:message code="label.order.status.delivery" /></label>
								<input type="checkbox" id="check_04" value="040" checked><label for="check_04" class="inp_func"><spring:message code="label.order.status.deliveryComplete" /></label>
								<input type="checkbox" id="check_05" value="050" checked><label for="check_05" class="inp_func"><spring:message code="label.order.status.purchaseComplete" /></label>
								<input type="hidden" id="sts_cd" name="sts_cd"/>
							</td>							
						</tr>
						
						<tr>
							<th><spring:message code="label.order.search"/></th>
							<td colspan="3">
								<select class="" id="search_opt" name="search_type" style="width:15%;">
								<option value=50><spring:message code="label.order.sellerId"/></option>
								</select>
								<input type="text" id="search_text" name="search_txt" value="" class="inp" style="width: 50%;" placeholder='<spring:message code="label.order.search.placeholder"/>' />
							</td>
						</tr>
					</tbody>
				</table>

				<span class="searchFormBtn">
					<a href="javascript:;" id="btn_search" class="amb_btnstyle black middle">
						<spring:message code="label.common.search" />
					</a>
				</span>
			</div>
			</form>
		</div>
	</div>
	<!-- 페이징 공통 리스트부분 Div id : dataTable -->
	<div id="dataTable"></div>
