<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">
	$(document).ready(function() {
		//버튼 클릭시
	    $("#btn_search").click(function() {
	    	searchList(1);
	    });
	    $('#title').val($('.title').text());
		
	    //콤보박스 셋팅
	    selectAllSet('approval_stat','<spring:message code="label.common.all"/>');
	    selectAllSet('operational_stat','<spring:message code="label.common.all"/>');
	    
	    searchList(1);
	});
	
	
	
	function fnInit() {
		var param = $("#myForm").serialize();
		fnShowLoading();
		$.post('listAction.ajax', param, function(data) {
			$('#dataTable').html(data);
		});
	}

	function clearSearchText() {
		$("#store_name").val('');
		$("#comp_name").val('');
		$("#president_name").val('');
	}

	function searchInit() {
		clearSearchText();
		if ($("#search_opt").val() == "store_name") {
			$("#store_name").val($("#search_text").val());
		}
		if ($("#search_opt").val() == "comp_name") {
			$("#comp_name").val($("#search_text").val());
		}
		if ($("#search_opt").val() == "president_name") {
			$("#president_name").val($("#search_text").val());
		}
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

	function goExcel() {
		searchInit();
		var param = $("#myForm").serialize();
		$.download('exportAction.ajax', param, 'post');
	}

	function goAdd() {
		var url = "insert"; // admin/store/storeInfoMgmt/insert
		var param = new Object();
		openModal(url, "insertModal", param);
	}
</script>

<form id="myForm" name="myForm" method="post">
	<input type="hidden" id="title" name="title" />
	<input type="hidden" id="store_name" name="store_name" />
	<input type="hidden" id="comp_name" name="comp_name" />
	<input type="hidden" id="president_name" name="president_name" />
	<input type="hidden" id="store_id" name="store_id" />
	<input type="hidden" id="pageType" name="pageType" />
	<input type="hidden" id="page" name="page" />
	<input type="hidden" id="perPage" name="perPage" />


	<!-- 검색영역  -->
	<!-- rowBox 반복단위 -->
	<div class="rowBox mgT30">
		<div class="g_column w_1_1">
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
							<th><spring:message code="label.store.approval.stat.text" /></th>
							<td>
							    <select id="approval_stat" name="approval_stat" class="px100">
									<c:forEach items="${approval_stat}" var="approvalList" varStatus="status">
	                              		<option value="${approvalList.value}">${approvalList.name}</option>
		                            </c:forEach>
					            </select>
							</td>
							<th><spring:message code="label.store.operational.stat.text" /></th>
							<td>
							    <select id="operational_stat" name="operational_stat" class="px100">
									<c:forEach items="${operational_stat}" var="operationalList" varStatus="status">
	                              		<option value="${operationalList.value}">${operationalList.name}</option>
		                            </c:forEach>
					            </select>
							</td>
						</tr>
						<tr>
							<th><spring:message code="label.common.reg.period"/></th>
							<td colspan="3">
								<input type="text" id="startDate" name="startDate" value="${startDate}" class="inp datepicker startDate" readonly="readonly" style="width: 120px;" placeholder="date" />
								~
								<input type="text" id="endDate" name="endDate" value="${endDate}" class="inp datepicker endDate" readonly="readonly" style="width: 120px;" placeholder="date" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="label.common.search"/></th>
							<td colspan="3">
								<select class="" id="search_opt">
									<option value=""><spring:message code="label.common.select" /></option>
									<option value="store_name"><spring:message code="label.store.name" /></option>
									<option value="comp_name"><spring:message code="label.store.comp.name" /></option>
									<option value="president_name"><spring:message code="label.store.president.name" /></option>
								</select>
								<input type="text" id="search_text" value="" class="inp" style="width: 60%;" />
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
		</div>
	</div>
	<!-- 페이징 공통 리스트부분 Div id : dataTable -->
	<div id="dataTable"></div>
</form>



