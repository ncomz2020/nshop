<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!-- 차트가 필요한 곳에서만 사용 -->
<!--[if lte IE 8]><script type="text/javascript" src="/js/chart/excanvas.js"></script><![endif]-->
<script type="text/javascript" src="/js/chart/chart.js"></script>

<script type="text/javascript">
	//chart 공통 부분							
	Chart.defaults.global.responsive = true; //가변형
	Chart.defaults.global.responsiveAnimationDuration = 500; //가변형 animation
	Chart.defaults.global.maintainAspectRatio = false; //가로세로 비율 유지,
	
	//폰트 
	Chart.defaults.global.defaultFontColor = "#222"; 
	Chart.defaults.global.defaultFontFamily = "Arial, Helvetica, sans-serif"; 
	Chart.defaults.global.defaultFontSize = 12; 							
	
	//툴팁
	Chart.defaults.global.tooltips.cornerRadius = 2 ;
	Chart.defaults.global.tooltips.bodySpacing = 5;
	Chart.defaults.global.tooltips.xPadding = 10;
	Chart.defaults.global.tooltips.yPadding = 10;
	
	//animation
	Chart.defaults.global.animation.duration = 1800;
	Chart.defaults.global.animation.easing = "easeOutBounce";
	
	// line chart용 //공통을 채울때
	Chart.defaults.global.elements.line.borderWidth = 1;

	Chart.defaults.global.elements.point.radius = 3;
	Chart.defaults.global.elements.point.hoverRadius = 5;
	Chart.defaults.global.elements.point.hoverBorderWidth = 0;

	
	var sessionStoreId = "${sessionStoreId}";
	var sessionGrpNm = "${sessionGrpNm}";
	
	$(document).ready(function() {
		init();
		
		$('#btnSearch').click(function() {
			search();
		});
		
		$("#searchDateClCd").on("change",function(e){
			changeCmb(this.value);
		});
	});
	
	function init() {
		var newDate = new Date();
		var edDate = new Date();
		var strtDate = new Date( newDate.setDate(newDate.getDate() - 14));
		var firstDayOfMonth = new Date( newDate.getFullYear(), newDate.getMonth()-1 , 1 );
		var threeMonthAgo = new Date ( firstDayOfMonth.setDate( firstDayOfMonth.getDate() - 1 ) );
		var oneYearAgo = new Date( newDate.getFullYear()-1,newDate.getMonth(),1 );
		
		// 일달력 초기화
		$("#startDate").datepicker( "setDate", strtDate);
		$("#endDate").datepicker( "setDate", edDate);
		
		// 월달력 초기화
		$("#startMonth").datepicker( "setDate", threeMonthAgo);
		$("#endMonth").datepicker( "setDate", edDate);

		// 년달력 초기화
		$("#startYear").datepicker( "setDate", oneYearAgo);
		$("#endYear").datepicker( "setDate", strtDate);
		
		//달력 숨김
		$("#picker2").hide();
		$("#picker3").hide();
		
		// 접속 계정 그룹에 따른 컴포넌트 컨트롤
		if(sessionGrpNm != "ADMIN"){
			$("#searchStoreId").val(sessionStoreId);
			$("#searchStoreId").attr('disabled', true);
		}
		chartMake(0);
	}
	
	//달력 select에 의한 달력 교체
	function changeCmb(cmb) {
		if(cmb == "10"){
			$("#picker1").show();
			$("#picker2").hide();
			$("#picker3").hide();
		}else if(cmb == "20"){
			$("#picker1").hide();
			$("#picker2").show();
			$("#picker3").hide();
		}else{
			$("#picker1").hide();
			$("#picker2").hide();
			$("#picker3").show();
		}
	}
	
	// 두 날짜 사이의 일수 계산
	function getDateDiff(_date1, _date2) {
		
		if(_date1 == null || _date1 == '') return '';
		if(_date2 == null || _date2 == '') return '';
		if(!/^(\d){8}$/.test(_date1)) return "invalid date";
		if(!/^(\d){8}$/.test(_date2)) return "invalid date";

	    var yy1 = _date1.substr(0,4),
	        mm1 = _date1.substr(4,2) - 1,
	        dd1 = _date1.substr(6,2);

	    var diffDate_1 = new Date(yy1,mm1,dd1);
	    
	    var yy2 = _date2.substr(0,4),
	    		mm2 = _date2.substr(4,2) - 1,
			dd2 = _date2.substr(6,2);

	    var diffDate_2 = new Date(yy2,mm2,dd2);
	 
	    var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
	    diff = Math.ceil(diff / (1000 * 3600 * 24));
	    diff = diff + 1;
	    return diff;
	}

	//검색
	function search(){
		var param = checkparam();
		if(param){
			$.ajax({
				url:"getOrderStatisticsListAction.ajax",
				type:'POST',
				data : param,
				dataType: 'json',
				success : function(data) {
					var chData = data.chartData;
					var gridData = data.gridData;
					
					$("#lineChart02").remove();
					$("#chartDiv").append('<canvas id="lineChart02" style="display: block; width: 728px; height: 300px;" width="728" height="300"></canvas>');
					
					var inputStr = "";
					var amtArray = [];
					if(gridData != null){
						for(var i=0; i<gridData.length; i++){
							inputStr += "<tr><td class='center'>"+gridData[i].order_date+"</td>";
							inputStr += "<td class='right'>"+ comma(gridData[i].ten) +"</td>;"
							inputStr += "<td class='right'>"+ comma(gridData[i].twenty) +"</td>;"
							inputStr += "<td class='right'>"+ comma(gridData[i].thirty) +"</td>;"
							inputStr += "<td class='right'>"+ comma(gridData[i].forty) +"</td>;"
							inputStr += "<td class='right'>"+ comma(gridData[i].fifty) +"</td>;"
							inputStr += "<td class='right'>"+ comma(gridData[i].sixty) +"</td>;"
							inputStr += "<td class='right'>"+ comma(gridData[i].none) +"</td></tr>";

							amtArray = chData[0].amt_array;
						}
					}else{
						inputStr = "<tr><td colspan='8'>조회된 데이터가 없습니다</td></tr>";
						swal("조회된 데이터가 없습니다.", "", "error");
						chartMake(0);
					}
					
					 $("#tbody1").html(inputStr);
				     chartMake(amtArray);
				}
			});
		}
	}
	
	function checkparam() {
		var param = new Object();
		var strDateClCd = $("#searchDateClCd").val();
		param.date_clcd = strDateClCd;
		
		if($("#startDate").val() == ""){
			swal("시작일시을 선택해주세요.", "", "error");
			return false;
		}
		if($("#endDate").val() == ""){
			swal("종료일시을 선택해주세요.", "", "error");
			return false;
		}
		
		if(strDateClCd == "10"){
			var strStartDt = $("#startDate").val().replace(/[^0-9]/g, "");
			var strEndDt = $("#endDate").val().replace(/[^0-9]/g, "");
			if(getDateDiff(strStartDt,strEndDt) > 15){
				swal("조회기간의 간격은 15일을 초과하여 설정 하실수 없습니다.", "", "error");
				return false;
			}else{
				param.start_dt  = strStartDt;
				param.end_dt    = strEndDt;
			}
			
		}else if(strDateClCd == "20"){
			var strStartMth = $("#startMonth").val().replace(/[^0-9]/g, "")+"01";
			var strEndMth = $("#endMonth").val().replace(/[^0-9]/g, "")+"31";
			if(getDateDiff(strStartMth,strEndMth) > 368){
				swal("조회기간의 간격은 12개월을 초과하여 설정 하실수 없습니다.", "", "error");
				return false;
			}else{
				param.start_dt  = $("#startMonth").val().replace(/[^0-9]/g, "");
				param.end_dt    = $("#endMonth").val().replace(/[^0-9]/g, "");
			}
			
		}else if(strDateClCd == "30"){
			var strStartYear = $("#startYear").val().replace(/[^0-9]/g, "");
			var strEndYear = $("#endYear").val().replace(/[^0-9]/g, "");
			if( strEndYear - strStartYear >= 3){
				swal("조회기간의 간격은 3년을 초과하여 설정 하실수 없습니다.", "", "error");
				return false;
			}else{
				param.start_dt  = strStartYear;
				param.end_dt    = strEndYear;
			}
		}
	
		if($("#searchStoreId").val != ""){
			param.store_id = $("#searchStoreId").val();
		}
		if($("#searchProdId").val != ""){
			param.prod_id = $("#searchProdId").val();
		}
		
		return param;
	}
	
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	
	function goExcel() {
		var param = checkparam();
		$.download('orderExportAction.ajax', param, 'post');
	}
	
	function chartMake(amtArray) {
		var lineData = {
				datasets: [{
					label: "주문분석",
					data: amtArray,
					backgroundColor: ["rgba(255,0,0,1.0)", "#8e5ea2","#3cba9f","#e8c3b9","#c45850","rgba(76,79,98,0.3)","rgba(49,141,231,1.0)"],
					borderColor : "rgba(255, 255, 255, 0.7)"
				}],
				labels: ["10대 이하","20대","30대","40대","50대","60대이상","정보없음"]
			};
			
			//각종 세부 option부분
			var options = {
				legend: {display: false},
				// 커스텀 툴팁
				tooltips: {
					mode : 'x-axis',
					showAllTooltips: true,
					callbacks: {
						label: function (tooltipItem, data) {
							var amount = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
							var tt = data.labels[tooltipItem.index];
							return tt + ': '+ comma(amount) + '건 ';
						}
					}
				},
				// 커스텀 라벨
				legendCallback: function(chart) {
					var text = [];
					text.push('<ul>');
					for (var i=0; i<chart.data.labels.length; i++) {
						text.push('<li>');
						text.push('<span style="background-color:' + chart.data.datasets[0].backgroundColor[i] + '"></span>' + chart.data.labels[i] + '');
						text.push('</li>');
					}
					text.push('</ul>');
					return text.join("");
				}
			};
	
		var ctx = document.getElementById("lineChart02").getContext("2d");
		var myChart = new Chart(ctx, {
			type: 'pie',
			data: lineData,
			options: options
		});

		document.getElementById('chardLegend02').innerHTML = myChart.generateLegend();//커스텀 legend를 생성함
	}
	 
