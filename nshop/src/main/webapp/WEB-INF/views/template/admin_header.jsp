<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="com.ncomz.nshop.utillty.SessionUtil" %>
<%@ page import="com.ncomz.nshop.domain.common.SessionUser" %>
<script type="text/javascript">
	function logout() {
		document.frmMenuHandle.action="<%=request.getContextPath()%>/login/admin/logoutAction";
		document.frmMenuHandle.method="post";
		document.frmMenuHandle.submit();
	}
</script>

<div id="header" class="header">
	<div class="wrap">
		<button type="button" class="subMenuIcon close"></button>
		<h1>
			<a href="javascript:movePage('/admin/product/list');">
				<span>nshop</span>
			</a>
		</h1>

		<div class="loginInfo">
			<div class="setting">
				<span class="photo">
					<img src="/img/member_icon_02.png">
				</span>
				<a href="javascript:;">
					<i class="ambicon-033_human"></i>
					<span>${session_user.usr_id }</span>
				</a>
			</div>
			<div class="logout">
				<a href="javascript:logout();">
					<i class="ambicon-074_get_out"></i>
					<span><spring:message code="label.btn.logout.title"/></span>
				</a>
			</div>
		</div>
	</div>
</div>