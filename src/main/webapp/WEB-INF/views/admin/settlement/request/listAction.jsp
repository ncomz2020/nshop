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

	

	function goExcel() {
		var param = $('#calcRequestListForm').serialize();
		$.download('exportAction.ajax', param, 'post');
	}
	
	
	function statusModifyAction(){
		
		if ($("input[name=checkboxList]:checkbox:checked").length < 1) {
			swal({
				title: "<spring:message code='label.calculation.settlement.stat.valid.check'/>",
			    type: "error"
			});
			return;
		}
		
		swal({
		    title: '<spring:message code="label.calculation.settlement.stat.request.check"/>' + '<spring:message code="label.calculation.settlementRequest"/>' + '<spring:message code="label.product.prod.confirm.change.back"/>',
		    type: "warning",
		    showCancelButton: true,
		    confirmButtonText: "예",
		    cancelButtonText: "아니오",
		    closeOnConfirm: false,
		    closeOnCancel: false 
		},function (isConfirm) {
		    if (isConfirm) {
		    	var arrProdOrderSeq = [];
				$('input[name="checkboxList"]').each(function() {
					var checkedStatus = this.checked;
					if (checkedStatus) {
						var prod_order_seq = $(this).val();
						arrProdOrderSeq.push(prod_order_seq);
					}
				});

				var param = new Object();
				param.prodOrderSeq = arrProdOrderSeq.join();
				$.ajax({
				url : "statusModifyAction.json",
				type : "POST",
				data : param,
				dataType : "json",
				success : function(data) {
					var result = data.result;
					if (result == "success") {
						swal({
				        	title: "요청 되었습니다", 
			      			type: "success",
			      			confirmButtonText: "닫기"
				        },function(){
				        	refreshList();
				        });
					} else {
						swal({
				        	title: result, 
			      			type: "error",
			      			confirmButtonText: "닫기"
				        });
					}
				},
				error : function() {
					swal({
			        	title: '<spring:message code="label.common.fail.action"/>', 
		      			type: "error",
		      			confirmButtonText: "닫기"
			        });
				}
				});
		    } else {
		        swal({
		        	title: "취소 되었습니다", 
	      			type: "error",
	      			confirmButtonText: "닫기"
		        });
		    }
		});
	}
	
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code="label.calculation.purchaseConfirmList"/>
			: <em class="pColor_01">&nbsp;&nbsp;총 ${count}건</em>
			</span>
		</h3>
		<div class="unitBox" style="">
			<table class="amb_table">
				<colgroup>
					<col style="width: 3%" />
					<col style="width: 5%" />
					<col style="width: 7%" />
					<col style="width: 7%" />
					<col style="width: 12%" />
					<col style="width: 12%" />
					<col style="width: 7%" />
					<col style="width: 15%" />
					<col style="width: 7%" />
					<col style="width: 7%" />
				</colgroup>
				<thead>
					<tr>
						<th class="center"><input type="checkbox" id="checkboxListAll" name="checkboxListAll"><label for="checkboxListAll" class="inp_func"></th>
						<th class="center">no</th>
						<th class="center">구매완료일</th>
						<th class="center">주문일시</th>
						<th class="center">주문번호</th>
						<th class="center">상품주문번호</th>
						<th class="center">구매자명</th>
						<%-- <th><spring:message code="label.calculation.orderClassification"/></th> --%>
						<th class="center"><spring:message code="label.product.prod.name"/></th>
						<th class="center">주문금액</th>
						<th class="center"><spring:message code="label.order.status"/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="info" varStatus="status">
						<tr>
							<td>
								<input type="checkbox" id="check_${info.rownum}" name="checkboxList" value="${info.prod_order_seq}">
								<label for="check_${info.rownum}" class="inp_func"></label>
							</td>
							<td>${info.rownum}</td>
							<td>${info.sts_update_datetime}</td>
							<td>${info.order_datetime}</td>
							<td><a href="#" onclick="javascript:openModal('/admin/order/orderList/detailPopup.ajax' , 'orderDetailPopup' , 'order_seq=${info.order_seq}' , '900');">${info.order_no}</a></td>
							<td>${info.prod_order_no}</td>
							<td>${info.user_nm}</td>
							<td>${info.prod_name}</td>
							<td><fmt:formatNumber value="${info.order_amt}" pattern="#,###" />&nbsp;원</td>
							<td>${info.order_sts_name}</td>
						</tr>
					</c:forEach>
					<c:if test="${empty list}">
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
			<c:if test="${userGrup eq 2}">
				<div class="fl btnArea middle">
					선택한 항목을
					<a href="javascript:statusModifyAction();" class="amb_btnstyle blue middle"><spring:message code="label.calculation.settlementRequest"/></a>
				</div>
			</c:if>
		</div>
	</div>
</div>
<!-- rowBox 반복단위 -->