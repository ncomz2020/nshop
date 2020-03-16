
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(document).ready(function() {
	});
	
	function goStateChange(){
		
		// 필수값 체크
		var calcul_sts_cd = "${param.calcul_sts_cd}";
		var calcul_memo = $("#calcul_memo").val();
		if(calcul_sts_cd=='SH' ||calcul_sts_cd=='SW'){	//정산보류나 철회로 변경하는 경우 메모 필수입력
			if(calcul_memo == null || calcul_memo == ""){
				swal({
					title: '변경사유를 입력해주세요.',
				    type: "error"
				});
				return;
			}
		}
		
		var param = new Object();
		param.calcul_seq = '${param.calcul_seq}';
		param.calcul_sts_cd = calcul_sts_cd;
		param.calcul_memo = calcul_memo;
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
			      		confirmButtonText: "닫기"
			      	}, function(){
			      		refreshList();
			      	});
				} else {
					swal({
						title: result,
					    type: "error"
					});
				}
				$("#btnCloseFoot").trigger("click");
			},
			error : function() {
				swal({
					title: '<spring:message code="label.common.fail.action"/>',
				    type: "error"
				});
			}
    	});
		
		
	}
</script>

<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">

	<div class="modal-content">

		<!-- 실제 컨텐츠 작업부분 -->
		<h1 class="popupHeader">
			<span class="title">정산상태변경</span>
			<a href="#" class="close" onClick="javascript:closeModal(this);"><i class="ambicon-015_mark_times"></i></a>
		</h1>

		<div class="content">		
			<div class="rowBox">
				<div class="unitBox">
					<h3>
						<span class="title"><spring:message code="label.calculation.settlement.confirm.change.front"/>&nbsp;${param.calcul_sts_nm}&nbsp;<spring:message code="label.calculation.settlement.confirm.change.back"/></span>
					</h3>
					<c:if test="${param.calcul_sts_cd eq 'SH' || param.calcul_sts_cd eq 'SW'}">
						<i class="bullet mandatory"></i>
					</c:if>
					<input type="text" id="calcul_memo" name="calcul_memo" class="inp" style="width:95%;" placeholder='변경사유를 입력해주세요.' />
				</div>
				<div class="fr btnArea middle">
					<a href="#" id="btnCloseFoot" class="amb_btnstyle gray middle" onclick="javascript:closeModal(this);">취소</a>
					<a href="#" class="amb_btnstyle blue middle" onclick="goStateChange();">확인</a>
				</div>
			</div>
		</div>
	</div>
</div>