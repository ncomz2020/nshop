<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
.amb_btnstyle.large {
    font-size: 11px;
    font-weight: ;
    height: 20px;
    line-height: 20px;
    padding: 0px 14px;
}
</style>
<script>
	$(document).ready(function() {
		initUserInfo();
		setPhone();
		
		$("#input_memo").change(function(){
			$("#memo").val($("#input_memo").val());
		});
		
		$('#checkboxListAll').click(function() {
			var checkedStatus = this.checked;
			$('input[name="checkboxList"]').each(function() {
				$(this).prop('checked', checkedStatus);
			});
		});
		
		var filter = "win16|win32|win64|mac|macintel"; 
		if ( navigator.platform ) { 
			if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) {
				//mobile 
				$("#order_way_cd").val("20");//주문수단코드
			} else { 
				//pc 
				$("#order_way_cd").val("10");
			}
		}	
		
	});
	
	function openInsertUserGroup() {
		var url = "insert.ajax";
		openModal(url, 'insertModal');
	}

	function openUpdateUserGroup(usr_grp_id) {
		var param = new Object();
		param.usr_grp_id = usr_grp_id;
		var url = "update.ajax";
		openModal(url, 'updateModal', param);
	}
		
	function goHome(){
		movePage("/front/product/list");
	}
	
	function goStatUpdateAction(store_id, prod_id, wish_seq) {
		var coment = "";
		

		var arrWishSeq = [];
		$('input[name="checkboxList"]').each(function() {
			var checkedStatus = this.checked;
			if (checkedStatus) {
				var wish_seq = $(this).val();
				arrWishSeq.push(wish_seq);
			}
		});
		console.log(arrWishSeq)

		
		var param = new Object();
		if(wish_seq !=null){
			param.wish_seq = wish_seq;
		}else{
			param.wish_seq = arrWishSeq.join();			
		}
		console.log(param.wish_seq);
		
		
	/*	$.alertable.confirm('(' + coment + ')' + ' <spring:message code="label.product.prod.confirm.change.back"/>').then(function() {
			$.ajax({
			url : "deleteCartAction.json",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data) {
				var result = data.result;
				if (result == "succ") {
					$.alertable.alert('(' + coment + ')' + ' <spring:message code="label.common.success.action"/>').then(function() {
						movePage('/front/mypage/cart/list');
					});
				} else {
					$.alertable.alert(result);
				}
			},
			});
		});*/
		
		swal({
	        title: '' + coment + '' + ' <spring:message code="label.product.prod.confirm.change.back"/>',
	        showCancelButton: true,
	        confirmButtonText: '<spring:message code="label.common.yes"/>',
	        cancelButtonText: '<spring:message code="label.common.no"/>',
	        closeOnConfirm: false
	    },function () {
			$.ajax({
			url : "deleteCartAction.json",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data) {
				var result = data.result;
				if (result == "succ") {
					swal({
			      		title: '' + coment + '' + ' <spring:message code="label.common.success.action"/>', 
			      		}, function(){
			      		movePage('/front/mypage/cart/list');
			      	});
					
				} else {
					swal({
			      		title: result, 
			      	});
				}				
			},
			});
	    });
	}
	
	
	function goPay(){
		/*필수 입력 항목 체크*/
		$("#payment_way_cd").val($('input:radio[name="radio_1"]:checked').val());//결제수단코드
		
		
		if($("#user_nm").val() == ""){
			swal({
		        title: '<spring:message code="label.order.front.valid.receiver"/>'
		    });	
			return;
		}
		if($("#mobile_no").val() == ""){
			swal({
		        title: '<spring:message code="label.order.front.valid.phone"/>'
		    });	
			return;
		}else{
			var regex= /^[0-9]*$/;
			if(!regex.test($("#mobile_no").val())){
				swal({
			        title: '<spring:message code="label.order.front.valid.number"/>'
			    });	
				return;
			}
		}
		if($("#zip_cd").val() == "" || $("#base_addr").val() == ""){
			swal({
		        title: '<spring:message code="label.order.front.valid.addr"/>'
		    });	
			return;
		}
		
		var payName = "";
		if("${fn:length(list)}" > 1){
			payName = "${list[0].prod_name}" + ' <spring:message code="label.order.front.ex"/>'+"${fn:length(list)-1}"+'<spring:message code="label.order.front.count"/>';
		}else{
			payName = "${list[0].prod_name}";
		};
		
		IMP.request_pay({
		    pg : 'inicis', // version 1.1.0부터 지원.
			pay_method : 'card',
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : payName,
			amount : 100, //결제 총 액
			escrow : true,
			buyer_email : "${info.email}",
			buyer_name : "${info.user_nm}",
			buyer_tel : "${info.mobile_no}",
			buyer_addr : "${info.base_addr} ${info.dtil_aar}",
			buyer_postcode : "${info.zip_cd}",
			m_redirect_url : "http://192.168.20.162:8080/front/order/mobilePay.ajax?"+$("#myForm").serialize()   ,// 모바일 결제시 redirect 페이지
				card_quota : [2,3,4,5,6]
		}, function(rsp) {
			console.log(rsp)
			  console.log($('.tit').text())
		       if ( rsp.success ) {
		    	   console.log($('.tit').text())
		           var msg = '결제가 완료되었습니다.';
		           msg += '고유ID : ' + rsp.imp_uid;
		           msg += '상점 거래ID : ' + rsp.merchant_uid;
		           msg += '결제 금액 : ' + rsp.paid_amount;
		           msg += '카드 승인번호 : ' + rsp.apply_num;

				   payAction();
		           //폼 action 실행
		      //    $("#_payFrm").attr("action", "afPayView.do").submit();
		       } else {
		           var msg = '결제에 실패하였습니다.';
		           msg += '에러내용 : ' + rsp.error_msg;
		       }
		       //alert(msg);
		   } );
	}	
	
	function payAction(){
		var param = new Object();
		param = $("#myForm").serialize();
		$.ajax({
		url : "payAction.json",
		type : "POST",
		data : param,
		dataType : "json",
		success : function(data) {
			var result = data.result;
			if (result != "0") {
				var param = new Object();
				param.order_seq = result;
	        	movePage("/front/order/finish", param);	
			} else {
				swal({
			        title: result,
		      		type: "error"
			    });
			}
		},
		});
	}
	
	function setPhone(){
		var sMobile = "${info.mobile_no}";//"${orderInfo[0].s_mobile_no}";
		sMobile = sMobile.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
		$("#s_mobile").text(sMobile);
	}
	
	function initUserInfo(){
		$("#prod_id").val("${orderList.prod_id}");
		$("#order_cnt").val("${orderList.order_cnt}");
		$("#wish_seq").val("${orderList.wish_seq}");
		
		$("#user_nm").val("${info.user_nm}");
		$("#mobile_no").val("${info.mobile_no}");
		$("#zip_cd").val("${info.zip_cd}");
		$("#base_addr").val("${info.base_addr}");
		$("#dtil_aar").val("${info.dtil_aar}");		
	}
	
	function goModiAddr(flag){			
		if(flag == 'N'){//신규배송지
			$("#addrBtn").html("<a href=\"javascript:goModiAddr('O')\" class=\"amb_btnstyle gray middle\" style=\"float:right;\"><spring:message code='label.cart.ori.addr'/></a>"); //버튼 변경
			
			$("#user_nm").css("display", "");
			$("#mobile_no").css("display", "");
			$("#input_addr").css("display", "");
			
			$("#nm").css("display", "none");
			$("#s_mobile").css("display", "none");
			$("#addr").css("display", "none");
			
		}else if(flag == "O"){ //기본배송지
			initUserInfo();
			$("#addrBtn").html("<a href=\"javascript:goModiAddr('N')\" class=\"amb_btnstyle gray middle\" style=\"float:right;\"><spring:message code='label.order.front.change.address'/></a>");//버튼번경
			
			$("#user_nm").css("display", "none");
			$("#mobile_no").css("display", "none");
			$("#input_addr").css("display", "none");
			
			$("#nm").css("display", "");
			$("#s_mobile").css("display", "");
			$("#addr").css("display", "");
		}
	}
