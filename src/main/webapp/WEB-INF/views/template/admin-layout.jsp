<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@page import="com.ncomz.nshop.utillty.SessionUtil"%>
<%@page import="com.ncomz.nshop.utillty.StringUtil"%>
<%
	String lang = (String)request.getAttribute("language");
	if(StringUtil.isEmpty(lang)){
		lang = "ko";
	}
%>
<!DOCTYPE html>
<!--[if IE 7]><html class="ie7" lang="ko"><![endif]-->
<!--[if IE 8]><html class="ie8" lang="ko"><![endif]-->
<!--[if IE 9]><html class="ie9" lang="ko"><![endif]-->
<!--[if gt IE 9]><!-->
<html lang="ko">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<!--  head 공통 부분으로 meta 및 css, js 등 사이트 공통 요소를 불러옵니다  -->
<meta id="viewport" name="viewport">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="description" content="">
<meta name="keywords" content="">
<script type="text/javascript" src="/js/jquery/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/js/amb_ui_common.js"></script>
<!-- meta viewport 분기 처리를 위한 js 관련 -->
<script type="text/javascript" src="/js/jquery/jquery-ui.js"></script>
<!-- jquery modal drag drop등 jquery 특화 ui용 -->


<link rel="stylesheet" href="/css/amb_admin_import.css"><!-- 해당 사이트의 레이아웃 템플릿 결정 -->

<!-- //공통 부분 -->
<!-- /////////// 사이트 특화부분 -->
<title>nshop</title>
<!-- 해당 사이트의 타이틀 부분 -->
<!-- <link rel="stylesheet" href="/css/nshop_iconfont.css"> -->
<!-- amb 아이콘 폰트 정의 -->

<script type="text/javascript" src="/js/bootstrap.js"></script>                              <!-- bootstrap.js --> 
<script type="text/javascript" src="/js/datapicker/bootstrap-datepicker.js"></script>        <!--datepicker 사용시 필수 // core  -->
<script type="text/javascript" src="/js/datapicker/bootstrap-datepicker.<%=lang %>.js"></script>     <!--datepicker 사용시 필수 // 한국어 -->

<script type="text/javascript" src="/js/tablesorter/jquery.tablesorter.js"></script>
<!-- 테이블 Sorter 사용 -->
<script type="text/javascript" src="/js/tablesorter/jquery.tablesorter.widgets.js"></script>
<!-- 테이블 Sorter theadFixed 사용 -->
<script type="text/javascript" src="/js/sweetalert/sweetalert.min.js"></script>
<!-- alert confirm 관련 사용 -->
<script type="text/javascript" src="/js/commonUtil.js"></script>
<!-- 테이블 Sorter theadFixed 사용 -->
<script type="text/javascript" src="/js/amb_validator.js"></script>

<!-- 테이블 Sorter theadFixed 사용 -->
<script type="text/javascript" src="/js/paging.js"></script>


<script type="text/javascript" src="/js/jquery/jquery.number.min.js"></script>



<script type="text/javascript">
	// 엑셀 다운로드 추가
	jQuery.download = function(url, data, method){
	    // url과 data를 입력받음
	    if( url && data ){ 
	        // data 는  string 또는 array/object 를 파라미터로 받는다.
	        data = typeof data == 'string' ? data : jQuery.param(data);
	        // 파라미터를 form의  input으로 만든다.
	        var inputs = '';
	        jQuery.each(data.split('&'), function(){ 
	            var pair = this.split('=');
	            inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
	        });
	        // request를 보낸다.
	        jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>').appendTo('body').submit().remove();
	    };
	};


	
	

	
</script>
</head>
<body class="">
	<form name="frmMenuHandle">
<%-- 		<input type="hidden" id="choiceMenuno" value="${selectedMenu.selectMenuNo}" /> --%>
	</form>
	
	<div class="amb_layout_common amb_admin_layout_temp_01">
		<!--  default layout 구조 -->
		<tiles:insertAttribute name="header" />
		<div id="contentWrap" class="contentWrap wrap">
			<tiles:insertAttribute name="snb" />
			<div id="content" class="content">
				<tiles:insertAttribute name="body" />
			</div>
		</div>
		<tiles:insertAttribute name="footer" />
	</div>
</body>
</html>