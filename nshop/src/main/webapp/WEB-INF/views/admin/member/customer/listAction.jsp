<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
	$(document).ready(function() {
		$('#checkboxListAll').click(function() {
			var checkedStatus = this.checked;
			$('input[name="checkboxList"]').each(function() {
				$(this).prop('checked', checkedStatus);
			});
		});
        
	});
	
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

	function goExcel() {
		if("${count}" == 0){
			swal({
				title: '<spring:message code="label.common.empty.list"/>',
			    type: "error"
			});
			return; 
		}
		
		var param = $('#calculDailyListForm').serialize();
		$.download('exportAction.ajax', param, 'post');
	}
</script>

<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code="label.member.management.customer.list"/>
			: <em class="pColor_01">&nbsp;&nbsp;<spring:message code="label.common.total"/> ${count}<spring:message code="label.common.total.count"/></em>
			</span>
			
			<div class="fr btnArea middle">
				<a href="javascript:goExcel();" class="amb_btnstyle white middle"><spring:message code="label.common.export.excel"/></a>
			</div>
		</h3>
		<div class="unitBox" style="">
			<table class="amb_table">
				<colgroup>
					<col style="width: 2%" />
					<col style="width: 3%" />
					<col style="width: 7%" />
					<col style="width: 8%" />
					<col style="width: 8%" />
					<col style="width: 8%" />
					<col style="width: 10%" />
					<col style="width: 8%" />
					<col style="width: 3%" />
					<col style="width: 3%" />
					
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="checkboxListAll" name="checkboxListAll"><label for="checkboxListAll" class="inp_func"></label></th>
						<th rowspan="2">no</th>
						<th rowspan="2"><spring:message code="label.member.join.id"/></th>
						<th rowspan="2"><spring:message code="label.member.join.name"/></th>
						<th rowspan="2"><spring:message code="label.member.join.telno"/></th>
						<th rowspan="2"><spring:message code="label.member.join.mobileno"/></th>
						<th rowspan="2"><spring:message code="label.member.join.email"/></th>
						<th rowspan="2"><spring:message code="label.member.join.date"/></th>
						<th rowspan="2" colspan="2"><spring:message code="label.member.management.edit"/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${user}" var="info" varStatus="status">
						<tr>
							<td>
								<input type="checkbox" id="check_${info.usr_id}" name="checkboxList" value="${info.usr_id}">
								<label for="check_${info.usr_id}" class="inp_func"></label>
							</td>
							<td>${status.index+1}</td>
							<td>${info.usr_id}</td>
							<td>${info.usr_nm}</td>
							<td>${info.tel_no}</td>
							<td>${info.mobile_no}</td>
							<td>${info.email}</td>
							<td>${info.join_date}</td>
							<td colspan="2">
							<a href="javascript:openModal('/admin/member/customer/customerPopup.ajax' , 'customerPopup' ,'usr_id=${info.usr_id}' , '600'); " class="amb_btnstyle green middle"><spring:message code="label.common.inquiry"/></a>
							<a href="javascript:deletemember('${info.usr_id}');" class="amb_btnstyle green middle"><spring:message code="label.common.delete"/></a>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty user}">
						<tr>
							<td colspan="10"><spring:message code="label.common.empty.list"/></td>
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
	</div>
</div>

<!-- rowBox 반복단위 -->