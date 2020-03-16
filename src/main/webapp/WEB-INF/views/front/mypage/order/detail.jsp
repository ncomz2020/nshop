<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
 	
<script type="text/javascript">
	var pageType = '';
	
	$(document).ready(function() {
		pageType = '${pageType}';
		//로고이미지 가운데 정렬
		$('.photoBox').css('width','100%');
		setPhone();
	});
	
	function goListPage() {
		$("#myForm").attr("action", "list");
		$("#myForm").submit();
	}
	
	function setPhone(){
		var sMobile = "${orderInfo[0].s_mobile_no}";
		var rMobile = "${orderInfo[0].r_mobile_no}";
		sMobile = sMobile.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
		rMobile = rMobile.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
		$("#s_mobile").text(sMobile);
		$("#r_mobile").text(rMobile);
	}
	/*
	* 구매확정 : P, 취소신청 : C, 교환/반품신청 : E, 교환/반품 철회 : R,  주소지 변경 : A
	*/
	function goPopup(str) {
		var param = new Object();
		param.order_seq = ${orderInfo[0].order_seq};
		if(str == "P"){
			var url = "confirmation.ajax";
			param.sts_cd = "10"; 
			openModal(url, "ModifyModal", param,"500");
		}else if(str == "R"){
			var url = "confirmation.ajax";
			param.sts_cd = "20";
			openModal(url, "ModifyModal", param,"500");
		}else if(str == "C"){
			var url = "applyPopup.ajax";
			param.sts_cd = "30"; 
			openModal(url, "ModifyModal", param,"500");
		}else if(str == "E"){
			var url = "applyPopup.ajax";
			param.sts_cd = "10"; 
			openModal(url, "ModifyModal", param,"500");
		}
		
		if(str == "A"){
			var url = "modifyAddr.ajax";
			openModal(url, "ModifyModal", param,"500");
		}
	}
	
	function delivery_tracking(invoice){
	    
		var url = "/admin/delivery/delivery_tracking.ajax";
	      
		var param = {};
		param.t_code = "04";
		param.t_invoice = invoice;
			      
		openModal(url, 'delivery_tracking' ,param , '900');
			      
	}

</script>

</head>
<body>
	<div id="contentWrap" class="contentWrap">
		<div id="content" class="content wrap">
			<h3>
				<span class="title" id="subtitle"><spring:message code="label.order.front.title.detail" /></span>
			</h3>
	<!-- rowBox 반복단위 -->
	<div class="rowBox mgT10 ">
		<div class="g_column w_1_1">
			<div class="unitBox searchBox" style="">
			<form id="myForm" name="myForm" method="post"></form>
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
	</div>
		
		<!-- 주문 상품 정보 영역 -->
		<div class="rowBox mgT30 prd_info">
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
					<col style="width: 10%" />
					<col style="width: 12%" />
				</colgroup>
				<thead>
					<tr>
						<th><spring:message code="label.order.productOrderNumber"/></th>
						<th><spring:message code="label.order.productInfo"/></th>
						<th><spring:message code="label.order.productAmount"/></th>
						<th><spring:message code="label.order.deliveryCharge"/></th>
						<th><spring:message code="label.order.front.sellerName"/></th>
						<th><spring:message code="label.order.status"/></th>
						<th><spring:message code="label.order.front.y.n"/></th>
					</tr>
					
					<c:set var="current" value="0"/> <!-- 현재row -->
					<c:set var="prod_amt" value="0"/> <!-- 상품가격합산 -->
					<c:set var="dlvy_amt" value="0"/> <!-- 배송비합상 -->
					<c:set var="storeChk" value="T"/> <!-- 같은상점 체크 -->
					<c:set var="addrYN" value="T"/> <!-- 배송지수정 가능 여부 -->
					
					<c:forEach items="${orderInfo}" var="info" varStatus="status">
					<c:if test="${info.order_sts_cd ne '010' and info.order_sts_cd ne'020' }">
					 	<c:set var="addrYN" value="F"/>
					</c:if>
					<c:set var="prod_amt" value="${prod_amt+info.payment_amt}"/>
						<tr>
							<td>${info.prod_order_no}</td>
							<td  style="text-align:left">
								<div style="float:left; margin-right:10px;">
									<img src="/common/file/downloadImage/${info.file_id}" onload="javascript:initImage(this);" style="cursor: pointer;height: 100px; width: 88px; margin-left: 3px;">	
								</div>
								<div style="margin-top:12px;" class="ellipsis">
									<a href="javascript:movePage('/front/product/detail', {prod_id: '${info.prod_id}',pageType:'productList'});">${info.prod_name}</a><br/><spring:message code="label.order.amount"/> : ${info.order_cnt} <spring:message code="label.order.unit"/>
								</div>
							</td>
							<td><fmt:formatNumber value="${info.payment_amt}" pattern="#,###" /><spring:message code="label.order.won"/></td>
							<c:if test="${current == 0 }">
								<c:set var="dlvy_amt" value="${dlvy_amt+2500}"/><!-- 한 상점에 대해 한번의 배송비 합산  -->
								<c:set var="current" value="${info.cnt}"/>
								<td rowspan="${current}"><fmt:formatNumber value="${info.dlvy_amt}" pattern="#,###" /><spring:message code="label.order.won"/></td>
								<td rowspan="${current}">${info.store_name}</td>
							</c:if>						
							<td>
								${info.order_sts_name}
								<br/>
								<c:if test="${info.order_sts_cd eq '030' || info.order_sts_cd eq '040'}">
									<a href="javascript:delivery_tracking('${info.waybil_no}')" class="amb_btnstyle green middle"><spring:message code="label.order.delivery.search"/></a>
								</c:if>
								<c:if test="${info.order_sts_cd eq '230' || info.order_sts_cd eq '240'}">
									<a href="javascript:delivery_tracking('${info.echn_waybil_no}')" class="amb_btnstyle green middle"><spring:message code="label.order.delivery.search"/></a>
								</c:if>
							</td>
							<c:choose>
								<c:when test="${info.order_sts_cd eq '010' || info.order_sts_cd eq '020'}">
									<td>
										<input type="hidden" id="btnIndex" value="${status.index}"/>
										<a href="javascript:goPopup('C');" class="amb_btnstyle gray middle" style="margin:2px;"><spring:message code="label.order.status.cancel.request"/></a>
									</td>
								</c:when>
								<c:when test="${info.order_sts_cd eq '040' || info.order_sts_cd eq '240'}">
									<td>	
										<a href="javascript:goPopup('P');" class="amb_btnstyle gray middle" style="margin:2px;"><spring:message code="label.order.status.purchase.confirmation"/></a>
										<a href="javascript:goPopup('E');" class="amb_btnstyle gray middle" style="margin:2px;"><spring:message code="label.order.status.exchange"/>/<spring:message code="label.order.status.return"/> <spring:message code="label.order.status.apply"/></a>
									</td>
								</c:when>
								<c:when test="${info.order_sts_cd eq '210' || info.order_sts_cd eq '220' || info.order_sts_cd eq '310'}">
									<td>	
										<a href="javascript:goPopup('R');" class="amb_btnstyle gray middle" style="margin:2px;"><spring:message code="label.order.status.exchange"/>/<spring:message code="label.order.status.return"/> <spring:message code="label.order.refuse"/></a>
									</td>
								</c:when>
								<c:otherwise>
									<td>
									</td>
								</c:otherwise>
							</c:choose>								
						</tr>
						
					<c:set var="current" value="${current-1}"/><!-- 감소 -->
					</c:forEach>
				</thead>
				
			</table>
		</div>
	</div>
