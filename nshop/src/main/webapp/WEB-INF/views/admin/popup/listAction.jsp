<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
	//Ajax로 첫 화면의 데이터 호출
	$(document).ready(function() {
		
	});


	function fn_goUpdate(popup_id) {
		$("#popup_id").val(popup_id);
		$("#popupForm").attr("action", "update");
		$("#popupForm").submit();
	}
	function fn_goInsert() {
		$("#popupForm").attr("action", "insert");
		$("#popupForm").submit();
	}
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30 data">
	<div class="g_column w_1_1">
		<h3>
			<span class="title">팝업리스트</span>
			<div class="fr btnArea middle">
				<a href="javascript:fn_goInsert();" class="amb_btnstyle white middle">등록</a>
			</div>
		</h3>
		<div class="unitBox">
			<table class="amb_table">
				<colgroup>
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
					<col style="" />
				</colgroup>
				<thead>
					<tr class="colHeaders">
						<th>NO</th>
						<th>ID</th>
						<th>팝업제목</th>
						<th>top</th>
						<th>left</th>
						<th>width</th>
						<th>height</th>
						<th>게시시작일</th>
						<th>게시종료일</th>
						<th>등록일</th>
						<th>사용상태</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach items="${list}" var="data" varStatus="status">
						<tr>
							<td>${data.rownum}</td>
							<td><a href="javascript:;" onclick="fn_goUpdate('${data.popup_id}');">${data.popup_id}</a></td>
							<td><a href="javascript:;" onclick="fn_goUpdate('${data.popup_id}');">${data.popup_title}</a></td>
							<td>${data.top}</td>
							<td>${data.left_p}</td>
							<td>${data.width}</td>
							<td>${data.height}</td>
							<td>${data.start_dttm}</td>
							<td>${data.end_dttm}</td>
							<td>${data.reg_dttm}</td>
							<td>${data.use_yn}</td>
						</tr>
					</c:forEach>
					<c:if test="${empty list}">
						<tr class="odd" style="cursor: default;">
							<td align="center" colspan="11">
								<spring:message code="label.common.empty.list" />
							</td>
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
		<!-- 페이징 end -->
	</div>
</div>

