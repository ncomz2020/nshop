<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/js/jquery.form.js"></script>
<script>

$(document).ready(function() {
});

	function saveAction(action_type) {
		var action_string="";
		if("insert" == action_type) {
			action_string = "insertAction";
		} else if ("update" == action_type) {
			action_string = "updateAction";
		} else {
			swal({
		        title: "error",
		        type: "error"
		    });
		}
		
		if ($("#file1").val() == "") {
			$("#file1").remove();
		}

		$("#updateForm").attr("action",action_string);
		$("#updateForm").ajaxForm({
			dataType: "text",
	        beforeSend : function(xmlHttpRequest){
	            xmlHttpRequest.setRequestHeader("AJAX", "true"); 
	        },
	        success: function(responseText, statusText) {
	        	if (responseText == "succ") {
	        	    swal({
			        title: "저장되었습니다."},function() {
                    movePage('/admin/popup/list');
				});
	        	} else {
					swal({
				        title: responseText
				    });
	        	}
	        },
	        error: function() {
				swal({
			        title: "오류가 발생하였습니다. 관리자에게 문의하세요."
			    });
	        },
	        complete: function() {
	        	
	        }
		}).submit();
	}
	
	function openThisPopup(popupId) {
		
		$("#"+popupId).show();
	}
	function closeThisPopup(popupId) {
		
		$("#"+popupId).hide();
	}
	
</script>

<form id="updateForm" name="updateForm" enctype="multipart/form-data" method="post">
	<input type="hidden" id="popup_id" name="popup_id" value="${popupInfo.popup_id}" />

	<!-- rowBox 반복단위 -->
	<div class="rowBox mgT30">
		<div class="g_column w_1_1">
			<div class="unitBox" style="">
				<table class="amb_form_table lineAll" >	
					<colgroup>
						<col style="width:15%;" />
						<col style="" />
						<col style="width:15%;" />
						<col style="" />
					</colgroup>	
					<tbody>
						<tr>
							<th>popup_title<i class="bullet mandatory"></i></th>
							<td><input type="text" value="${popupInfo.popup_title}" class="inp" style="width:90%;" id="popup_title" name="popup_title" /></td>
							<th>사용여부</th>
							<td>
								<select  id="use_yn" name="use_yn">
									<option value="">선택</option>
									<option value="Y" <c:if test="${popupInfo.use_yn eq 'Y' }"> selected </c:if> >Y</option>
									<option value="N" <c:if test="${popupInfo.use_yn eq 'N' }"> selected </c:if> >N</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>top</th>
							<td><input type="text" value="${popupInfo.top}" class="inp" style="width:90%;" id="top" name="top" /></td>
							<th>left</th>
							<td><input type="text" value="${popupInfo.left_p}" class="inp" style="width:90%;" id="left_p" name="left_p" /></td>
						</tr>
						<tr>
							<th>width</th>
							<td><input type="text" value="${popupInfo.width}" class="inp" style="width:90%;" id="width" name="width" /></td>
							<th>height</th>
							<td><input type="text" value="${popupInfo.height}" class="inp" style="width:90%;" id="height" name="height" /></td>
						</tr>
				        <tr>
							<th>게시시작일</th>
							<td>
								<input type="text" id="start_dttm" name="start_dttm" class="inp datepicker" readonly="readonly" value="${popupInfo.start_dttm}" style="width: 120px;" />
							</td>
							<th>게시종료일</th>
							<td>
								<input type="text" id="end_dttm" name="end_dttm" class="inp datepicker" readonly="readonly" value="${popupInfo.end_dttm}" style="width: 120px;" />
							</td>
						</tr>
				        <tr>
							<th>팝업이미지</th>
							<td colspan="3">
								<input type="file" id="file1" name="file1" value="${popupInfo.file_id}" />
							</td>
						</tr>
				        <tr>
							<th>imagepath</th>
							<td colspan="3">
								<input type="text" value="${popupInfo.image_path}" class="inp" style="width:90%;" id="image_path" name="image_path" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- rowBox 반복단위 -->
	<div class="paging left">
		<div class="fr btnArea middle">
			<a href="javascript:saveAction('${action_type}');" class="amb_btnstyle blue middle">저장</a>
			<a href="javascript:openThisPopup('pop_${popupInfo.popup_id}');" class="amb_btnstyle blue middle">보기</a>
			<a href="javascript:movePage('/admin/popup/list');" class="amb_btnstyle gray middle">취소</a>
		</div>
	</div>
	<div id="pop_${popupInfo.popup_id}" style="position:absolute; height:${popupInfo.height};width:${popupInfo.width};top:${popupInfo.top};left:${popupInfo.left_p}; background-color:#FFFFFF; z-index:999; display:none; ">
		<img src="/common/file/downloadImage/${popupInfo.file_id}" onload="javascript:initImage(this);" style="opacity: 0;" />
		<div style="float:right;">
			<a class="amb_btnstyle blue middle" id="testa" onclick="javascript:closeThisPopup('pop_${popupInfo.popup_id}');">닫기</a>
		</div>
	</div>
</form>
				
