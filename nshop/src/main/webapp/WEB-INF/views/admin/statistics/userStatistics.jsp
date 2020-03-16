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
		
		//차트 초기화
		chartMake(0,0,0);
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
				url:"getUserStatisticsListAction.ajax",
				type:'POST',
				data : param,
				dataType: 'json',
				success : function(data) {
					var ssData = data.data;
					var inputStr = "";
					var joinData = [];
					var withData = [];
					var dateData = [];
					
					$("#lineChart02").remove();
					$("#chartDiv").append('<canvas id="lineChart02" style="display: block; width: 728px; height: 300px;" width="728" height="300"></canvas>');
					
					if(ssData != null){
						for(var i=0; i<ssData.length; i++){
							inputStr += "<tr><td class='center'>"+ssData[i].join_date+"</td>";
							inputStr += "<td class='right'>"+ comma(ssData[i].join_count) +"</td>";
							inputStr += "<td class='right'>"+ comma(ssData[i].withdrawal_count) +"</td>";
						}
						joinData = ssData[0].join_array;
						withData = ssData[0].with_array;
						dateData = ssData[0].date_array;
						chartMake(joinData,withData,dateData);
					}else{
						inputStr = "<tr><td colspan=''>조회된 데이터가 없습니다</td></tr>";
						swal("조회된 데이터가 없습니다.", "", "error");
						//chartMake(0,0);
					}
	
					$("#tbody1").html(inputStr);
				}
			});
		}
	}
	
	function checkparam() {
		var param = new Object();
		var strDateClCd = $("#searchDateClCd").val();
		param.date_clcd = strDateClCd;
		param.usr_grp_id = $("#searchGrpClCd").val();
		
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
			console.log(strStartYear);
			console.log(strEndYear);
			console.log(strEndYear - strStartYear);
			if( strEndYear - strStartYear >= 3){
				swal("조회기간의 간격은 3년을 초과하여 설정 하실수 없습니다.", "", "error");
				return false;
			}else{
				param.start_dt  = strStartYear;
				param.end_dt    = strEndYear;
			}
		}
	
		return param;
	}
	
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	
	function goExcel() {
		var param = checkparam();
		$.download('userExportAction.ajax', param, 'post');
	}
	
	function chartMake(joinData,withData,dateData ) {
		var lineData = {
			labels: dateData,
			datasets: [{
				label: "신규회원",
				data: joinData,
				backgroundColor: "rgba(49,141,231,0)",
				borderColor : "rgba(49,141,231,1)",
				lineTension: 0.0,
				pointBackgroundColor:"rgba(49,141,231,0.5)",
				pointHoverBackgroundColor :"rgba(49,141,231,1.0)",
			},{
				label: "탈퇴회원",
				data: withData,
				backgroundColor: "rgba(243,73,80,0)",
				borderColor : "rgba(243,73,80,1)",
				lineTension: 0.0,
				pointBackgroundColor:"rgba(243,73,80,0.5)",
				pointHoverBackgroundColor :"rgba(243,73,80,1.0)",
			}]
		};
		
		//각종 세부 option부분
		var options = {							
					legend: {display: false},
					scales:{
						xAxes: [{
									gridLines: {display:false, tickMarkLength:15, zeroLineWidth:0, zeroLineColor:"rgba(0, 0, 0, 0.4)",},
								}],
						yAxes: [{
									position: "left",
									gridLines: {display:true, color:"rgba(0, 0, 0, 0.07)", drawTicks:true, tickMarkLength:30, zeroLineColor:"rgba(0, 0, 0, 0.4)", lineWidth:1},
									ticks: {padding:45, min:0, }
								}]
			},
			// 커스텀 툴팁
			tooltips: {
				mode : 'x-axis',
				callbacks: {
					title: function (tooltipItem, data) { 
						return '신규 및 탈퇴 회원';
					},
					label: function (tooltipItem, data) {
						var amount = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
						var tt = data.datasets[tooltipItem.datasetIndex].label;
						return tt + ': '+ comma(amount) + '명 ';
					}
				},
			},
	
			// 커스텀 라벨
			legendCallback: function(chart) {
				var text = [];
				text.push('<ul>');
				for (var i=0; i<chart.data.datasets.length; i++) {
					text.push('<li>');
					text.push('<span style="background-color:' + chart.data.datasets[i].borderColor + '"></span>' + chart.data.datasets[i].label + '');
					text.push('</li>');
				}
				text.push('</ul>');
				return text.join("");
			}
		};
	
		var ctx = document.getElementById("lineChart02").getContext("2d");
		var myChart = new Chart(ctx, {
			type: 'line',
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
							 <th>회원구분</th>
							<td>
								<select id="searchGrpClCd" name="searchDateClCd">
								 <option value="2">판매회원</option>
								 <option value="3">구매회원</option>
								</select>
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
	
	<div class="g_column w_2_1 mgT20" style="width: 80%" >
		<h3><span class="title">신규/탈퇴회원 분석</span></h3>
		<div class="unitBox chartBox lineChartBox" id="chartDiv" style="height:340px;">
			<canvas id="lineChart02" style="display: block; width: 728px; height: 300px;" width="728" height="300"></canvas>
			<div id="chardLegend02" class="chartLegend"></div><!-- 커스텀으로 제작된 legend 부분 -->
		</div>
	</div>
	
	<div class="g_column w_2_1 mgT20" style="width: 20%">
		<h3>
			<div class="fr btnArea middle">
				<a href="javascript:goExcel();" class="amb_btnstyle white middle"><spring:message code="label.common.export.excel"/></a>
			</div>
		</h3>
		<div class="unitBox" id="listActionDiv" style="">
			<table class="amb_table">
				<colgroup>
					<col style="width: 40%" />
					<col style="width: 30%" />
					<col style="width: 30%" />
				</colgroup>
				<thead>
					<tr>
						<th class="center">일시</th>
						<th class="center">가입회원수</th>
						<th class="center">탈퇴회원수</th>
					</tr>
				</thead>
				<tbody id="tbody1">
					<tr>
						<td colspan='3'>조회된 데이터가 없습니다</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
</div>