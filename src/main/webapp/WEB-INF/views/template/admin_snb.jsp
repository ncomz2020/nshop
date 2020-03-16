<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$(document).ready(function() {
	
	var subMenu = $("#menu_${activeMenuId}").addClass("active");
	var gnb = $(subMenu).parentsUntil(".subDepth").parent("li");
	$(gnb).addClass("active open");
	
	// title, path
	var activeGnbLi = $("#nav_aside li.active");
	var activeSnbLi = $(".subDepth").filter(".open").find('span');
	var sHtml = "";
	sHtml += "<h2>";
	sHtml += "<span class=\"title\">"+subMenu.find(">a>span").text()+"</span>";
	sHtml += "<div class=\"location\">";
	sHtml += "<a href=\"javascript:;\">Home</a>";
	sHtml += ">";
	sHtml += "<a href=\"javascript:;\">"+gnb.find(">a>span").text()+"</a>";
	sHtml += ">";
	sHtml += "<a href=\"javascript:;\">"+subMenu.find(">a>span").text()+"</a>";
	sHtml += "</div>";
	sHtml += "</h2>";
	$("#content").prepend(sHtml);
});
</script>
<div id="nav_aside" class="nav_aside open">
	<ul class="depth_1 mgT30">
		<c:forEach items="${userGroupMenuList}" var="menu" varStatus="status">
			<li>
				<a href="#" data-num="s_${status.index}">
					<i class="<c:out value="${menu.icon}"/>"></i>
					<span><c:out value="${menu.title}"/></span>
				</a>
			<ul class="depth_2">
				<c:forEach items="${menu.children}" var="subMenu" varStatus="subStatus">
					<li id="menu_${subMenu.menu_id}">
						<a href="javascript:movePage('<c:out value="${subMenu.url}"/>');">
							<i class="<c:out value="${subMenu.icon}"/>"></i>
							<span><c:out value="${subMenu.title}"/></span>
						</a>
					</li>
				</c:forEach>
			</ul>
			</li>
			</c:forEach>		
	</ul>
	<span class="asideSlider">
		<i></i>
	</span>
</div>

