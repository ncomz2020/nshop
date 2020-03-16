/******** viewport 분기 /********/
$(document).ready(function() {	
	(function(doc) {
        var viewport = document.getElementById('viewport');
        if ( navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPod/i) || navigator.userAgent.match(/Android/i) )  {
            viewport.setAttribute("content", "user-scalable=yes");
        } else if ( navigator.userAgent.match(/iPad/i) ) {
            viewport.setAttribute("content", "user-scalable=yes");
        } else {
            viewport.setAttribute("content", "user-scalable=yes");
        } 
    }(document));
});


/********  *******/


/******** GNB 클릭  *******/
function gnbClick() {
	$(document).on("click", "#nav li", function(){ 
		$(this).siblings('li').removeClass('active');
		$(this).addClass('active');
		
		// 자신의 텍스트를 snb title에 넣어줌
		var _thisText = $(this).find('a>span').text();
		var _lnb = $('#nav_aside');
		var _lnbTitle = _lnb.find('h2');
		_lnbTitle.text(_thisText);

		//자신의 data-num을 확인하고
		//snb의 동일한 data-num를 보여줌		
		var _thisNum = $(this).find('>a').attr('data-num');
		$(".depth_2[data-num='" + _thisNum + "']").slideDown(250).siblings('.depth_2').slideUp(150);
		

	});	
}

/******** Snb(Lnb) 펼침 숨김 *******/
function snbShowHide() {
	//$(document).on("click", "#nav_aside .asideSlider", function(event){
	$(document).on("click", "#header .subMenuIcon", function(event){
		event.stopImmediatePropagation();
		snbAniAction();

		if ($('#nav_aside').hasClass('open')) {
			$(this).removeClass('open');
			$(this).addClass('close');
		} else if ($('#nav_aside').hasClass('close')) {
			$(this).removeClass('close');
			$(this).addClass('open');
		}
	});	
}
function snbAniAction() {
	var lnb = $('#nav_aside');
	var w = $('#nav_aside').outerWidth(true);
	if (lnb.hasClass('open')) {
		lnb.removeClass('open');
		lnb.addClass('close');
		$('#nav_aside').animate({left: -w}, 200);
		$('#nav_aside').next('#content').animate({ marginLeft: '0px'}, 200);
		return false;
	} else if (lnb.hasClass('close')) {
		lnb.removeClass('close');
		lnb.addClass('open');
		$('#nav_aside').animate({left: '0px'}, 200);
		$('#nav_aside').next('#content').animate({ marginLeft: w}, 200);
		return false;
	}
}



/******** Snb(Lnb) Depth 펼침 숨김 *******/
function snbDepthShowHide() {
	$(document).on("click", "#nav_aside .depth_2 li>a", function(){		
		//$(this).next('ul').toggle();
		$('#nav_aside  .depth_2 li.subDepth').removeClass('open');
		var _parent = $(this).parent('li');
		_parent.toggleClass('open');
				
	});
	$('ul.depth_2 li:has(ul)').addClass('subDepth'); //하위 메뉴가 있으면 class명 subDepth를 추가하여 아이콘 및 펼침 숨김 처리 
	$('ul.depth_2 li.active').addClass('open');
}



/******** location의 텍스트를 이용한  gnb , lnb active 설정 ********/
// location의 텍스트와 GNB / LNB의 텍스틑  비교하여 필요한 GNB/LNB에 active 클래스를 추가하는 스크립트이므로
// 반드시 location의 텍스트와 GNB /LNB 의 텍스틑는 띄워쓰기까지 일치해야합니다.

// 해당 템플릿은 GNB가 없으므로 Gnb관련 항목은 삭제하고 curLocation 비교 구문 부분을 수정합니다.
var currentMenu = function(){
	var curLocation_1 = $(".location").find("a").eq(1).text().replace(/\s/g, ""),
		curLocation_2 = $(".location").find("a").eq(2).text().replace(/\s/g, ""),
		curLocation_3 = $(".location").find("a").eq(3).text().replace(/\s/g, ""),
		curLocation_4 = $(".location").find("a").eq(4).text().replace(/\s/g, ""),
		
		gnb = $("#nav"),
		gnbMenu = gnb.find("ul>li"),

		lnb = $(".depth_2"),
		lnbMenu_2 = lnb.find(">li"),
		lnbMenu_3 = lnb.find(">li>ul>li");
		lnbMenu_4 = lnb.find(">li>ul>li>ul>li");

	/**/
	gnbMenu.each(function(){
		var _this = $(this),
			menuStr = _this.find(">a>span").text().replace(/\s/g, "");
		if(menuStr == curLocation_1){
			_this.addClass("active");

			//자신의 텍스트를 h2에 넣기
			var _lnbTitle = $('#nav_aside h2');
			_lnbTitle.text(menuStr);
		}
	});
	
	
	lnbMenu_2.each(function(){
		var _this = $(this),
			menuStr = _this.find(">a>span").text().replace(/\s/g, "");
		if(menuStr == curLocation_2){
			_this.addClass("active");
			if (_this.hasClass('subDepth')){
				_this.addClass("open");
			}
		}
	});

	lnbMenu_3.each(function(){
		var _this = $(this),
			menuStr = _this.find(">a>span").text().replace(/\s/g, "");
		if(menuStr == curLocation_3){
			_this.addClass("active");
			if (_this.hasClass('subDepth')){
				_this.addClass("open");
			}
		}
	});
	lnbMenu_4.each(function(){
		var _this = $(this),
			menuStr = _this.find(">a>span").text().replace(/\s/g, "");
		if(menuStr == curLocation_4){
			_this.addClass("active");
			if (_this.hasClass('subDepth')){
				_this.addClass("open");
			}
		}
	});

	//active가 있는놈을 찾아 오픈함
	lnb.hide();
	lnb.find('>li.active').parent('ul').show();
};


