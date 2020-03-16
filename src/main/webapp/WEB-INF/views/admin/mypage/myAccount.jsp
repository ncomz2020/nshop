<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.ncomz.nshop.utillty.SessionUtil" %>
<%@ page import="com.ncomz.nshop.domain.common.SessionUser" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/js/jquery.form.js"></script>
<script>
var pageType = '';
$(document).ready(function() {
	birth_year();
	
	// 현재 접속한 유저의 정보를 표시
	$('#usr_email').val("${list.email}");
	
	if("${list.gender}" == "M"){
		$("input:radio[name='radio_1'][value='M']").prop('checked', true);
	}else if("${list.gender}" == "W"){
		$("input:radio[name='radio_1'][value='W']").prop('checked', true);
	}
	if("${list.birth}" != ""){
		$('#birth_year').val("${list.birth}").prop("selected",true);
	}
	$('#usr_tel_no').val("${list.tel_no}");
	$('#usr_mobile_no').val("${list.mobile_no}");
	$('#post_num').val("${list.zip_cd}");
	$('#comp_addr').val("${list.base_addr}");
	$('#comp_addr2').val("${list.dtl_addr}");
	// 현재 접속한 유저의 정보를 표시 end
	
});
var emailChk = false;
//Email 중복,유효성 체크 
function goEmailChk(email){
	
	var param = new Object();
	//이메일 유효성 체크
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	if(exptext.test($("#usr_email").val())==false){
			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
			swal({
		        title: '<spring:message code="msg.member.join.valid.email.effectiveness" />'
		    });
			$("#usr_email").focus();
			return;
	}
	//이메일 중복 체크
	param.email = email;
	if($("#usr_email").val() != "${list.email}"){
		if($("#usr_email").val()==null || $("#usr_email").val()==""){
			swal({
		        title: '<spring:message code="msg.member.join.valid.input.email" />'
		    });
			$("#usr_email").focus();
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
			    		$("#usr_email").attr("disabled",true);
			    	} 
			    },
			    error: function(e){
			    	console.log(e.responseText.trim());
			    },
			    complete: function() {
			    }
		});
	}
	else{
		swal({
			title: '<spring:message code="msg.member.join.valid.input.same.email" />'
	    });
		emailChk = true;
		$("#usr_email").attr("disabled",true);
	}
}
//이메일 관련 값 체크
function isValid(){
	var returnType = false;
	
	if($("#usr_email").val()==null || $("#usr_email").val()==""){
		swal({
	        title: '<spring:message code="msg.member.join.valid.input.email" />'
	    });
		$("#usr_email").focus();
		return true;
	}
	
	if($("#usr_email").val()!=null || $("#usr_email").val()!=""){
		if(!emailChk){
			swal({
		        title: '<spring:message code="msg.member.join.valid.input.email.check" />'
		    });
			return true;
		}
	}
	//전화번호, 휴대번호 정규식 체크
	if($("#usr_tel_no").val().length > 11){
		swal({
	        title: '<spring:message code="msg.member.join.valid.input.wrong.tel" />'
	    });
    	return true; 
	}
	if($("#usr_tel_no").val()!=null){
		var rgEx = /(0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]))(\d{4}|\d{3})\d{4}$/g;  
        var chkFlg = rgEx.test($("#usr_tel_no").val());   
	    if(!chkFlg){
	    	swal({
		        title: '<spring:message code="msg.member.join.valid.input.wrong.tel" />'
		    });
	    	return true; 
		}
	}
	if($("#usr_mobile_no").val()!=null){
		var rgEx = /(01[0|1|6|7|8|9])(\d{4}|\d{3})\d{4}$/g;  
        var chkFlg = rgEx.test($("#usr_mobile_no").val());   
	    if(!chkFlg){
	    	swal({
		        title: '<spring:message code="msg.member.join.valid.input.wrong.mobile" />'
		    });
	    	return true; 
		}
	}
	return false;
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

//회원 정보 수정

