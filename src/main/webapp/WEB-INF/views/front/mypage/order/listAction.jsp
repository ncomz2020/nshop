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
		initMorePage();
	});	
	
	function delivery_tracking(invoice){
	    
		var url = "/admin/delivery/delivery_tracking.ajax";
	      
		var param = {};
		param.t_code = "04";
		param.t_invoice = invoice;
			      
		openModal(url, 'delivery_tracking' ,param , '900');
			      
	}
	
	function initMorePage(){
		var page = $('#page').val();
		var count = ${count};
		if(count <= page){
		$("#paging_pos").remove();
		}
	}
	
	function setPage(){
		var page = $('#page').val();
		var perPage = $("#perPage").val();
		var count = ${count};
		if(count > page){
			searchList((page*1)+(perPage*1), perPage);
		}					
	}

</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code="label.order.title.list"/></span>
		</h3>
		<div class="unitBox" style="">
			<table class="amb_table">
				<colgroup>
					<col style="width: 20%;" />
					<col style="" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
				</colgroup>
				<thead>
					<tr>
						<th><spring:message code="label.order.orderNumber"/></th>
						<th><spring:message code="label.order.productDetail"/></th>
						<th><spring:message code="label.order.productAmount"/></th>
						<th><spring:message code="label.order.status"/></th>
						<th><spring:message code="label.order.front.sellerName"/></th>
					</tr>
				</thead>
				<tbody>
				<c:set var="current" value="0"/>
					<c:forEach items="${list}" var="info" varStatus="status">
						<tr>
							<c:if test="${current == 0 }"><!-- 설정 -->
								<c:set var="current" value="${info.cnt}"/>
								<td rowspan="${current}"><a href="javascript:movePage('detail', {order_seq: '${info.order_seq}',pageType:'orderList'});">${info.order_no}<br/>(${info.order_datetime})</a></td>
							</c:if>
							
							<td style="text-align:left">
							<div style="float:left; margin-right:10px;">
								<img src="/common/file/downloadImage/${info.file_id}" onload="javascript:initImage(this);" style="cursor: pointer;height: 50px; width: 44px; margin-left: 3px;">	
							</div>
							<div style="float:left;margin-top:10px;">		
							<a href="javascript:movePage('/front/product/detail', {prod_id: '${info.prod_id}',pageType:'productList'});">						
								${info.prod_name}</a>
								<br/><spring:message code="label.order.amount"/> : ${info.order_cnt} <spring:message code="label.order.unit"/>
							</div>
							</td>
							<td>
								<fmt:formatNumber value="${info.payment_amt}" pattern="#,###" /><spring:message code="label.order.won"/>
							</td>
							<td>${info.order_sts_name}<br/>
								<c:if test="${info.order_sts_cd eq '030' || info.order_sts_cd eq '040'}">
									<a href="javascript:delivery_tracking('${info.waybil_no}')" class="amb_btnstyle green middle"><spring:message code="label.order.delivery.search"/></a>
								</c:if>	
								<c:if test="${info.order_sts_cd eq '230' || info.order_sts_cd eq '240'}">
									<a href="javascript:delivery_tracking('${info.echn_waybil_no}')" class="amb_btnstyle green middle"><spring:message code="label.order.delivery.search"/></a>
								</c:if>	
							</td>
							<td>${info.store_name}</td>
						</tr>	
											
					<c:set var="current" value="${current-1}"/><!-- 감소 -->
					</c:forEach>
					<c:if test="${empty list}">
						<tr>
							<td colspan="5"><spring:message code="label.common.empty.list"/></td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div id="paging_pos" class="paging center" style="border:#f8f8f9 1px solid; background:#f8f8f9;heigth:20px">
			<a id="more_btn" href="javascript:setPage();">
				<span>+ <spring:message code="label.order.front.more"/></span>
			</a>
		</div>
	</div>
</div>
</div>
<!-- rowBox 반복단위 -->