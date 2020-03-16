<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<script>
	$(document).ready(function() {
		var price = "${list[0].prod_price}";
		var totalPrice = "";
		var cnt = 0;
		$("#order_cnt").spinner({change:function(){
			cnt = $("#order_cnt").val();
			totalPrice = cnt*price+'';
			
			 var reg = /(^[+-]?\d+)(\d{3})/;
			 while (reg.test(totalPrice)) {
			     // replace 정규표현식으로 3자리씩 콤마 처리
			     totalPrice = totalPrice.replace(reg,'$1'+','+'$2');
			 }
			   
			var str = "<spring:message code='label.order.totalProductAmount'/> "+totalPrice+"<spring:message code='label.order.won'/>";
			$("#conf_msg").text(str);
			}
		});
	});
	
	function updateCartnAction(){
		var param = new Object();
		param.order_cnt = $("#order_cnt").val();
		param.wish_seq = "${list[0].wish_seq}";
		$.ajax({
		url : "updateCartAction.json",
		type : "POST",
		data : param,
		dataType : "json",
		success : function(data) {
			var result = data.result;
			if (result == 1) {
				swal({
			        title: '<spring:message code="label.common.success.save"/>',
			        type: "success"
				});
				movePage("/front/mypage/cart/list");
			} else {
				swal({
			        title: result,
		      		type: "error"
			    });
			}
		},
		});
	}
	
	function closePopup(){
		var str = document.getElementById("popup_01");
		closeModal(str);
	}
	
	
</script>
<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
<div class="modal-content">
	<h1 class="popupHeader">
		<span class="title" id="popupTitle"><spring:message code="label.order.status.purchase.confirmation"/></span>
		<a href="javascript:closePopup();" id="popup_01" class="close"">
			<i class="ambicon-015_mark_times"></i>
		</a>
	</h1>

	<div id="content" class="content">
		<div class="rowBox">
			<div class="unitBox" style="">
					<table class="amb_table" style="margin-bottom:30px;">
						<colgroup>
							<col style="" />
						</colgroup>
						<thead>
							<tr>
								<th><spring:message code="label.order.productDetail"/></th>
							</tr>
						</thead>
						<tbody>
					 	<c:forEach items="${list}" var="info" varStatus="status">
						<tr>
							<td style="text-align:left">
								<div style="float:left; margin-right:10px;">
									<img src="/common/file/downloadImage/${info.imageFileList[0].file_id}" onload="javascript:initImage(this);" style="cursor: pointer;height: 50px; width: 44px; margin-left: 3px;">	
								</div>
								<div style="margin-top:5px;" class="ellipsis">
									${info.prod_name}
									<br/><fmt:formatNumber value="${info.prod_price}" pattern="#,###" /><spring:message code="label.order.won"/>
								</div>
							</td>
						</tr>
						<tr>
							<td style="text-align:left">
								<spring:message code="label.order.amount"/>  <input type="number" id="order_cnt" class="inp spinner right ui-spinner-input" autocomplete="off" role="spinbutton" min="1" value="${info.order_cnt}"><spring:message code="label.order.unit"/>
							</td>	
						</tr>
						</c:forEach> 
						</tbody>
					</table>
				<div class="right" id="conf_msg">
					<spring:message code="label.order.totalProductAmount"/><fmt:formatNumber value="${list[0].prod_price*list[0].order_cnt}" pattern="#,###" /><spring:message code="label.order.won"/>
				</div>
				<div class="rowBox mgT10 fr btnArea middle">
					<a href="javascript:closePopup();" class="amb_btnstyle gray middle" style="opacity: 0.5;"><spring:message code="label.common.cancle"/></a>
					<a href="javascript:updateCartnAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.confirm"/></a>
				</div>
			</div>
		</div>
		<!-- rowBox 반복단위 -->
	</div>
	</div>
</div>