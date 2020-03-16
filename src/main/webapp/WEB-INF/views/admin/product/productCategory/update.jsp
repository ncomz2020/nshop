<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
	function updateAction() {
		if ($("#update_title").val() == "") {
			swal({
		        title: '<spring:message code="label.product.category.valid.input.name"/>'},function() {
					$("#update_title").focus();
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
			        	refreshTree("tree");
				});

			} else {
				swal({
			        title: result
			    });				
			}
		},
		});
	}

	function deleteAction() {
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
				        title: '<spring:message code="label.common.success.delete"/>'},function() {					
						$("#updateModal a.close").trigger("click");
						$("#activateKey").val("0");
						refreshTree("tree");
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
<div class="amb_layout_common amb_admin_layout_temp_01 amb_layerpopup" style="width: 500px;">
	<!-- style="width:1000px;" 는 최대 1000px를 넘지 말아야 합니다. 1000px을 넘어도 css에 최대 1000px로 처리 되어있습니다. -->
	<h1 class="popupHeader">
		<span class="title"><spring:message code="label.product.category.modify"/></span>
		<a href="javascript:;" class="close" onClick="javascript:closeModal(this);">
			<i class="ambicon-015_mark_times"></i>
		</a>
	</h1>

	<div id="content" class="content">
		<div class="rowBox">
			<div class="unitBox" style="">
				<form id="updateForm" action="javascript:updateAction();">
					<input type="hidden" name="category_id" value="${productCategory.category_id}">
					<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 30%;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th class="center"><spring:message code="label.product.category.name"/></th>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="update_title" name="title" placeholder='<spring:message code="label.product.category.name"/>' maxlength="50" autofocus value="<c:out value="${productCategory.title}"/>" onfocus="this.value = this.value;">
								</td>
							</tr>
							<c:forEach items="${languageCodeList}" var="code" varStatus="status">
								<tr>
									<th class="center"><c:out value="${code.dtl_nm}"/></th>
									<td>
										<input type="hidden" name="languageCode" value="<c:out value="${code.dtl_cd}"/>">
										<c:set var="languageTitle" value=""/>
										<c:forEach items="${productCategoryLanguageList}" var="productCategoryLanguage" varStatus="status">
											<c:if test="${code.dtl_cd == productCategoryLanguage.language}">
												<c:set var="languageTitle" value="${productCategoryLanguage.title}"/>
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
					<a href="javascript:updateAction();" class="amb_btnstyle gray middle">저장</a>
					<a href="javascript:deleteAction();" class="amb_btnstyle gray middle">삭제</a>
				</div>
			</div>
		</div>
		<!-- rowBox 반복단위 -->
	</div>
</div>