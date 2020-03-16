<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
 	
<script type="text/javascript">
var pageType = '';
$(document).ready(function() {
	pageType = '${pageType}';
	console.log("pageType : " + pageType);
	//로고이미지 가운데 정렬
	$('.photoBox').css('width','100%');
});

function goListPage() {
	
	if(pageType == 'fileMgmt'){
		//파일관리 페이지 이동
		movePage('/admin/common/file/list');
	}else{
		//상점 관리 페이지 이동
		$("#myForm").attr("action", "list");
		$("#myForm").submit();
	}
}

function goUpdateView(store_id){
	var url = "update.ajax";
	var param = new Object();
	param.store_id = store_id;
	param.pageType = pageType;
	movePage(url, param);
}



// 승인,운영 상태변경
function goStatUpdateAction(store_id, stat, code) {
	var coment = "";
	var param = new Object();
	param.store_id = store_id;
	if (code == 'approval_stat') {
		param.approval_stat = stat;
		if (stat == 'Y') {  // 승인
		coment = '<spring:message code="label.store.approve"/>';
		}else{    // 승인취소
		coment = '<spring:message code="label.store.approve.cancel"/>';
		param.operational_stat = 'N';  // 승인취소 -> 운영중지
		}
	} else {
		param.operational_stat = stat;
		if (stat == 'Y') {
			coment = '<spring:message code="label.store.operate"/>';
		} else {
			coment = '<spring:message code="label.store.operate.off"/>';
		}
	}

	swal({
        title: '(' + coment + ')' + ' <spring:message code="label.product.prod.confirm.change.back"/>',
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "YES",
        cancelButtonText: "NO",
        closeOnConfirm: false
         },function() {
		$.ajax({
		url : "statUpdateAction.json",
		type : "POST",
		data : param,
		dataType : "json",
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				swal({
			        title: '(' + coment + ')' + ' <spring:message code="label.common.success.action"/>',
			        type: "success",
		      		confirmButtonText: "CLOSE" },function() {
					location.reload();
				});
			} else {
				swal({
			        title: result
			    });
			}
		},
		});
	});
}


function requestAuth(store_id,stat) {
	var param = new Object();
	param.store_id = store_id;
	param.approval_stat= stat;
	swal({
        title: '<spring:message code="label.store.confirm.approve.request" />',
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "YES",
        cancelButtonText: "NO",
        closeOnConfirm: false
         },function() {
		$.ajax({
		url : "updateStoreAuthStateAction.json",
		type : "POST",
		data : param,
		dataType : "json",
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				swal({
			        title: '<spring:message code="label.store.success.approve.request" />',
			        type: "success",
		      		confirmButtonText: "CLOSE" },function() {
					location.reload()
				});
			} else {
				swal({
			        title: result
			    });
			}
		},
		});
	});
}





</script>

</head>
<body>
<form id="myForm" name="myForm" method="post">
<input type="hidden" id="store_id" name="store_id" value="" />
<div class="rowBox mgT30">
<h3>
	<span class="title"><spring:message code="label.store.info"/></span>
