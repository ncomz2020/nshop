<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src='/js/tinymce/tinymce.min.js'></script>
<script src="/js/jquery.form.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>
.mce-edit-area {
	border-width: 0px !important;
}
input[type="number"] {
   width:80px;
}
</style>
<script type="text/javascript">
	var pageType = '';
	$(document).ready(function() {
		IMP.init('imp44626297'); //iamport 대신 자신의 "가맹점 식별코드"를 사용하시면 됩니다
		
		
		pageType = '${pageType}';

		$('.tab-area').css('display', 'none');
		$('.detail').css('display', 'block');
		$('#detail').addClass('active');
		$(document).on("click", ".tab li a", function() {
			var thisId = $(this).attr('id');
			var thisParent = $(this).parent('li');
			
			console.log(thisId);
			console.log(thisParent);

			thisParent.siblings().removeClass('on');
			thisParent.addClass('on');

			$('.tab-area').css('display', 'none');
			$('.' + thisId).css('display', 'block');
			$('#' + thisId).css('display', 'block');
			
			$('.temp').removeClass('active');
			$(this).addClass("active");
		});
		
		$('.img > img').click(function () {  
            imgPath = $(this).attr("src");  
            jQuery('#bigPicture').attr("src",imgPath);  
        });  
	});

	function goListPage() {
		//상품관리 페이지 이동
		$("#prodForm").attr("action", "list");
		$("#prodForm").submit();
	}
	
	function goServicePreparing(msg){
		swal({
		        title: msg
		    });
	}
	
	function loginCheck(){
		var loginId = "${session_user.usr_nm}";
		
		if(loginId == null || loginId == ""){
			swal({
		        title: '<spring:message code="label.front.product.detail.login"/>'
		    });
			return false;
		}else{
			return true;
		}
	}

	
	function pay(){
		if(!loginCheck()){
			return;
		}
		//주문 페이지 이동
		//$("#prodForm").attr("action", "/front/order/detail");
		//$("#prodForm").submit(); 
	/*	var param = new Object();
		param.prod_id ='23'
		
		movePage("/front/order/detail",param);*/
		
		var coment = "";
		
/*		if ($("input[name=checkboxList]:checkbox:checked").length < 1) {
			swal({
				title: '상품을 선택해주세요.',
			    type: "error"
			});
			return;
		}
		
		var arrWishSeq = [];
		$('input[name="checkboxList"]').each(function() {
			var checkedStatus = this.checked;
			if (checkedStatus) {
				var wish_seq = $(this).val();
				arrWishSeq.push(wish_seq);
			}
		});
		var param = new Object();
		if(wish_seq ==null  ||  wish_seq =="" ||  wish_seq == undefined){
			param.wish_seq = arrWishSeq.join();			
		}else{
			
			param.wish_seq = wish_seq;
		}
		*/
		
		var param = new Object();
		param.wish_seq = "";
		param.order_cnt = $("#order_cnt").val();
		param.store_id = $("#store_id").val();
		param.prod_id = $("#prod_id").val()
		param.direct_order = "Y";
		
		swal({
	        title:  '<spring:message code="label.front.product.detail.buy.now"/>',
	        showCancelButton: true,
	        confirmButtonText: '<spring:message code="label.common.yes"/>',
	        cancelButtonText: '<spring:message code="label.common.no"/>',
	        closeOnConfirm: false
	    },function () {
			movePage('/front/order/list',param);
	    });
		
		
	}
	
	/* function insertCart(){
		loginCheck();
		$.ajax({
			url : "/front/mypage/cart/addAction.ajax",
			type : "POST",
			//data : param,
			success : function(data) {
				console.log(data);
				//$("#listActionDiv").html(data);
			}
		});
	} */
	
	// 승인,운영 상태변경
	function insertCart() {
	 	var coment = "";
	 	var param = new Object();
	 	param.prod_id = $("#prod_id").val()
	 	param.store_id = $("#store_id").val()
	 	param.order_cnt = $("#order_cnt").val();
	 	
	 	if(!loginCheck()){
			return;
		}
	 	
	/* 	var coment = "";
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
			}else{
				coment = '<spring:message code="label.store.operate.off"/>';
			}
		} */

//		$.alertable.confirm('(' + coment + ')' + ' <spring:message code="label.product.prod.confirm.change.back"/>').then(function() {
/* 		$.alertable.confirm('장바구니에 담으시겠습니까?').then(function() {
			$.ajax({
			url : "/front/mypage/cart/insertAction.json",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data) {
				var result = data.result;
				if(result >= 1) {
					$.alertable.alert('장바구니에 담겼습니다.').then(function() {
						//searchList($("#page").val());
					});
				}
				 if (result == "succ") {
					$.alertable.alert('(' + coment + ')' + ' <spring:message code="label.common.success.action"/>').then(function() {
						//searchList($("#page").val());
					});
				} else {
					//$.alertable.alert(result);
				} 
			},
			});
		}); */
		
		swal({
	        title: '<spring:message code="label.front.product.detail.cart.title"/>',
	        showCancelButton: true,
	        confirmButtonText: '<spring:message code="label.common.yes"/>',
	        cancelButtonText: '<spring:message code="label.common.no"/>',
	        closeOnConfirm: false
	    },function () {
			$.ajax({
			url : "/front/mypage/cart/insertAction.json",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data) {
				var result = data.result;
				if (result >= 1) {
					swal({
			      		title: '<spring:message code="label.front.product.detail.cart"/>', 
			      		type: "success",
				        showCancelButton: true,
			      		confirmButtonText: '<spring:message code="label.front.product.detail.cart.view"/>' ,
			      	    cancelButtonText: ' <spring:message code="label.common.close"/>',
				        closeOnConfirm: false
			      	}, function(){ 
			      		movePage("/front/mypage/cart/list.ajax"); 
			      		});
				} 
			},
			});
	    });
	}
	
	</script>
