<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
	function updateAction() {
		if ($("#update_dtl_nm").val() == "") {
			swal({
		        title: '<spring:message code="label.code.valid.input.name"/>'},function() {
				$("#update_dtl_nm").focus();
			});	
			return;
		}
		var param = $("#updateForm").serialize();
		$.ajax({
		url : "updateAction.json",
		type : "POST",
		data : param,
		dataType : "json",
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				swal({
			        title: '<spring:message code="label.common.success.save"/>'},function() {
						$("#updateModal a.close").trigger("click");
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
	
	function updateUseYnAction(use_yn) {
		$("#update_use_yn").val(use_yn);
		var param = $("#updateForm").serialize();
		$.ajax({
		url : "updateUseYnAction.json",
		type : "POST",
		data : param,
		dataType : "json",
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				swal({
			        title: '<spring:message code="label.common.success.save"/>'},function() {
						$("#updateModal a.close").trigger("click");
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
	
	function deleteConfirm() {
		swal({
	        title: '<spring:message code="label.common.confirm.delete"/>',
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonText: "YES",
	        cancelButtonText: "NO",
	        closeOnConfirm: false
	         },function() {
			var param = $("#updateForm").serialize();
			$.ajax({
			url : "deleteAction.json",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data) {
				var result = data.result;
				if (result == "succ") {
					swal({
				        title: '<spring:message code="label.common.success.delete"/>',
				        type: "success",
			      		confirmButtonText: "CLOSE" },function() {
						$("#updateModal a.close").trigger("click");
						$("#activateKey").val("0");
						$("#tree").dynatree("getTree").reload();
						// refreshScreen("0");
					});
				} else {
					swal({
				        title: result
				    });
				}
			},
			});
		});
	}
</script>
<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
<div class="modal-content">
	<h1 class="popupHeader">
		<span class="title"><spring:message code="label.code.modify"/></span>
		<a href="javascript:;" class="close" onClick="javascript:closeModal(this);">
			<i class="ambicon-015_mark_times"></i>
		</a>
	</h1>

	<div id="content" class="content">
		<div class="rowBox">
			<div class="unitBox" style="">
				<form id="updateForm" action="javascript:updateAction();">
					<input type="hidden" name="grp_cd" value="${code.grp_cd}">
					<input type="hidden" name="dtl_cd" value="${code.dtl_cd}">
					<input type="hidden" name="depth" value="${code.depth}">
					<input type="hidden" id="update_use_yn" name="use_yn" value="${code.use_yn}">
					<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 25%;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th class="center"><spring:message code="label.code.code"/></th>
								<td>
									<input type="text" class="inp" style="width: 100%;" placeholder="코드" maxlength="50" autofocus value="<c:out value="${code.dtl_cd}"/>" disabled>
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="label.code.name"/></th>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="update_dtl_nm" name="dtl_nm" placeholder="코드명" maxlength="50" autofocus value="<c:out value="${code.dtl_nm}"/>" onfocus="this.value = this.value;">
								</td>
							</tr>
							<c:forEach items="${languageCodeList}" var="code" varStatus="status">
								<tr>
									<th class="center"><c:out value="${code.dtl_nm}"/></th>
									<td>
										<input type="hidden" name="languageCode" value="<c:out value="${code.dtl_cd}"/>">
										<c:set var="languageTitle" value=""/>
										<c:forEach items="${codeLanguageList}" var="codeLanguage" varStatus="status">
											<c:if test="${code.dtl_cd == codeLanguage.language}">
												<c:set var="languageTitle" value="${codeLanguage.dtl_nm}"/>
											</c:if>
										</c:forEach>
										<input type="text" class="inp" style="width: 100%;" name="languageTitle" placeholder="<c:out value="${code.dtl_nm}"/>" maxlength="50" value="<c:out value="${languageTitle}"/>">
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
				<div class="fr btnArea middle">
					<c:choose>
						<c:when test="${code.use_yn == 'Y'}">
							<a href="javascript:updateUseYnAction('N');" class="amb_btnstyle gray middle"><spring:message code="label.common.unuse"/></a>
						</c:when>
						<c:otherwise>
							<a href="javascript:updateUseYnAction('Y');" class="amb_btnstyle gray middle"><spring:message code="label.common.use"/></a>
						</c:otherwise>
					</c:choose>
					<a href="javascript:updateAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.save"/></a>
					<a href="javascript:deleteConfirm();" class="amb_btnstyle gray middle"><spring:message code="label.common.delete"/></a>
				</div>
			</div>
		</div>
		<!-- rowBox 반복단위 -->
	</div>
	</div>
</div>