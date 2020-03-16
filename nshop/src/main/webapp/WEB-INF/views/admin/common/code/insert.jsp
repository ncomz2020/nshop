<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
	function insertAction() {
		if ($("#insert_dtl_cd").val() == "") {
			swal({
		        title: '<spring:message code="label.code.valid.input.code"/>'},function() {
					$("#insert_dtl_cd").focus();
			});	
			return;
		}
		
		if ($("#insert_dtl_nm").val() == "") {
			swal({
		        title: '<spring:message code="label.code.valid.input.name"/>'},function() {
				$("#insert_dtl_nm").focus();
			});	
			return;
		}
		
		var param = $("#insertForm").serialize();
		$.ajax({
		url : "insertAction.json",
		type : "POST",
		data : param,
		dataType : "json",
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				swal({
			        title: '<spring:message code="label.common.success.save"/>'},function() {
						$("#insertModal a.close").trigger("click");
						$("#tree").dynatree("getTree").reload();
				});
			} else {
				swal({
			        title: result
			    });
			}
		},
		});
	}
</script>
<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
<div class="modal-content">
	<h1 class="popupHeader">
		<span class="title"><spring:message code="label.code.add"/></span>
		<a href="javascript:;" class="close" onClick="javascript:closeModal(this);">
			<i class="ambicon-015_mark_times"></i>
		</a>
	</h1>

	<div id="content" class="content">
		<div class="rowBox">
			<div class="unitBox" style="">
				<form id="insertForm" action="javascript:insertAction();">
					<input type="hidden" name="grp_cd" value="${(parent.dtl_cd == null || parent.dtl_cd == '') ? '0' : parent.dtl_cd}">
					<input type="hidden" name="depth" value="${parent.depth+1}">
					<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 25%;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th class="center"><spring:message code="label.code.code"/></th>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="insert_dtl_cd" name="dtl_cd" placeholder="<spring:message code="label.code.code"/>" maxlength="20" autofocus>
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="label.code.name"/></th>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="insert_dtl_nm" name="dtl_nm" placeholder="<spring:message code="label.code.name"/>" maxlength="50">
								</td>
							</tr>
							<c:forEach items="${languageCodeList}" var="code" varStatus="status">
								<tr>
									<th class="center"><c:out value="${code.dtl_nm}"/></th>
									<td>
										<input type="hidden" name="languageCode" value="<c:out value="${code.dtl_cd}"/>">
										<input type="text" class="inp" style="width: 100%;" name="languageTitle" placeholder="<c:out value="${code.dtl_nm}"/>" maxlength="50">
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
				<div class="fr btnArea middle">
					<a href="javascript:insertAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.save"/></a>
				</div>
			</div>
		</div>
		<!-- rowBox 반복단위 -->
	</div>
	</div>
</div>