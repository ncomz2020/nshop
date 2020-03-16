<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/js/jquery.form.js"></script>
<script>
var pageType = '';
$(document).ready(function() {
});

	function saveAction(action_type) {
		
		if(!fn_checkIsNullValidate()) { return; }
		
		$("#updateForm").attr("action","modPwdAction");
		
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
								movePage('/front/mypage/myaccount/modPwd');
							});
		        	} else if(responseText == 'notmatch'){
						swal({
					        title: '<spring:message code="label.mypage.valid.input.currentPwd.notequal"/>'
					    });
		        	} else if(responseText == 'errorpwd'){
		        		swal({
					        title: '<spring:message code="msg.member.join.valid.input.pw.does.not.match"/>'
					    });	        		
		        	}
		        },
		        error: function() {
					swal({
			        title: '<spring:message code="label.common.fail.action"/>'
				    });		        	
		        },
		        complete: function() {
		        	
		        }
			}).submit();
		});
	}
	
	function fn_checkIsNullValidate(){
		if(isEmpty($('#currentPwd').val())){
			swal({
		        title: '<spring:message code="label.mypage.valid.input.currentPwd"/>',
		        type: "warning",
	      		confirmButtonText: "CLOSE" },function() {		        		
	      		$("#currentPwd").focus();
			});			
			return false;
		}
		
		if(isEmpty($('#newPwd').val())){
			swal({
		        title: '<spring:message code="label.mypage.valid.input.newPwd"/>',
		        type: "warning",
	      		confirmButtonText: "CLOSE" },function() {		        		
	      		$("#newPwd").focus();
			});				
			return false;
		}
		
		if(isEmpty($('#newPwdConfirm').val())){
			swal({
		        title: '<spring:message code="label.mypage.valid.input.newPwdConfirm"/>',
		        type: "warning",
	      		confirmButtonText: "CLOSE" },function() {		        		
	      			$("#newPwdConfirm").focus();
			});				
			return false;
		}
		
		if($('#newPwd').val() != $('#newPwdConfirm').val()){
			swal({
		        title: '<spring:message code="label.mypage.valid.input.newPwd.notequal"/>',
		        type: "warning",
	      		confirmButtonText: "CLOSE" },function() {		        		
	      			$("#newPwdConfirm").focus();
			});			
			return false;
		}
		
		return true;
	}
</script>
<body>
<form id="updateForm" name="updateForm" method="post">
<div id="contentWrap" class="contentWrap">
<div id="content" class="content wrap">
<div class="rowBox mgT30">
	<h3>
		<span class="title"><spring:message code="label.mypage.modify.password"/></span>
	</h3>
	<div class="g_column w_1_1">
		<div class="unitBox" style="">
			<table class="amb_form_table lineAll" >	
				<colgroup>
					<col style="width:15%;" />
					<col style="" />
				</colgroup>
				<tbody>
					<tr>
						<th><spring:message code="label.mypage.modify.currentPassword"/><i class="bullet mandatory"></i></th>
						<td><input type="password" class="inp" style="width:50%;" id="currentPwd" name="currentPwd" placeholder='<spring:message code="label.mypage.modify.currentPassword"/>' /></td>
					</tr>
					<tr>
						<th><spring:message code="label.mypage.modify.newPassword"/><i class="bullet mandatory"></i></th>
						<td><input type="password" class="inp" style="width:50%;" id="newPwd" name="newPwd" placeholder='<spring:message code="label.mypage.modify.newPassword"/>' /></td>
					</tr>
					<tr>
						<th><spring:message code="label.mypage.modify.confirmPassword"/><i class="bullet mandatory"></i></th>
						<td><input type="password" class="inp" style="width:50%;" id="newPwdConfirm" name="newPwdConfirm" placeholder='<spring:message code="label.mypage.modify.confirmPassword"/>' /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div class="paging left">
	<div class="fr btnArea middle">
		<a href="javascript:saveAction();" class="amb_btnstyle blue middle"><spring:message code="label.common.save"/></a>
		<%-- <a href="javascript:history.go(-1);" class="amb_btnstyle gray middle"><spring:message code="label.common.cancle"/></a> --%>
	</div>
</div>
</div>
</div>
</form>