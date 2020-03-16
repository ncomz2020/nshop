<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/js/jquery.form.js"></script>
<script>
var pageType = '';
$(document).ready(function() {
	pageType = '${pageType}';
	console.log("pageType : " + pageType);
});

	function saveAction(action_type) {
		
		if(!fn_checkIsNullValidate()) { return; }
		
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
            return;
		}
		
		if ($("#file1").val() == "") {
			$("#file1").remove();
		}

		$("#updateForm").attr("action",action_string);
		
		swal({
	        title: '<spring:message code="label.common.confirm.save"/>',
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonText: "YES",
	        cancelButtonText: "NO",
	        closeOnConfirm: false
	         },function() {
			$("#updateForm").ajaxForm({
				dataType: "text",
		        beforeSend : function(xmlHttpRequest){
		            xmlHttpRequest.setRequestHeader("AJAX", "true"); 
		        },
		        success: function(responseText, statusText) {
		        	if (responseText == "succ") {
						swal({
					        title: '<spring:message code="label.common.success.save"/>',
					        type: "success",
				      		confirmButtonText: "CLOSE" },function() {
							if(pageType == 'fileMgmt'){
								//파일관리 페이지 이동
								movePage('/admin/common/file/list');
							}else{
								movePage('/admin/store/storeInfoMgmt/list');
							}
						});
		        	} else {
		    		    swal({
		    		    	title: responseText
		    		    });
		        	}
		        },
		        error: function() {
				    swal({
				    	title: '<spring:message code="label.common.fail.action"/>',
				        type: "error"
				    });
		        },
		        complete: function() {
		        	
		        }
			}).submit();
		});
	}

	function findFileAction(key) {
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
			var fileName = $(this).val().substring($(this).val().lastIndexOf("\\") + 1);
			var fileExt = getFileExt($(this).val()).toUpperCase();
			
			if (fileExt != "JPG" && fileExt != "JPEG" && fileExt != "GIF" && fileExt != "PNG" && fileExt != "BMP") {
				if(key == "comp_reg_copy"){
					if(fileExt != "PDF"){  // 사업증등록사본 pdf 파일 업로드허용
		    		    swal({
		    		    	title: '<spring:message code="label.product.prod.valid.limit.image.pdf"/>'
		    		    });
						return;
					}
				}else{
	    		    swal({
	    		    	title: '<spring:message code="label.product.prod.valid.limit.image"/>'
	    		    });
				return;
				}
			}
			
			
			$("#nshopFileForm").ajaxForm({
			dataType : "text",
	        beforeSend : function(xmlHttpRequest){
	            xmlHttpRequest.setRequestHeader("AJAX", "true"); 
	        },
			success : function(responseText, statusText) {
				if (!isEmpty(responseText) && responseText.indexOf("succ") >= 0) {
					var file_id = responseText.split(":")[1];
					$('#'+key).val(file_id);
					if(key == 'store_logo' ){
					addImage(file_id);
					}else{
						$("#comp_reg_image").text(fileName);
					}
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
		$("#productImageDiv img").remove();
		$("#productImageDiv").append("<img data-file_id=\""+ file_id+"\" src=\"/common/file/downloadImage/" + file_id + "\" onload=\"javascript:initImage(this);\">");
		
	}
	
    function goListPage() {
		var pageType = '${pageType}';
		if(pageType == 'fileMgmt'){
			//파일관리 페이지 이동
			movePage('/admin/common/file/list');
		}else{
			//상품관리 페이지 이동
			movePage('/admin/store/storeInfoMgmt/list');
		}
	}
    
	function fn_checkIsNullValidate(){
		if(isEmpty($('#store_name').val())){
			swal({
		        title: '<spring:message code="label.store.valid.input.store_name"/>'},function() {
		        	$("#store_name").focus();
			});
			return false;
		}
		
		if(isEmpty($('#comp_name').val())){
			swal({
		        title: '<spring:message code="label.store.valid.input.comp_name"/>'},function() {
		        	$("#comp_name").focus();
			});
			return false;
		}
		
		return true;
	}
</script>

<form id="updateForm" name="updateForm" enctype="multipart/form-data" method="post">

<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
<h3>
	<span class="title"><spring:message code="label.store.manage"/></span>
</h3>
	<div class="g_column w_1_1">
		<div class="unitBox" style="">
		<table>
		<tbody>
			<tr>
				<td style="width: 200px; height: 240px;" valign="top">
					<div id="productImageDiv" style="width: 198px; height: 198px; border: 1px solid #d1d1d1; position: relative;">
						<img src="/common/file/downloadImage/<c:if test="${not empty storeInfoMgmt.store_logo}">${storeInfoMgmt.store_logo}</c:if><c:if test="${empty storeInfoMgmt.store_logo}">noImage</c:if>" onload="javascript:initImage(this);" style="opacity: 0;" />
						<div style="position: absolute; left: 10px; top: 206px;">
						<a href="javascript:findFileAction('store_logo');" class="amb_btnstyle blue middle"><spring:message code="label.common.filesearch"/></a>
						<input type="hidden" id="store_logo" name="store_logo" value="${storeInfoMgmt.store_logo}" />
						</div>
					</div>
				</td>
				<td valign="top">			
				<table class="amb_form_table lineAll" >	
					<colgroup>
						<col style="width:15%;" />
						<col style="" />
						<col style="width:15%;" />
						<col style="" />
					</colgroup>	
					<tbody>
						<tr>
							<th><spring:message code="label.store.id"/><i class="bullet mandatory"></i></th>
							<td>
								<c:set var="store_id_text" />
								<c:if test="${session_user.usr_grp_id eq 1 }">
									<c:set var="store_id_text" value="${storeInfoMgmt.store_id }" />
								</c:if>
								<c:if test="${session_user.usr_grp_id eq 2 }">
									<c:set var="store_id_text" value="${session_user.usr_id}" />
								</c:if>
								${store_id_text }
								<input type="hidden" id="store_id" name="store_id" value="${store_id_text}" />
							</td>
							<th><spring:message code="label.store.name"/><i class="bullet mandatory"></i></th>
							<td><input type="text" value="${storeInfoMgmt.store_name}" class="inp" style="width:90%;" id="store_name" name="store_name" xRequired="true" title='<spring:message code="label.store.name"/>' /></td>
						</tr>
						<tr>
							<th><spring:message code="label.store.comp.name"/><i class="bullet mandatory"></i></th>
							<td><input type="text" value="${storeInfoMgmt.comp_name}" class="inp" style="width:90%;" id="comp_name" name="comp_name" xRequired="true" title='<spring:message code="label.store.comp.name"/>' /></td>
							<th><spring:message code="label.store.president.name"/></th>
							<td><input type="text" value="${storeInfoMgmt.president_name}" class="inp" style="width:90%;" id="president_name" name="president_name" title='<spring:message code="label.store.president.name"/>' /></td>
						</tr>
						<tr>
							<th><spring:message code="label.store.comp.addr"/></th>
							<td colspan="3" >
								<input type="text" class="inp"  placeholder='<spring:message code="label.common.postno"/>' style="width:20%;" id="post_num" name="post_num" value="${storeInfoMgmt.post_num}" >
								<a href="#" onclick="sample6_execDaumPostcode()"  class="amb_btnstyle blue middle" ><spring:message code="label.common.find.postno"/></a></br> 
								<input type="text" class="inp" id="comp_addr" name="comp_addr" placeholder='<spring:message code="label.common.addr"/>' style="width:50%;" value="${storeInfoMgmt.comp_addr}" >
								<input type="text" class="inp" id="comp_addr2" name="comp_addr2" placeholder='<spring:message code="label.common.addr.detail"/>' style="width:50%;" value="${storeInfoMgmt.comp_addr2}" >
							</td>
						</tr>
				        <tr>
							<th><spring:message code="label.store.main.phone"/></th>
							<td><input type="text" value="${storeInfoMgmt.main_phone_num}" class="inp" style="width:90%;" id="main_phone_num" name="main_phone_num" title='<spring:message code="label.store.main.phone"/>' /></td>
							<th>FAX</th>
							<td><input type="text" value="${storeInfoMgmt.fax_num}" class="inp" style="width:90%;" id="fax_num" name="fax_num" title="FAX" /></td>
						</tr>
						<tr>
							<th><spring:message code="label.store.comp.reg.num"/></th>
							<td><input type="text" value="${storeInfoMgmt.comp_reg_num}" class="inp" style="width:90%;" id="comp_reg_num" name="comp_reg_num" title='<spring:message code="label.store.comp.reg.num"/>' /></td>
							<th><spring:message code="label.store.comp.reg.copy"/></th>
							<td ><span class="title" id="comp_reg_image">${storeInfoMgmt.org_filename1}</span>
								<a href="javascript:findFileAction('comp_reg_copy');" class="amb_btnstyle blue middle"><spring:message code="label.common.filesearch"/></a>
								<input type="hidden" id="comp_reg_copy" name="comp_reg_copy" value="${storeInfoMgmt.comp_reg_copy}" />
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
	<!-- rowBox 반복단위 -->
	<div class="paging left">
		<div class="fr btnArea middle">
			<a href="javascript:saveAction('${action_type}');" class="amb_btnstyle blue middle">
			<c:if test="${action_type eq 'update'}">
			<spring:message code="label.common.save"/>
			</c:if>
			<c:if test="${action_type eq 'insert'}">
			<spring:message code="label.common.regist"/>
			</c:if>
			</a>
			<c:if test="${action_type eq 'update'}">
				<a href="javascript:goListPage();" class="amb_btnstyle gray middle"><spring:message code="label.common.cancle"/></a>
		    </c:if>
		</div>
	</div>
</form>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('post_num').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('comp_addr').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('comp_addr2').focus();
            },
            theme: {
            	bgColor: "#617FD9", //바탕 배경색   
            	searchBgColor: "#617FD9", //검색창 배경색
            	queryTextColor: "#FFFFFF" //검색창 글자색
            }
        }).open();
    }
</script>				
