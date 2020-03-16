<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src='/js/tinymce/tinymce.min.js'></script>
<script src="/js/jquery.form.js"></script>
<script type="text/javascript">
	var arrCategory = [];
	var arrFileInfo = [];
	$(document).ready(function() {
		init();

		var rex = new RegExp("[^0-9]", "g");
		$(".numCheck").on("keyup keypress blur change", function() {
			var ok = rex.exec($.number(this.value));
			if (ok) {
				this.value = $.number(this.value.replace(rex, ''));
			}
		});

		$('#fileupload').click(function() {
			if (arrFileInfo.length > 0) {
				openSelectImage(arrFileInfo.join(','));
			} else {
				openSelectImage();
			}
		});

		$('#setCategory').click(function() {
			if (arrCategory.length > 0) {
				openSelectCategory(arrCategory.join(','));
			} else {
				openSelectCategory();
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
		tinymce.init({
		selector : 'textarea',
		width : 'calc(100% - 2px)',
		schema : 'html5',
		height : 600,
		menubar : false,
		statusbar : false,
		plugins : "autosave code link media image table textcolor",
		toolbar : "fontsizeselect | undo redo | uploadImageButton | bold underline italic forecolor | alignleft aligncenter alignright alignjustify   | code  ",
		language : '<spring:message code="label.common.locale"/>',
		plugins : [ 'autoresize', 'code' ],
		autoresize_min_height : 600,
		relative_urls : false,
		setup : function(editor) {
			editor.addButton('uploadImageButton', {
			tooltip : "Image",
			icon : "image",
			onclick : function() {
				if ($("#nshopFileDiv").length > 0) {
					$("#nshopFileDiv").remove();
				}

				var sHtml = "";
				sHtml += "<div id=\"nshopFileDiv\" style=\"display:none;\">";
				sHtml += "<form id=\"nshopFileForm\" name=\"nshopFileForm\" action=\"/common/file/insertTempImageAction\" method=\"post\" enctype=\"multipart/form-data\">";
				sHtml += "<input type=\"file\" id=\"nshopFile\" name=\"file\">";
				sHtml += "</form>";
				sHtml += "</div>";
				$("body").append(sHtml);

				$("#nshopFile").change(function() {
					var fileExt = getFileExt($(this).val()).toUpperCase();
					if (fileExt != "JPG" && fileExt != "JPEG" && fileExt != "GIF" && fileExt != "PNG" && fileExt != "BMP") {
						swal({
					        title: '<spring:message code="label.product.prod.valid.limit.image"/>'
					    });
						return;
					}
					$("#nshopFileForm").ajaxForm({
					dataType : "text",
			        beforeSend : function(xmlHttpRequest){
			            xmlHttpRequest.setRequestHeader("AJAX", "true"); 
			        },
					success : function(responseText, statusText) {
						if (!isEmpty(responseText) && responseText.indexOf("succ") >= 0) {
							var file_id = responseText.split(":")[1];
							$("body").append("<div style=\"position:absolute;top:-9999px;\"><img src=\"/common/file/downloadImage/" + file_id + "\" onload=\"javascript:onLoadEditorImage(this, '" + editor.id + "');\"></div>");
						} else {
							swal({
						        title: responseText
						    });
						}
					},
					}).submit();
				});

				$("#nshopFile").trigger("click");
			}
			});
		}
		});
	}

	function onLoadEditorImage(image, editorId) {
		var width = $(image).width();
		var height = $(image).height();
		var sHtml = "<p><img src=\"" + $(image).attr("src") + "\" width=\"" + width + "\" height=\"" + height + "\"></p>";
		tinymce.get(editorId).insertContent(sHtml);
		$(image).parent("div").remove();
	}

	function goListPage() {
		$("#prodForm").attr("action", "list");
		$("#prodForm").submit();
	}

	function onSelectCategory(arr) {
		$('#selectedCategory').html('');

		var str = '';
		arrCategory.length = 0;
		for (var i = 0; i < arr.length; i++) {
			arrCategory.push(arr[i].category_id);
			if (i == (arr.length - 1)) {
				str = str + arr[i].path;
			} else {
				str = str + arr[i].path + '<br/>';
			}
		}

		$('#selectedCategory').html(str);

		if (arr.length > 0) {
			$('#onCategory').show();
		} else {
			$('#onCategory').hide();
		}
	}

	function onSelectImage(arr) {
		$("#productImageDiv img").remove();
		arrFileInfo.length = 0;
		for (var i = 0; i < arr.length; i++) {
			if (i == 0) {
				var file_id = arr[i];
				$("#productImageDiv").append("<img src=\"/common/file/downloadImage/" + file_id + "\" onload=\"javascript:initImage(this);\" style=\"opacity:0;\">");
			}
			arrFileInfo.push(arr[i]);
		}
	}

	function isValidProduct() {
		if (arrFileInfo.length == 0) {
			swal({
		        title: '<spring:message code="label.product.prod.valid.input.image"/>'
		    },function() {
				$("#fileupload").trigger("click");
			});
			return false;
		}

		if (isEmpty($('#prod_name').val())) {
			swal({
		        title: '<spring:message code="label.product.prod.valid.input.name"/>'},function() {
				$('#prod_name').focus();
			});
			return false;
		}

		if (isEmpty($('#prod_price').val())) {
			swal({
		        title: '<spring:message code="label.product.prod.valid.input.price"/>'},function() {
				$('#prod_price').focus();
			});	
			return false;
		}

		if (arrCategory.length == 0) {
			swal({
		        title: '<spring:message code="label.product.prod.valid.select.category"/>'},function() {
		        	$("#setCategory").trigger("click");
			});	
			return false;
		}

		if (isEmpty(tinymce.get('prod_detail_txt').getContent())) {
			swal({
		        title: '<spring:message code="label.product.prod.valid.input.detail"/>'},function() {
					$("#tab01").trigger("click");
					tinymce.get("prod_detail_txt").focus();
			});	
			return false;
		}

		if (isEmpty(tinymce.get('prod_delivery_info_txt').getContent())) {
			swal({
		        title: '<spring:message code="label.product.prod.valid.input.delivery"/>'},function() {
					$("#tab02").trigger("click");
					tinymce.get("prod_delivery_info_txt").focus();
			});
			return false;
		}

		if (isEmpty(tinymce.get('prod_refund_info_txt').getContent())) {
			swal({
		        title: '<spring:message code="label.product.prod.valid.input.refund"/>'},function() {
					$("#tab03").trigger("click");
					tinymce.get("prod_refund_info_txt").focus();
			});	
			return false;
		}
		return true;
	}

	function goSave() {
		if (!isValidProduct()) {
			return;
		}

		$('#prod_price').val($('#prod_price').val().replace(/,/g, ''));

		$('textarea').each(function(index) {
			var content = tinymce.get($(this).attr('id')).getContent();
			$('#' + $(this).attr('target_id')).val(content);
		});

		$('#category_info').val(arrCategory.join(','));
		$('#file_info').val(arrFileInfo.join(','));

		var param = $("#prodForm").serialize();

		$.ajax({
		url : "addAction",
		type : "POST",
		data : param,
		dataType : "json",
        beforeSend : function(xmlHttpRequest){
            xmlHttpRequest.setRequestHeader("AJAX", "true"); 
        },
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				swal({
			        title: '<spring:message code="label.common.success.save"/>'
			    },function() {
					var param = new Object();
					param.prod_id = data.productInfo.prod_id;
					movePage("detail", param);
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
	}
</script>
</head>
<body>
	<form id="prodForm" name="prodForm" method="post">
		<input type="hidden" id="prod_detail" name="prod_detail" />
		<input type="hidden" id="prod_delivery_info" name="prod_delivery_info" />
		<input type="hidden" id="prod_refund_info" name="prod_refund_info" />
		<input type="hidden" id="category_info" name="category_info" />
		<input type="hidden" id="file_info" name="file_info" />
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
								<td style="width: 200px; height: 200px;">
									<div id="productImageDiv" style="width: 198px; height: 198px; border: 1px solid #d1d1d1; position: relative;">
										<div style="position: absolute; left: 90px; top: 165px;">
											<a id="fileupload" class="amb_btnstyle blue middle"><spring:message code="label.product.prod.regist.image"/></a>
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
												<th><spring:message code="label.product.prod.name"/><i class="bullet mandatory"></i></th>
												<td>
													<input type="text" id="prod_name" name="prod_name" class="inp" style="width: 90%" placeholder='<spring:message code="label.product.prod.input.name"/>' maxlength="40" />
												</td>
											</tr>
											<tr>
												<th><spring:message code="label.product.prod.price"/><i class="bullet mandatory"></i></th>
												<td>
													<input type="text" id="prod_price" name="prod_price" class="inp numCheck" style="width: 90%" placeholder='<spring:message code="label.product.prod.input.numberonly"/>' />
													<spring:message code="label.product.prod.price.unit"/>
												</td>
											</tr>
											<tr>
											 	<th><spring:message code="label.product.prod.stat"/></th>
												<td><spring:message code="label.product.prod.stat.ready"/></td>
											</tr>
											<tr>
												<th><spring:message code="label.product.category"/><i class="bullet mandatory"></i>
												<a id="setCategory" class="amb_btnstyle blue middle" style="float: right;"><spring:message code="label.common.select"/></a></th>
												<td>
													<div id="selectedCategory" style="height: 68px; overflow-y: auto;">* <spring:message code="label.product.prod.valid.select.category"/></div>
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
					<div class="unitBox" style="">
						<table class="amb_form_table lineAll">
							<colgroup>
								<col style="">
							</colgroup>
							<tbody>
								<textarea class="inp contents" id="prod_detail_txt" target_id="prod_detail" style="width: 90%;" placeholder='<spring:message code="label.product.prod.valid.input.content"/>'></textarea>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div id="tab02_contBox" class="contBox" style="display: none;">
			<div class="rowBox mgT30">
				<h3>
					<span class="title">
						<spring:message code="label.product.prod.delivery.info"/><i class="bullet mandatory"></i>
					</span>
				</h3>
				<div class="g_column w_1_1">
					<div class="unitBox" style="">
						<table class="amb_form_table lineAll">
							<colgroup>
								<col style="">
							</colgroup>
							<tbody>
								<textarea class="inp contents" id="prod_delivery_info_txt" target_id="prod_delivery_info" style="width: 90%;" placeholder='<spring:message code="label.product.prod.valid.input.content"/>'></textarea>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div id="tab03_contBox" class="contBox" style="display: none;">
			<div class="rowBox mgT30">
				<h3>
					<span class="title">
						<spring:message code="label.product.prod.refund.info"/><i class="bullet mandatory"></i>
					</span>
				</h3>
				<div class="g_column w_1_1">
					<div class="unitBox" style="">
						<table class="amb_form_table lineAll">
							<colgroup>
								<col style="">
							</colgroup>
							<tbody>
								<textarea class="inp contents" id="prod_refund_info_txt" target_id="prod_refund_info" style="width: 90%;" placeholder='<spring:message code="label.product.prod.valid.input.content"/>'></textarea>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="rowBox mgT30">
		<div class="fr btnArea middle">
			<a href="javascript:goListPage();" class="amb_btnstyle blue middle"><spring:message code="label.common.cancle"/></a>
			<a href="javascript:goSave();" class="amb_btnstyle blue middle"><spring:message code="label.common.save"/></a>
		</div>
	</div>
</body>