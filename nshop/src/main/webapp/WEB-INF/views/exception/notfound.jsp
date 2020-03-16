<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="com.ncomz.nshop.utillty.SessionUtil" %>
<%@ page import="com.ncomz.nshop.domain.common.SessionUser" %>
<!DOCTYPE html>

<!--[if IE 7]><html class="ie7" lang="ko"><![endif]-->
<!--[if IE 8]><html class="ie8" lang="ko"><![endif]-->
<!--[if IE 9]><html class="ie9" lang="ko"><![endif]-->
<head>
<meta charset="utf-8">
<!--  head 공통 부분으로 meta 및 css, js 등 사이트 공통 요소를 불러옵니다  -->
<meta id="viewport" name="viewport">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="description" content="">
<meta name="keywords" content="">

<link rel="stylesheet" href="/css/amb_admin_import.css"><!-- 해당 사이트의 레이아웃 템플릿 결정 -->



<script type="text/javascript" src="/js/jquery/jquery-3.1.1.min.js"></script>                       <!-- jquery core  --> 
<script type="text/javascript" src="/js/jquery/jquery-ui.js"></script>                              <!-- jquery modal drag drop등 jquery 특화 ui용 --> 
<script type="text/javascript" src="/js/amb_ui_common.js"></script>

<script type="text/javascript" src="/js/bootstrap.js"></script>                              <!-- bootstrap.js --> 
<script type="text/javascript" src="/js/datapicker/bootstrap-datepicker.js"></script>        <!--datepicker 사용시 필수 // core  -->
<script type="text/javascript" src="/js/datapicker/bootstrap-datepicker.ko.js"></script>     <!--datepicker 사용시 필수 // 한국어 -->

<script type="text/javascript" src="/js/tablesorter/jquery.tablesorter.js"></script>         <!-- 테이블 Sorter 사용 -->
<script type="text/javascript" src="/js/tablesorter/jquery.tablesorter.widgets.js"></script> <!-- 테이블 Sorter theadFixed 사용 -->
<script type="text/javascript" src="/js/sweetalert/sweetalert.min.js"></script>              <!-- curstom sweetalert// alert confirm 관련 사용 -->


<script type="text/javascript" src="/js/commonUtil.js"></script>
<!-- 테이블 Sorter theadFixed 사용 -->
<script type="text/javascript" src="/js/amb_validator.js"></script>

<!-- 테이블 Sorter theadFixed 사용 -->
<script type="text/javascript" src="/js/paging.js"></script>


<script type="text/javascript" src="/js/jquery/jquery.number.min.js"></script>

<!--  페이지 특화 css / js 는 이부분에 추가 -->
</head>
<body class="fullPage"><!-- fullPage Error창을 표시할려면 반드시 body에 fullPage 클래스명 추가 // 필수 -->

<!--  default layout 구조 -->
<div class="amb_layout_common amb_admin_layout_temp_01"><!-- class명 amb_layout_common :필수  / amb_admin_layout_temp_01:필수(사이트 레이아웃 결정) -->

	<div class="errorPage">
		<h1>
			<img src="/img/error.png" />
			<div class="tit">
				죄송합니다<br/>
				선택한 페이지를 찾을 수 없습니다.
			</div>
		</h1>
		<div class="detail">
			요청 하신 페이지가 존재하지 않습니다.<br/>
			잠시후 다시 접속해 주시기 바랍니다.

			<!-- 버튼이 필요한 경우는 이렇게 추가 -->
			<div class="mgT30">
				<a href="javascript:history.back()" class="amb_btnstyle gray middle">이전페이지</a>
			</div>
			<!-- // 버튼이 필요한 경우는 이렇게 추가 -->
		</div>
			
		<div class="copy">
			Copyright @2016 Ncomz All Rights Reserved
		</div>
	</div>

	<script type="text/javascript">
		// 브라우저 센터 정렬을 위해
		$(document).ready( function(){
			var _this = $('.errorPage');
			var thisWidth = _this.outerWidth();
			var thisHeight = _this.outerHeight();
			var marginLeftValue = thisWidth/2;
			var marginTopValue = thisHeight/2;

			//fullPageError
			if ($('body').hasClass('fullPage'))
			{
				_this.parent('.amb_admin_layout_temp_01').css('height','100%');
				_this.css({'margin-left': - marginLeftValue + 'px' , 'margin-top': - marginTopValue + 'px'});
			} 
			
			//insidePageError
			else 			
			{				
				//자신의 상위에 #content 가 있을시
				if (_this.parents('#content').hasClass('content'))
				{
					_this.parents('#content').addClass('insidePageError');
					_this.parent('.amb_admin_layout_temp_01').removeClass('amb_layout_common amb_admin_layout_temp_01');
				} 
				
				//자신의 상위에 #content 가 없을시
				else 
				{
					_this.parent('.amb_admin_layout_temp_01').addClass('content insidePageError').attr('id', 'content');
					_this.parent('.amb_admin_layout_temp_01').removeClass('amb_layout_common amb_admin_layout_temp_01');
				}			    
			}			
		});		
	</script>

</div>

</body>
</html>
