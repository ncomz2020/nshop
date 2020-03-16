<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="amb_admin_layout_temp_01 main" >
	<!-- class명 amb_layout_common :필수  / amb_admin_layout_temp_01:필수(사이트 레이아웃 결정) -->

	<div class="loginStyle01">
		<!-- 로그인 스타일을 class명으로 지정함 // loginStyle01 // background 이미지 & 컨텐츠 센터형 -->


<script type="text/javascript">
$(document).ready(function(){
	$('#searchId').click(function(){
		if($("#usr_nm").val() == ""){
			swal({
		        title: '<spring:message code="msg.login.valid.chk.name" />'
		    });
		}
		else if($("#email").val() == ""){
			swal({
		        title: '<spring:message code="msg.login.valid.chk.email" />'
		    });
		}
		else{
			searchId();
		}
	});
	
	$('#searchPw').click(function(){
		if($("#usr_nm2").val() == ""){
			swal({
		        title: '<spring:message code="msg.login.valid.chk.name" />'
		    });
		}
		else if($("#email2").val() == ""){
			swal({
		        title: '<spring:message code="msg.login.valid.chk.email" />'
		    });
		}
		else{
			searchPw();
		}
	});


	var _this = $('body .loginPage');
	
	// 로그인 페이지에서만 필요한 ui js // body에 클래스명 추가
	_this.parents('body').addClass('loginPage');
		// 브라우저 센터 정렬을 위해	
	var thisWidth = _this.outerWidth();
	var thisHeight = _this.outerHeight();
	
	_this.css({
	'margin-left' : -thisWidth / 2,
	'margin-top' : -thisHeight / 1.4
	});

})
function searchId(){
	
	var secret_id = "";
	var param = new Object();
	param.email = $("#email").val();
	param.usr_nm = $("#usr_nm").val();
	$.ajax({
		url		:	'/login/searchIdAction'
	   ,type	:	'POST'
	   ,data	:	param
	   ,success	:	function(data){
			if(data == "CHECK_DATA"){
				swal({
			        title: '<spring:message code="msg.login.valid.chk.id.not.exist" />'
			    });
			}else{
				
 				for(var i = 0 ; i < data.length - 3 ; i ++){
 					secret_id += data[i];
 				}
 				for(var i = data.length - 3 ; i < data.length ; i ++){
 					secret_id += "*";
 				}
 				swal({
			        title: '<spring:message code="label.search.member.infoamtion.id.complete" />'+secret_id
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
function searchPw(){
	
	var param = new Object();
	param.email = $("#email2").val();
	param.usr_nm = $("#usr_nm2").val();
	$.ajax({
		url		:	'/login/searchPwAction'
	   ,type	:	'POST'
	   ,data	:	param
	   ,success	:	function(data){
		   if(data == "NO_EMAIL"){
			   swal({
			        title: '<spring:message code="label.search.member.noreg.email" />'
			    });
			}else if(data == "success"){
				swal({
			        title: '<spring:message code="msg.search.member.transform.pw.email" />'
			    });
			}else if(data == "error"){
				swal({
					title: '<spring:message code="msg.login.valid.chk.id.not.exist" />',
			        type: "error"
			    });
			}
			else{
				swal({
					title: data,
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
				<span class="title"><spring:message code="label.search.member.information.id.title" /></span>
			</h1>

			<fieldset class="loginBox">
				<span class="ex" style="color: white; margin-bottom : 20px;"><spring:message code="label.search.member.msg" /></span>
				<div class="fr" style="width:65%; height:100%; float:left">
				<div>
				<input type="text" class="id" id="usr_nm" name="usr_nm" maxlength="20" placeholder="<spring:message code="label.search.member.name.placeholder" />" value=""  />
				</div>
				<div>
				<input type="text" class="id" id="email" name="email" maxlength="20" placeholder="<spring:message code="label.search.member.email.placeholder" />" value=""  />
				</div>
				</div>
				<div class="loginBtn" style="width:32%; height:100%; float:right">
					<a href="javascript:;" class="amb_btnstyle red large" id="searchId" name="searchId"><spring:message code="label.search.member.information.id.title" /></a>
				</div>
			</fieldset>

			<h1>
				<span class="title">&nbsp;</span>
				<span class="title"><spring:message code="label.search.member.information.pw.title" /></span>
			</h1>

			<script type="text/javascript">
				$(document).on("click", ".selectLang a", function() {
					$(this).siblings().removeClass('active');
					$(this).addClass('active');
				});
			</script>
			
			<!-- //필요없는 경우 삭제 -->
			<fieldset class="loginBox">
				<span class="ex" style="color: white; margin-bottom : 20px;"><spring:message code="label.search.member.msg" /></span>
				<div class="fr" style="width:65%; height:100%; float:left">
				<div>
				<input type="text" class="id" id="usr_nm2" name="usr_nm2" maxlength="20" placeholder="<spring:message code="label.search.member.name.placeholder" />" value=""  />
				</div>
				<div>
				<input type="text" class="id" id="email2" name="email2" maxlength="20" placeholder="<spring:message code="label.search.member.email.placeholder" />" value=""  />
				</div>
				</div>
				<div class="loginBtn" style="width:32%; float:right">
					<a href="javascript:;" class="amb_btnstyle red large" id="searchPw" name="searchPw"><spring:message code="label.search.member.information.pw.title" /></a>
				</div>
			</fieldset>
			<div class="copyright" style="color:white;"><spring:message code="msg.login.bottom.copyright" /></div>
		</div>
		<!-- //실제 로그인 부분 -->
	
	</div>
</div>

