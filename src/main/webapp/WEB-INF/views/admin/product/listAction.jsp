<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
	$(document).ready(function() {
		selectBoxSetting();
		$('#checkboxListAll').click(function() {
			var checkedStatus = this.checked;
			$('input[name="checkboxList"]').each(function() {
				$(this).prop('checked', checkedStatus);
			});
		});
	});

	function statusModifyAction() {
		if ($("input[name=checkboxList]:checkbox:checked").length < 1) {
			swal({
		        title: '<spring:message code="label.product.prod.valid.check.prod"/>'
		    });			
			return;
		}

		if (isEmpty($("#modify_status option:selected").val())) {
			swal({
		        title: '<spring:message code="label.product.prod.valid.check.state"/>'
		    });	
			return;
		}

		swal({
	        title: '<spring:message code="label.product.prod.confirm.change.front"/>' + $("#modify_status>option:selected").html() + '<spring:message code="label.product.prod.confirm.change.back"/>',
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonText: "YES",
	        cancelButtonText: "NO",
	        closeOnConfirm: false
	         },function() {
			var arrProdId = [];
			$('input[name="checkboxList"]').each(function() {
				var checkedStatus = this.checked;
				if (checkedStatus) {
					var prod_id = $(this).val();
					arrProdId.push(prod_id);
				}
			});

			var param = new Object();
			param.prod_id = arrProdId.join();
			param.prod_stat = $("#modify_status option:selected").val();
			$.ajax({
			url : "statusModifyAction.json",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data) {
				var result = data.result;
				if (result == "succ") {
					swal({
				        title: $("#modify_status>option:selected").html() + ' <spring:message code="label.common.success.action"/>',
				        type: "success",
			      		confirmButtonText: "CLOSE" },function() {
						refreshList();
					});
				} else {
					swal({
				        title: result
				    });
				}
			},
			error : function() {
				swal({
			        title: '<spring:message code="label.common.fail.action"/>'
			    });
			}
			});
		});
	}

	function selectBoxSetting() {
		var statusSelectBox = [ {
		'codeType' : 'commCode',
		'grp_cd' : 'P001',
		'selectId' : 'modify_status',
		'defaultName' : '<spring:message code="label.product.prod.stat.select"/>'
		} ];

		// 판매상태 조회
		callAajaxJson(statusSelectBox);
	}

	function goExcel() {
		var param = $('#productListForm').serialize();
		$.download('exportAction.ajax', param, 'post');
	}
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code="label.product.prod.list"/></span>
			<div class="fr btnArea middle">
				<a href="javascript:goExcel();" class="amb_btnstyle white middle"><spring:message code="label.common.export.excel"/></a>
			</div>
		</h3>
		<div class="unitBox" style="">
			<table class="amb_table">
				<colgroup>
					<col style="width: 5%" />
					<col style="width: 70px;" />
					<col style="" />
					<col style="width: 10%" />
					<col style="width: 15%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="checkboxListAll" name="checkboxListAll"><label for="checkboxListAll" class="inp_func"></th>
						<th><spring:message code="label.product.prod.image"/></th>
						<th><spring:message code="label.product.prod.name"/></th>
						<th><spring:message code="label.product.create.user.name"/></th>
						<th><spring:message code="label.product.create.datetime"/></th>
						<th><spring:message code="label.product.prod.price"/></th>
						<th><spring:message code="label.product.prod.stat"/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="info" varStatus="status">
						<tr>
							<td>
								<input type="checkbox" id="check_${info.rownum}" name="checkboxList" value="${info.prod_id}">
								<label for="check_${info.rownum}" class="inp_func">
							</td>
							<td style="text-align: left;">
								<div style="width: 50px; height: 50px; overflow: hidden; position: relative;">
									<c:if test="${not empty info.imageFileList}">
										<c:if test="${fn:length(info.imageFileList) > 1}">
											<div style="text-align: right; position: absolute; left: 35px; top: 35px; width: 15px; height: 15px; font-weight: bold; background-color: #000; color: #fff; opacity: 0.5;">+${fn:length(info.imageFileList) - 1}</div>
										</c:if>
										<c:set var="imageFileIdList" value="" />
										<c:forEach items="${info.imageFileList}" var="imageFile">
											<c:if test="${imageFileIdList != ''}">
												<c:set var="imageFileIdList" value="${imageFileIdList}," />
											</c:if>
											<c:set var="imageFileIdList" value="${imageFileIdList}${imageFile.file_id}" />
										</c:forEach>
										<img src="/common/file/downloadImage/${info.imageFileList[0].file_id}" onload="javascript:initImage(this);" style="cursor: pointer;" onclick="javascript:openImageList('${imageFileIdList}');">
									</c:if>
								</div>
							</td>
							<td>
								<a href="javascript:movePage('detail', {prod_id: '${info.prod_id}',pageType:'productList'});">${info.prod_name}</a>
								<br />(${info.prod_id})
							</td>
							<td>${info.create_user_id}<br />(${info.create_user_name})
							</td>
							<td>${info.create_datetime}</td>
							<td>
								<fmt:formatNumber value="${info.prod_price}" pattern="#,###" />
							</td>
							<td>
								<c:choose>
									<c:when test="${info.prod_stat eq '10'}">${info.prod_stat_name}</c:when>
									<c:when test="${info.prod_stat eq '20'}">
										<font color="red">${info.prod_stat_name}</font>
									</c:when>
									<c:when test="${info.prod_stat eq '30'}">${info.prod_stat_name}</c:when>
									<c:when test="${info.prod_stat eq '40'}">
										<font color="blue">${info.prod_stat_name}</font>
									</c:when>
									<c:when test="${info.prod_stat eq '50'}">
										<font color="red">${info.prod_stat_name}</font>
									</c:when>
									<c:otherwise>
										${info.prod_stat_name}
									</c:otherwise>
								</c:choose>
							</td>
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
			<div class="fl btnArea middle">
				<select id="modify_status"></select>
				<a href="javascript:statusModifyAction();" class="amb_btnstyle gray large"><spring:message code="label.common.change"/></a>
			</div>
		</div>
	</div>
</div>
</div>
<!-- rowBox 반복단위 -->