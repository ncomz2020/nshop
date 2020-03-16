<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<script>
	var grpCd = "";
	var orderStsCd = "";
	
	$(document).ready(function() {	
		
		console.log("${sts_cd}");
		/*
		* 10: 교환반품, 30: 취소
		*/
		if("${sts_cd}" == "10"){
			$("#chng_cd").val("200");
			grpCd = "CHNG";
			orderStsCd = "210";
		}else if("${sts_cd}" == "30"){
			$("#chng_cd").val("100");
			grpCd = "CANCEL";
			orderStsCd = "110";
		}	
		selectBoxSetting();
		$("#price").text("0"+'<spring:message code="label.order.won"/>');
		$('#checkboxListAll').click(function() {
			var checkedStatus = this.checked;
			$('input[name="checkboxList"]').each(function() {
				$(this).prop('checked', checkedStatus);
				checkList()
			});	
		});
		
		$('input[name="checkboxList"]').change(function(){
			checkList()
		})
	});
	
	function checkList(){
		var arrOrderSeq = [];
		var total = 0;
		$('input[name="checkboxList"]').each(function() {
			var checkedStatus = this.checked;
			if (checkedStatus) {
				var prod_order_seq = $(this).val();
				arrOrderSeq.push(prod_order_seq);
				total += ($("#price_"+this.value).val()*1);
			}
		});
		
		 var reg = /(^[+-]?\d+)(\d{3})/;
		 total = (total+'').replace(reg, '$1' + ',' + '$2');

		$("#price").text(total+'<spring:message code="label.order.won"/>');
	}

	function selectBoxSetting() {
		var statusSelectBox = [ {
		'codeType' : 'commCode',
		'grp_cd' : grpCd,
		'selectId' : 'cancel_opt'
		} ];
	
		// 판매상태 조회
		callAajaxJson(statusSelectBox);
	}
	
	function applyPopupAction(){		
		var sts = "";
		var stsName = "";
		
		if("${sts_cd}" == "10"){
			sts = $('input:radio[name="radio_1"]:checked').val();
			stsName = '<spring:message code="label.order.status.exchange"/>/<spring:message code="label.order.status.return"/> <spring:message code="label.order.status.apply"/>';
			if(sts == "200"){
				$("#chng_cd").val("200");
				orderStsCd = "210";				
			}else if(sts == "300"){
				$("#chng_cd").val("300");
				orderStsCd = "310";
			}
		}else if("${sts_cd}" == "30"){
			stsName = '<spring:message code="label.order.status.cancel"/> <spring:message code="label.order.status.apply"/>';
			$("#chng_cd").val("100");
			orderStsCd = "110";
		}
			
		var arrOrderSeq = [];
		$('input[name="checkboxList"]').each(function() {
			var checkedStatus = this.checked;
			if (checkedStatus) {
				var prod_order_seq = $(this).val();
				arrOrderSeq.push(prod_order_seq);
			}
		});
		
		if(arrOrderSeq.length < 1){
			swal({
		        title: '<spring:message code="label.order.front.select.warn"/>'
		    });
			return;
		}
		
		var param = new Object();
		param = $("#popupForm").serialize();
		param += "&order_sts_cd="+orderStsCd;
		param += "&prod_order_seq="+arrOrderSeq.join();
		console.log(param);
		$.ajax({
		url : "applyPopupAction.json",
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
	
</script>
<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
<div class="modal-content">
	<h1 class="popupHeader">
		<span class="title"><spring:message code="label.order.front.change.address" /></span>
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
									<input type="hidden" id="price_${info.prod_order_seq}" name="price" value="${info.payment_amt}">
									<input type="hidden" id="delivery_${info.prod_order_seq}" name="delivery" value="${info.dlvy_amt}">								
								</div>
							</td>
							<td>
								${info.store_name}
							</td>
						</tr>
						</c:forEach>
						</tbody>
					</table>
				
				<form id="popupForm" action="javascript:applyPopupAction();">
					<input type="hidden" id="chng_cd" name="chng_cd" />
					<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 25%;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th class="center"><spring:message code="label.order.orderNumber"/></th>
								<td>
									${list[0].order_no}
								</td>
							</tr>
							<c:if test="${sts_cd eq '10'}">
								<tr>
									<th class="center"><spring:message code="label.order.front.type"/></th>
									<td>
										<input type="radio" id="radio_1_01" name="radio_1" value="200" checked><label for="radio_1_01" class="inp_func"><spring:message code="label.order.status.exchange" /></label>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" id="radio_1_02" name="radio_1" value="300" ><label for="radio_1_02" class="inp_func"><spring:message code="label.order.status.return" /></label>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
								</tr>
							</c:if>
							
							<tr>
								<th class="center"><spring:message code='label.order.productAmount'/></th>
								<td id="price">
								</td>
							</tr>
							 
							<tr>
								<th class="center"><spring:message code='label.order.rsn'/><spring:message code='label.common.select'/></th>
								<td>
									<select id="cancel_opt" name="chng_rsn" style="width: 100%;">
									</select>
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="label.order.dtl.rsn"/></th>
								<td>
									<textarea id="chng_dtl_rsn" name="chng_dtl_rsn" rows="2" cols="50" style="width: 100%;resize: none;" placeholder="<spring:message code='label.order.dtl.rsn.msg'/>">${orderInfo[0].store_id_memo}</textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<div class="rowBox mgT10 fr btnArea middle">
					<a href="javascript:closePopup();" class="amb_btnstyle gray middle" style="opacity: 0.5;"><spring:message code="label.common.cancle"/></a>
					<a href="javascript:applyPopupAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.confirm"/></a>
				</div>
			</div>
		</div>
		<!-- rowBox 반복단위 -->
	</div>
	</div>
</div>