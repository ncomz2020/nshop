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
		
	});	
	 
	/* 상품순번, 교환/반품 구분, 버튼상태 
	*  취소 : C, 교환 : E, 반품 : R
	*  승인 : A, 철회 : R, 불가 : N, 상품발송: S, 반품완료 : C, 교환배송완료 : D
	*/
	function gostatusChangeAction(index, type1, type2){
		var statusName = "";
		var param = new Object();
		param.prod_order_seq = index;
		if(type1 == "E"){
			if(type2 == "A"){
				param.order_sts_cd = "220";
			}else if(type2 == "R"){
				param.order_sts_cd = "050";
				param.chng_cd="200";
				param.title="<spring:message code='label.order.title.exchange'/>";
				refusePopup(param);
				return;
			}else if(type2 == "N"){
				param.order_sts_cd = "260";
				param.chng_cd="200";
				param.title="<spring:message code='label.order.title.exchange.no'/>";
				refusePopup(param);
				return;
			}else if(type2 == "S"){
				param.order_sts_cd = "230";
			}else if(type2 == "D"){
				param.order_sts_cd = "240";
			}
		}else if(type1 == "R"){
			if(type2 == "A"){
				param.order_sts_cd = "320";
			}else if(type2 == "R"){
				param.order_sts_cd = "050";
				param.chng_cd="300";
				param.title="<spring:message code='label.order.title.refuse'/>";
				refusePopup(param);
				return;
			}else if(type2 == "N"){
				param.order_sts_cd = "340";
				param.chng_cd="300";
				param.title="<spring:message code='label.order.title.refuse.no'/>";
				refusePopup(param);
				return;
			}else if(type2 == "C"){
				param.order_sts_cd = "330";
			}
		}else if(type1 == "C"){
			param.order_sts_cd = "120";
		}
		
		if(type2 == "A")
			statusName = "<spring:message code='label.order.approve'/>";
		else if(type2 == "S")
			statusName = "<spring:message code='label.order.send'/>";
		else if(type2 == "C")
			statusName = "<spring:message code='label.order.complete'/>";
		
		 swal({
		        title: statusName + '<spring:message code="label.product.prod.confirm.change.back"/>',
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonText: "예",
		        cancelButtonText: "아니오",
		        closeOnConfirm: false
		    },function () {
				$.ajax({
				url : "statusModifyAction.json",
				type : "POST",
				data : param,
				dataType : "json",
				success : function(data) {
					var result = data.result;
					if (result == "succ") {
						swal({
				      		title: statusName + ' <spring:message code="label.common.success.action"/>', 
				      		type: "success",
				      		confirmButtonText: ' <spring:message code="label.common.close"/>'
				      	});
						refreshList();
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
	
	function refusePopup(param){
		var url = "refuse.ajax";
		openModal(url, "ModifyModal", param,"500");		
	}
	
	
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code="label.order.cancel.list"/></span>
		</h3>
		<div class="unitBox" style="">
			<table class="amb_table">
				<colgroup>
					<col style="width: 15%;" />
					<col style="width: 10%" />
					<col style="" />
					<col style="width: 10%" />
					<c:if test="${userGrup eq 2}">
						<col style="width: 20%" />
					</c:if>
					<c:if test="${userGrup eq 1}">
						<col style="width: 10%" />
					</c:if>
					<col style="width: 10%" />
					<col style="width: 10%" />
					<c:if test="${userGrup eq 1}">
						<col style="width: 10%" />
					</c:if>
				</colgroup>
				<thead>
					<tr>
						<th><spring:message code="label.order.orderNumber"/></th>
						<th><spring:message code="label.order.status.apply"/><spring:message code="label.common.date"/></th>
						<th><spring:message code="label.order.productDetail"/></th>
						<th><spring:message code="label.order.productAmount"/></th>
						<th><spring:message code="label.order.status"/></th>
						<th><spring:message code="label.order.rsn"/>(<spring:message code="label.order.dtl.rsn"/>)</th>
						<th><spring:message code="label.order.buyerId"/></th>
						<c:if test="${userGrup eq 1}">
							<th><spring:message code="label.order.sellerId"/></th>
						</c:if>
					</tr>
				</thead>
				<tbody>
				<c:set var="current" value="0"/>
				<c:set var="num" value="0"/>
					<c:forEach items="${list}" var="info" varStatus="status">					
						<tr>					
							<c:if test="${current == 0 }"><!-- 설정 -->
								<td rowspan="${rowCount[num]}"><a href="javascript:movePage('/admin/order/orderList/detail.ajax', {order_seq: '${info.order_seq}',pageType:'cancelList'});">${info.order_no}<br/>(${info.order_datetime})</a></td>
								<c:set var="current" value="${rowCount[num]}"/>
								<c:set var="num" value="${num+1}"/>
							</c:if>
							
							<td>${info.chng_aply_datetime}</td>	
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
							<td>
								${info.order_sts_name}
								<c:if test="${userGrup eq 2}">
									<c:choose>
										<c:when test="${info.order_sts_cd eq '110'}">
											<a href="javascript:gostatusChangeAction(${info.prod_order_seq}, 'C', 'A');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.order.status.cancel.approve"/></a>
										</c:when>
										<c:when test="${info.order_sts_cd eq '210'}">
											<a href="javascript:gostatusChangeAction(${info.prod_order_seq}, 'E', 'A');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.order.status.exchange.approve"/></a>
											<a href="javascript:gostatusChangeAction(${info.prod_order_seq}, 'E', 'R');" class="amb_btnstyle red middle stateEdit"><spring:message code="label.order.status.exchange.withdraw"/></a>
										</c:when>
										<c:when test="${info.order_sts_cd eq '220'}">
											<a href="javascript:gostatusChangeAction(${info.prod_order_seq}, 'E', 'S');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.order.status.exchange.send"/></a>
											<a href="javascript:gostatusChangeAction(${info.prod_order_seq}, 'E', 'N');" class="amb_btnstyle red middle stateEdit"><spring:message code="label.order.status.exchange.no"/></a>
										</c:when>
										<c:when test="${info.order_sts_cd eq '230'}">
											<a href="javascript:gostatusChangeAction(${info.prod_order_seq}, 'E', 'D');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.order.status.deliveryComplete"/></a>
										</c:when>
										<c:when test="${info.order_sts_cd eq '310'}">
											<a href="javascript:gostatusChangeAction(${info.prod_order_seq}, 'R', 'A');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.order.status.return.approve"/></a>
											<a href="javascript:gostatusChangeAction(${info.prod_order_seq}, 'R', 'R');" class="amb_btnstyle red middle stateEdit"><spring:message code="label.order.status.return.withdraw"/></a>
										</c:when>
										<c:when test="${info.order_sts_cd eq '320'}">
											<a href="javascript:gostatusChangeAction(${info.prod_order_seq}, 'R', 'C');" class="amb_btnstyle blue middle stateEdit"><spring:message code="label.order.status.return.complete"/></a>
											<a href="javascript:gostatusChangeAction(${info.prod_order_seq}, 'R', 'N');" class="amb_btnstyle red middle stateEdit"><spring:message code="label.order.status.return.no"/></a>
										</c:when>
									</c:choose>
									
								</c:if>
							</td>							
							<td>${info.chng_rsn}<br/>(${info.chng_dtl_rsn})</td>
							<td>${info.user_id}</td>
							<c:if test="${userGrup eq 1}">
								<td>${info.store_id}<br/>(${info.store_name})</a></td>
							</c:if>
						</tr>	
											
					<c:set var="current" value="${current-1}"/><!-- 감소 -->
					
					</c:forEach>
					<c:if test="${empty list}">
						<tr>
							<c:if test="${userGrup eq 1}">
								<td colspan="8"><spring:message code="label.common.empty.list"/></td>
							</c:if>
							<c:if test="${userGrup eq 2}">
								<td colspan="7"><spring:message code="label.common.empty.list"/></td>
							</c:if>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="paging center">
			<ul class="paginglist">
				<jsp:include page="/WEB-INF/views/include/paging.jsp" />
			</ul>
		</div>
	</div>
</div>
</div>
<!-- rowBox 반복단위 -->