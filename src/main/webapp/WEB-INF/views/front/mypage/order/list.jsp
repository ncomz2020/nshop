<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script type="text/javascript">
	$(document).ready(function() {
		//버튼 클릭시
	    $("#btn_search").click(function() {
	    	searchList(10, 10);
	    });
	    $('#title').val($('.title').text());
	    searchList(10, 10);
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
		str.push($("#search_opt").val());
		
		$("#sts_cd").val(str);
		
		if($("#search_opt").val() == '010' || $("#search_opt").val() == '020' || $("#search_opt").val() == '030' || $("#search_opt").val() == '040' || $("#search_opt").val() == '050'){
			$("#list_sts_cd").val("O");
		}else if($("#search_opt").val() == '000'){
			$("#list_sts_cd").val("A");
		}else{
			$("#list_sts_cd").val("C");
		}
	}

	function searchList(page, perPage) { //현재페이지 목록 수  , 한 페이지당 목록 수 
		$("#page").val(page);
		$("#perPage").val(perPage);
		
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
	

	
	function delivery_tracking(invoice){
	    
		var url = "/admin/delivery/delivery_tracking.ajax";
	      
		var param = {};
		param.t_key = "xXFLUhx1CJfUSruDrV5J8g";
		param.t_code = "04";
		param.t_invoice = invoice;
			      
		openModal(url, 'delivery_tracking' ,param , '900');
			      
	}
</script>

<!-- contentWrap -->
	<div id="contentWrap" class="contentWrap">
		<div id="content" class="content wrap">
			<h3>
				<span class="title" id="subtitle"><spring:message code="label.order.front.title.list" /></span>
			</h3>
				<!-- 검색영역  -->
				<div class="rowBox mgT10">
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
										<td>
											<select class="" id="search_opt" style="width:50%;">
												<option value="000"><spring:message code="label.common.all" /></option>
												<option value="010"><spring:message code="label.order.status.paymentComplete" /></option>
												<option value="020"><spring:message code="label.order.status.preparingProduct" /></option>
												<option value="030"><spring:message code="label.order.status.delivery" /></option>
												<option value="040"><spring:message code="label.order.status.deliveryComplete" /></option>
												<option value="050"><spring:message code="label.order.status.purchaseComplete" /></option>
												<option value="100"><spring:message code="label.order.status.cancel" /></option>
												<option value="200"><spring:message code="label.order.status.exchange" /></option>
												<option value="300"><spring:message code="label.order.status.return" /></option>
											</select>
											<input type="hidden" id="sts_cd" name="sts_cd"/>
										</td>
										<th><spring:message code="label.order.productName" /></th>
										<td>
											<input type="hidden" id="search_type" name="search_type" value="30"/>
											<input type="text" id="search_text" name="search_txt" value="" class="inp" style="width: 85%;" placeholder='<spring:message code="label.order.product.placeholder"/>' />
											<span class="searchFormBtn" style="float:right">
												<a href="javascript:;" id="btn_search" class="amb_btnstyle black middle">
													<spring:message code="label.common.search" />
												</a>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
			
							
						</div>
						</form>
					</div>
				</div>
				<!-- 페이징 공통 리스트부분 Div id : dataTable -->
				<div id="dataTable">
				</div>
		</div>
	</div>
	<!-- //contentWrap -->

