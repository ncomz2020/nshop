<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<script>

	var arrOrderSeq = [];
	var stsCd = ${sts_cd};
	var type = ""; //구매확정 or 교환반품
	var stsName = ""; //상태
	
	$(document).ready(function() {	
		if(stsCd == "10"){//구매확정
			$("#popupTitle").text('<spring:message code="label.order.status.purchase.confirmation"/>');
			stsName = '<spring:message code="label.order.status.purchase.confirmation"/>';
			type = "C";
		}else if(stsCd == "20"){//교환/반품 철회
			$("#popupTitle").text('<spring:message code="label.order.status.exchange"/>/<spring:message code="label.order.status.return"/> <spring:message code="label.order.refuse"/>');
			stsName = '<spring:message code="label.order.refuse"/>';
			type = "R";
		}
		
		$('input[name="checkboxList"]').change(function(){
		 	checkList();	
		});
		
		 $('#checkboxListAll').click(function() {
				var checkedStatus = this.checked;
				$('input[name="checkboxList"]').each(function() {
					$(this).prop('checked', checkedStatus);
				});
				checkList();	
			});
	});

	function confirmationAction(){
		
		if(arrOrderSeq.length < 1){
			swal({
		        title: '<spring:message code="label.order.front.select.warn"/>'
		    });
			return;
		}
		var param = new Object();
		console.log(type);
		param.popupType = type;
		param.prod_order_seq = arrOrderSeq.join();
		$.ajax({
		url : "confirmationAction.json",
		type : "POST",
		data : param,
		dataType : "json",
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				swal({
			        title: stsName+' <spring:message code="label.order.front.select.success"/>',
			        type: "success"
				});
				movePage('detail', {order_seq: '${list[0].order_seq}',pageType:'orderList'});
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
	
	function checkList(){
		arrOrderSeq = [];
		$('input[name="checkboxList"]').each(function() {
			var checkedStatus = this.checked;
			if (checkedStatus) {
				var prod_order_seq = $(this).val();
				arrOrderSeq.push(prod_order_seq);
			}
		});
		
		var str = "";
		if(arrOrderSeq.length > 0){
			str = "<b>";
			str += arrOrderSeq.length;
			str += ' <spring:message code="label.order.front.select.num"/>'+stsName+' <spring:message code="label.order.front.select.question"/>';
			$("#conf_msg").html(str);
		}else{
			$("#conf_msg").html(str);
		}
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
							<col style="width: 10%;" />
							<col style="" />
							<col style="width: 20%" />
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="checkboxListAll" name="checkboxListAll"><label for="checkboxListAll" class="inp_func"></th>
								<th><spring:message code="label.order.productDetail"/></th>
								<th><spring:message code="label.order.sellerName"/></th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${list}" var="info" varStatus="status">
						<tr>
							<td>
								<input type="checkbox" id="check_${info.prod_order_seq}" name="checkboxList" value="${info.prod_order_seq}">
								<label for="check_${info.prod_order_seq}" class="inp_func"></label>
							</td>
							<td style="text-align:left">
								<div style="float:left; margin-right:10px;">
									<img src="/common/file/downloadImage/${info.file_id}" onload="javascript:initImage(this);" style="cursor: pointer;height: 50px; width: 44px; margin-left: 3px;">	
								</div>
								<div style="margin-top:5px;" class="ellipsis">
									${info.prod_name}
									<br/><spring:message code="label.order.amount"/> : ${info.order_cnt}<spring:message code="label.order.unit"/>
								</div>
							</td>
							<td>
								${info.store_name}
							</td>
						</tr>
						</c:forEach>
						</tbody>
					</table>
				<div class="center" id="conf_msg">
					
				</div>
				<div class="rowBox mgT10 fr btnArea middle">
					<a href="javascript:closePopup();" class="amb_btnstyle gray middle" style="opacity: 0.5;"><spring:message code="label.common.cancle"/></a>
					<a href="javascript:confirmationAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.confirm"/></a>
				</div>
			</div>
		</div>
		<!-- rowBox 반복단위 -->
	</div>
	</div>
</div>