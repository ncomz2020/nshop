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
	init();
	${user}
	$(document).on("click", ".tab-area li a", function() {
		var thisId = $(this).attr('id');
		var thisParent = $(this).parent('li');

		thisParent.siblings().removeClass('on');
		thisParent.addClass('on');

	});
});

function initializePw(){
	
	var param = new Object();
	param.email = '${user[0].email}';
	param.usr_nm = '${user[0].usr_nm}';
	swal({
        title: '비밀번호를 초기화 하시겠습니까?',
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "YES",
        cancelButtonText: "NO",
        closeOnConfirm: false
         },function() {		
        	 $.ajax({
 			    url:  '/admin/member/customer/initializePwAction.ajax',
 			    async:false,
 		 	    type: 'POST',
 			    data: param,
 			    success: function(data){
 			    	console.log("AAA : "+data);
 			    	if(data == 'error') {
 			    		swal({
 			    			title: '<spring:message code="label.common.fail.action"/>'
 					    });
 			    	} else if(data == 'success'){
 			    		swal({
 					        title: '<spring:message code="msg.search.member.transform.pw.email"/>'
 					    });
 			    		refreshList();
 			    		//movePage('/admin/member/customer/list');
 			    	} 
 			    	else{
 			    		swal({
 					        title: data
 					    });
 			    	}
 			    },
 			     error: function(e){
 			    	console.log(e.responseText.trim());
 			    },
 			    complete: function() {
 			    }
 			});
	});
}


function deletemember(usr_id){
	swal({
        title: '<spring:message code="label.common.confirm.delete"/>',
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "YES",
        cancelButtonText: "NO",
        closeOnConfirm: false
         },function() {		
        	 $.ajax({
 			    url:  '/admin/member/customer/deleteAction.ajax',
 			    async:false,
 		 	    type: 'POST',
 			    data: {'usr_id': usr_id},
 			    success: function(data){
 			    	if(data == 'error') {
 			    		swal({
 			    			title: '<spring:message code="label.common.fail.action"/>'
 					    });
 			    	} else if(data == 'success'){
 			    		swal({
 					        title: '<spring:message code="label.common.success.delete"/>'
 					    });
 			    		$("#customerPopup").remove();
 			    		refreshList();
 			    		
 			    	} 
 			    },
 			   error:function(request,status,error){
 			        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
 			       },
 			    /* error: function(e){
 			    	console.log(e.responseText.trim());
 			    }, */
 			    complete: function() {
 			    }
 			});
	});
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

<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
	<div class="modal-content">
		<!-- 실제 컨텐츠 작업부분 -->
		<h1 class="popupHeader">
			<span class="title"><spring:message code="label.member.customer.list.view"/></span> <a href="#" class="close"
				onClick="javascript:closeModal(this);"><i
				class="ambicon-015_mark_times"></i></a>
		</h1>

		<div class="content">
			<div class="rowBox">
		
				<div class="g_column w_1_1">
					<div id="" class="unitBox" style="overflow: hidden;">
						<table>
							<tbody>
								<tr>
									<td valign="top">
										<table class="amb_form_table lineAll">
											<colgroup>
												<col style="width: 200px;">
												<col style="">
											</colgroup>
												<tr>
													<th><spring:message code="label.member.join.id" /><i class="bullet mandatory"></i></th>
													<td>${user[0].usr_id}</td>
												</tr>
												<tr>
													<th><spring:message code="label.member.join.name" /><i class="bullet mandatory"></i></th>
													<td>${user[0].usr_nm}</td>
												</tr>
												<tr>
													<th><spring:message code="label.member.join.telno" /></th>
													<td>${user[0].tel_no}</td>
												</tr>
												<tr>
													<th><spring:message code="label.member.join.mobileno" /></th>
													<td>${user[0].mobile_no}</td>
												</tr>
												<tr>
													<th><spring:message code="label.member.join.email" /></th>
													<td>${user[0].email}</td>
												</tr>
												<tr>
													<th><spring:message code="label.member.join.birth" /></th>
													<td>${user[0].birth}</td>
												</tr>
												<tr>
													<th><spring:message code="label.member.join.gender" /></th>
													<td>${user[0].gender}</td>
												</tr>
												<tr>
													<th><spring:message code="label.member.join.date" /></th>
													<td>${user[0].join_date}</td>
												</tr>
												<tr>
													<th><spring:message code="label.common.postno" /></th>
													<td>${user[0].zip_cd}</td>
												</tr>
												<tr>
													<th><spring:message code="label.common.addr" /></th>
													<td>${user[0].base_addr}</td>
												</tr>
												<tr>
													<th><spring:message code="label.common.addr.detail" /></th>
													<td>${user[0].dtl_addr}</td>
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
			<div class="fr btnArea middle">
			<a href="javascript:initializePw();" class="amb_btnstyle blue middle">비밀번호초기화</a>
			&nbsp;
			<a href="javascript:deletemember('${user[0].usr_id}');" class="amb_btnstyle blue middle">회원삭제</a>
			</div>
		</div>
	</div>
</div>