/******** 스크롤시 header가 따라다니게 *******/
function headerScroller() {

	var currentScrollTop = 0;
	
	window.onload = function() {                   // 비동기식 jQuery이므로 window load 후 jQuery를 실행해야 함		
		scrollController();                        // 새로고침 했을 경우를 대비한 메소드 실행

		$(window).on('scroll', function() {        // 스크롤을 하는 경우에만 실행됨
			scrollController();
		});
	}
	
	function scrollController() {                   // top 메뉴의 위치를 제어하는 함수
		currentHeadHeight = $('#header').height();
		currentScrollTop = $(window).scrollTop();
		if (currentScrollTop < currentHeadHeight) {
			$('#header').removeClass('fixed');
		} else if(currentScrollTop > currentHeadHeight) {
			$('#header').addClass('fixed');
		}
	}
}


/******** table sortable,  table thead fixed 스크립트 *******/
function tableSortableNtheadFixed() {
	$('table.tableSortable, table.theadFix').each(function() {
		
		var curTable = $(this);
		var curTableHeight = curTable.attr('data-role-height');

		//table 자신을 감싸는 div tableWrapBox 생성 및 table 의  data-role-height를 가져와 div tableWrapBox에 height를 넣어줌
		function tableWrapBoxMake(){
			curTable.wrapAll('<div class="tableWrapBox" />');
			curTable.parent('.tableWrapBox').css({'height' : curTableHeight });
		}

		// 제이쿼리 플러그인 TableSorter2.0 (jquery.tablesorter.js, jquery.tablesorter.widgets.js)을 이용한 tablesorter 생성
		function tableSorterMake(){
			curTable.tablesorter({
				widthFixed : false,
				widgets: ['stickyHeaders'],
				widgetOptions: {
					stickyHeaders_attachTo : curTableSorterBox
				}
			});	
		}		

		//table 자신을 복사하여 tbody는 제거하고 table 자신 다음에 div tableTheadWarpBox를 생성하고 여기에 복사해 넣음
		function tableTheadFixed(){
			var curTableClone = curTable.clone();
			tableWrapBoxMake();

			curTable.after("<div class='tableTheadWarpBox'></div>");
			curTableClone.removeClass('theadFix').find('tbody, tfoot').remove();
			curTable.next('.tableTheadWarpBox').html(curTableClone);

			curTable.parent('.tableWrapBox').on('scroll', function() {
				var e =  $(this);
				var curHeight = e.scrollTop();
				e.find('.tableTheadWarpBox').css('top' , curHeight);
			});
		}
		
		// table이 sortable 과 thead Fixed가 함께 필요한 경우
		if (curTable.hasClass('theadFix') && curTable.hasClass('tableSortable') ){
			if (curTable.hasClass('theadFixEnd')){//중복으로 작업이 일어나지 않게 가상의 class theadFixEnd 존재 확인			
				tableSorterMake(); //tablesorter 생성
			} else {
				curTable.addClass('theadFixEnd');//중복으로 작업이 일어나지 않게 가상의 class theadFixEnd 추가
				tableWrapBoxMake();
				var curTableSorterBox = curTable.parent('.tableWrapBox');
				tableSorterMake(); //tablesorter 생성
			}

		// table이 sortable만 필요한 경우
		} else if (curTable.hasClass('tableSortable')) {
			curTable.tablesorter({
				widthFixed : false
			});		
		
		// table이 thead Fixed만 필요한 경우
		} else if (curTable.hasClass('theadFix')) {
			if (curTable.hasClass('theadFixEnd')){//중복으로 작업이 일어나지 않게 가상의 class theadFixEnd 존재 확인
			} else {
				curTable.addClass('theadFixEnd');//중복으로 작업이 일어나지 않게 가상의 class theadFixEnd 추가
				tableTheadFixed();
			}
		}
		
	});
}

