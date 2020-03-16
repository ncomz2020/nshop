<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">
	$(document).ready(function() {
		searchList(1);
		
		//검색 버튼 이벤트
		$('#btn_search').click(function(){
			searchList(1);
		});
		
		//엔터키 검색 이벤트
		$("#fileListForm input").keyup(function(event) {
			if (event.keyCode == 13) {
				searchList(1);
			}
		});
	});

	//히든으로 잡힌 셀렉트 영역 초기화
	function clearSearchText() {
		$("#prod_name, #org_filename, #file_type").val('');
	}

	function searchInit() {
		clearSearchText();
		if ($("#search_opt").val() == "prod_name") {
			$("#prod_name").val($("#search_text").val());
		}
		if ($("#search_opt").val() == "org_filename") {
			$("#org_filename").val($("#search_text").val());
		}
		if ($("#search_fileType").val() != "") {
			$("#file_type").val($("#search_fileType").val());
		}
	}

	//페이지 설정
	function searchList(page) {
		$("#page").val(page);
		$("#perPage").val(10);
		
		searchInit();
		var param = $('#fileListForm').serialize();
		fnShowLoading();
		
		$.ajax({
			url : "listAction.ajax",
			type : "POST",
			data : param,
			success : function(data) {
				$("#dataTable").html(data);
			},
			error : function() {
				swal({
			        title: '<spring:message code="label.common.fail.action" />'
			    });				
			}
		});
	}
</script>

<form id="fileListForm" name="fileListForm" method="post">
	<input type="hidden" id="prod_name" name="prod_name" />
	<input type="hidden" id="org_filename" name="org_filename" />
	<input type="hidden" id="page" name="page" />
	<input type="hidden" id="perPage" name="perPage" />
	<input type="hidden" id="store_id" name="store_id" />
	<input type="hidden" id="prod_id" name="prod_id" />
	<input type="hidden" id="file_type" name="file_type" />


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
							<th>
								<spring:message code="label.file.search.reg.period" />
							</th>
							<td colspan="3">
								<input type="text" id="startDate" name="startDate" value="${startDate}" class="inp datepicker startDate" readonly="readonly" style="width: 120px;" placeholder="date" />
								~
								<input type="text" id="endDate" name="endDate" value="${endDate}" class="inp datepicker endDate" readonly="readonly" style="width: 120px;" placeholder="date" />
							</td>
						</tr>
						<tr>
							<th>
								<spring:message code="label.file.search.file.type" />
							</th>
							<td>
								<select id="search_fileType">
									<option value="">
										<spring:message code="label.file.search.file.type.all" />
									</option>
										<c:forEach items="${opt_fileTypes}" var="list" varStatus="status">
											<option value='${list.dtl_cd}'>${list.dtl_nm}</option>
										</c:forEach>
								</select>
							
							</td>
						</tr>
						<tr>
							<th>
								<spring:message code="label.file.search.title" />
							</th>
							<td colspan="3">
								<select class="" id="search_opt">
									<option value="">
										<spring:message code="label.file.search.select" />
									</option>
									<option value="prod_name">
										<spring:message code="label.file.search.storename" />
									</option>
									<option value="org_filename">
										<spring:message code="label.file.search.filename" />
									</option>
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