</script>



<!-- //차트가 필요한 곳에서만 사용 -->

<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<form id="productListForm" name="productListForm">
			<input type="hidden" id="page" name="page">
			<div class="unitBox searchBox" style="">
				<table class="amb_form_table">
					<colgroup>
						<col style="width: 10%;" />
						<col style="width: 25%;" />
						<col style="width: 10%;" />
						<col style="width: 25%;" />
					</colgroup>
					<tbody>
						<tr>
							<!-- <th><spring:message code="label.product.prod.stat"/></th>-->
							<th>기간 설정</th> <!--  임시  -->
							<td>
								<select id="searchDateClCd" name="searchDateClCd">
								 <option value="10">일</option>
								 <option value="20">월</option>
								 <option value="30">년</option>
								</select>
								<span class="datepickerRange" id="picker1">
									<input type="text" value="" id="startDate" name="startDate" class="inp datepicker startDate" placeholder="date" />
									~
									<input type="text" value="" id="endDate" name="endDate" class="inp datepicker endDate" placeholder="date" />
								</span>
								<span class="datepickerRange" id="picker2">
									<input type="text" value="" id="startMonth" class="inp datepicker months startDate" placeholder="date" />
									~
									<input type="text" value="" id="endMonth" class="inp datepicker months endDate" placeholder="date" />
								</span>
								<span class="datepickerRange" id="picker3">
									<input type="text" value="" id="startYear" class="inp datepicker years startDate" placeholder="date" />
									~
									<input type="text" value="" id="endYear" class="inp datepicker years endDate" placeholder="date" />
								</span>
							</td>
						</tr>
						<tr>
						
							<!-- <th><spring:message code="label.common.search"/></th> -->
							 <th>상점ID</th>
							<td>
								<input type="text" id="searchStoreId" name="searchStoreId" class="inp" style="width: 68%" placeholder='<spring:message code="label.product.prod.input.search"/>' />
							</td>
						</tr>
						<tr>
						
							<!-- <th><spring:message code="label.common.search"/></th> -->
							 <th>상품ID</th>
							<td>
								<input type="text" id="searchProdId" name="searchProdId" class="inp" style="width: 68%" placeholder='<spring:message code="label.product.prod.input.search"/>' />
							</td>
						</tr>
					</tbody>
				</table>
				<span class="searchFormBtn">
					<a href="javascript:;" class="amb_btnstyle black middle" id="btnSearch" name="btnSearch" role="button"><spring:message code="label.common.search"/></a>
				</span>
			</div>
		</form>
	</div>
	
	<div class="g_column w_2_1 mgT20">
		<h3><span class="title">주문분석</span></h3>
		<div class="unitBox chartBox lineChartBox" id="chartDiv" style="height:340px;">
			<canvas id="lineChart02" style="display: block; width: 728px; height: 300px;" width="728" height="300"></canvas>
			<div id="chardLegend02" class="chartLegend"></div><!-- 커스텀으로 제작된 legend 부분 -->
		</div>
	</div>
	
	<div class="g_column w_2_1 mgT20">
		<h3>
			<div class="fr btnArea middle">
				<a href="javascript:goExcel();" class="amb_btnstyle white middle"><spring:message code="label.common.export.excel"/></a>
			</div>
		</h3>
		<div class="unitBox" id="listActionDiv" style="">
			<table class="amb_table">
				<colgroup>
					<col style="width: 16%" />
					<col style="width: 12%" />
					<col style="width: 12%" />
					<col style="width: 12%" />
					<col style="width: 12%" />
					<col style="width: 12%" />
					<col style="width: 12%" />
					<col style="width: 12%" />
				</colgroup>
				<thead>
					<tr>
						<th class="center">일시</th>
						<th class="center">10대이하</th>
						<th class="center">20대</th>
						<th class="center">30대</th>
						<th class="center">40대</th>
						<th class="center">50대</th>
						<th class="center">60대이상</th>
						<th class="center">정보없음</th>
					</tr>
				</thead>
				<tbody id="tbody1">
					<tr>
						<td colspan='8'>조회된 데이터가 없습니다</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
</div>