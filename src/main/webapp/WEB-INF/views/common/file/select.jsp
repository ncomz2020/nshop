<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
.smallImageDiv {
	width: 58px;
	height: 58px;
	border: 1px solid #eee;
	overflow: hidden;
	position: relative;
}

#selectImageModal img {opacity:0;}
</style>
<script src="/js/jquery.form.js"></script>
<script>
	$(document).ready(function() {
		var selectedImageId = "${param.selectedImageId}";
		if (!isEmpty(selectedImageId)) {
			var arr = selectedImageId.split(",");
			for (var i = 0; i < arr.length; i++) {
				addImage(arr[i]);
			}
		}
	});

	function findFileAction() {
		if ($("#smallImageTable img").length >= 5) {
			swal({
		        title: '<spring:message code="label.product.prod.valid.file.available.length"/>'
		    });
			return;
		}

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
			var f=this.files[0];
			
			var maxSize = 1024 * 1024 * 5;
		 	if (f.size > maxSize || f.fileSize > maxSize)
	        {
				swal({
			        title: '<spring:message code="label.product.prod.valid.file.maxsize"/>'
			    });
	           	return;
	        }
			
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
					addImage(file_id);
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

	function addImage(file_id) {
		if ($("#largeImageDiv img").length == 0) {
			initLargeImageDiv(file_id);
		}
		var div = $("#smallImageTable td").eq($("#smallImageTable img").length).children("div");
		var callback = "${param.callback}";
		if (!isEmpty(callback)) {
			$(div).append("<div style=\"position:absolute;z-index:1;left:45px;\"><a href=\"javascript:deleteImage('" + file_id + "');\"><i class=\"ambicon-015_mark_times\"></i></a></div>");
		}
		$(div).append("<img data-file_id=\"" + file_id + "\" src=\"/common/file/downloadImage/" + file_id + "\" style=\"cursor:pointer;\" onload=\"javascript:initImage(this);\">");
		initDivImage(div);
	}
	
	function initDivImage(element) {
		$(element).children("img").click(function() {
			initLargeImageDiv($(this).data("file_id"));
		});
		$(element).children("img").mouseout(function() {
			$(this).parent("div").css({border: "1px solid #eee"}, 200);
		});
		$(element).children("img").mouseover(function() {
			$(this).parent("div").css({border: "1px solid #f00"}, 200);
		});
	}
	
	function initLargeImageDiv(file_id) {
		$("#largeImageDiv img").remove();
		$("#largeImageDiv").append("<img data-file_id=\""+ file_id+"\" src=\"/common/file/downloadImage/" + file_id + "\" onload=\"javascript:initImage(this);\">");
	}
	
	function deleteImage(file_id) {
		var largeImageDiv = $("#largeImageDiv img[data-file_id="+file_id+"]");
		if ($(largeImageDiv).length > 0) {
			$(largeImageDiv).remove();
		}
		$("#smallImageTable img[data-file_id="+file_id+"]").parent("div").html("");
		$("#smallImageTable td div").each(function() {
			if (isEmpty($(this).html())) {
				var nextDiv = $(this).parent("td").next("td").children("div");
				$(this).html($(nextDiv).html());
				$(nextDiv).html("");
				initDivImage(this);
			}
		});
		$("#smallImageTable td img:first").trigger("click");
	}

	function selectImageAction() {
		var arr = new Array();
		$("#smallImageTable img").each(function() {
			arr.push($(this).data("file_id"));
		});
		var callback = "${param.callback}";
		if (!isEmpty(callback)) {
			eval(callback + "(arr)");
		}
		$("#selectImageModal a.close").trigger("click");
	}
</script>
<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
<div class="modal-content">
	<h1 class="popupHeader">
		<span class="title"><spring:message code="label.product.prod.image"/></span>
		<a href="javascript:;" class="close" onClick="javascript:closeModal(this);">
			<i class="ambicon-015_mark_times"></i>
		</a>
	</h1>

	<div id="content" class="content">
		<div class="rowBox">
			<div class="unitBox" style="">
				<div id="largeImageDiv" style="border: 1px solid #eee; width: 300px; height: 300px; overflow: hidden;"></div>
				<div style="width: 300px; height: 60px;">
					<table id="smallImageTable" style="width: 100%; height: 100%;">
						<colgroup>
							<col style="width: 20%;">
							<col style="width: 20%;">
							<col style="width: 20%;">
							<col style="width: 20%;">
							<col style="width: 20%;">
						</colgroup>
						<tr>
							<td>
								<div class="smallImageDiv"></div>
							</td>
							<td>
								<div class="smallImageDiv"></div>
							</td>
							<td>
								<div class="smallImageDiv"></div>
							</td>
							<td>
								<div class="smallImageDiv"></div>
							</td>
							<td>
								<div class="smallImageDiv"></div>
							</td>
						</tr>
					</table>
				</div>
				<c:if test="${param.callback != null && param.callback != ''}">
					<div class="fr btnArea middle">
						<a href="javascript:findFileAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.filesearch"/></a>
						<a href="javascript:selectImageAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.confirm"/></a>
					</div>
				</c:if>
			</div>
		</div>
		<!-- rowBox 반복단위 -->
	</div>
	</div>
</div>