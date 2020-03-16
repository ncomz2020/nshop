<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<script>

//모바일시 리스트 스타일 갤러리형으로 셋팅
$(document).ready(function(){ 
	if($('body').hasClass('phone')){
		$('#listStySelect').find('.amb_btnstyle').removeClass('active');
		$('#listStySelect').find('.listSty_gallery').addClass('active');

		$('#listSty').removeClass();
		$('#listSty').addClass('listSty listSty_gallery');
	}
	
	$('.listSty_photo01').css("background", "#5cbb61");
	$('.listSty_photo01').css("color", "#ffffff");
	searchList(1);
});	


// 리스트 모양결정 스크립트
$(document).on("click", "#listStySelect.listStyle > a[class*=' listSty_']", function(){ 
	var sty = $(this).attr("data-sty"),
	    target = $("#listSty");

	$(this).siblings('a').removeClass('active');
	$(this).addClass('active');
	
	$('#listStySelect').find('.amb_btnstyle').css("background", "#ffffff");
	$('#listStySelect').find('.amb_btnstyle').css("color", "#333333");
	
	target.removeClass();
	target.addClass("listSty " + sty + "");
	
	$(this).css("background", "#5cbb61");
	$(this).css("color", "#ffffff");
});

function searchList(page) {
	//$("#page").val(page);
	var param = new Object();
	param.page = page;
	param.language = "<spring:message code="label.common.language"/>";
	
	var cate1 = "${productInfo.category_1}";
	var cate2 = "${productInfo.category_2}";
	
	
	
	if(cate1 != null && cate1 != ""){
		param.category_1= cate1;
		param.category_id = cate1;
		
	}
	if(cate2 != null && cate2 != ""){
		param.category_2= cate2;
		param.category_id = cate2;
	}
	
	
	
	$.ajax({
	url : "/front/product/listAction.ajax",
	type : "POST",
	data : param,
	success : function(data) {
		$("#listActionDiv").html(data);
	},
	error : function() {
		swal({
	    	title: '<spring:message code="label.common.fail.action"/>',
	        type: "error"
	    });
	}
	});
	
	
}

function fnDetailView(prod_id){
	var param = new Object();
	param.prod_id = prod_id;
	movePage("detail", param);
}

function fnSetTitle(titleStr){
	$("#subtitle").text(titleStr);
}


</script>
<!-- contentWrap -->
	<div id="contentWrap" class="contentWrap">
		<div id="content" class="content wrap">
			<h3>
				<span class="title" id="subtitle"></span>
				<div id="listStySelect" class="fr btnArea listStyle">
					<a href="#" class="amb_btnstyle white middle listSty_list" data-sty="listSty_list"><span class=""><spring:message code="label.product.prod.type.list"/></span></a>
					<a href="#" class="amb_btnstyle white middle listSty_photo01 active" data-sty="listSty_photo01"><span class=""><spring:message code="label.product.prod.type.photo01"/></span></a>
					<a href="#" class="amb_btnstyle white middle listSty_photo02" data-sty="listSty_photo02"><span class=""><spring:message code="label.product.prod.type.photo02"/></span></a>
					<a href="#" class="amb_btnstyle white middle listSty_gallery" data-sty="listSty_gallery"><span class=""><spring:message code="label.product.prod.type.galary"/></span></a>
				</div>
			</h3>
			
			<div class="listBox">
				<div id="listActionDiv">
				</div>
			</div>
		</div>
	</div>
	<!-- //contentWrap -->