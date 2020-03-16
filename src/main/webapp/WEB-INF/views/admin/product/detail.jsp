<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<script src='/js/tinymce/tinymce.min.js'></script>
<script src="/js/jquery.form.js"></script>
<style>
.mce-edit-area {
	border-width: 0px !important;
}
</style>
<script type="text/javascript">
	var pageType = '';
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

	function goListPage() {
		if(pageType == 'fileMgmt'){
			//파일관리 페이지 이동
			movePage('/admin/common/file/list');
		}else{
			//상품관리 페이지 이동
			$("#prodForm").attr("action", "list");
			$("#prodForm").submit();
		}
	}

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
</head>
<body>
	<form id="prodForm" name="prodForm" method="post">
		<div class="rowBox mgT30">
			<h3>
				<span class="title"><spring:message code="label.product.prod.basic.info"/></span>
			</h3>
			<!-- 오른쪽 정보영역 -->
			<div class="g_column w_1_1">
				<div id="" class="unitBox" style="overflow:hidden;">
					<table>
						<tbody>
							<tr>
								<td style="width: 200px; height: 235px;" valign="top">
									<div id="productImageDiv" style="width: 198px; height: 198px; border: 1px solid #d1d1d1; position: relative;">
										<img src="/common/file/downloadImage/${fileInfo.file_id}" onload="javascript:initImage(this);" style="opacity: 0;" />
										<div style="position: absolute; left: 90px; top: 206px;">
											<a id="fileupload" class="amb_btnstyle blue middle"><spring:message code="label.product.prod.view.image"/></a>
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
												<th><spring:message code="label.product.prod.code"/><i class="bullet mandatory"></i></th>
												<td>${productInfo.prod_id}</td>
											</tr>
											<tr>
												<th><spring:message code="label.product.prod.name"/><i class="bullet mandatory"></i></th>
												<td>${productInfo.prod_name}</td>
											</tr>
											<tr>
												<th><spring:message code="label.product.prod.price"/><i class="bullet mandatory"></i></th>
												<td><fmt:formatNumber value="${productInfo.prod_price}" pattern="#,###" /><spring:message code="label.product.prod.price.unit"/></td>
											</tr>
											<tr>
												<th><spring:message code="label.product.prod.stat"/></th>
												<td>${productInfo.prod_stat_name}</td>
											</tr>
											<tr>
												<th><spring:message code="label.product.category"/></th>
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
		<div class="rowBox mgT30">
			<ul class="tab-area clear">
				<li class="on">
					<a href="javascript:;" id="tab01"><spring:message code="label.product.prod.detail.info"/></a>
				</li>
				<li class="">
					<a href="javascript:;" id="tab02"><spring:message code="label.product.prod.delivery.info"/></a>
				</li>
				<li class="">
					<a href="javascript:;" id="tab03"><spring:message code="label.product.prod.refund.info"/></a>
				</li>
			</ul>
		</div>
		<div id="tab01_contBox" class="contBox" style="display: block;">
			<div class="rowBox mgT30">
				<h3>
					<span class="title">
						<spring:message code="label.product.prod.detail.info"/><i class="bullet mandatory"></i>
					</span>
				</h3>
				<div class="g_column w_1_1">
					<div class="unitBox" style="min-height: 600px;">
						<table class="amb_form_table lineAll">
							<colgroup>
								<col style="">
							</colgroup>
							<tbody>
								<textarea id="prod_detail" class="inp contents">${productInfo.prod_detail}</textarea>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div id="tab02_contBox" class="contBox" style="display: block;">
			<div class="rowBox mgT30">
				<h3>
					<span class="title">
						<spring:message code="label.product.prod.delivery.info"/><i class="bullet mandatory"></i>
					</span>
				</h3>
				<div class="g_column w_1_1">
					<div class="unitBox" style="min-height: 600px;">
						<table class="amb_form_table lineAll">
							<colgroup>
								<col style="">
							</colgroup>
							<tbody>
								<textarea id="prod_delivery_info" class="inp contents">${productInfo.prod_delivery_info}</textarea>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div id="tab03_contBox" class="contBox" style="display: block;">
			<div class="rowBox mgT30">
				<h3>
					<span class="title">
						<spring:message code="label.product.prod.refund.info"/><i class="bullet mandatory"></i>
					</span>
				</h3>
				<div class="g_column w_1_1">
					<div class="unitBox" style="min-height: 600px;">
						<table class="amb_form_table lineAll">
							<colgroup>
								<col style="">
							</colgroup>
							<tbody>
								<textarea id="prod_refund_info" class="inp contents">${productInfo.prod_refund_info}</textarea>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="rowBox mgT30">
			<div class="fr btnArea middle">
				<a href="javascript:movePage('modify', {prod_id: '${productInfo.prod_id}',pageType:'${pageType}'});" class="amb_btnstyle blue middle"><spring:message code="label.common.modify"/></a>
				<a href="javascript:goListPage();" class="amb_btnstyle blue middle"><spring:message code="label.common.list"/></a>
			</div>
		</div>
	</form>
</body>