</h3>
				
				<!-- 왼쪽 이미지 영역 -->
				<div class="g_column w_3_1">
					<div id="sameHeight_01" class="unitBox lineBox" style="height: 281px; position: relative;">
						<div class="photoBox" >
							<span class="photoBox_imgBox"><img src="/common/file/downloadImage/<c:if test="${not empty storeInfo.store_logo}">${storeInfo.store_logo}</c:if><c:if test="${empty storeInfo.store_logo}">noImage</c:if>"  class="pdImg" alt="Logo"/><span>
						</div>
					</div>
				</div>
				<!-- 오른쪽 정보영역 -->
				<div class="g_column w_3_2">
					<div id="sameHeight_02" class="unitBox" style="">
						<table class="amb_form_table lineAll">
							<colgroup>
								<col style="width:20%;">
								<col style="">
								<col style="width:20%;">
								<col style="">
							</colgroup>	
							<tbody>
								<tr>
									<th><spring:message code="label.store.id"/></th>
									<td>${storeInfo.store_id}</td>
									<th><spring:message code="label.store.name"/></th>
									<td>${storeInfo.store_name}</td>
								</tr>
								<tr>
									<th><spring:message code="label.store.regist.prod.count"/></th>
									<td>${storeInfo.product_cnt}<spring:message code="label.store.regist.prod.count.unit"/></td>
									<th><spring:message code="label.store.reg.datetime"/></th>
									<td>${storeInfo.reg_datetime}</td>
								</tr>
								<tr>
									<th><spring:message code="label.store.comp.name"/></th>
									<td>${storeInfo.comp_name}</td>

									<th><spring:message code="label.store.president.name"/></th>
									<td>${storeInfo.president_name}</td>
								</tr>
								<tr>
									<th><spring:message code="label.store.comp.addr"/></th>
									<td colspan="3">
										<spring:message code="label.common.postno"/>:&nbsp;${storeInfo.post_num}<br/>
										${storeInfo.comp_addr}&nbsp;
										${storeInfo.comp_addr2}
									</td>
								</tr>
								<tr>
									<th><spring:message code="label.store.main.phone"/></th>
									<td>${storeInfo.main_phone_num}</td>

									<th>FAX</th>
									<td>${storeInfo.fax_num}</td>
								</tr>
								<tr>
									<th><spring:message code="label.store.comp.reg.num"/></th>
									<td>${storeInfo.comp_reg_num}</td>

									<th><spring:message code="label.store.comp.reg.copy"/></th>
									<td><a href="javascript:downloadFile('${storeInfo.comp_reg_copy}');">${storeInfo.org_filename1}</a></td>
								</tr>
								<tr>
									<th><spring:message code="label.store.operational.stat.text"/></th>
									<td>
										<div class="stateBox2 before2">
											<span class="state">${storeInfo.operational_stat_text}</span>&nbsp;&nbsp;&nbsp;
											<c:if test="${storeInfo.approval_stat eq 'Y'}">
												<c:if test="${storeInfo.operational_stat eq 'Y' }">
													<button type="button" onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','N','operational_stat');" class="amb_btnstyle red middle stateEdit"><spring:message code="label.store.operate.off_2"/></button>
												</c:if>
												<c:if test="${storeInfo.operational_stat eq 'N' }">
													<button type="button" onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','Y','operational_stat');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.store.operate"/></button>
												</c:if>
										    </c:if>
										</div>
									</td>
									<th><spring:message code="label.store.approval.stat.text"/></th>
									<td>
										${storeInfo.approval_stat_text}&nbsp;&nbsp;
										<c:if test="${storeInfo.approval_stat eq 'N' and session_user.usr_grp_id eq 2}">
											<button type="button" onclick="javascript:requestAuth('${storeInfo.store_id}','R');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.store.approval.request"/></button>
										</c:if>
										<c:if test="${storeInfo.approval_stat eq 'R' and session_user.usr_grp_id eq 1}">
											<button type="button"  onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','Y','approval_stat');" class="amb_btnstyle blue middle"><spring:message code="label.store.approve"/></button>
										</c:if>
										<c:if test="${storeInfo.approval_stat eq 'Y' and session_user.usr_grp_id eq 1}">
										<button type="button" onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','F','approval_stat');" class="amb_btnstyle red middle stateEdit"><spring:message code="label.store.approve.cancel"/></button>
									    </c:if>
										<c:if test="${storeInfo.approval_stat eq 'F' and session_user.usr_grp_id eq 1}">
											<button type="button"  onclick="javascript:goStatUpdateAction('${storeInfo.store_id}','Y','approval_stat');" class="amb_btnstyle blue middle"><spring:message code="label.store.approve"/></button>
										</c:if>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

		<div class="fr btnArea middle">
			<a href="javascript:goUpdateView('${storeInfo.store_id}');" class="amb_btnstyle blue middle"><spring:message code="label.common.modify"/></a>
			<c:if test="${session_user.usr_grp_id eq 1 }">
				<a href="javascript:goListPage();" class="amb_btnstyle blue middle"><spring:message code="label.common.list"/></a>
			</c:if>
		</div>
				</div>
</div>

</form>
</body>    