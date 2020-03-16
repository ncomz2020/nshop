<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="com.ncomz.nshop.utillty.SessionUtil" %>
<%@ page import="com.ncomz.nshop.domain.common.SessionUser" %>
<script type="text/javascript">

	$(function(){
		$("#selectLang").change(function(){
			var selected = $("#selectLang option:selected");
			changeLocale(selected.data("language"), selected.data("country"));
		});
		
		var language = "<spring:message code="label.common.language"/>";
		if (language != "") {
			$("#selectLang option[data-language="+language+"]").attr("selected", "selected");
		}
		
		$('.btn').click(function(){
			header_searchList(1);
		});
	});

	function header_searchList(page) {
		var param = new Object();
		param.page = page;
		param.language = "<spring:message code="label.common.language"/>";
		param.search_type = 'N';
		param.search_txt = $('#search_txt').val();
		$.ajax({
			url : "/front/product/listAction.ajax",
			type : "POST",
			data : param,
			success : function(data) {
				$("#listActionDiv").html(data);
			},
			error : function() {
				$.alertable.alert('<spring:message code="label.common.fail.action"/>');
			}
		});
	}
	
	function logout() {
		document.frmMenuHandle.action="<%=request.getContextPath()%>/login/logoutAction";
		document.frmMenuHandle.method="post";
		document.frmMenuHandle.submit();
	}
	
	/**
		카테고리별 리스트보기
	*/
	function goCategory(categoryId){
		var depth = $("*[id="+categoryId+"]").parent().parent().attr("class");
		var submenu = $(".depth_2[data-num=s0"+categoryId+"]").html();
		var existDepth = $("ul[data-num=s0"+categoryId+"]").last().html();
		
		console.log('categoryId='+categoryId);
		var param = new Object();
		
		if(depth == "depth_1")	param.category_1 =  categoryId;
		if(depth == "depth_2")	param.category_2 =  categoryId;
		
		if(existDepth == "" || existDepth == null){
			movePage('/front/product/list', param);	
		}
		
	}
	
	/**
		언어 변경
	*/
	function changeLocale(locale, country) {
		var param = new Object();
		param.language = locale;
		param.country = country;
		var cate1 = "${productInfo.category_1}";
		var cate2 = "${productInfo.category_2}";
		var product_id = "${productInfo.prod_id}";
		
		// 리스트 view일 경우
		if(cate1 !=null || cate1 !="")		param.category_1 = cate1;
		else if(cate2 !=null || cate2 !="")	param.category_2 = cate2;
		
		// detail view일 경우
		if(product_id != null || product_id !="")	param.prod_id = product_id;
			
			
		movePage("/front/product/list", param);
	}
	$(document).ready(function() {      
		$("#header .subMenuIcon").click(function(){
			asideAction();
		})	
	});
</script>
<div id="header" class="header">		
		<div class="wrap">
			<div class="topLink">
				<span class="lang">
					<select id="selectLang">
						<c:forEach items="${languageCodeList}" var="code" varStatus="status">
							<option data-language="<c:out value="${code.dtl_cd}" />" data-country="KR" > <c:out value="${code.dtl_nm }"/></option>
						</c:forEach>
					</select>
				</span>
			</div>

			<div class="topHeader">
				<h1><a href="javascript:movePage('/front/product/list');" class="logo" title="logo"><span class="">AMB nShop</span></a></h1>

				<div class="iconBtn">
					<button type="button" class="icobBtn searchIcon mobileOnly" title="검색"><span class="hiddenText">검색</span></button>
					<button type="button" class="icobBtn subMenuIcon" id="subMenuIcon" title="메뉴"><span class="hiddenText">메뉴</span></button>
				</div>
					
				<div class="totalSearchBox">
					<input type="text" id="search_txt" class="inp totalSearch" placeholder='<spring:message code="label.front.product.search"/>' />
					<a href="#" class="btn" title="search"><span class="hiddenText">search</span></a>
				</div>				
			</div>
		</div>	
	</div>
	


