<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
.amb_btnstyle.large {
    font-size: 11px;
    font-weight: ;
    height: 20px;
    line-height: 20px;
    padding: 0px 14px;
}
</style>
<script>

	$(document).ready(function() {
		$('#checkboxListAll').click(function() {
			var checkedStatus = this.checked;
			$('input[name="checkboxList"]').each(function() {
				$(this).prop('checked', checkedStatus);
			});
		});
	});
	
	function goPopup(seq){
		var param = new Object();
		param.wish_seq = seq;
		var url = "countPopup.ajax";
		openModal(url, "countModal", param, "500");
	}	
	
	function goHome(){
		movePage("/front/product/list");
	}
	
	function openInsertUserGroup() {
		var url = "insert.ajax";
		openModal(url, 'insertModal');
	}

	function openUpdateUserGroup(usr_grp_id) {
		var param = new Object();
		param.usr_grp_id = usr_grp_id;
		var url = "update.ajax";
		openModal(url, 'updateModal', param);
	}
	
	function goOrderAction(store_id, prod_id, wish_seq) {
		var coment = "";
		
		if ($("input[name=checkboxList]:checkbox:checked").length < 1) {
			swal({
				title: '<spring:message code="label.cart.select.product"/>',
			    type: "error"
			});
			return;
		}
		
		var arrWishSeq = [];
		$('input[name="checkboxList"]').each(function() {
			var checkedStatus = this.checked;
			if (checkedStatus) {
				var wish_seq = $(this).val();
				arrWishSeq.push(wish_seq);
			}
		});
		var param = new Object();
		if(wish_seq ==null  ||  wish_seq =="" ||  wish_seq == undefined){
			param.wish_seq = arrWishSeq.join();			
		}else{
			
			param.wish_seq = wish_seq;
		}
		
		
		movePage('/front/order/list',param);
	}
	
	
	//삭제
	function goStatUpdateAction(store_id, prod_id, wish_seq, sts_cd) {
		var coment = '<spring:message code="label.common.order"/>';
		
		if(sts_cd != "O")
			coment='<spring:message code="label.common.delete"/>';
		
		

		var arrWishSeq = [];
		$('input[name="checkboxList"]').each(function() {
			var checkedStatus = this.checked;
			if (checkedStatus) {
				var wish_seq = $(this).val();
				arrWishSeq.push(wish_seq);
			}
		});
		console.log(arrWishSeq)

		
		var param = new Object();
		if(wish_seq !=null){
			param.wish_seq = wish_seq;
		}else{
			param.wish_seq = arrWishSeq.join();			
		}
		console.log(param);
		
/* 		$.alertable.confirm('(' + coment + ')' + ' <spring:message code="label.product.prod.confirm.change.back"/>').then(function() {
			$.ajax({
			url : "deleteCartAction.json",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data) {
				var result = data.result;
				if (result == "succ") {
					$.alertable.alert('(' + coment + ')' + ' <spring:message code="label.common.success.action"/>').then(function() {
						movePage('/front/mypage/cart/list');
					});
				} else {
					$.alertable.alert(result);
				}
			},
			});
		}); 
		 */
		 
		swal({
	        title: '' + coment + '' + ' <spring:message code="label.product.prod.confirm.change.back"/>',
	        showCancelButton: true,
	        confirmButtonText: '<spring:message code="label.common.yes"/>',
	        cancelButtonText: '<spring:message code="label.common.no"/>',
	        closeOnConfirm: false
	    },function () {
	    	if(sts_cd == "O"){
	    		movePage('/front/order/list',param);
			 }else if(sts_cd == "R"){
				 $.ajax({
						url : "deleteCartAction.json",
						type : "POST",
						data : param,
						dataType : "json",
						success : function(data) {
							var result = data.result;
							if (result == "succ") {
								swal({
						      		title: '' + coment + '' + ' <spring:message code="label.common.success.action"/>', 
						      		}, function(){
						      		movePage('/front/mypage/cart/list');
						      	});
								
							} else {
								swal({
						      		title: result, 
						      	});
							}				
						},
					});
			 }
	    });
	}
	
	function goDeleteAction(){
		
		if ($("input[name=checkboxList]:checkbox:checked").length < 1) {
			swal({
				title: '<spring:message code="label.cart.select.product"/>',
			    type: "error"
			});
			return;
		}
		
		var arrWishSeq = [];
		$('input[name="checkboxList"]').each(function() {
			var checkedStatus = this.checked;
			if (checkedStatus) {
				var wish_seq = $(this).val();
				arrWishSeq.push(wish_seq);
			}
		});
		
		var param = new Object();
		param.wish_seq = arrWishSeq.join();			
		
		swal({
	        title: '<spring:message code="label.cart.select.delete"/>',
	        showCancelButton: true,
	        confirmButtonText: '<spring:message code="label.common.yes"/>',
	        cancelButtonText: '<spring:message code="label.common.no"/>',
	        closeOnConfirm: false
	    },function () {
			$.ajax({
			url : "deleteCartAction.json",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data) {
				var result = data.result;
				if (result == "succ") {
					swal({
			      		title: '<spring:message code="label.common.success.delete"/>', 
			      		type: "success",
			      		confirmButtonText: '<spring:message code="label.common.close"/>'
			      	});
					movePage('/front/mypage/cart/list');
				} else {
					swal({
			      		title: result, 
			      	});
				}				
			},
			});
	    });
	}