</head>
<body>
	<div id="contentWrap" class="contentWrap">
		<div id="content" class="content wrap productDetail">
			<form id="prodForm" name="prodForm" method="post">
				<input type="hidden" id="prod_id" name="prod_id" value="${productInfo.prod_id}"> 
				<input type="hidden" id="store_id" name="store_id" value="${productInfo.store_id}"> 
			<h3>
				<span class="title"><spring:message code="label.product.prod.detail.info"/></span>
			</h3>

			<div class="prd_info">
				<div class="imgBox">
					<div class="bImg">
						<span class="img">
							<img id="bigPicture" src="/common/file/downloadImage/${fileList[0].file_id}" />
						</span>
					</div>
					<div class="sImg">
						<c:forEach items="${fileList}" var="fInfo" varStatus="status">
							<a href="#"><span class="img"><img src="/common/file/downloadImage/${fInfo.file_id}" /></span></a>
						</c:forEach>
					</div>
				</div>

				<div class="contBox">
					<span class="tit">${productInfo.prod_name}</span>

					<span class="sCont category">
						<label class="title"><spring:message code="label.front.product.detail.category.title"/></label>
						<span class="cont">
							<c:forEach items="${categoryInfo}" var="info" varStatus="status">
								${info.path}<br />
							</c:forEach>
						</span>
					</span>
					<%-- <span class="sCont delivery">
						<label class="title"><spring:message code="label.front.product.detail.delivery.title"/></label>
						<span class="cont">무료</span>
					</span> --%>
					<span class="sCont saller">
						<label class="title"><spring:message code="label.front.product.detail.seller.title"/></label>
						<span class="cont">${productInfo.create_user_name}</span>
					</span>
					<span class="sCont saller">
						<label class="title"><spring:message code="label.cart.amount"/></label>
						<input type="number" id="order_cnt"class="inp spinner right ui-spinner-input"   autocomplete="off" role="spinbutton" value="1" min="1" >
					</span>
					
					<span class="price">￦<fmt:formatNumber value="${productInfo.prod_price}" pattern="#,###" /></span>

					<div class="orderBox">
						<%-- <a href="javascript:goServicePreparing('<spring:message code="label.front.product.detail.service.ready"/>');" class="amb_btnstyle basket"><span><spring:message code="label.front.product.detail.basket.btn"/></span></a> --%>
						<a href="javascript:insertCart();" class="amb_btnstyle basket"><span><spring:message code="label.front.product.detail.basket.btn"/></span></a> 
						<%-- <a href="javascript:goServicePreparing('<spring:message code="label.front.product.detail.service.ready"/>');" class="amb_btnstyle quickOrder"><span><spring:message code="label.front.product.detail.order.btn"/></span></a> --%>
						<a href="javascript:pay();" class="amb_btnstyle quickOrder"><span><spring:message code="label.front.product.detail.order.btn"/></span></a>
						<a href="javascript:goListPage();" class="amb_btnstyle listGo"><span><spring:message code="label.common.list"/></span></a>
					</div>
				</div>
			</div>

			<div class="prd_detail">
				<div class="tab">
					<ul>
						<li><a href="javascript:;" id="detail" class="temp"><spring:message code="label.product.prod.detail.info"/></a></li>
						<li><a href="javascript:;" id="delivery" class="temp"><spring:message code="label.product.prod.delivery.info"/></a></li>
						<li><a href="javascript:;" id="saller" class="temp"><spring:message code="label.product.prod.refund.info"/></a></li>
					</ul>
				</div>

				<div class="contBox tab-area detail">
					<h4>
						<span class="title"><spring:message code="label.product.prod.detail.info"/></span>
					</h4>

					<div class="contArea">
						${productInfo.prod_detail}
					</div>
				</div>

				<div class="contBox tab-area delivery">
					<h4>
						<span class="title"><spring:message code="label.product.prod.delivery.info"/></span>
					</h4>

					<div class="contArea">
						${productInfo.prod_delivery_info}
					</div>
				</div>

				<div class="contBox tab-area saller">
					<h4>
						<span class="title"><spring:message code="label.product.prod.refund.info"/></span>
					</h4>
					<div class="contArea">
						${productInfo.prod_refund_info}
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>
</body>