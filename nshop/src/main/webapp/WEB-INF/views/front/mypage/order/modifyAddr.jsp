<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<script>
	
	function updateAddrAction(){
		if ($("#update_receiver").val() == "") {
			swal({
		        title: '받는사람을 입력하세요.'},function() {
					$("#update_receiver").focus();
			});	
			return;
		}
		
		if ($("#update_phone").val() == "") {
			swal({
		        title: '연락처를 입력하세요.'},function() {
				$("#update_phone").focus();
			});	
			return;
		}else{
			regNumber = /^[0-9]*$/;
			if(!regNumber.test($("#update_phone").val())){
				swal({
			        title: '숫자만 입력 가능합니다.'},function() {
					$("#update_phone").focus();
				});
				return;
			}
		}
		
		if ($("#update_zip_code").val() == "" || $("#update_addr").val() == "") {
			swal({
		        title: '우편번호를 찾으세요.'
		        });	
			return;
		}
		
		if ($("#update_dtl_addr").val() == "") {
			swal({
		        title: '상세주소를 입력하세요.'},function() {
				$("#update_dtl_addr").focus();
			});	
			return;
		}		

		var param = new Object();
		param = $("#modifyAddr").serialize();
		param += "&order_seq="+ ${orderSeq}+"";
		$.ajax({
		url : "addrModifyAction.json",
		type : "POST",
		data : param,
		dataType : "json",
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				swal({
			        title: '<spring:message code="label.common.success.save"/>',
			        type: "success"
				});
				movePage('detail', {order_seq: '${orderSeq}',pageType:'orderList'});
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
				<form id="modifyAddr" action="javascript:updateAddrAction();">
					<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 25%;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th class="center"><spring:message code="label.order.receiver" /> *</th>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="update_receiver" name="update_receiver" value="${info[0].user_nm}" placeholder="<spring:message code='label.order.front.name' />" maxlength="20" autofocus>
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="label.order.phone" /> *</th>
								<td><!-- 연락처 포맷 확인 -->
									<input type="text" class="inp" style="width: 100%;" id="update_phone" name="update_phone" value="${info[0].r_mobile_no}" placeholder="<spring:message code='label.order.phone' />" maxlength="11">
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="label.order.addr" /> *</th>
								<td>
									<div style="margin-bottom:5px;">
										<span><input type="text" class="inp" style="width: 40%;" id="update_zip_code" name="update_zip_code"  value="${info[0].zip_cd}"  readonly="readonly" placeholder="<spring:message code='label.common.postno' />" ></span>
										<span><a href="javascript:sample6_execDaumPostcode();" class="amb_btnstyle gray middle"><spring:message code="label.common.find.postno" /></a></span><br/>
									</div>
									<div>
										<input type="text" class="inp" style="width: 100%;" id="update_addr" name="update_addr"  value="${info[0].base_addr}"  readonly="readonly" placeholder="<spring:message code='label.common.addr' />" ><br/>
									</div>
									<div style="margin-top:5px;">
										<input type="text" class="inp" style="width: 100%;" id="update_dtl_addr" name="update_dtl_addr" value="${info[0].dtl_addr}" placeholder="<spring:message code='label.common.addr.detail' />">
									</div>
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="label.order.addrMsg" /></th>
								<td>
									<textarea id="update_memo" name="update_memo" value="${info[0].dlvy_memo}" rows="2" cols="50" style="width: 100%;resize: none;" placeholder="<spring:message code='label.order.front.addr.msg' />">${orderInfo[0].store_id_memo}</textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<div class="rowBox mgT10 fr btnArea middle">
					<a href="javascript:closePopup();" class="amb_btnstyle gray middle" style="opacity: 0.5;"><spring:message code="label.common.cancle"/></a>
					<a href="javascript:updateAddrAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.save"/></a>
				</div>
			</div>
		</div>
		<!-- rowBox 반복단위 -->
	</div>
	</div>
</div>