/******** input number Spinner *******/
function inputSpinner() {
	$('input.spinner').each(function() {
		
		var attr_disable = $(this).prop("disabled");
		var thisWidth = $(this).width();
        
		if ($(this).hasClass('noSpinner'))
		{
			$(this).removeClass('spinner');
			return false;
		} 
		else 
		{
			
			if (attr_disable == true) {
				$(this).spinner({ disabled: true });
			} else {
				$(this).spinner({
					change: function(event,ui){
						$(this).attr("value",$(this).val());
					}
				});
			}

			//만약 spinner로 만들어질 input에 인라인 스타일로 width가 있을시는 해당 width를 가져와서 spinner를 감싸는 span에 width를 넣어줌
			
			var spinnerInputStyle = $(this).prop('style');
			for (var i = 0; i < spinnerInputStyle.length; i++) {
				var style_name = spinnerInputStyle[i];
				var style_value = spinnerInputStyle[style_name];
			  
				if (style_name == 'width') {
					var thisSpinnerBox = $(this).parent('span.ui-spinner');
					thisSpinnerBox.css('width',style_value);
				}
			}
		}		
	});
}

/******** html5의 input type date및 month 속성을 jq datepicker로 바꾸기 워한 type속성 변경 스크립트 *******/
function html5DateMonthTypeChange() {
	$('input[type=date]').each(function() {
		$(this).attr('type','text').addClass('datepicker').attr("readonly",true);
	});
}

/******** dateMonthPicker 스크립트 *******/
function datePicker() {
	//$('#ui-datepicker-div').remove();
	$( "input.datepicker" ).attr("readonly",true).next('span.inline').remove();	

	//multi From Date Minimum To Date Maximum setting// class를 이용한 방법 multi setting 때문 id로 작업시 중복 id는 구현되지 않음
	// From Date Minimum setting		
	$( ".datepicker.startDate" ).datepicker({
		onClose: function( selectedDate ) {
			$( ".endDate" ).datepicker( "option", "minDate", selectedDate );
		}
	});
		
	// To Date Maximum setting
	$( ".datepicker.endDate" ).datepicker({
	});
	
	// Minimum Maximum not setting 인 경우
	$( ".datepicker" ).datepicker({
	});

}

/******** 일반 table tr 클릭시 해당 tr부분을 활성화표시하는 스크립트 *******/
function trActive() {
	$(document).on("click", "table.amb_table.trActive tbody tr", function(){
		$(this).addClass('trActived').siblings().addClass('trNoActived').removeClass('trActived');
	});
	$(document).on("click", "table.amb_table.trActive tfoot", function(){
		$(this).parent('table.trActive').find('tr').removeClass('trActived , trNoActived');
	});
}

/* 첨부파일 input value */
function addFile(){
	var fileTarget = $('.inputFileBox input[type=file].upload_hidden');

	fileTarget.on('change', function(){  // 값이 변경되면
		if(window.FileReader){  // modern browser
		var filename = $(this)[0].files[0].name;
		} 
		else {  // old IE
		var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
		}
		// 추출한 파일명 삽입
		$(this).siblings('.upload_name').val(filename);
	});
}
/* /첨부파일 input value */


/******** new 윈도우 팝업 스크립트 *******/
function openWindow(url, width, height, winPopupId) {
	var NewW = '';
	var NewH = '';
	var sw = screen.width;
	var sh = screen.height;	

	if(width == 'full'){
		var NewW = screen.availWidth;
		var left = 0;
	}else{
		NewW = width;
		var left = (sw/2)-(NewW/2);
		var top = (sh/2)-(NewH/2);
	}

	if(height == 'full'){
		var NewH = screen.availHeight;
		var top = 0;
	}else{
		NewH = height;
		var left = (sw/2)-(NewW/2);
		var top = (sh/2)-(NewH/2);
	}
	
	var windowName = winPopupId;
	var windowFeatures = 'height=' + NewH +
						 ',width=' + NewW +
						 ',top=' + top +
						 ',left=' + left +
						 ',status=no, toolbar=no, location=no, menubar=no, directoryies=no, resizable=yes, scrollbars=yes, titlebar=no';

	var popup = window.open(url, windowName, windowFeatures);

	$(popup).on('load', function() {
		// 속성 찾기
		var findClass = $(popup.document).find(".amb_layerpopup");

		// style 속성 지우기
		findClass.removeAttr('style');
		findClass.addClass("amb_winpopup");		
		findClass.find('h1.popupHeader > .close').remove();
	});
}


$(document).one('ready',function(event){  
	event.stopPropagation();
	
	headerScroller();
	gnbClick();
	snbShowHide();
	snbDepthShowHide();	
	tableSortableNtheadFixed()
	html5DateMonthTypeChange();
	datePicker();
	inputSpinner();
	trActive();
	currentMenu();

	addFile();   //첨부파일 관련
	
});