</div>
		
		<div class="rowBox mgT30 prd_info">
			<!-- 배송지 정보영역 -->
			<h3>
				<span class="title"><spring:message code="label.order.deliveryInfo" /></span>
				<c:if test="${addrYN eq 'T'}">
					<a href="javascript:goPopup('A');" class="amb_btnstyle gray middle " style="float:right;"><spring:message code="label.order.front.change.address" /></a>
				</c:if>
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
						</tbody>
					</table>
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
		
		<c:if test="${refundInfo.list_sts_cd eq 'R' }">
		<div class="rowBox mgT30 prd_info">
			<!-- 환불 결제정보 정보영역 -->
			<h3>
				<span class="title"><spring:message code="label.order.refundInfo" /></span>
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
								<th><spring:message code="label.order.totalProductAmount" /></th>
								<td><fmt:formatNumber value="${refundInfo.payment_amt}" pattern="#,###" /><spring:message code="label.order.won" /></td>
							</tr>
							<tr>
								<th><spring:message code="label.order.deliveryCharge" /></th>
								<td><fmt:formatNumber value="${refundInfo.dlvy_amt}" pattern="#,###" /><spring:message code="label.order.won" /></td>
							</tr>
							<tr>
								<th><spring:message code="label.order.totalRefundAmount" /></th>
								<td><fmt:formatNumber value="${refundInfo.payment_amt+refundInfo.dlvy_amt}" pattern="#,###" /><spring:message code="label.order.won" /></td>
							</tr>
						</tbody>
					</table>
				</div>

			</div>
		</div>
		</c:if>
		
		<div class="prd_info">
				<div class="contBox">
					<div class="rowBox mgT10 orderBox">
						<a href="javascript:goListPage();" class="amb_btnstyle listGo"><span><spring:message code="label.common.list" /></span></a>
					</div>
				</div>
			</div>
</div>
</div>
</body>


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
			$("#update_zip_code").val(data.zonecode);
			$("#update_addr").val(fullAddr);

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('update_dtl_addr').focus();
        },
        theme: {
        	bgColor: "#617FD9", //바탕 배경색   
        	searchBgColor: "#617FD9", //검색창 배경색
        	queryTextColor: "#FFFFFF" //검색창 글자색
        }
    }).open();
}
</script>

