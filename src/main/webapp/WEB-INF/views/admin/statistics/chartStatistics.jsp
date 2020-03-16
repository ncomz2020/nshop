<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!-- 차트가 필요한 곳에서만 사용 -->
<!--[if lte IE 8]><script type="text/javascript" src="/js/chart/excanvas.js"></script><![endif]-->
<script type="text/javascript" src="/js/chart/chart.js"></script>

<script type="text/javascript"> // 차트 공통 요소로써 차트가 존재하는 페이지에 반드시 한번만 존재해야함 
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
	
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
</script>

<script type="text/javascript">
	// line chart용 //공통을 채울때
	Chart.defaults.global.elements.line.borderWidth = 1;

	Chart.defaults.global.elements.point.radius = 3;
	Chart.defaults.global.elements.point.hoverRadius = 5;
	Chart.defaults.global.elements.point.hoverBorderWidth = 0;
</script>

<!-- //차트가 필요한 곳에서만 사용 -->

<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_2_1">
		<h3>
			<span class="title">방문자분석</span>
		</h3>
		<div class="unitBox chartBox barChartBox" style="min-height:300px;">
			<canvas id="barChart00"></canvas>
			<div id="chardLegend000" class="chartLegend"></div>
				
			<script>
				// Bar chart
				new Chart(document.getElementById("barChart00"), {
				    type: 'bar',
				    data: {
				    	labels: ["2018-02-01", "2018-02-02", "2018-02-03", "2018-02-04", "2018-02-05", "2018-02-06", "2018-02-07"],
				      	datasets: [
				        {
				          label: "방문자수",
				          backgroundColor: ["#"+((1<<24)*Math.random()|0).toString(16), "#8e5ea2","#3cba9f","#e8c3b9","#c45850","rgba(76,79,98,0.3)","rgba(49,141,231,1.0)"],
				          data: [20, 35, 61, 10, 9, 22, 83]
				        }
				      ]
				    },
				    options: {
				      legend: { display: false },
				      scales:{
							xAxes: [{
										gridLines: {display:false,},
										categoryPercentage: 0.3,
										ticks: {},
										
									}],
							yAxes: [{
										position: "left",
										gridLines: {display:true, color:"rgba(0, 0, 0, 0.07)", drawTicks:false, tickMarkLength:10, zeroLineColor:"rgba(0, 0, 0, 0.2)", lineWidth:1},
										ticks: {padding:20, min:0, }
										
									}]
						},
						// 커스텀 툴팁
						tooltips: {
							mode : 'label',
							callbacks: {
								label: function (tooltipItem, data) {
									var amount = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
									var tt = data.datasets[tooltipItem.datasetIndex].label;
									return tt + ': '+ amount + '명 ';
								}
							},
						}
				    }
				});					
			</script>						
		</div>
	</div>
	
	<div class="g_column w_2_1">
		<h3>
			<span class="title">신규 회원분석</span>
			<span class="ex">(회원 성별 현황)</span>
		</h3>
		<div class="unitBox chartBox lineChartBox" style="min-height:300px;">
			<canvas id="lineChart03" style="display: block;"></canvas>
			<div id="chardLegend03" class="chartLegend">
			<script type="text/javascript">
				//data 부분
				var lineData = {
					labels: ["2018-02-01", "2018-02-02", "2018-02-03", "2018-02-04", "2018-02-05", "2018-02-06", "2018-02-07"],
					datasets: [{
						label: "남성",
						data: [85, 107, 60, 150, 100, 259 , 30],
						backgroundColor: "rgba(49,141,231,0)",
						borderColor : "rgba(49,141,231,0.6)",
						lineTension: 0.0,
						pointBackgroundColor:"rgba(49,141,231,0.5)",
						pointHoverBackgroundColor :"rgba(49,141,231,1.0)",
					},{
						label: "여성",
						data: [205, 30, 205, 90, 309, 40, 198],
						backgroundColor: "rgba(243,73,80,0)",
						borderColor : "rgba(243,73,80,0.7)",
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
								var total01 = data.datasets[tooltipItem[0].datasetIndex].data[tooltipItem[0].index];
								var total02 = data.datasets[tooltipItem[1].datasetIndex].data[tooltipItem[1].index];
								return 'Total : ' + (total01 + total02) + '명 ';
							},
							label: function (tooltipItem, data) {
								var amount = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
								var tt = data.datasets[tooltipItem.datasetIndex].label;
								return tt + ': '+ amount + '명 ';
							}
						},
					},
					
					// 커스텀 라벨
					legendCallback: function(chart) {
						console.log(chart.data);
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
		
		
		
				var ctx = document.getElementById("lineChart03").getContext("2d");
				var myChart  = new Chart(ctx, {
					type: 'line',
					data: lineData,
					options: options
				});
		
				document.getElementById('chardLegend03').innerHTML = myChart.generateLegend();//커스텀 legend를 생성함							
			</script>						
		</div>
	</div>
</div>

<div class="rowBox mgT30">
	<div class="g_column w_2_1 mgT20">
		<h3>
			<span class="title">주문분석</span>
			<span class="ex">(연령별 주문통계)</span>
		</h3>
		<div class="unitBox chartBox barChartBox" style="height:340px;">
			<canvas id="barChart04" style="display: block; width: 728px; height: 300px;" width="728" height="300"></canvas>
			<div id="chardLegend04" class="chartLegend"></div><!-- 커스텀으로 제작된 legend 부분 -->
			<script>
				//data 부분
				var barData = {
						labels: ["2018-02-01", "2018-02-02", "2018-02-03", "2018-02-04", "2018-02-05", "2018-02-06", "2018-02-07"],
					datasets: [{
						label: "10대",
						data: [3, 2, 10, 13, 1, 0, 3],
						backgroundColor: "#3e95cd",
						borderColor : "rgba(49,141,231,1.0)"
					},{
						label: "20대",
						data: [4, 6, 8, 54, 27, 10, 15],
						backgroundColor: "#8e5ea2",
						borderColor : "rgba(76,79,98,0.5)"
					},{
						label: "30대",
						data: [15, 0, 3, 24, 10, 5, 17],
						backgroundColor: "#3cba9f",
						borderColor : "rgba(49,141,231,1.0)"
					},{
						label: "40대",
						data: [2, 13, 0, 37, 5, 10, 30],
						backgroundColor: "#e8c3b9",
						borderColor : "rgba(76,79,98,0.5)"
					},{
						label: "50대",
						data: [30, 27, 22, 13, 11, 23, 13],
						backgroundColor: "#c45850",
						borderColor : "rgba(49,141,231,1.0)"
					},{
						label: "60대이상",
						data: [12, 22, 9, 7, 13, 30, 5],
						backgroundColor: "rgba(76,79,98,0.3)",
						borderColor : "rgba(76,79,98,0.5)"
					}]
				};

				//각종 세부 option부분
				var options = {
					legend: {display: false},
					scales:{
						xAxes: [{
									gridLines: {display:true, color:"rgba(0, 0, 0, 0.1)", drawTicks:false, tickMarkLength:30, zeroLineColor:"rgba(0, 0, 0, 0.3)", lineWidth:1},
									stacked: true,
									ticks: {display:false,},
									
								}],
						yAxes: [{
									gridLines: {display:false, },
									stacked: true,
									categoryPercentage: 0.5,
									ticks: {autoSkip: false,},										
								}]
					},
					
					// 커스텀 툴팁
					tooltips: {
						mode : 'label',
						callbacks: {
							title: function (tooltipItem, data) { 
								var total01 = data.datasets[tooltipItem[0].datasetIndex].data[tooltipItem[0].index];
								var total02 = data.datasets[tooltipItem[1].datasetIndex].data[tooltipItem[1].index];
								var total03 = data.datasets[tooltipItem[2].datasetIndex].data[tooltipItem[2].index];
								var total04 = data.datasets[tooltipItem[3].datasetIndex].data[tooltipItem[3].index];
								var total05 = data.datasets[tooltipItem[4].datasetIndex].data[tooltipItem[4].index];
								var total06 = data.datasets[tooltipItem[5].datasetIndex].data[tooltipItem[5].index];
								return 'Total : ' + (total01 + total02 + total03 + total04 + total05+ total06) + '건 ';
							},
							label: function (tooltipItem, data) {
								var amount = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
								var tt = data.datasets[tooltipItem.datasetIndex].label;
								return tt + ': '+ amount + '건 ';
							}
						},
					},

					// 커스텀 라벨
					legendCallback: function(chart) {
						console.log(chart.data);
						var text = [];
						text.push('<ul>');
						for (var i=0; i<chart.data.datasets.length; i++) {
							text.push('<li>');
							text.push('<span style="background-color:' + chart.data.datasets[i].backgroundColor + '"></span>' + chart.data.datasets[i].label + '');
							text.push('</li>');
						}
						text.push('</ul>');
						return text.join("");
					}
					

				};

				var ctx = document.getElementById("barChart04").getContext("2d");
				var myChart  = new Chart(ctx, {
					type: 'horizontalBar',
					data: barData,
					options: options
				});

				document.getElementById('chardLegend04').innerHTML = myChart.generateLegend();
				
			</script>						
		</div>
	</div>
	
	<div class="g_column w_2_1 mgT20">
		<h3>
			<span class="title">매출분석</span>
			<span class="ex">(결제수단별 매출통계)</span>
		</h3>
		<div class="unitBox chartBox lineChartBox" style="height:340px;">
			<canvas id="lineChart02" style="display: block; width: 728px; height: 300px;" width="728" height="300"></canvas>
			<div id="chardLegend02" class="chartLegend"></div><!-- 커스텀으로 제작된 legend 부분 -->
				
			<script type="text/javascript">
				//data 부분
				var lineData = {
					datasets: [{
						label: "신용카드",
						data: [1, 2, 3, 4, 5, 6, 7],
						backgroundColor: ["#"+((1<<24)*Math.random()|0).toString(16), "#8e5ea2","#3cba9f","#e8c3b9","#c45850","rgba(76,79,98,0.3)","rgba(49,141,231,1.0)"],
						borderColor : "rgba(255, 255, 255, 0.7)"
					}]
				};
				
				//각종 세부 option부분
				var options = {							
					legend: {display: false},
					// 커스텀 툴팁
					tooltips: {
						mode : 'x-axis',
						callbacks: {
							title: function (tooltipItem, data) { 
								return '!!!!!!!!! ';
							},
							label: function (tooltipItem, data) {
								var amount = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
								var tt = data.datasets[tooltipItem.datasetIndex].label;
								return tt + ': '+ comma(amount) + '원 ';
							}
						},
					},

					// 커스텀 라벨
					legendCallback: function(chart) {
						console.log(chart.data);
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
				var myChart  = new Chart(ctx, {
					type: 'pie',
					data: lineData,
					options: options
				});

				document.getElementById('chardLegend02').innerHTML = myChart.generateLegend();//커스텀 legend를 생성함							
			</script>						
		</div>
	</div>
</div>