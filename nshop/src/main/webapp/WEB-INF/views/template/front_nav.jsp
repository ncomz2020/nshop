<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="com.ncomz.nshop.utillty.SessionUtil" %>
<%@ page import="com.ncomz.nshop.domain.common.SessionUser" %>
<%@ page import="com.ncomz.nshop.domain.common.CommonCode" %>
<%@ page import="java.util.List" %>
<%
List<CommonCode> categoryListTop = (List<CommonCode>)request.getAttribute("categoryListTop");
List<CommonCode> categoryListSub = (List<CommonCode>)request.getAttribute("categoryListSub");

String subMenu = "";
String panId = "1";
	if(categoryListSub != null){
		subMenu += "<ul class='depth_2' data-num='s01'>";		
		for(int i=0; i< categoryListSub.size();i++){
			
			if(panId.equals(categoryListSub.get(i).getParent_id())){
				subMenu += "<li>";
				subMenu += "<a href=javascript:goCategory(\'"+categoryListSub.get(i).getCategory_id()+"\') id='"+categoryListSub.get(i).getCategory_id()+"'><span>"+categoryListSub.get(i).getTitle()+"</span></a>";			
				subMenu += "</li>";
			}else{
				panId = categoryListSub.get(i).getParent_id();
				subMenu +="</ul>";				
				subMenu += "<ul class='depth_2' data-num='s0"+categoryListSub.get(i).getParent_id()+"' >";
				subMenu += "<li>";
				subMenu += "<a href=javascript:goCategory(\'"+categoryListSub.get(i).getCategory_id()+"\') id='"+categoryListSub.get(i).getCategory_id()+"'><span>"+categoryListSub.get(i).getTitle()+"</span></a>";			
				subMenu += "</li>";
			}
			
			
		}
		subMenu +="</ul>";	
	}

%>
<script type="text/javascript">
/*<![CDATA[*/
 $(document).ready(function() {          
	 var subMenu = "<%=subMenu%>" ; 
	 $("#snb").html(subMenu);
	 
	 console.log("${sessionUser.usr_nm}")
	//쿠키에 저장된 아이디 가져오기
	 	var usercookieId = getCookie("usercookieId");
		$("input[name='textId']").val(usercookieId);
		
		if($("#textId").val() != ""){
			$("#checkBox_01").prop('checked', true);

		}else{
			$("#checkBox_01").prop('checked', false);
		} 
 });
 
	function goSignin_front() {
		movePage('/login/front/goSignInfront');
	}
	function searchIdPw() {
		movePage('/login/front/searchId');
	}
	
	
/*]]>*/	
</script>

<script type="text/javascript">

			function login(bForce) {
				if (bForce == null) {
					bForce = false;
				}

				
				
				<!-- ////////// ID 저장 , 쿠키에 저장된 ID 값 불러온다 ///////// -->
				if (checkBox_01.checked == true) {
					var usercookieId = $("#textId").val();
					setCookie("usercookieId",usercookieId ,7);
					
				}else{
					deleteCookie("usercookieId");
				}
				
				if ($("#textId").val() == "") {
					swal({
				        title: '<spring:message code="msg.login.valid.chk.id" />'
				    });
					$("#textId").focus();
					return;
				}

				if ($("#textNm").val() == "") {
					swal({
				        title: '<spring:message code="msg.login.valid.chk.pw" />'
				    });
					$("#textNm").focus();
					return;
				}

				var param = new Object();
				param.textId = replaceall($("#textId").val());
				param.textNm = replaceall($("#textNm").val());
				param.force = bForce;

				$.ajax({
				url : '/login/front/loginAction',
				type : 'POST',
				data : param,
				success : function(data) {
					if (data == "GO_MAIN") {
						location.reload();
					} else if (data == "GO_STORE_JOIN") {
						location.reload();
					} else if (data == "GO_CHANGE_PASSWORD") {
						swal({
					        title: 'go_change_password'
					    });
					} else if (data == "ERROR_INPUT_NULL") {
						swal({
					        title: '<spring:message code="msg.login.error.input.null" />'
					    });
						deleteCookie("usercookieId");
					} else if (data == "LOGIN_FAIL") {
						swal({
					        title: '<spring:message code="msg.login.fail.login" />'
					    });
						deleteCookie("usercookieId");
					} else if (data == "FAIL_PASS_IP_BANDWIDTH") {
						swal({
					        title: '<spring:message code="msg.login.fail.pass.ipbandwidth" />'
					    });
					} else if (data == "OVER_LOGIN_FAIL_COUNT") {
						swal({
					        title: '<spring:message code="msg.login.over.fail.login.count" />'
					    });
						deleteCookie("usercookieId");
					} else if (data == "LOCK_ACCOUNT") {
						swal({
					        title: '<spring:message code="msg.login.lock.account" />'
					    });
					} else if (data == "ALREADY_LOGGED_IN") {
						location.reload();
					} else if (data == "ID_DOES_NOT_EXIST") {
						swal({
					        title: '<spring:message code="msg.login.does.not.id" />'
					    });
						deleteCookie("usercookieId");
					}
				},
				error : function(e) {
					console.log(e.responseText.trim());
					viewLayer(e.responseText.trim());
				},
				complete : function() {
				}
				});

			}
  
			function setCookie(cookieName, value, exdays){
				var exdate = new Date();
				exdate.setDate(exdate.getDate() + exdays);
				var cookieValue = escape(value) + ((exdays==null)? "": "; expires="+ exdate.toGMTString());
				document.cookie = cookieName + "=" + cookieValue;
				//체크 박스 유지
				
			}
			//쿠키 삭제
			function deleteCookie(cookieName){
				var expireDate = new Date();
				expireDate.setDate(expireDate.getDate() - 1);
				document.cookie = cookieName + "= "+ "; expires="+ expireDate.toGMTString();
			}
			//쿠키 가져오기
			function getCookie(cookieName){
				console.log(cookieName);				
				cookieName = cookieName + '=';
				var cookieData = document.cookie;
				var start = cookieData.indexOf(cookieName);
				var cookieValue = '';
				  if(start != -1){
					start += cookieName.length;
					var end = cookieData.indexOf(';',start);
					if(end == -1) end = cookieData.length;
					cookieValue = cookieData.substring(start,end);
				} 
				return unescape(cookieValue);
			}
			// 로그아웃
			function logout() {
				swal({
			        title: '<spring:message code="label.common.logout"/>',
			        type: "warning",
			        showCancelButton: true,
			        confirmButtonText: "YES",
			        cancelButtonText: "NO",
			        closeOnConfirm: false
			         },function(){
						document.frmMenuHandle.action="<%=request.getContextPath()%>/login/logoutActionfront";
						document.frmMenuHandle.method="post";
						document.frmMenuHandle.submit();
			         });
			}
