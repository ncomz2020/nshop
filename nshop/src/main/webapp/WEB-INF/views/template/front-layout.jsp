<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<!--[if IE 7]><html class="ie7" lang="ko"><![endif]-->
<!--[if IE 8]><html class="ie8" lang="ko"><![endif]-->
<!--[if IE 9]><html class="ie9" lang="ko"><![endif]-->
<!--[if gt IE 9]><!-->
<html lang="ko">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta id="viewport" name="viewport">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="description" content="">
<meta name="keywords" content="">

<script type="text/javascript" src="/js/jquery/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/js/front/amb_ui_common.js"></script>

<script type="text/javascript" src="/js/jquery/jquery-ui.js"></script>
<!-- jquery modal drag drop등 jquery 특화 ui용 -->



<link rel="stylesheet" href="/css/amb_front_import.css"><!-- 해당 사이트의 레이아웃 템플릿 결정 -->


<!-- //공통 부분 -->


<!-- /////////// 사이트 특화부분 -->
<title>Ameoba UI shop Templete</title><!-- 해당 사이트의 타이틀 부분 -->

<link rel="stylesheet" href="/css/shop_layout_temp_01.css"><!-- 해당 사이트의 레이아웃 템플릿 결정 -->

<script type="text/javascript" src="/js/bootstrap.js"></script>                              <!-- bootstrap.js --> 
<script type="text/javascript" src="/js/datapicker/bootstrap-datepicker.js"></script>        <!--datepicker 사용시 필수 // core  -->
<script type="text/javascript" src="/js/datapicker/bootstrap-datepicker.ko.js"></script>     <!--datepicker 사용시 필수 // 한국어 -->


<script type="text/javascript" src="/js/commonUtil.js"></script>

<script type="text/javascript" src="/js/sweetalert/sweetalert.min.js"></script>
<!-- alert confirm 관련 사용 -->
<script type="text/javascript" src="/js/amb_validator.js"></script>



	
</script>
</head>
<body class="desktop">
	<form name="frmMenuHandle">
<%-- 		<input type="hidden" id="choiceMenuno" value="${selectedMenu.selectMenuNo}" /> --%>
	</form>
	
	<div class="amb_layout_common shop_layout_temp_01 main">		
		<!--  default layout 구조 -->
		<tiles:insertAttribute name="header" />
		<tiles:insertAttribute name="nav" />
		<div id="contentWrap" class="contentWrap wrap">			
			<div id="content" class="content">
				<tiles:insertAttribute name="body" />
			</div>
		</div>
		<tiles:insertAttribute name="footer" />
	</div>
</body>
</html>