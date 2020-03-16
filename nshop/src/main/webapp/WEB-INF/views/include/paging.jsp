<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
function refreshList() {
	searchList(getCurrentPage());
}

function getCurrentPage() {
	return $("ul.paginglist li.active").text().trim();
}
</script>
<!--페이지-->
<c:set var="maxPage" value="${count / pagingObject.perPage}"/>
<c:set var="maxPage" value="${maxPage+(1-(maxPage%1))%1}"/>
<c:set var="startPage" value="${pagingObject.page}"/>
<c:forEach begin="0" end="2" var="idx" varStatus="status">
	<c:if test="${startPage - 1 > 0}">
		<c:set var="startPage" value="${startPage - 1}"/>
	</c:if>
</c:forEach>
<c:set var="endPage" value="${pagingObject.page}"/>
<c:forEach begin="0" end="2" var="idx" varStatus="status">
	<c:if test="${endPage + 1 <= maxPage}">
		<c:set var="endPage" value="${endPage + 1}"/>
	</c:if>
</c:forEach>
<c:choose>
	<c:when test="${pagingObject.page > 1}">
		<li class="first"><a href="javascript:searchList(1);"><i class="ambicon-006_arrow_first"></i></a></li>
		<li class="prev"><a href="javascript:searchList(${pagingObject.page - 1});"><i class="ambicon-002_arrow_left"></i></a></li>
	</c:when>
	<c:otherwise>
		<li class="first"><a href="javascript:;"><i class="ambicon-006_arrow_first"></i></a></li>
		<li class="prev"><a href="javascript:;"><i class="ambicon-002_arrow_left"></i></a></li>
	</c:otherwise>
</c:choose>
<c:forEach begin="${startPage}" end="${endPage}" var="idx" varStatus="status">
	<c:choose>
		<c:when test="${idx == pagingObject.page}">
			<li class="active"><a href="javascript:;"> ${idx} </a></li>
		</c:when>
		<c:otherwise>
			<li><a href="javascript:searchList(${idx});"> ${idx} </a></li>
		</c:otherwise>
</c:choose>
</c:forEach>
<c:choose>
	<c:when test="${pagingObject.page < maxPage}">
		<li class="next"><a href="javascript:searchList(${pagingObject.page + 1});"><i class="ambicon-001_arrow_right"></i></a></li>
		<li class="last"><a href="javascript:searchList(${maxPage});"><i class="ambicon-005_arrow_last"></i></a></li>
	</c:when>
	<c:otherwise>
		<li class="next"><a href="javascript:;"><i class="ambicon-001_arrow_right"></i></a></li>
		<li class="last"><a href="javascript:;"><i class="ambicon-005_arrow_last"></i></a></li>
	</c:otherwise>
</c:choose>