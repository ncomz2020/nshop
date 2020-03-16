<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
	$(document).ready(function() {
		
		var title = "${category_path}";
		if(title == null || title == ""){
			var title = '<spring:message code="label.product.prod.list"/>';
		}
		
		fnSetTitle(title);
	});

</script>
<!-- rowBox 반복단위 -->
<div class="prd_info" style="margin-top:0px; padding-top:0px;"></div>
<div class="rowBox mgT30">	
	<div class="g_column w_1_1">
		<ul id="listSty" class="listSty listSty_photo01">
			<c:if test="${empty list }">
				<li style="font-weight:bold;font-size:15px;text-align:right;"><spring:message code="label.common.empty.product.list"/></li>
			</c:if>
		
			<c:forEach items="${list}" var="prod" varStatus="status">
				<li>
					<a href="javascript:movePage('detail', {prod_id: '${prod.prod_id}',store_id: '${prod.store_id}',pageType:'productList'});">
						<c:if test="${not empty prod.imageFileList }">
							<span class="imgBox" >
								<span class="img">
										<img src="/common/file/downloadImage/${prod.imageFileList[0].file_id}" />
								</span>
							</span>
						</c:if>
						<c:if test="${empty prod.imageFileList }">
							<span class="imgBox">
								<span class="img"><img src="/img/img_sample.jpg" /></span>
							</span>
						</c:if>
						<span class="contBox">
							<span class="tit">${prod.prod_name}</span>
							<span class="sCont category">${prod.category_info }</span>
							<!-- <span class="sCont delivery">배송방법</span> -->
							<span class="sCont saller"><spring:message code="label.front.product.detail.seller.title"/> : ${prod.create_user_id}</span>
							<span class="price">￦<fmt:formatNumber value="${prod.prod_price}" pattern="#,###" /></span>
						</span>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>
<!-- rowBox 반복단위 -->