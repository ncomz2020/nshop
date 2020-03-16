<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
	// 상세보기
	function detailView(store_id) {
		$("#store_id").val(store_id);
		$("#fileListForm").attr("action", "detailView");
		$("#fileListForm").submit();
	}
	
	function goExcel() {
		var param = $('#fileListForm').serialize();
		$.download('exportAction.ajax', param, 'post');
	}
	
	//임시파일삭제 이벤트
	function delTempImg(){
		swal({
	        title: '<spring:message code="label.common.confirm.delete"/>',
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonText: "YES",
	        cancelButtonText: "NO",
	        closeOnConfirm: false
	        },function() {
			$.ajax({
				url : "deleteTempImg.ajax",
				type : "POST",
				success : function(data) {
					swal({
				        title: '<spring:message code="label.common.success.delete"/>',
				        type: "success",
			      		confirmButtonText: "CLOSE" },function() {
			      			searchList($("#page").val());
					});					
				},
				error : function() { 
					swal({
				        title: '<spring:message code="label.common.fail.action" />');
				    });
				}
			});
		}, function() {
			//취소이벤트..
		});
	}
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30 data">
	<div class="g_column w_1_1">
		<h3>
			<span class="title">
				<spring:message code="label.file.filelist.title" />
			</span>
			<div class="fr btnArea middle">
				<a href="javascript:delTempImg();" class="amb_btnstyle gray middle">
					<spring:message code="label.file.filelist.delete.temp.img" />
				</a>
				<a href="javascript:goExcel();" class="amb_btnstyle white middle">
					<spring:message code="label.file.filelist.download.excel" />
				</a>
			</div>
		</h3>
		<div class="unitBox">
			<table class="amb_table">
				<colgroup>
					<col style="width: 5%;" />
					<col style="width: 15%;" />
					<col style="width: 25%;" />
					<col style="width: 10%;" />
					<col style="width: 15%;" />
					<col style="width: 10%;" />
					<col style="width: 6%;" />
				</colgroup>
				<thead>
					<tr class="colHeaders">
						<th>
							<spring:message code="label.file.filelist.no" />
						</th>
						<th>
							<spring:message code="label.file.filelist.filename" />
						</th>
						<th>
							<spring:message code="label.file.filelist.subject" />
						</th>
						<th>
							<spring:message code="label.file.filelist.filetype" />
						</th>
						<th>
							<spring:message code="label.file.filelist.updatetime" />
						</th>
						<th>
							<spring:message code="label.file.filelist.volume" />
						</th>
						<th>
							<spring:message code="label.file.filelist.istemp" />
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="fileInfo" varStatus="status">
						<tr>
							<td>${fileInfo.rownum}</td>
							<td>
								<a href="javascript:downloadFile('${fileInfo.file_id}');">${fileInfo.org_filename}</a>
							</td>
							<td>
								<c:choose>
									<c:when test="${fileInfo.file_type == 'stroe logo' || fileInfo.file_type == 'stroe comp reg copy'}">
										<a href="javascript:movePage('/admin/store/storeInfoMgmt/detailView', {store_id: '${fileInfo.store_id}',pageType:'fileMgmt'});">${fileInfo.STORE_NAME}</a>
									</c:when>
									<c:otherwise>
										<a href="javascript:movePage('/admin/product/detail', {prod_id: '${fileInfo.prod_id}',pageType:'fileMgmt' });">${fileInfo.prod_name}</a>
									</c:otherwise>
								</c:choose>
							</td>
							<td>${fileInfo.file_type_text}</td>
							<td>${fileInfo.update_datetime}</td>
							<td>${fileInfo.file_size}</td>
							<td>${fileInfo.temp_yn}</td>
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

