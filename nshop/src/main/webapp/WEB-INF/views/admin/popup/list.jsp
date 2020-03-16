<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">
	$(document).ready(function() {
		searchList(1);
	});


	function searchList(page) {
		$("#page").val(page);
		$("#perPage").val(10);
		
		var param = $("#popupForm").serialize();
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
			        title: "오류가 발생하였습니다. 관리자에게 문의하세요."
			    });
			}
		});
	}

</script>

<form id="popupForm" name="popupForm" method="post">
	<input type="hidden" id="page" name="page" />
	<input type="hidden" id="perPage" name="perPage" />
	<input type="hidden" id="popup_id" name="popup_id" />


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
							<th>검색</th>
							<td colspan="3">
								<select class="" id="search_opt">
									<option value="">선택</option>
<!-- 									<option value="store_name">상점명</option> -->
<!-- 									<option value="comp_name">업체명</option> -->
<!-- 									<option value="president_name">대표자명</option> -->
								</select>
								<input type="text" id="search_text" value="" class="inp" style="width: 60%;" />
							</td>
						</tr>
					</tbody>
				</table>

				<span class="searchFormBtn">
					<a href="javascript:searchList(1);" id="btn_search" class="amb_btnstyle black middle">
						<spring:message code="label.common.search" />
					</a>
				</span>
			</div>
		</div>
	</div>
	<!-- 페이징 공통 리스트부분 Div id : dataTable -->
	<div id="dataTable"></div>
</form>



