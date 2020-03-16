<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">
$(document).ready(function() {
	//$('body').addClass('loginPage');

	// 브라우저 센터 정렬을 위해	
	var thisWidth = $('div.loginPage').outerWidth();
	var thisHeight = $('div.loginPage').outerHeight();

	$('div.loginPage').css({
	'margin-left' : -thisWidth / 2,
	'margin-top' : -thisHeight / 1.3
	});
	
	birth_year();
});
</script>
<script type="text/javascript">
var idChk = false;
var emailChk = false;

// 회원 가입
function goJoin(){
	if(!isValid()){
		var param = new Object();
		param.usr_id = $("#usr_id").val();
		param.usr_nm = $("#usr_nm").val();
		param.pwd = $("#pwd").val();
		param.email = $("#email").val();
		param.tel_no = $("#tel_no").val();
		param.mobile_no = $("#mobile_no").val();
		param.chk_pwd = $("#chk_pwd").val();
		param.comp_addr = $("#comp_addr").val();
		param.comp_addr2 = $("#comp_addr2").val();
		param.post_num = $("#post_num").val();
		param.gender = $("input[name=radio_1]:checked").val();
		param.birth = $('#birth_year').val();
		param.usr_grp_id = 2;
		$.ajax({
			url:  '/login/joinMemberAction',
		    type: 'POST',
			data: param,
		    success: function(data){
		    	if(data=="successNewMember"){
		    		swal({
				        title: '<spring:message code="msg.member.join.complete" />'
				    },function() {
				    	movePage('/login/admin/login');
					});				
		    	}else if(data=="failNewMember"){
		    		swal({
				        title: '<spring:message code="msg.member.join.error" />'
				    });
		    	}else{
		    		swal({
				        title: 'error!!'
				    });
		    	}
		    },
		    error: function(e){
		    	console.log(e.responseText.trim());
		    },
		    complete: function() {
		    }
		});
	}
}

// Validation Chk
function isValid(){
	var returnType = false;
	
	if($("#usr_id").val()==null || $("#usr_id").val()==""){
		swal({
	        title: '<spring:message code="msg.member.join.valid.input.id" />'
	    });
		$("#usr_id").focus();
		return true;
	}
	
	if($("#usr_id").val()!=null || $("#usr_id").val()!=""){
		if(!idChk){
			swal({
		        title: '<spring:message code="msg.member.join.valid.input.id.check" />'
		    });
			return true;
		}
	}
	
	if($("#pwd").val()==null || $("#pwd").val()==""){
		swal({
	        title: '<spring:message code="msg.member.join.valid.input.pw" />'
	    });
		$("#pwd").focus();
		return true;
	}
	
	if($("#chk_pwd").val()==null || $("#chk_pwd").val()==""){
		swal({
	        title: '<spring:message code="msg.member.join.valid.input.pw" />'
	    });
		$("#chk_pwd").focus();
		return true;
	}
	
	if($("#pwd").val()!=$("#chk_pwd").val()){
		swal({
	        title: '<spring:message code="msg.member.join.valid.input.pw.does.not.match" />'
	    });
		$("#pwd").val("");
		$("#chk_pwd").val("");
		$("#pwd").focus();
		return true;
	}
	
	if($("#usr_nm").val()==null || $("#usr_nm").val()==""){
		swal({
	        title: '<spring:message code="msg.member.join.valid.input.name" />'
	    });
		$("#usr_nm").focus();
		return true;
	}
	
	
	if($("#email").val()==null || $("#email").val()==""){
		swal({
	        title: '<spring:message code="msg.member.join.valid.input.email" />'
	    });
		$("#email").focus();
		return true;
	}
	
	if($("#email").val()!=null || $("#email").val()!=""){
		if(!emailChk){
			swal({
		        title: '<spring:message code="msg.member.join.valid.input.email.check" />'
		    });
			return true;
		}
	}
	
	return false;
}