function saveAction(){
	if(!isValid()){
		var param = new Object();
		param.usr_id = $("#usr_id").val();
		param.email = $("#usr_email").val();
		param.tel_no = $("#usr_tel_no").val();
		param.mobile_no = $("#usr_mobile_no").val();
		param.comp_addr = $("#comp_addr").val();
		param.comp_addr2 = $("#comp_addr2").val();
		param.post_num = $("#post_num").val();
		param.gender = $("input[name=radio_1]:checked").val();
		param.birth = $('#birth_year').val();
		swal({
	        title: '<spring:message code="label.common.confirm.save"/>',
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonText: "YES",
	        cancelButtonText: "NO",
	        closeOnConfirm: false
	         },function(){
			$.ajax({
			url:  '/admin/mypage/myaccountAction.ajax',
		    type: 'POST',
			data: param,
		    success: function(data){
		    	console.log(data);
		    	if(data=="successUpdate"){
		    		swal({
				        title: '<spring:message code="label.common.success.save" />'
				    });
		    		movePage('/admin/product/list');
		    	}else if(data=="failUpdate"){
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
		    	console.log("why");
		    	console.log(e.responseText.trim());
		    },
		    complete: function() {
		    }
		
			});
	    });
	}
}

//회원 탈퇴
function deletemember(usr_id){
		swal({
			title: '<spring:message code="label.common.confirm.delete"/>',
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonText: "YES",
	        cancelButtonText: "NO",
	        closeOnConfirm: false
	         },function() {		
	        	 $.ajax({
	 			    url:  '/admin/member/seller/deleteAction',
	 			    async:false,
	 		 	    type: 'POST',
	 			    data: {'usr_id': usr_id},
	 			    success: function(data){
	 			    	if(data == 'error') {
	 			    		swal({
	 			    			title: '<spring:message code="label.common.fail.action"/>'
	 					    });
	 			    	} else if(data == 'success'){
	 			    		swal({
	 					        title: '<spring:message code="label.common.success.delete"/>'
	 					    });
	 			    		document.frmMenuHandle.action="<%=request.getContextPath()%>/login/logoutActionfront";
	 						document.frmMenuHandle.method="post";
	 						document.frmMenuHandle.submit();
	 						movePage('/login/login');
	 			    	} 
	 			    },
	 			   error:function(request,status,error){
	 			        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	 			       },
	 			   complete: function() {
	 			   }
	 			});
		});
}
</script>
<body>
<form id="updateForm" name="updateForm" method="post">
<div class="rowBox mgT30">
	<h3>
		<span class="title"><spring:message code="label.mypage.modify.myAccount"/></span>
	</h3>
	<div class="g_column w_1_1">
		<div class="unitBox" style="">
			<table class="amb_form_table lineAll" >	
				<colgroup>
					<col style="width:15%;" />
					<col style="" />
				</colgroup>
				<tbody>
					<tr>
						<th><spring:message code="label.member.join.id"/><i class="bullet mandatory"></i></th>
						<td><input type="id" class="inp" style="width:30%;" id="usr_id" name="usr_id" value="${session_user.usr_id}" disabled/></td>
					</tr>
					<tr>
						<th><spring:message code="label.member.join.name"/><i class="bullet mandatory"></i></th>
						<td><input type="id" class="inp" style="width:30%;" id="usr_nm" name="usr_nm" value="${session_user.usr_nm}" disabled/></td>
					</tr>
					<tr>
						<th><spring:message code="label.member.join.email"/><i class="bullet mandatory"></i></th>
						<td><input type="id" class="inp" style="width:30%;" id="usr_email" name="usr_email" placeholder='<spring:message code="label.member.join.email"/>' />
						<a href="javascript:goEmailChk($('#usr_email').val());" class="amb_btnstyle blue middle" style="width: 10%;"><spring:message code="label.member.join.chk.overlap" /></a>
						</td>
					</tr>
					<tr>
						<th><spring:message code="label.member.join.gender"/></th>
						<td>
							<input type="radio" id="radio_1_01" name="radio_1" value ="M"><label for="radio_1_01" class="inp_func">남자</label>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="radio_1_02" name="radio_1" value ="W"><label for="radio_1_02" class="inp_func">여자</label>
						</td>
					</tr>
					<tr>
						<th><spring:message code="label.member.join.birth"/></th>
						<td>
							<!-- 태어난년도를 위한 동적 select -->
							<select id="birth_year" name="birth_year">
							</select>
						</td>
					</tr>
					<tr>
						<th><spring:message code="label.member.join.telno"/></th>
						<td><input type="text" class="inp" style="width:30%;" id="usr_tel_no" name="usr_tel_no" maxlength="11" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" placeholder='<spring:message code="label.member.join.telno"/>' /></td>
					</tr>
					<tr>
						<th><spring:message code="label.member.join.mobileno"/></th>
						<td><input type="text" class="inp" style="width:30%;" id="usr_mobile_no" name="usr_mobile_no" maxlength="11" placeholder='<spring:message code="label.member.join.mobileno"/>' /></td>
					</tr>
					<tr>
						<th class="left"><spring:message code="label.common.addr" /></th>
						<td>
							<input type="text" class="inp"  placeholder='<spring:message code="label.common.postno"/>' style="width:15%;" id="post_num" name="post_num" value="${storeInfoMgmt.post_num}" >
							<a href="#" onclick="sample6_execDaumPostcode()"  class="amb_btnstyle blue middle" ><spring:message code="label.common.find.postno"/></a><br> 
							<input type="text" class="inp" id="comp_addr" name="comp_addr" placeholder='<spring:message code="label.common.addr"/>' style="width:30%;" value="${storeInfoMgmt.comp_addr}" ><br>
							<input type="text" class="inp" id="comp_addr2" name="comp_addr2" placeholder='<spring:message code="label.common.addr.detail"/>' style="width:30%;" value="${storeInfoMgmt.comp_addr2}" >
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div class="paging left">
	<div class="fr btnArea middle">
		<a href="javascript:saveAction();" class="amb_btnstyle blue middle"><spring:message code="label.common.save"/></a>
		<a href="javascript:deletemember('${session_user.usr_id}');"  class="amb_btnstyle gray middle"><spring:message code="label.common.membership.cancel"/></a>
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
                document.getElementById('comp_addr2').value = "";
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

</form>