</script>



 <div id="contentWrap" class="contentWrap">
		<div id="content" class="content wrap productDetail">
			<form id="prodForm" name="prodForm" method="post">
			 	
			</form>
			<div class="rowBox mgT30 data">
				<div class="g_column w_1_1">
					<h3>
						<span class="title"><spring:message code="label.common.order"/>/<spring:message code="label.common.pay"/></span>						 
					</h3>
					<div class="unitBox">
						<table class="amb_table">
							<colgroup>
								<col style="width: 10%;" />
								<col style="width: 30%;" />
								<col style="width: 10%;" />
								<col style="width: 10%;" />
								<col style="width: 10%;" />
								<col style="width: 10%;" />  
								<%-- <col style="width: 10%;" />  --%>
							</colgroup>
							<thead>
								<tr class="colHeaders">
									<th><spring:message code="label.cart.image"/></th>
									<th><spring:message code="label.cart.product.name"/></th>
									<th><spring:message code="label.cart.product.price"/></th>
									<th><spring:message code="label.cart.amount"/></th>
									<th><spring:message code="label.cart.delivery.fee"/></th>
									<th><spring:message code="label.cart.store"/></th>
								<%--	<th>주문금액</th> --%>
								</tr>
							</thead>
							<tbody>
								<c:set var="shipping_fee" value="0"/>
								<c:set var="prod_price" value="0"/>
								<c:forEach items="${list}" var="info" varStatus="status">
									<c:if  test = "${info.flag eq true}">		
									<tr>
										<td style="text-align: left;">
											<div style="width: 50px; height: 50px; overflow: hidden; position: relative;">
												<c:if test="${not empty info.imageFileList}">
													<c:if test="${fn:length(info.imageFileList) > 1}">
														<div style="text-align: right; position: absolute; left: 35px; top: 35px; width: 15px; height: 15px; font-weight: bold; background-color: #000; color: #fff; opacity: 0.5;">+${fn:length(info.imageFileList) - 1}</div>
													</c:if>
													<c:set var="imageFileIdList" value="" />
													<c:forEach items="${info.imageFileList}" var="imageFile">
														<c:if test="${imageFileIdList != ''}">
															<c:set var="imageFileIdList" value="${imageFileIdList}," />
														</c:if>
														<c:set var="imageFileIdList" value="${imageFileIdList}${imageFile.file_id}" />
													</c:forEach>
													<a href="javascript:openImageList('${imageFileIdList}');">
														<img src="/common/file/downloadImage/${info.imageFileList[0].file_id}" onload="javascript:initImage(this);" style="cursor: pointer;width:50px; height:50px;">
													</a>
												</c:if>
											</div>
										</td>
										<td>
											<a href="javascript:movePage('/front/product/detail', {prod_id: '${info.prod_id}',pageType:'productList'});">${info.prod_name}</a>
											<br />(${info.prod_id})
										</td>
										 
										<td>
											<fmt:formatNumber value="${info.prod_price}" pattern="#,###" />
											<c:set var="prod_price" value="${prod_price+info.prod_price*info.order_cnt}"/>
										</td>
										<td>
											  ${info.order_cnt} 
										</td>
										 <td rowspan="${info.store_cnt}"> <fmt:formatNumber value="${info.shipping_fee}" pattern="#,###" /><c:set var="shipping_fee" value="${shipping_fee+info.shipping_fee}"/> </td>
										  <td rowspan="${info.store_cnt}">${info.store_id}</td>
										  <c:set var="prevStoreId" value="${info.store_id}" />
									</tr>
									</c:if>
								 	<c:if test= "${info.flag ne true}">
							 			<tr>
										<td style="text-align: left;">
											<div style="width: 50px; height: 50px; overflow: hidden; position: relative;">
												<c:if test="${not empty info.imageFileList}">
													<c:if test="${fn:length(info.imageFileList) > 1}">
														<div style="text-align: right; position: absolute; left: 35px; top: 35px; width: 15px; height: 15px; font-weight: bold; background-color: #000; color: #fff; opacity: 0.5;">+${fn:length(info.imageFileList) - 1}</div>
													</c:if>
													<c:set var="imageFileIdList" value="" />
													<c:forEach items="${info.imageFileList}" var="imageFile">
														<c:if test="${imageFileIdList != ''}">
															<c:set var="imageFileIdList" value="${imageFileIdList}," />
														</c:if>
														<c:set var="imageFileIdList" value="${imageFileIdList}${imageFile.file_id}" />
													</c:forEach>
													<a href="javascript:openImageList('${imageFileIdList}');">
														<img src="/common/file/downloadImage/${info.imageFileList[0].file_id}" onload="javascript:initImage(this);" style="cursor: pointer;width:50px; height:50px;">
													</a>
												</c:if>
											</div>
										</td>
										<td>
											<a href="javascript:movePage('/front/product/detail', {prod_id: '${info.prod_id}',pageType:'productList'});">${info.prod_name}</a>
											<br />(${info.prod_id})
										</td>
										 
										<td>
											<fmt:formatNumber value="${info.prod_price}" pattern="#,###" />
											<c:set var="prod_price" value="${prod_price+info.prod_price*info.order_cnt}"/>
										</td>
										<td>
											  ${info.order_cnt} 
										</td>
										<c:if test="${prevStoreId ne info.store_id}">
										<td>
											  <fmt:formatNumber value="${info.shipping_fee}" pattern="#,###" />
											<c:set var="shipping_fee" value="${shipping_fee+info.shipping_fee}"/>
										</td>
										<td>
											  ${info.store_id}
										</td>
										</c:if>
										</tr>
								 	</c:if>
								</c:forEach>
								<c:if test="${!empty list}">
									<tr>
										<td colspan="6">
										 <fmt:formatNumber value="${prod_price}" pattern="#,###" /><spring:message code="label.order.won" /> +  <fmt:formatNumber value="${shipping_fee}" pattern="#,###" /><spring:message code="label.order.won" /> = <fmt:formatNumber value="${prod_price+shipping_fee}" pattern="#,###" /><spring:message code="label.order.won" />
										</td>
									</tr>
								</c:if>
								<c:if test="${empty list}">
									<tr>
										<td colspan="6"><spring:message code="label.common.empty.list"/></td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					
					<div class="rowBox mgT30 prd_info">
						<!-- 배송지 정보영역 -->
						<h3>
							<span class="title"><spring:message code="label.order.deliveryInfo" /></span>
							<div id="addrBtn">
								<a href="javascript:goModiAddr('N')" class="amb_btnstyle gray middle " style="float:right;"><spring:message code="label.order.front.change.address" /></a>
							</div>
						</h3>
						<div class="g_column w_1_1">
							<div id="sameHeight_02" class="unitBox" style="">
							<form id="myForm" name="myForm" method="post">
							<input type="hidden" id="order_way_cd" name="order_way_cd">
							<input type="hidden" id="payment_way_cd" name="payment_way_cd">
							<input type="hidden" id="prod_id" name="prod_id">
							<input type="hidden" id="order_cnt" name="order_cnt">
							<input type="hidden" id="wish_seq" name="wish_seq">
							<input type="hidden" id="memo" name="memo">
								<table class="amb_form_table lineAll">
									<colgroup>
										<col style="width: 20%;">
										<col style="">
									</colgroup>
									<tbody>
										<tr>
											<th><spring:message code="label.order.receiver" /> *</th>
											<td>
												<span id="nm">${info.user_nm}</span>
												<input type="text" class="inp" style="width: 30%;display:none" id="user_nm" name="user_nm" value="" placeholder='<spring:message code="label.order.receiver"/>' maxlength="20">
											</td>
										</tr>
										<tr>
											<th><spring:message code="label.order.phone" /> *</th>
											<td>
												<span id="s_mobile"></span>
												<input type="text" class="inp" style="width: 30%;display:none" id="mobile_no" name="mobile_no" value="" placeholder='<spring:message code="label.order.phone"/>' maxlength="20">
											</td>
										</tr>
										<tr>
											<th><spring:message code="label.order.addr" /> *</th>
											<td>
												<span id="addr">${info.base_addr}, ${info.dtil_aar}</span>
												<div id="input_addr" style="display:none;">
													<input type="number" class="inp" style="width: 20%;" readonly="readonly" id="zip_cd" name="zip_cd" value="" placeholder='<spring:message code="label.common.postno"/>' maxlength="8">
													<a href="javascript:sample6_execDaumPostcode()" style="margin-left:10px" class="amb_btnstyle gray middle" ><spring:message code="label.common.find.postno"/></a>
													<br/><input type="text" class="inp" style="width: 40%;" readonly="readonly" id="base_addr" name="base_addr" value="" placeholder='<spring:message code="label.common.addr"/>' maxlength="300">
													<input type="text" class="inp" style="width: 50%;" id="dtil_aar" name="dtil_aar" value="" placeholder='<spring:message code="label.common.addr.detail"/>' maxlength="300">
												</div>
											</td>
										</tr>
										<tr>
											<th><spring:message code="label.order.addrMsg" /></th>
											<td>
												<textarea id="input_memo" rows="2" cols="50" style="width: 100%;resize: none;" placeholder='<spring:message code="label.order.front.addr.msg"/>'></textarea>
											</td>
										</tr>
									</tbody>
								</table>
								
							</form>
							</div>
			
						</div>
					</div>
					
					<div class="rowBox mgT30 prd_info">
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
											<th><spring:message code="label.order.totalAmount" /></th>
											<td><fmt:formatNumber value="${prod_price+shipping_fee}" pattern="#,###" /><spring:message code="label.order.won" /></td>
										</tr>
										<tr>
											<th><spring:message code="label.order.paymentMethod" /></th>
											<td>
												<input type="radio" id="radio_1_01" name="radio_1" value="10" checked><label for="radio_1_01" class="inp_func"><spring:message code="label.order.card" /></label>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="radio" id="radio_1_02" name="radio_1" value="20" ><label for="radio_1_02" class="inp_func"><spring:message code="label.order.mobile" /></label>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											</td>
										</tr>
									</tbody>
								</table>
							</div>
			
						</div>
					</div>
					
					<!-- <a href="javascript:goStatUpdateAction();" class="amb_btnstyle gray large">선택상품삭제</a> -->
					<div class="prd_info paging center">
						<ul class="paginglist">
							<div>
								<a href="javascript:goPay();" class="amb_btnstyle gray middle"><spring:message code="label.order.front.pay"/></a>
								<a href="javascript:goHome();" class="amb_btnstyle gray middle"><spring:message code="label.cart.home"/></a>
							</div>
						</ul>
					</div> 
					<!-- 페이징 end -->
				
				</div>
			</div>
			
		</div>
	 
	</div> 
	
	
