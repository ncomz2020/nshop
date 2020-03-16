<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
	function openInsertUserGroup() {
		var url = "insert.ajax";
		openModal(url , 'insertModal',null,'500');
	}

	function openUpdateUserGroup(usr_grp_id) {
		var param = new Object();
		param.usr_grp_id = usr_grp_id;
		var url = "update.ajax";
		openModal(url , 'updateModal',param,'900');
	}
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code="label.usergroup.list"/></span>
		</h3>
		<div class="unitBox" style="">
			<table class="amb_table">
				<colgroup>
					<col style="width: 40px;" />
					<col style="width: 20%" />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th></th>
						<th><spring:message code="label.usergroup.name"/></th>
						<th><spring:message code="label.usergroup.description"/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="userGroup" varStatus="status">
						<tr>
							<td>${userGroup.rownum}</td>
							<td>
								<a href="javascript:openUpdateUserGroup('${userGroup.usr_grp_id}');">
									<c:out value="${userGroup.usr_grp_nm}" />
								</a>
							</td>
							<td>${userGroup.expln}</td>
						</tr>
					</c:forEach>
					<c:if test="${empty list}">
						<tr>
							<td colspan="7"><spring:message code="label.common.empty.list"/></td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="paging center">
			<ul class="paginglist">
				<jsp:include page="/WEB-INF/views/include/paging.jsp" />
			</ul>
			<div class="fr btnArea middle">
				<a href="javascript:openInsertUserGroup();" class="amb_btnstyle blue middle"><spring:message code="label.common.regist"/></a>
			</div>
		</div>
	</div>
</div>