</script>



 <div id="contentWrap" class="contentWrap">
		<div id="content" class="content wrap productDetail">
			<form id="prodForm" name="prodForm" method="post">
			 	
			</form>
			<div class="rowBox mgT30 data">
				<div class="g_column w_1_1">
					<h3>
						<span class="title"><spring:message code="label.front.product.detail.basket.btn"/></span>
						 
					</h3>
					<div class="unitBox">
						<table class="amb_table">
							<colgroup>
								<col style="width: 3%" />
								<col style="width: 5%;" />
								<col style="width: 30%;" />
								<col style="width: 10%;" />
								<col style="width: 10%;" />
								<col style="width: 10%;" />
								<col style="width: 10%;" />  
								<col style="width: 10%;" />  
							</colgroup>
							<thead>
								<tr class="colHeaders">
									<th><input type="checkbox" id="checkboxListAll" name="checkboxListAll"><label for="checkboxListAll" class="inp_func"></th>
									<th><spring:message code="label.cart.image"/></th>
									<th><spring:message code="label.cart.product.name"/></th>
									<th><spring:message code="label.cart.product.price"/></th>
									<th><spring:message code="label.cart.amount"/></th>
									<th><spring:message code="label.cart.delivery.fee"/></th>
									<th><spring:message code="label.cart.store"/></th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							
								<c:forEach items="${list}" var="info" varStatus="status">
									<c:if  test = "${info.flag eq true}">		
									<tr>
										<td>
											<input type="checkbox" id="check_${status.count}" name="checkboxList" value="${info.wish_seq}">
											<label for="check_${status.count}" class="inp_func">
										</td>
										<td style="text-align: left;">
											<div style="width: 50px; height: 50px; overflow: hidden; position: relative;">
												<c:if test="${not empty info.imageFileList}">
													<%-- <c:if test="${fn:length(info.imageFileList) > 1}">
														<div style="text-align: right; position: absolute; left: 35px; top: 35px; width: 15px; height: 15px; font-weight: bold; background-color: #000; color: #fff; opacity: 0.5;">+${fn:length(info.imageFileList) - 1}</div>
													</c:if>
													<c:set var="imageFileIdList" value="" />
													<c:forEach items="${info.imageFileList}" var="imageFile">
														<c:if test="${imageFileIdList != ''}">
															<c:set var="imageFileIdList" value="${imageFileIdList}," />
														</c:if>
														<c:set var="imageFileIdList" value="${imageFileIdList}${imageFile.file_id}" />
													</c:forEach> --%>
													<img src="/common/file/downloadImage/${info.imageFileList[0].file_id}" onload="javascript:initImage(this);">
												</c:if>
											</div>
										</td>
										<td>
											<a href="javascript:movePage('/front/product/detail', {prod_id: '${info.prod_id}',pageType:'productList'});">${info.prod_name}</a>
											<br />(${info.prod_id})
										</td>
										 
										<td>
											<fmt:formatNumber value="${info.prod_price}" pattern="#,###" />
										</td>
										<td>
											${info.order_cnt} <a href="javascript:goPopup('${info.wish_seq}');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.common.change"/></a>
										</td>
										<td rowspan="${info.store_cnt}"> <fmt:formatNumber value="${info.shipping_fee}" pattern="#,###" /> </td>
										<td rowspan="${info.store_cnt}">${info.store_id}</td>
										<td>
											<div class="stateBox2 before2">
												<a href="javascript:goStatUpdateAction('${info.store_id}','${info.prod_id}',  '${info.wish_seq}', 'O');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.common.order"/></a>
												<a href="javascript:goStatUpdateAction('${info.store_id}','${info.prod_id}',  '${info.wish_seq}', 'R');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.common.delete"/></a>
											</div>
										</td>
										<c:set var="prevStoreId" value="${info.store_id}" />
									</tr>
									</c:if>
								 	<c:if test= "${info.flag ne true}">
							 			<tr>
										<td>
											<input type="checkbox" id="check_${status.count}" name="checkboxList" value="${info.wish_seq}">
											<label for="check_${status.count}" class="inp_func">
										</td>
										<td style="text-align: left;">
											<div style="width: 50px; height: 50px; overflow: hidden; position: relative;">
												<c:if test="${not empty info.imageFileList}">
													<%-- <c:if test="${fn:length(info.imageFileList) > 1}">
														<div style="text-align: right; position: absolute; left: 35px; top: 35px; width: 15px; height: 15px; font-weight: bold; background-color: #000; color: #fff; opacity: 0.5;">+${fn:length(info.imageFileList) - 1}</div>
													</c:if>
													<c:set var="imageFileIdList" value="" />
													<c:forEach items="${info.imageFileList}" var="imageFile">
														<c:if test="${imageFileIdList != ''}">
															<c:set var="imageFileIdList" value="${imageFileIdList}," />
														</c:if>
														<c:set var="imageFileIdList" value="${imageFileIdList}${imageFile.file_id}" />
													</c:forEach> --%>
													<img src="/common/file/downloadImage/${info.imageFileList[0].file_id}" onload="javascript:initImage(this);">
												</c:if>
											</div>
										</td>
										<td>
											<a href="javascript:movePage('/front/product/detail', {prod_id: '${info.prod_id}',pageType:'productList'});">${info.prod_name}</a>
											<br />(${info.prod_id})
										</td>
										 
										<td>
											<fmt:formatNumber value="${info.prod_price}" pattern="#,###" />
										</td>
										<td>
											${info.order_cnt} <a href="javascript:goPopup('${info.wish_seq}');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.common.change"/></a>
										</td>
										<c:if test="${prevStoreId ne info.store_id}">
										<td>
											  <fmt:formatNumber value="${info.shipping_fee}" pattern="#,###" />
										</td>
										<td>
											  ${info.store_id}
										</td>
										</c:if>
										<td>
										  	<div class="stateBox2 before2">
										  		<a href="javascript:goStatUpdateAction('${info.store_id}','${info.prod_id}',  '${info.wish_seq}', 'O');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.common.order"/></a>
												<a href="javascript:goStatUpdateAction('${info.store_id}','${info.prod_id}',  '${info.wish_seq}', 'R');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.common.delete"/></a>
										  	</div>
										 </td>
										</tr>
								 	</c:if>
								</c:forEach>
								<c:if test="${empty list}">
									<tr>
										<td colspan="8"><spring:message code="label.common.empty.list"/></td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<a href="javascript:goDeleteAction();" class="amb_btnstyle gray large"><spring:message code="label.cart.delete"/></a>
					<div class="paging center">
						<ul class="paginglist">
							<div>
								<a href="javascript:goOrderAction();" class="amb_btnstyle gray middle"><spring:message code="label.cart.order"/></a>
								<a href="javascript:goHome();" class="amb_btnstyle gray middle"><spring:message code="label.cart.home"/></a>
							</div>
						</ul>
					</div> 
					<!-- 페이징 end -->
				
				</div>
			</div>
			
		</div>
	 


	</div> 
