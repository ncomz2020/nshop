<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<script src="/js/jquery.form.js"></script>
<jsp:useBean id="toDay" class="java.util.Date" />
<script>
   $(document).ready(function(){
      
      objectReset();
      $("#perPage").val(10);
      selectBoxSetting('PERIOD_SELECT', 'period_opt');
      selectBoxSetting('SEARCH', 'search_opt');
      searchList(1);
      
   });
   
   // 발송내역 목록화면 그리기
   function searchList(page, listType) {
   
      if( typeof(listType) == 'number' ) {
         $("#listType").val(listType);
      }else if (typeof(listType) == 'string') {
    	 $("#listType").val(null);
      }
      
      $("#page").val(page);
      
      var param = $('#deliveryListForm').serialize();
      
      console.log(param);
      
      $.ajax({
         url : "listAction.ajax",
         type : "POST",
         data : param,
         success : function(data) {
            $("#listActionDiv").html(data);
            objectCount();
         },
         error : function() {
             swal({
                       title: '<spring:message code="label.common.fail.action"/>',
                        type: "error"
                 });
         }
      }).done(function() {
         if ( typeof(listType) == 'function' ) {
            listType();
            return;
         } 
      });
      
   }
   
   // selectBox option 셋팅
   function selectBoxSetting(grp_cd, selectId) {
      var statusSelectBox = [{
         'codeType' : 'commCode',
         'grp_cd' : grp_cd,
         'selectId' : selectId
      }];

      callAajaxJson(statusSelectBox);
   }
   
   // 날짜 셋팅
	function setPeriod(period){ 
		var reg = new RegExp("m$", "g");
		var monthFlag = reg.test(period);
		var startDate = new Date();
		var endDate = new Date();
		
		if(monthFlag){
			startDate.setMonth(endDate.getMonth() - (period.split('m')[0]));
		}else{
			startDate.setDate(endDate.getDate() - period);
		}
		
		$("#start_date").datepicker("setDate",startDate.toISOString().substring(0, 10));
		$("#start_date").datepicker().val(startDate.toISOString().substring(0, 10));
		
		$("#end_date").datepicker("setDate",endDate.toISOString().substring(0, 10));
		$("#end_date").datepicker().val(endDate.toISOString().substring(0, 10));
	}
   
   // form 조건 초기화
   function objectReset() {
      
      $("form").each(function(){
          this.reset();
      });
      
   }
   
   
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
   <div class="g_column w_1_1">
      <form id="deliveryListForm" name="deliveryListForm">
         <input type="hidden" id="page" name="page">
         <input type="hidden" id="perPage" name="perPage">
         <input type="hidden" id="listType" name="listType">
         <div class="unitBox searchBox">
            <table>
               <colgroup>
                  <col style="width: 12%;" />
                  <col style="width: 15%;" />
                  <col style="width: 8%;" />
                  <col style="width: 25%;" />
               </colgroup>
               <tbody>
                  <tr>
                     <th class="center" style="font-size:15px; color:#555555;"><spring:message code="label.delivery.trcknoMessage"/></th>
                     <th class="center" style="font-size:15px; color:#555555;"><spring:message code="label.delivery.memo"/></th>
                     <th><spring:message code="label.delivery.period"/></th>
                     <td colspan="3">
                        <span>
                           <select id="period_opt" name="period_opt" style="width: 97px">
                           </select>
                           &nbsp;&nbsp;                        
                           <a href="javascript:setPeriod(7);"><button type="button" class="amb_btnstyle gray middle">1주일</button></a>
                           <a href="javascript:setPeriod('1m');"><button type="button" class="amb_btnstyle gray middle">1개월</button></a>
                           <a href="javascript:setPeriod('6m');"><button type="button" class="amb_btnstyle gray middle">6개월</button></a>
                           <a href="javascript:setPeriod('12m');"><button type="button" class="amb_btnstyle gray middle">12개월</button></a>
                        </span>
                     </td>
                  </tr>
                  <tr>                     
                     <td rowspan='2' class="center">
                        <a href="javascript:searchList(1,1);">
                           <span><i class="ambicon-037_alert_line" style="font-size:50px"></i></span>
                        </a>
                     </td>
                     <td rowspan='2' class="center">
                        <a href="javascript:searchList(1,2);">
                           <span><i class="ambicon-034_pencel" style="font-size:50px"></i></span>
                        </a>
                     </td>
                     <th>&nbsp</th>
                     <td>
                        <span class="datepickerRange"> 
                        <input type="text" id="start_date" name="start_date" class="inp datepicker startDate" readonly="readonly" value="${info.start_date}" style="width: 120px;" placeholder="date" />
                        ~
                        <input type="text" id="end_date" name="end_date" class="inp datepicker endDate" readonly="readonly" value="${info.end_date}" style="width: 120px;" placeholder="date" />
                        </span>
                     </td>
                  </tr>
                  <tr>
                     <th><spring:message code="label.delivery.order.stat"/></th>
                     <td colspan="3">
                        <select id="order_opt" name="order_opt" style="width: 97px">
                           <option value=""><spring:message code="label.file.search.file.type.all"/></option>
                           <option value=<spring:message code="label.delivery.order.stat.ready"/>><spring:message code="label.delivery.order.stat.ready"/></option>
                           <option value=<spring:message code="label.delivery.order.stat.shipped"/>><spring:message code="label.delivery.order.stat.shipped"/></option>
                           <option value=<spring:message code="label.delivery.order.stat.delivered"/>><spring:message code="label.delivery.order.stat.delivered"/></option>
                           <option value=<spring:message code="label.order.status.purchaseComplete"/>><spring:message code="label.order.status.purchaseComplete"/></option>
                           <option value=<spring:message code="label.delivery.order.stat.cancel"/>><spring:message code="label.delivery.order.stat.cancel"/></option>
                           <option value=<spring:message code="label.delivery.order.stat.canceled"/>><spring:message code="label.delivery.order.stat.canceled"/></option>
                           <option value=<spring:message code="label.delivery.order.stat.exchange"/>><spring:message code="label.delivery.order.stat.exchange"/></option>
                           <option value=<spring:message code="label.delivery.order.stat.exchange_ready"/>><spring:message code="label.delivery.order.stat.exchange_ready"/></option>
                           <option value=<spring:message code="label.delivery.order.stat.in_exchange"/>><spring:message code="label.delivery.order.stat.in_exchange"/></option>
                           <option value=<spring:message code="label.delivery.order.stat.exchanged"/>><spring:message code="label.delivery.order.stat.exchanged"/></option>
                        </select>
                     </td>
                  </tr>
                  <tr>
                     <td class="center" style="font-size:30px; color:#555555;" id="trcknoMessageCount"></td>
                     <td class="center" style="font-size:30px; color:#555555;" id="deliveryMemoCount"></td>
                     <th><spring:message code="label.common.search"/></th>
                     <td colspan="3">
                        <select id="search_opt" name="search_opt">
                        </select>
                        &nbsp;&nbsp;
                        <input type="text" id="search_txt" name="search_txt" class="inp" style="width: 63%;" placeholder='<spring:message code="label.product.prod.input.search"/>' />
                     </td>
                     <td class="left">
                        <span class="searchFormBtn">
                           <a href="javascript:searchList(1,'#');" class="amb_btnstyle black middle" style="margin-right:30px"><spring:message code="label.common.search"/></a>
                        </span>
                     </td>
                  </tr>
               </tbody>
            </table>
         </div>
      </form>
   </div>
</div>
<div id="listActionDiv" class="nh_conBox"></div>