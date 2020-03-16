<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/js/dynatree/jquery.dynatree.js"></script>
<link rel="stylesheet" href="/js/dynatree/skin/ui.dynatree.css">
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
	$(document).ready(function() {
		IMP.init('imp44626297'); //iamport 대신 자신의 "가맹점 식별코드"를 사용하시면 됩니다
		/* var page = "${param.page}";
		if (isEmpty(page)) {
			page = 1;
		}
		searchList(page); */
		searchList();
	});

	function goDetail(ppl_id) {
		var param = new Object();
		param.ppl_id = ppl_id;
		movePage("detail", param);
	}
	
	function goHome(){
		movePage("/front/product/list");
	}
	

	function searchList() {
		var param = new Object();
		console.log("${wish_seq}");
		console.log("${direct_order}");
		param.wish_seq = "${wish_seq}";
		param.direct_order = "${direct_order}";
		$.ajax({
			url : "listAction.ajax",
			type : "POST",
			data : param,
			success : function(data) {
				console.log(data);
				$("#listActionDiv").html(data);
			}
		});
	}
</script>

<!-- contentWrap -->
	<div id="contentWrap" class="contentWrap">
		<div id="content" class="content wrap">
			<div class="prd_info rowBox mgT10">
					<spring:message code="label.order.front.complete"/>
			</div>
			<!-- <a href="javascript:goStatUpdateAction();" class="amb_btnstyle gray large">선택상품삭제</a> -->
					<div class="prd_info paging center">
						<ul class="paginglist">
							<div>
							<!-- order seq로 변경 -->
								<a href="javascript:movePage('/front/mypage/order/detail', {order_seq: '${orderSeq}',pageType:'orderList'});" class="amb_btnstyle gray middle"><spring:message code="label.order.front.list"/></a>
								<a href="javascript:goHome();" class="amb_btnstyle gray middle"><spring:message code="label.cart.home"/></a>
							</div>
						</ul>
					</div> 
					<!-- 페이징 end -->
		</div>
	</div>
	<!-- //contentWrap -->