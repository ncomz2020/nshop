<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<script src='/js/tinymce/tinymce.min.js'></script>
<style>
.mce-edit-area {
	border-width: 0px !important;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	pageType = '${pageType}';
	console.log("pageType : " + pageType);
	init();

	$('.contBox').css('display', 'none');
	$('#tab01_contBox').css('display', 'block');
	$('#fileupload').click(function() {
		var file_id = "${productInfo.prod_id}";
		if (file_id != '') {
			openImageList("${productInfo.file_id}");
		} else {
			openImageList();
		}
	});

	$(document).on("click", ".tab-area li a", function() {
		var thisId = $(this).attr('id');
		var thisParent = $(this).parent('li');

		thisParent.siblings().removeClass('on');
		thisParent.addClass('on');

		$('.contBox').css('display', 'none');
		$('#' + thisId + '_contBox').css('display', 'block');
	});
});


function init() {
	var editorInstance = tinymce.init({
	selector : 'textarea',
	width : 'calc(100% - 2px)',
	schema : 'html5',
	readonly : true,
	menubar : false,
	statusbar : false,
	toolbar : false,
	language : '<spring:message code="label.common.locale"/>',
	plugins: ['autoresize'],
	autoresize_min_height : 600,
	relative_urls : false,
	});
	$("body").data("editorInstance", editorInstance);
}
</script>

<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
	<div class="modal-content">
		<!-- 실제 컨텐츠 작업부분 -->
		<h1 class="popupHeader">
			<span class="title">주문상품정보</span> <a href="#" class="close"
				onClick="javascript:closeModal(this);"><i
				class="ambicon-015_mark_times"></i></a>
		</h1>

		<div class="content">
			<div class="rowBox">
				<h3>
					<span class="title"><spring:message code="label.product.prod.basic.info" /></span>
				</h3>
				<div class="g_column w_1_1">
					<div id="" class="unitBox" style="overflow: hidden;">
						<table>
							<tbody>
								<tr>
									<td style="width: 200px; height: 235px;" valign="top">
										<div id="productImageDiv"
											style="width: 198px; height: 198px; border: 1px solid #d1d1d1; position: relative;">
											<img src="/common/file/downloadImage/${fileInfo.file_id}"
												onload="javascript:initImage(this);" style="opacity: 0;" />
											<div style="position: absolute; left: 90px; top: 206px;">
												<a id="fileupload" class="amb_btnstyle blue middle"><spring:message code="label.product.prod.view.image" /></a>
											</div>
										</div>
									</td>
									<td valign="top">
										<table class="amb_form_table lineAll">
											<colgroup>
												<col style="width: 200px;">
												<col style="">
											</colgroup>
											<tbody>
												<tr>
													<th><spring:message code="label.product.prod.code" /><i class="bullet mandatory"></i></th>
													<td>${productInfo.prod_id}</td>
												</tr>
												<tr>
													<th><spring:message code="label.product.prod.name" /><i class="bullet mandatory"></i></th>
													<td>${productInfo.prod_name}</td>
												</tr>
												<tr>
													<th><spring:message code="label.product.prod.price" /><i class="bullet mandatory"></i></th>
													<td><fmt:formatNumber value="${productInfo.prod_price}" pattern="#,###" />
														<spring:message code="label.product.prod.price.unit" /></td>
												</tr>
												<tr>
													<th><spring:message code="label.product.prod.stat" /></th>
													<td>${productInfo.prod_stat_name}</td>
												</tr>
												<tr>
													<th><spring:message code="label.product.category" /></th>
													<td>
														<div id="selectedCategory" style="height: 68px; overflow-y: auto;">
															<c:forEach items="${categoryInfo}" var="info" varStatus="status">
															${info.path}<br />
															</c:forEach>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>