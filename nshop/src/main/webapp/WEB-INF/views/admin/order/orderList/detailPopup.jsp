<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
 	
<script type="text/javascript">
var pageType = '';

$(document).ready(function() {
	pageType = '${pageType}';
	console.log("pageType : " + pageType);
	//로고이미지 가운데 정렬
	$('.photoBox').css('width','100%');
	setPhone();
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

function setPhone(){
	var sMobile = "${orderInfo[0].s_mobile_no}";
	var rMobile = "${orderInfo[0].r_mobile_no}";
	sMobile = sMobile.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	rMobile = rMobile.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	$("#s_mobile").text(sMobile);
	$("#r_mobile").text(rMobile);
}

function delivery_tracking(invoice){
    
	var url = "/admin/delivery/delivery_tracking.ajax";
      
	var param = {};
	param.t_key = "xXFLUhx1CJfUSruDrV5J8g";
	param.t_code = "04";
	param.t_invoice = invoice;
		      
	openModal(url, 'delivery_tracking' ,param , '900');
		      
}

/* 요구사항 수정 fn */
function memoModifyAction() {
	swal({
        title: '<spring:message code="label.common.confirm.save"/>',
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "예",
        cancelButtonText: "아니오",
        closeOnConfirm: false
    },function(){		
		var param = new Object();
		param.store_id_memo = $("#memo").val();
		param.order_seq=${orderInfo[0].order_seq};
		param.store_id="${orderInfo[0].store_id}";
		$.ajax({
		url : "memoModifyAction.ajax",
		type : "POST",
		data : param,
		dataType : "json",
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				swal({
		      		title:' <spring:message code="label.common.success.save"/>', 
		      		type: "success",
		      		confirmButtonText: ' <spring:message code="label.common.close"/>'
		      	});
				movePage('detail', {order_seq: '${orderInfo[0].order_seq}',pageType:'orderList'});
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

<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
	<div class="modal-content">
		<!-- 실제 컨텐츠 작업부분 -->
		<h1 class="popupHeader">
			<span class="title">주문 상세내역</span>
			<a href="#" class="close" onClick="javascript:closeModal(this);"><i class="ambicon-015_mark_times"></i></a>
		</h1>

		<div class="content">		
			<div class="rowBox">
				<div class="unitBox searchBox" style="">
				<table class="amb_form_table">
					<colgroup>
						<col style="width: 5%;" />
						<col style="width: 25%;" />
						<col style="width: 5%;" />
						<col style="width: 25%;" />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="label.order.orderNumber" /></th>
							<td>${orderInfo[0].order_no}</td>
							<th><spring:message code="label.order.orderDate" /></th>
							<td>${orderInfo[0].order_datetime}</td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>
			<!-- 주문 상품 정보 영역 -->
			<div class="rowBox mgT30">
				<div class="g_column w_1_1">
					<h3>
						<span class="title"><spring:message code="label.order.orderProductInfo"/></span>
					</h3>
					<div class="unitBox" style="">
						<table class="amb_table">
							<colgroup>
								<col style="width: 20%" />
								<col style="" />
								<col style="width: 10%" />
								<col style="width: 10%" />
								<col style="width: 10%" />
								<c:if test="${userGrup eq 1}">
									<col style="width: 10%" />
								</c:if>
								<col style="width: 15%" />
							</colgroup>
							<thead>
								<tr>
									<th><spring:message code="label.order.productOrderNumber"/></th>
									<th><spring:message code="label.order.productInfo"/></th>
									<th><spring:message code="label.order.productAmount"/></th>
									<th><spring:message code="label.order.deliveryCharge"/></th>
									<th><spring:message code="label.order.buyerName"/></th>
									<c:if test="${userGrup eq 1}">
										<th><spring:message code="label.order.sellerName"/></th>
									</c:if>
									<th><spring:message code="label.order.status"/></th>
								</tr>
								
								<c:set var="current" value="0"/>
								<c:set var="prod_amt" value="0"/>
								<c:set var="dlvy_amt" value="0"/>
								<c:forEach items="${orderInfo}" var="info" varStatus="status">	
								<c:set var="prod_amt" value="${prod_amt+info.order_amt}"/>
									<tr>
										<td>${info.prod_order_no}</td>
										<td  style="text-align:left">
											<div style="float:left; margin-right:10px;">
												<img src="/common/file/downloadImage/${info.file_id}" onload="javascript:initImage(this);" style="cursor: pointer;height: 50px; width: 44px; margin-left: 3px;">	
											</div>
											<div style="margin-top:12px;" class="ellipsis">
												${info.prod_name}<br/><spring:message code="label.order.amount"/> : ${info.order_cnt} <spring:message code="label.order.unit"/>
											</div>
										</td>
										<td><fmt:formatNumber value="${info.order_amt}" pattern="#,###" /><spring:message code="label.order.won"/></td>
										<c:if test="${current == 0 }"><!-- 설정 -->
											<c:set var="dlvy_amt" value="${dlvy_amt+2500}"/>
											<c:set var="current" value="${info.cnt}"/>
											<td rowspan="${current}"><fmt:formatNumber value="${info.dlvy_amt}" pattern="#,###" /><spring:message code="label.order.won"/></td>
											<td rowspan="${current}">${info.user_id}</td>
											<c:if test="${userGrup eq 1}">
												<td rowspan="${current}">${info.store_id}<br/>(${info.store_name})</td>
											</c:if>
										</c:if>						
										<td>
											${info.order_sts_name}
											<br/>
											<c:if test="${info.order_sts_cd eq '030' || info.order_sts_cd eq '040'}">
												<a href="javascript:delivery_tracking('${info.waybil_no}')" class="amb_btnstyle green middle"><spring:message code="label.order.delivery.search"/></a>
											</c:if>
										</td>
									</tr>
									
								<c:set var="current" value="${current-1}"/><!-- 감소 -->
								</c:forEach>
							</thead>
							
						</table>
					</div>
				</div>
			</div>
			<div class="rowBox mgT30">
			<!-- 주문자정보 정보영역 -->
			<h3>
				<span class="title"><spring:message code="label.order.buyerInfo" /></span>
			</h3>
			<div class="g_column w_1_1">
				<div id="sameHeight_02" class="unitBox" style="">
					<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 20%;">
							<col style="">
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="label.order.buyerName" /></th>
								<td>${orderInfo[0].user_id}</td>
							</tr>
							<tr>
								<th><spring:message code="label.order.phone" /></th>
								<td id="s_mobile"></td>
							</tr>
							<tr>
								<th><spring:message code="label.order.email" /></th>
								<td>${orderInfo[0].email}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		<div class="rowBox mgT30">
			<!-- 배송지 정보영역 -->
			<h3>
				<span class="title"><spring:message code="label.order.deliveryInfo" /></span>
			</h3>
			<div class="g_column w_1_1">
				<div id="sameHeight_02" class="unitBox" style="">
					<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 20%;">
							<col style="">
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="label.order.receiver" /></th>
								<td>${orderInfo[0].user_nm}</td>
							</tr>
							<tr>
								<th><spring:message code="label.order.phone" /></th>
								<td id="r_mobile"></td>
							</tr>
							<tr>
								<th><spring:message code="label.order.addr" /></th>
								<td>${orderInfo[0].base_addr}, ${orderInfo[0].dtl_addr} </td>
							</tr>
							<tr>
								<th><spring:message code="label.order.addrMsg" /></th>
								<td>${orderInfo[0].dlvy_memo} </td>
							</tr>
							<c:if test="${userGrup eq 2}">
								<tr>
									<th><spring:message code="label.order.memo" /></th>
									<td>
										<textarea id="memo" rows="3" cols="50" style="width: 100%;" placeholder='<spring:message code="label.order.memo.placeholder"/>'>${orderInfo[0].store_id_memo}</textarea>
										<div class="fr btnArea middle">
											<a href="javascript:memoModifyAction();" class="amb_btnstyle blue middle"><spring:message code="label.common.save"/></a>
										</div>
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>

			</div>
		</div>
		
		<div class="rowBox mgT30">
			<!-- 결제정보 정보영역 -->
			<h3>
				<span class="title"><spring:message code="label.order.paymentInfo" /></span>
			</h3>
			<div class="g_column w_1_1">
				<div id="sameHeight_02" class="unitBox" style="">
					<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 20%;">
							<col style="">
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="label.order.paymentMethod" /></th>
								<td>${orderInfo[0].payment_way_name}</td>
							</tr>
							<tr>
								<th><spring:message code="label.order.totalProductAmount" /></th>
								<td><fmt:formatNumber value="${prod_amt}" pattern="#,###" /><spring:message code="label.order.won" /></td>
							</tr>
							<tr>
								<th><spring:message code="label.order.deliveryCharge" /></th>
								<td><fmt:formatNumber value="${dlvy_amt}" pattern="#,###" /><spring:message code="label.order.won" /></td>
							</tr>
							<tr>
								<th><spring:message code="label.order.totalAmount" /></th>
								<td><fmt:formatNumber value="${prod_amt+dlvy_amt}" pattern="#,###" /><spring:message code="label.order.won" /></td>
							</tr>
						</tbody>
					</table>
				</div>

			</div>
		</div>
		<div class="fr btnArea middle">
			<a href="#" id="btnCloseFoot" class="amb_btnstyle gray middle" onclick="javascript:closeModal(this);">닫기</a>
		</div>
		</div>
	</div>
</div>