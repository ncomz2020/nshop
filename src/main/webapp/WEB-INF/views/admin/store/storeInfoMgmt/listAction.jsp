<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
	//Ajax로 첫 화면의 데이터 호출
	$(document).ready(function() {
		
	});

	// 승인,운영 상태변경
	function goStatUpdateAction(store_id, stat, code) {
		var coment = "";
		var param = new Object();
		param.store_id = store_id;
		if (code == 'approval_stat') {
			param.approval_stat = stat;
			if (stat == 'Y') {  // 승인
			coment = '<spring:message code="label.store.approve"/>';
			}else{    // 승인취소
			coment = '<spring:message code="label.store.approve.cancel"/>';
			param.operational_stat = 'N';  // 승인취소 -> 운영중지
			}
		} else {
			param.operational_stat = stat;
			if (stat == 'Y') {
				coment = '<spring:message code="label.store.operate"/>';
			}else{
				coment = '<spring:message code="label.store.operate.off"/>';
			}
		}

		swal({
	        title: '(' + coment + ')' + ' <spring:message code="label.product.prod.confirm.change.back"/>',
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonText: "YES",
	        cancelButtonText: "NO",
	        closeOnConfirm: false
	         },function() {
			$.ajax({
			url : "statUpdateAction.json",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data) {
				var result = data.result;
				if (result == "succ") {
					swal({
				        title: '(' + coment + ')' + ' <spring:message code="label.common.success.action"/>',
				        type: "success",
			      		confirmButtonText: "CLOSE" },function() {
						searchList($("#page").val());
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

	// 상세보기
	function detailView(store_id) {
		$("#store_id").val(store_id);
		$("#pageType").val("storeList");
		$("#myForm").attr("action", "detailView.ajax");
		$("#myForm").submit();
	}
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30 data">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code="label.store.list"/></span>
			<div class="fr btnArea middle">
				<a href="javascript:goExcel();" class="amb_btnstyle white middle"><spring:message code="label.common.export.excel"/></a>
			</div>
		</h3>
		<div class="unitBox">
			<table class="amb_table">
				<colgroup>
					<col style="width: 5%;" />
					<col style="width: 70px;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="" />
					<col style="width: 20%;" />
					<col style="width: 15%;" />
				</colgroup>
				<thead>
					<tr class="colHeaders">
						<th>no</th>
						<th>logo</th>
						<th><spring:message code="label.store.name"/></th>
						<th><spring:message code="label.store.comp.name"/></th>
						<th><spring:message code="label.store.president.name"/></th>
						<th><spring:message code="label.store.reg.datetime"/></th>
						<th><spring:message code="label.store.approval.stat.text"/></th>
						<th><spring:message code="label.store.operational.stat.text"/></th>
					</tr>
				</thead>
				<tbody>

					<c:forEach items="${list}" var="storeInfo" varStatus="status">
						<tr>
							<td>${storeInfo.rownum}</td>
							<td style="text-align: left;">
								<div style="width: 50px; height: 50px; overflow: hidden;position:relative;">
									<img src="/common/file/downloadImage/<c:if test="${not empty storeInfo.store_logo}">${storeInfo.store_logo}</c:if><c:if test="${empty storeInfo.store_logo}">noImage</c:if>" 
									onload="javascript:initImage(this);" style="cursor: pointer; height: 50px; width: 50px; margin-left: 0px;">
								</div>
							</td>
							<td>
								<a href="javascript:;" onclick="detailView('${storeInfo.store_id}');">${storeInfo.store_name}<br />(${storeInfo.store_id})</a>
							</td>
							<td>${storeInfo.comp_name}<br />
								<c:if test="${not empty storeInfo.comp_reg_num}">
								(${storeInfo.comp_reg_num})
								</c:if>
							</td>
							<td>${storeInfo.president_name}</td>
							<td>${storeInfo.reg_datetime}</td>
							<td>
								<div class="stateBox2 before2">
									<span class="state">${storeInfo.approval_stat_text}</span>
									<c:if test="${storeInfo.approval_stat eq 'R' and session_user.usr_grp_id eq 1}">
										<button type="button" onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','Y','approval_stat');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.store.approve"/></button>
									</c:if>
									<c:if test="${storeInfo.approval_stat eq 'Y' and session_user.usr_grp_id eq 1}">
										<button type="button" onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','F','approval_stat');" class="amb_btnstyle red middle stateEdit"><spring:message code="label.store.approve.cancel"/></button>
									</c:if>
								</div>
							</td>
							<td>
								<div class="stateBox2 before2">
									<span class="state">${storeInfo.operational_stat_text} </span>
									<c:if test="${storeInfo.approval_stat eq 'Y'}">
										<c:if test="${storeInfo.operational_stat eq 'Y' and session_user.usr_grp_id eq 1}">
											<button type="button" onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','N','operational_stat');" class="amb_btnstyle red middle stateEdit"><spring:message code="label.store.operate.off_2"/></button>
										</c:if>
										<c:if test="${storeInfo.operational_stat eq 'N' and session_user.usr_grp_id eq 1}">
											<button type="button" onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','Y','operational_stat');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.store.operate" /></button>
										</c:if>
									</c:if>
								</div>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty list}">
						<tr class="odd" style="cursor: default;">
							<td align="center" colspan="8">
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

