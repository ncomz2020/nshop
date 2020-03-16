<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="amb_layout_common amb_admin_layout_temp_01">
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

			$(window).load(function() {
				start_Int();
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

		<script type="text/javascript">
			//background color gradient change 스크립트
			$(document).ready(function() {
				var colors = new Array(
				/*
				[62,35,255],
				[60,255,60],
				[255,35,98],
				[45,175,230],
				[255,0,255],
				[255,128,0]
				 */

				[ 77, 153, 77 ], [ 158, 26, 158 ], [ 64, 57, 114 ], [ 31, 108, 140 ], [ 179, 11, 59 ], [ 225, 120, 14 ]);

				var step = 0;
				//color table indices for: 
				// current color left
				// next color left
				// current color right
				// next color right
				var colorIndices = [ 0, 1, 2, 3 ];

				//transition speed
				var gradientSpeed = 0.005;

				function updateGradient() {
					if ($ === undefined)
						return;

					var c0_0 = colors[colorIndices[0]];
					var c0_1 = colors[colorIndices[1]];
					var c1_0 = colors[colorIndices[2]];
					var c1_1 = colors[colorIndices[3]];

					var istep = 1 - step;
					var r1 = Math.round(istep * c0_0[0] + step * c0_1[0]);
					var g1 = Math.round(istep * c0_0[1] + step * c0_1[1]);
					var b1 = Math.round(istep * c0_0[2] + step * c0_1[2]);
					var color1 = "rgb(" + r1 + "," + g1 + "," + b1 + ")";

					var r2 = Math.round(istep * c1_0[0] + step * c1_1[0]);
					var g2 = Math.round(istep * c1_0[1] + step * c1_1[1]);
					var b2 = Math.round(istep * c1_0[2] + step * c1_1[2]);
					var color2 = "rgb(" + r2 + "," + g2 + "," + b2 + ")";

					$('#gradientBg').css({
						background : "-webkit-gradient(linear, left top, right top, from(" + color1 + "), to(" + color2 + "))"
					}).css({
						background : "-moz-linear-gradient(left, " + color1 + " 0%, " + color2 + " 100%)"
					});

					step += gradientSpeed;
					if (step >= 1) {
						step %= 1;
						colorIndices[0] = colorIndices[1];
						colorIndices[2] = colorIndices[3];

						//pick two new target color indices
						//do not pick the same as the current one
						colorIndices[1] = (colorIndices[1] + Math.floor(1 + Math.random() * (colors.length - 1))) % colors.length;
						colorIndices[3] = (colorIndices[3] + Math.floor(1 + Math.random() * (colors.length - 1))) % colors.length;
					}
				}

				setInterval(updateGradient, 10);
			});
		</script>
		<!-- ////////////// background color gradient 변경효과 관련 /////////////// -->
		
<script type="text/javascript">
$(document).ready(function(){
	$('#searchIdPw').click(function(){
		searchIdPw();
	});
})

function searchIdPw(){
	var param = new Object();
	param.email = $("#email").val();
	
	$.ajax({
		url		:	'/login/searchIdPwAction'
	   ,type	:	'POST'
	   ,data	:	param
	   ,success	:	function(data){
			if(data == "NO_EMAIL"){
				var emailMsg = document.getElementById("emailMsg");
				emailMsg.innerHTML='<spring:message code="label.search.member.noreg.email" />';
			}else if(data == "ALREADY_EMAIL"){
				swal({
			        title: '<spring:message code="msg.search.member.transform.email" />'
			    });
				movePage('/login/admin/login');
			}else if(data == "UPDATE_FAIL"){
			        swal({
    				title: "error Msg",
			        type: "error"
			    });
			}else{
			    swal({
    				title: data
			    });
			}	   
	   }
	   ,error	:function(e){
	    	console.log(e.responseText.trim());
	   }
	   ,complete: function() {
	   }
	});
}
</script>		
		<!-- 실제 로그인 부분 -->
		<div class="loginPage">
			<h1>
				<span class="title"><spring:message code="label.search.member.information.title" /></span>
			</h1>


			<script type="text/javascript">
				$(document).on("click", ".selectLang a", function() {
					$(this).siblings().removeClass('active');
					$(this).addClass('active');
				});
			</script>
			<!-- //필요없는 경우 삭제 -->


			<fieldset class="loginBox">
				<span class="ex" style="color: white;"><spring:message code="label.search.member.msg" /></span>
				<div class="loginSetting">
				<input type="text" class="id" id="email" name="email" maxlength="20"  onkeydown="javascript:if(event.keyCode==13){searchIdPw();}" placeholder="Email" value=""  />
				</div>

					<span class="ex" id="emailMsg" name="emailMsg" style="color:white;"></span>

				<div class="loginBtn">
					<a href="javascript:;" class="amb_btnstyle red large" id="searchIdPw" name="searchIdPw"><spring:message code="label.search.member.searchlabel" /></a>
				</div>
			</fieldset>
			<div class="copyright" style="color:white;"><spring:message code="msg.login.bottom.copyright" /></div>
		</div>
		<!-- //실제 로그인 부분 -->
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function() {
		var _this = $('body .loginPage');

		// 로그인 페이지에서만 필요한 ui js // body에 클래스명 추가
		_this.parents('body').addClass('loginPage');

		// 브라우저 센터 정렬을 위해	
		var thisWidth = _this.outerWidth();
		var thisHeight = _this.outerHeight();

		_this.css({
		'margin-left' : -thisWidth / 2,
		'margin-top' : -thisHeight / 2
		});
	});
</script>