// ID 중복 체크 
function goIdChk(usr_id){
	var param = new Object();
	param.usr_id = usr_id;
	var idReg =  /^[a-z]+[a-z0-9]{4,19}$/g;
	if($("#usr_id").val().length < 5 || $("#usr_id").val().length > 20){
		swal({
	        title: '<spring:message code="msg.member.join.valid.input.id.length" />'
	    });
		return;
	}
	if($("#usr_id").val()==null || $("#usr_id").val()==""){
		swal({
	        title: '<spring:message code="msg.member.join.valid.input.id" />'
	    });
		$("#usr_id").focus();
		return;
	}
	else if(idReg.test($("#usr_id").val())==false){
		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
		swal({
	        title: '<spring:message code="msg.member.join.valid.id.effectiveness" />'
	    });
		$("#usr_id").focus();
		return;
	}
	
	$.ajax({
		    url:  '/login/chkId',
	 	    type: 'POST',
		    data: param,
		    success: function(data){
		    	if(data == "previousId") {
		    		swal({
				        title: '<spring:message code="msg.member.join.valid.input.previous.id" />'
				    });
		    		idChk = false;
		    	} else if(data == "newId") {
		    		swal({
				        title: '<spring:message code="msg.member.join.valid.input.useful.id" />'
				    });
		    		idChk = true;
		    		$("#usr_id").attr("disabled",true);
		    	} 
		    },
		    error: function(e){
		    	console.log(e.responseText.trim());
		    },
		    complete: function() {
		    }
	});
}

//Email 중복 체크 
function goEmailChk(email){
	var param = new Object();
	param.email = email;
	
	//이메일 유효성 체크
	var exptext = /[A-Za-z0-9_\-]+@[A-Za-z0-9]+\.[A-Za-z0-9]/;
	
	if(exptext.test($("#email").val())==false){
			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
			swal({
		        title: '<spring:message code="msg.member.join.valid.email.effectiveness" />'
		    });
			$("#email").focus();
			return;
	}
	//이메일 중복 체크
	if($("#email").val()==null || $("#email").val()==""){
		swal({
	        title: '<spring:message code="msg.member.join.valid.input.email" />'
	    });
		$("#email").focus();
		return;
	}
	
	$.ajax({
		    url:  '/login/chkEmail',
	 	    type: 'POST',
		    data: param,
		    success: function(data){
		    	if(data == "previousEmail") {
		    		swal({
				        title: '<spring:message code="msg.member.join.valid.input.previous.email" />'
				    });
		    		emailChk = false;
		    	} else if(data == "newEmail") {
		    		swal({
				        title: '<spring:message code="msg.member.join.valid.input.useful.email" />'
				    });
		    		emailChk = true;
		    		$("#email").attr("disabled",true);
		    	} 
		    },
		    error: function(e){
		    	console.log(e.responseText.trim());
		    },
		    complete: function() {
		    }
	});
}

//태어난년도를 위한 select value 구하기
function birth_year(){
	var date = new Date();
	var year = date.getFullYear();

	for(var i = year - 80 ; i <= year ; i++){
		$('#birth_year').prepend("<option value = " +i+ ">"+"&nbsp;"+ i + "년 &nbsp;" + "</option>");
	}
	$('#birth_year').prepend("<option value = "+''+ ">"+"&nbsp;선&nbsp;택&nbsp"+ "</option>");
	$('#birth_year').find("option:first").prop("selected",true);

}

