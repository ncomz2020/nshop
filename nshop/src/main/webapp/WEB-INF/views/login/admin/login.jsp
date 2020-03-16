<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div id="loginHiddenDiv" class="amb_layout_common amb_admin_layout_temp_01" style="opacity:0;">
	<!-- class명 amb_layout_common :필수  / amb_admin_layout_temp_01:필수(사이트 레이아웃 결정) -->

	<div class="content loginStyle01">
		<!-- 로그인 스타일을 class명으로 지정함 // loginStyle01 // background 이미지 & 컨텐츠 센터형 -->

		<!-- ////////////// 롤링 페이드 인아웃 관련 /////////////// -->
		<!-- 롤링 페이드 인아웃 이미지 영역 -->
		<div class="loginBgBox">
			<div id="loginBg1" class="loginBg bg01" style="opacity: 1;"></div>
			<div id="loginBg2" class="loginBg bg02" style="opacity: 0;"></div>
			<div id="loginBg3" class="loginBg bg03" style="opacity: 0;"></div>
		</div>

		<style type="text/css">
		.bgShow {
			z-index: 1 !important
		}
		</style>

		<!-- 롤링 페이드 인아웃 이미지 스크립트 -->
		<script type="text/javascript">
			var intval = "";

			$(window).on('load', function () {
				start_Int();
				
				$(".selectLang a").click(function() {
					changeLocale($(this).data("language"), $(this).data("country"));
				});
				var language = '<spring:message code="label.common.language"/>';
				if (language != "") {
					$(".selectLang a[data-language="+language+"]").addClass("active");
				}
				
				$("#textId").keypress(function( event ) {
					if ( event.which == 13 ) {
						login();				
					}
				});
				$("#textNm").keypress(function( event ) {
					if ( event.which == 13 ) {
						login();				
					}
				});
			});

			function start_Int() {
				if (intval == "") {
					intval = window.setInterval("mainslider()", 5000);
				} else {
					stop_Int();
				}
			}

			function stop_Int() {
				if (intval != "") {
					window.clearInterval(intval);
					intval = "";
				}
			}
			
			var currentMainImage = 1;
			var mainImageCnt = 3; //롤링될 이미지 갯수

			function mainImg(a) {
				if (currentMainImage == a) {
					return;
				}

				$("#loginBg" + a).css({
					opacity : 0
				}).addClass("bgShow").animate({
					opacity : 1
				}, 1000);
				$("#loginBg" + currentMainImage).animate({
					opacity : 0
				}, 1000).removeClass("bgShow");
				currentMainImage = a;
				stop_Int();
				start_Int();
			}

			function mainslider() {
				if (currentMainImage + 1 > mainImageCnt) {
					mainImg(1);
				} else {
					mainImg(currentMainImage + 1);
				}
			}
		</script>
		<!-- ////////////// 롤링 페이드 인아웃 관련 /////////////// -->


		<!-- ////////////// background color gradient 변경효과 관련 /////////////// -->
		<div id="gradientBg" class="bgGradient"></div>

		
		<!-- ////////////// background color gradient 변경효과 관련 /////////////// -->

		<script type="text/javascript">
			function login(bForce) {
				if (bForce == null) {
					bForce = false;
				}

				var f = document.formLogin;
				
				<!-- ////////// ID 저장 , 쿠키에 저장된 ID 값 불러온다 ///////// -->
				if (f.checkBox_01.checked == true) {
					var usercookieId = $(f.textId).val();
					setCookie("usercookieId",usercookieId ,7);
					
				}else{
					deleteCookie("usercookieId");
				}
				
				if (f.textId.value == "") {
		    		swal({
		    	        title: '<spring:message code="msg.login.valid.chk.id" />'
		    	    });
					f.textId.focus();
					return;
				}

				if (f.textNm.value == "") {
		    		swal({
		    	        title: '<spring:message code="msg.login.valid.chk.pw" />'
		    	    });
					f.textNm.focus();
					return;
				}

				var param = new Object();
				param.textId = replaceall($("#textId").val());
				param.textNm = replaceall($("#textNm").val());
				param.force = bForce;

				$.ajax({
				url : '/login/admin/loginAction',
				type : 'POST',
				data : param,
				success : function(data) {
					if (data == "GO_MAIN") {
						console.log("go_main");
						movePage('/admin/product/list');
					} else if (data == "GO_STORE_JOIN") {
						movePage('/admin/store/storeInfoMgmt/list');
					} else if (data == "NORMAL_MEMBER") {
						deleteCookie("usercookieId");
						swal({
			    	        title: '<spring:message code="msg.login.fail.login" />'
			    	    });
					} else if (data == "GO_CHANGE_PASSWORD") {
						console.log("go_change_password");
						// 	    		var url = "/cm/authorization/passwd/changePasswordPopUp.ajax";

						// 	    		openModal(url);
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
			    	        title:'<spring:message code="msg.login.fail.pass.ipbandwidth" />'
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
			    		deleteCookie("usercookieId");
					} else if (data == "ALREADY_LOGGED_IN") {
						movePage('/admin/product/list');
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

			//Validation Chk
			function isValid() {

				return false;
			}

			function searchIdPw() {
				movePage('/login/admin/searchIdPw');
			}

			function goSignin() {
				movePage('/login/admin/goSignIn');
			}

			function changeLocale(locale, country) {
				var param = new Object();
				param.language = locale;
				param.country = country;
				movePage("", param);
			}
			//setCookie를 위한 함수, ID값 쿠키 생성
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
		</script>
		<form method="post" id="formLogin" action="/login/login" name="formLogin">
			<!-- 실제 로그인 부분 -->
			<div class="loginPage">
				<h1>
					<span class="title">
						<spring:message code="msg.login.login.title" />
					</span>
					<span class="ex">
						<spring:message code="msg.login.login.subtitle" />
					</span>
				</h1>

				<!-- 필요없는 경우 삭제 -->
				<div class="selectLang">
					<c:forEach items="${languageCodeList}" var="code" varStatus="status">
						<a href="javascript:;" class="amb_btnstyle middle" data-language="<c:out value="${code.dtl_cd}"/>" data-country="KR"><c:out value="${code.dtl_nm }"/></a>
					</c:forEach>
				</div>

				<script type="text/javascript">
					$(document).on("click", ".selectLang a", function() {
						$(this).siblings().removeClass('active');
						$(this).addClass('active');
					});
				</script>
				<!-- //필요없는 경우 삭제 -->


				<fieldset class="loginBox">
					<input type="text" class="id" id="textId" name="textId" maxlength="20" placeholder="ID" "/>
					<input type="password" class="pw" id="textNm" name="textNm" maxlength="20" placeholder="PASSWORD"  />

					<div class="loginSetting">
						<span class="fl">
<!-- 							<input type="checkbox" id="checkBox_01" checked /> -->
<%-- 							<label for="checkBox_01" class="inp_func"><spring:message code="msg.login.stay.signedin" /></label> --%>
 							<input type="checkbox" id="checkBox_01" name="idSave" unchecked/> 
 							<label for="checkBox_01" class="inp_func"><spring:message code="msg.login.stay.id" /></label> 

						</span>

						<span class="fr">
							<a href="javascript:goSignin();" class="underline">
								<spring:message code="msg.login.join.member" />
							</a>
							&nbsp;
							<a href="javascript:searchIdPw();" class="underline">
								<spring:message code="msg.login.search.idpw" />
							</a>
						</span>

					</div>

					<div class="loginBtn">
						<!-- 					<a href="javascript:movePage('/admin/product/productGroupConfig/index');" class="amb_btnstyle red large">LOGIN</a> -->
						<a href="javascript:login();" class="amb_btnstyle red large">
							<spring:message code="msg.login.btn.login" />
						</a>
					</div>
				</fieldset>
				<div class="copyright">
					<spring:message code="msg.login.bottom.copyright" />
				</div>
			</div>
			<!-- //실제 로그인 부분 -->
			<!-- 	</div> -->

		</form>

		<script type="text/javascript">
			$(document).ready(function() {
				var _this = $('body .loginPage');

				// 로그인 페이지에서만 필요한 ui js // body에 클래스명 추가
				_this.parents('body').addClass('loginPage');
				$("#loginHiddenDiv").animate({opacity : 1}, 500);

				// 브라우저 센터 정렬을 위해	
				var thisWidth = _this.outerWidth();
				var thisHeight = _this.outerHeight();

				_this.css({
				'margin-left' : -thisWidth / 2,
				'margin-top' : -thisHeight / 2
				});
				
			//쿠키에 저장된 아이디 가져오기
			var usercookieId = getCookie("usercookieId");
			$("input[name='textId']").val(usercookieId);
			
			if($(document.formLogin.textId).val() != ""){
				$(document.formLogin.checkBox_01).prop('checked', true);

			}else{
				$(document.formLogin.checkBox_01).prop('checked', false);
			}
				
			
			});
		</script>