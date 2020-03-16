<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
	$(document).ready(function() {		
		if("${userGrup}" == "2"){
			$("#search_opt").find("option:eq(4)").remove();
		}
		
	//	setTimeout("selectBoxInit()", 100);	
		
		$('#checkboxListAll').click(function() {
			var checkedStatus = this.checked;
			$('input[name="checkboxList"]').each(function() {
				$(this).prop('checked', checkedStatus);
			});
		});
	});	
	
	function statusModifyAction() {
		if ($("input[name=checkboxList]:checkbox:checked").length < 1) {
			swal({
		        title: '<spring:message code="label.order.valid.check.order"/>',
		            type: "info"
		    });
			return;
		}

		if (isEmpty($("#modify_status option:selected").val())) {
			swal({
		        title: '<spring:message code="label.order.valid.check.state"/>',
		        type: "info"
		    });
			return;
		}

		    swal({
		        title: '<spring:message code="label.order.confirm.change.front"/>' + $("#modify_status>option:selected").html() + '<spring:message code="label.product.prod.confirm.change.back"/>',
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonText: "예",
		        cancelButtonText: "아니오",
		        closeOnConfirm: false
		    },function () {
		    	var arrOrderSeq = [];
				$('input[name="checkboxList"]').each(function() {
					var checkedStatus = this.checked;
					if (checkedStatus) {
						var prod_order_seq = $(this).val();
						arrOrderSeq.push(prod_order_seq);
					}
				});

				var param = new Object();
				param.prod_order_seq = arrOrderSeq.join();
				param.order_sts_cd = $("#modify_status option:selected").val();
				$.ajax({
				url : "statusModifyAction.json",
				type : "POST",
				data : param,
				dataType : "json",
				success : function(data) {
					var result = data.result;
					if (result == "succ") {
						swal({
				      		title: $("#modify_status>option:selected").html() + ' <spring:message code="label.common.success.action"/>', 
				      		type: "success",
				      		confirmButtonText: ' <spring:message code="label.common.close"/>'
				      	},function(){
							refreshList();
				      	});
					} else {
						 swal({
					       	title: result, 
				      		type: "error",
				      		confirmButtonText: '<spring:message code="label.common.close"/>'
					      });
					}
				},
				error : function() {
					 swal({
				       	title: '<spring:message code="label.common.fail.action"/>', 
			      		type: "error",
			      		confirmButtonText: '<spring:message code="label.common.close"/>'
				       });
					}
				});
		    });
	}

</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code="label.order.title.list"/></span>
		</h3>
		<div class="unitBox" style="">
			<table class="amb_table">
				<colgroup>
				<c:if test="${userGrup eq 2}">
					<col style="width: 5%" />
				</c:if>
					<col style="width: 20%;" />
					<col style="" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
				<c:if test="${userGrup eq 1}">
					<col style="width: 10%" />
				</c:if>
				</colgroup>
				<thead>
					<tr>
					<c:if test="${userGrup eq 2}">
						<th><input type="checkbox" id="checkboxListAll" name="checkboxListAll"><label for="checkboxListAll" class="inp_func"></th>
					</c:if>
						<th><spring:message code="label.order.orderNumber"/></th>
						<th><spring:message code="label.order.productDetail"/></th>
						<th><spring:message code="label.order.productAmount"/></th>
						<th><spring:message code="label.order.status"/></th>
						<th><spring:message code="label.order.buyerId"/></th>
					<c:if test="${userGrup eq 1}">
						<th><spring:message code="label.order.sellerId"/></th>
					</c:if>
					</tr>
				</thead>
				<tbody>
				<c:set var="current" value="0"/>
				<c:set var="num" value="0"/> <!-- row count -->
					<c:forEach items="${list}" var="info" varStatus="status">
						<tr>
						<c:if test="${userGrup eq 2}">
							<td>
								<input type="checkbox" id="check_${info.prod_order_seq}" name="checkboxList" value="${info.prod_order_seq}">
								<label for="check_${info.prod_order_seq}" class="inp_func"></label>
							</td>
						</c:if>
							<c:if test="${current == 0 }"><!-- 설정 -->
								<td rowspan="${rowCount[num]}"><a href="javascript:movePage('detail.ajax', {order_seq: '${info.order_seq}',pageType:'orderList'});">${info.order_no}<br/>(${info.order_datetime})</a></td>								
								<c:set var="current" value="${rowCount[num]}"/>
								<c:set var="num" value="${num+1}"/>
							</c:if>
							
							<td style="text-align:left">
							<div style="float:left; margin-right:10px;">
								<img src="/common/file/downloadImage/${info.file_id}" onload="javascript:initImage(this);" style="cursor: pointer;height: 50px; width: 44px; margin-left: 3px;">	
							</div>
							<div style="float:left;margin-top:5px;">
								<a href="javascript:openModal('/admin/product/detailPopup.ajax' , 'productDetailPopup' , 'prod_id=${info.key_id}' , '900');">
									${info.prod_order_no}
									<br />${info.prod_name}
									<br/><spring:message code="label.order.amount"/> : ${info.order_cnt} <spring:message code="label.order.unit"/>
								</a>
							</div>
							</td>
							<td>
								<fmt:formatNumber value="${info.payment_amt}" pattern="#,###" /><spring:message code="label.order.won"/>
							</td>
							<td>${info.order_sts_name}</td>
							<td>${info.user_id}</td>
							<c:if test="${userGrup eq 1}">
								<td>${info.store_id}<br/>(${info.store_name})</a></td>
							</c:if>
						</tr>	
											
					<c:set var="current" value="${current-1}"/><!-- 감소 -->
					</c:forEach>
					<c:if test="${empty list}">
						<tr>
							<td colspan="6"><spring:message code="label.common.empty.list"/></td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="paging center">
			<ul class="paginglist">
				<jsp:include page="/WEB-INF/views/include/paging.jsp" />
			</ul>
			<c:if test="${userGrup eq 2}">
				<div class="fl btnArea middle">
					<select id="modify_status">
						<option value=""><spring:message code="label.order.status.select"/></option>
						<option value="010"><spring:message code="label.order.status.paymentComplete"/></option>
						<option value="020"><spring:message code="label.order.status.preparingProduct"/></option>
						<option value="030"><spring:message code="label.order.status.delivery"/></option>
						<option value="040"><spring:message code="label.order.status.deliveryComplete"/></option>
						<option value="050"><spring:message code="label.order.status.purchaseComplete"/></option>
					</select>
					<a href="javascript:statusModifyAction();" class="amb_btnstyle gray large"><spring:message code="label.common.change"/></a>
				</div>
			</c:if>
		</div>
	</div>
</div>
</div>
<!-- rowBox 반복단위 -->