</script>	
<div class="amb_layout_common amb_admin_layout_temp_01">

	<div class="content loginStyle01">
		<!-- 로그인 스타일을 class명으로 지정함 // loginStyle01 // background 이미지 & 컨텐츠 센터형 -->

		<!-- ////////////// 롤링 페이드 인아웃 관련 /////////////// -->
		<!-- 롤링 페이드 인아웃 이미지 영역 -->
		<div class="loginBgBox">
			<div id="loginBg1" class="loginBg bg01" style="opacity: 1;"></div>
		</div>

		


		
		
		<form method="post" id="formJoin" action="" name="formJoin">
		<!-- 실제 로그인 부분 -->
		<div class="loginPage">
			<h1>
				<span class="title"><spring:message code="label.member.join.title" /></span>
			</h1>

			

			<fieldset class="loginBox">
				<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 30%;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th class="left"><spring:message code="label.member.join.id" /><i class="bullet mandatory"></i></th>
								<td >
									<input type="text" class="inp" style="width: 70%; ime-mode:inactive; ime-mode:disabled;" id="usr_id" name="usr_id" placeholder='<spring:message code="label.member.join.id"/>' maxlength="20" autofocus onfocus="this.value = this.value;" value="" /><a href="javascript:goIdChk($('#usr_id').val());" class="amb_btnstyle blue middle" style="width: 30%;"><spring:message code="label.member.join.chk.overlap" /></a>
								</td>
							</tr>
							<tr>
								<th class="left"><spring:message code="label.member.join.pw" /><i class="bullet mandatory"></i></th>
								<td>
									<input type="password" class="inp" style="width: 100%;" id="pwd" name="pwd" placeholder='<spring:message code="label.member.join.pw"/>' maxlength="50" autofocus onfocus="this.value = this.value;" value="" />
								</td>
							</tr>
							<tr>
								<th class="left"><spring:message code="label.member.join.pw.chk" /><i class="bullet mandatory"></i></th>
								<td>
									<input type="password" class="inp" style="width: 100%;" id="chk_pwd" name="chk_pwd" placeholder='<spring:message code="label.member.join.pw.chk"/>' maxlength="50" autofocus onfocus="this.value = this.value;" value="" />
								</td>
							</tr>
							<tr>
								<th class="left"><spring:message code="label.member.join.name" /><i class="bullet mandatory"></i></th>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="usr_nm" name="usr_nm" placeholder='<spring:message code="label.member.join.name"/>' maxlength="30" autofocus onfocus="this.value = this.value;" value="" />
								</td>
							</tr>
							<tr>
								<th class="left"><spring:message code="label.member.join.email" /><i class="bullet mandatory"></i></th>
								<td>
									<input type="email" class="inp" style="width: 70%;" id="email" name="email" placeholder='<spring:message code="label.member.join.email"/>' maxlength="20" autofocus onfocus="this.value = this.value;" value="" /><a href="javascript:goEmailChk($('#email').val());" class="amb_btnstyle blue middle" style="width: 30%;"><spring:message code="label.member.join.chk.overlap" /></a>
								</td>
							</tr>
							 <tr>
								<th class="left"><spring:message code="label.member.join.gender" /></th>
								<td>
									<input type="radio" id="radio_1_01" name="radio_1" value ="M"><label for="radio_1_01" class="inp_func">남자</label>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" id="radio_1_02" name="radio_1" value ="W"><label for="radio_1_02" class="inp_func">여자</label>
								</td>
							</tr> 
							<tr>
								<th class="left"><spring:message code="label.member.join.birth" /></th>
								<td>
					<!-- 태어난년도를 위한 동적 select -->
									<select id="birth_year" name="birth_year">
									</select>
								</td>
							</tr>
							<tr>
								<th class="left"><spring:message code="label.member.join.telno" /></th>
								<td>
									<input type="number" class="inp" style="width: 100%;" id="tel_no" name="tel_no" placeholder='<spring:message code="label.member.join.telno"/>' maxlength="11" autofocus onfocus="this.value = this.value;" value="" />
								</td>
							</tr>
							<tr>
								<th class="left"><spring:message code="label.member.join.mobileno" /></th>
								<td>
									<input type="number" class="inp" style="width: 100%;" id="mobile_no" name="mobile_no" placeholder='<spring:message code="label.member.join.mobileno"/>' maxlength="11" autofocus onfocus="this.value = this.value;" value="" />
								</td>
							</tr>
							<!--  주소 관련 tr  -->
							<tr>
								<th class="left"><spring:message code="label.store.comp.addr" /></th>
								<td>
									<input type="text" class="inp"  placeholder='<spring:message code="label.common.postno"/>' style="width:40%;" id="post_num" name="post_num" value="${storeInfoMgmt.post_num}" >
								<a href="#" onclick="sample6_execDaumPostcode()"  class="amb_btnstyle blue middle" ><spring:message code="label.common.find.postno"/></a>
								<input type="text" class="inp" id="comp_addr" name="comp_addr" placeholder='<spring:message code="label.common.addr"/>' style="width:100%;" value="${storeInfoMgmt.comp_addr}" >
								<input type="text" class="inp" id="comp_addr2" name="comp_addr2" placeholder='<spring:message code="label.common.addr.detail"/>' style="width:100%;" value="${storeInfoMgmt.comp_addr2}" >
								</td>
							</tr>
						</tbody>
					</table>

				<div class="loginBtn">	
					<a href="javascript:goJoin();" class="amb_btnstyle red large"><spring:message code="label.member.join.joinlabel" /></a>
				</div>
			</fieldset>
			<div class="copyright"><spring:message code="msg.login.bottom.copyright" /></div>
		</div>
		<!-- //실제 로그인 부분 -->
		</form>
	</div>
</div>

<!-- 주소 찾기  -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('post_num').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('comp_addr').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('comp_addr2').focus();
            },
            theme: {
            	bgColor: "#617FD9", //바탕 배경색   
            	searchBgColor: "#617FD9", //검색창 배경색
            	queryTextColor: "#FFFFFF" //검색창 글자색
            }
        }).open();
    }
</script>	



