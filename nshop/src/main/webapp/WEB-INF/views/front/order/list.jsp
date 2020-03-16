<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/js/dynatree/jquery.dynatree.js"></script>
<link rel="stylesheet" href="/js/dynatree/skin/ui.dynatree.css">
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
	$(document).ready(function() {
		IMP.init('imp44626297'); //iamport 대신 자신의 "가맹점 식별코드"를 사용하시면 됩니다
		/* var page = "${param.page}";
		if (isEmpty(page)) {
			page = 1;
		}
		searchList(page); */
		searchList();
	});

	function goDetail(ppl_id) {
		var param = new Object();
		param.ppl_id = ppl_id;
		movePage("detail", param);
	}

	function searchList() {
		var param = new Object();
		param.wish_seq = "${wish_seq}";
		
		if("${info.direct_order}" == "Y"){ //바로주문으로 온 경우
			param.order_cnt = "${info.order_cnt}";
			param.direct_order = "${info.direct_order}";
			param.prod_id = "${info.prod_id}";
			param.store_id = "${info.store_id}";
		}
		
		$.ajax({
			url : "listAction.ajax",
			type : "POST",
			data : param,
			success : function(data) {
				console.log(data);
				$("#listActionDiv").html(data);
			}
		});
	}
</script>
<div id="listActionDiv"></div>

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
			$("#zip_cd").val(data.zonecode);
			$("#base_addr").val(fullAddr);

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('dtil_aar').focus();
        },
        theme: {
        	bgColor: "#5fc677", //바탕 배경색   
        	searchBgColor: "#5fc677", //검색창 배경색
        	queryTextColor: "#FFFFFF" //검색창 글자색
        }
    }).open();
}
</script>