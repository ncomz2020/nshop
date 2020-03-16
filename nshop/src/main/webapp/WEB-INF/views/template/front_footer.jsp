<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div id="footer" class="footer">
	<div class="wrap">
			<h1><a href="javascript:movePage('/front/product/list');"><span class="">AMB nShop</span></a></h1>

			<div class="address">
				<spring:message code="label.footer.txt1"/><br/>
				<spring:message code="label.footer.txt2"/>
			</div>
			<div class="copyright">
				<spring:message code="label.footer.txt3"/>
			</div>
		</div>
	</div>

	<!-- 페이지 마다 존재하는 하단 floating 버튼 --> 
	<div class="bottomFloatBtn fr">
		<a href="#" class="bfBtn top" id="bfBtnGoTop"><span class="text">TOP</span></a><!-- amb_ui_common_m.js에 의해 특정 scroll이상일때만 보임 -->
	</div>
