<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<script>
	$(document).ready(function() {		
		selectBoxSetting();
	});

	function selectBoxSetting() {
		var statusSelectBox = [ {
		'codeType' : 'commCode',
		'grp_cd' : 'REFUSE',
		'selectId' : 'refuse_opt'
		} ];
	
		callAajaxJson(statusSelectBox);
	}
	
	function refuseAction(){
		var param = new Object();
		param = $("#refuseForm").serialize();
		param += "&chng_cd="+${info.chng_cd}+"";
		param += "&order_sts_cd="+"${info.order_sts_cd}"+"";
		param += "&prod_order_seq="+${info.prod_order_seq}+"";
		console.log(param);
		$.ajax({
		url : "refuseAction.json",
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
				refreshList();
				closePopup();
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
		<span class="title">${info.title}</span>
		<a href="javascript:closePopup();" id="popup_01" class="close"">
			<i class="ambicon-015_mark_times"></i>
		</a>
	</h1>

	<div id="content" class="content">
		<div class="rowBox">
			<div class="unitBox" style="">
				<form id="refuseForm" action="javascript:updateAddrAction();">
					<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 25%;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th class="center"><spring:message code="label.order.rsn"/><spring:message code='label.common.select'/></th>
								<td>
									<select id="refuse_opt" name="chng_rsn" style="width: 100%;">
									</select>
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="label.order.dtl.rsn"/></th>
								<td>
									<textarea id="update_memo" name="chng_dtl_rsn" rows="2" cols="50" style="width: 100%;resize: none;" placeholder="<spring:message code='label.order.dtl.rsn.msg'/>">${orderInfo[0].store_id_memo}</textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<div class="rowBox mgT10 fr btnArea middle">
					<a href="javascript:closePopup();" class="amb_btnstyle gray middle" style="opacity: 0.5;"><spring:message code="label.common.cancle"/></a>
					<a href="javascript:refuseAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.confirm"/></a>
				</div>
			</div>
		</div>
		<!-- rowBox 반복단위 -->
	</div>
	</div>
</div>