</script>
			
	<div id="nav" class="nav">

		<div class="wrap">
			
			<!-- 1depth Area -->
			<div id="gnb" class="gnb">
				<ul class="depth_1">
					<c:forEach items="${categoryListTop}" var="categoryList" varStatus="status">					
					<li>
						<a href="javascript:goCategory('${categoryList.category_id}')" data-num="s0${categoryList.category_id}" id="${categoryList.category_id}" ><span>${categoryList.title}</span></a>
					</li>
					</c:forEach>
					
				</ul>
				<button class="arrow left"></button>
				<button class="arrow right"></button>
			</div>
			<!-- //1depth Area -->

			<!-- 2depth 이하 Area -->
			<div id="snb" class="snb">
											
			</div>
			<!-- //2depth 이하 Area -->
		</div>
	</div>
	<div id="aside" class="aside">
		<div class="asideBg"></div>

		<div class="asideBox">
		
	<!-- 로그인 시 세션 확인 -->
	<c:choose>
		
		<c:when test="${session_user.usr_nm eq null }" >
			<div class="as_header">
				<span class="loginArea">
					<input type="id" class="inp id" id="textId" name="textId" placeholder="<spring:message code="label.member.join.id"/>"  onkeydown="javascript:if(event.keyCode==13){login();}"/>
					<input type="password" class="inp pw" id="textNm" name="textNm" placeholder="<spring:message code="label.member.join.pw"/>" onkeydown="javascript:if(event.keyCode==13){login();}"/>
					
					<input type="checkbox" id="checkBox_01" unchecked /> 
					<label for="checkBox_01" class="inp_func"><spring:message code="msg.login.stay.id" /></label> 
					
					<a href="javascript:login();" class="amb_btnstyle middle login"><span><spring:message code="label.btn.login.title"/></span></a>
					<a href="javascript:searchIdPw();" class="underline"><span><spring:message code="msg.login.search.idpw" /></span></a>
				</span>
			</div>
		</c:when>
		<c:otherwise>
			<div class="as_header">
				<span class="loginArea">
					${session_user.usr_nm}<spring:message code="label.common.welcome.login"/>
					<a href="javascript:logout();" class="amb_btnstyle middle login"><span><spring:message code="label.btn.logout.title"/></span></a>
				</span>
			</div>	
		</c:otherwise>
	</c:choose>
	<!-- /로그인 부분 끝 -->
			<div class="as_cont">
			
	<!-- 로그인 상태시 회원가입 표시, 로그아웃 상태시 회원가입 사라짐 -->
		<c:choose>
			<c:when test="${session_user.usr_nm eq null }" >
				<span class="sList join">
					<a href="javascript:goSignin_front();" class="amb_btnstyle middle"><span><spring:message code="label.btn.register.title"/></span></a>
				</span>
			</c:when>
			<c:when test="${session_user.usr_nm ne null }" >
				<span class="sList maypage">
					<a href="javascript:movePage('/front/mypage/order/list');" class="amb_btnstyle middle"><span><spring:message code="label.btn.list.title"/></span></a>
				</span>
				<span class="sList basket">
					<a href="javascript:movePage('/front/mypage/cart/list');" class="amb_btnstyle middle"><span><spring:message code="label.btn.cart.title"/></span></a>
				</span>
				<span class="sList maypage">
					<a href="javascript:movePage('/front/mypage/myaccount/account');" class="amb_btnstyle middle"><span><spring:message code="label.btn.mypage.title"/></span></a>
				</span>
				<span class="sList join">
					<a href="javascript:movePage('/front/mypage/myaccount/modPwd');" class="amb_btnstyle middle"><span><spring:message code="label.mypage.modify.password"/></span></a>
				</span>
			</c:when>
		</c:choose>
	<!-- //로그인 상태시 회원가입 표시, 로그아웃 상태시 회원가입 사라짐 끝 -->
				
			</div>
		</div>

		<button type="button" class="subMenuIcon"><span class="hiddenText">메뉴<span></button>		
	</div>