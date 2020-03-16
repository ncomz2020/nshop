<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
   $(document).ready(function() {
	  $("#perpage_opt").val($("#perPage").val());
	  $('#perpage_opt').val($('#perPage').val()); 
	   
      $('#checkboxListAll').click(function() {
         var checkedStatus = this.checked;
         $('input[name="checkboxList"]').each(function() {
            $(this).prop('checked', checkedStatus);
         });
      });
      
   });
   
   // 엑셀 다운로드
   function goExcel() {
      var param = $('#deliveryListForm').serialize();
      $.download('exportAction.ajax', param, 'post');
   }
   
   // 배송추적
   function delivery_tracking(invoice){
         
      var url = "delivery_tracking.ajax";
         
      var param = {};
      param.t_code = "04";
      param.t_invoice = invoice;
               
      openModal(url, 'delivery_tracking' ,param , '900');
               
   }
   
   // 엑셀 업로드
   function excelUpload() {
        
        var key = "#"+key;
        
        if ($("#nshopFileDiv").length > 0) {
           $("#nshopFileDiv").remove();
        }
        
        var sHtml = "";
        sHtml += "<div id=\"nshopFileDiv\" style=\"display:none;\">";
        sHtml += "<form id=\"nshopFileForm\" name=\"nshopFileForm\" action=\"excelUploadInfo.ajax\" method=\"post\" enctype=\"multipart/form-data\">";
        sHtml += "<input type=\"file\" id=\"nshopFile\" name=\"file\">";
        sHtml += "</form>";
        sHtml += "</div>";
        $("body").append(sHtml);
   
        $("#nshopFile").change(function() {
           
           var fileName = $(this).val();
           var fileExt = getFileExt($(this).val()).toUpperCase();
           
           if (fileExt != "XLSX" && fileExt != "XLS" ) {
                 swal({
                    title: '<spring:message code="label.delivery.excel"/>',
                     type: "error"
                 });
              return;
           }
           
           $("#nshopFileForm").ajaxForm({
              success : function(responseText, statusText) {
                 if (!isEmpty(responseText ) && statusText == "success") {
                	 for(var i = 0; i < responseText.length; i++ ) {
	                	  var arrayValue = responseText[i]
		                  $("#listActionDiv input[id ^= 'prod_order_seq']").each(function( index ){
		                	  if(arrayValue[0] == $(this).val()) {
		                		  $(this).parent().nextAll("#waybil_no").find("input[id^='waybil_no']").val(arrayValue[1]);
		                	  }else {
		                		  return true;
		                	  }
		                  })
	                  }
                 } else {
                    swal({
                       title: responseText,
                        type: "error"
                    });
                 }
              },
           }).submit();
        });
   
        $("#nshopFile").trigger("click");
   }
   
   // Perpage SelectBox 변할때마다 실행
   $("#perpage_opt").change(function(){
      
      var $thisVal = $(this).val();
      $("#perPage").val($thisVal);
      
      searchList(1, function() {
         $("#perpage_opt").val( $thisVal );
      });
      
   })
   
   // 선택 건 저장
  function selectedSaveAction() {
    
    if ($("input[name=checkboxList]:checkbox:checked").length < 1) {
      swal({
            title: '<spring:message code="label.delivery.valid.check.state"/>'
        });     
      return;
    }   

    swal({
          title: '<spring:message code="label.delivery.valid.selected.save"/>',
          type: "warning",
          showCancelButton: true,
          confirmButtonText: "YES",
          cancelButtonText: "NO",
          closeOnConfirm: false
           },function() {            
    
      // checked array
      var checked_arr = [];
      
      // checkbox 아이디(ex:check_1)로 번호를 얻어내기 위한 변수
      var getSeq = 0;
      
      $("input[name=checkboxList]").each(function(){
        var checkedStatus = this.checked;
        if(checkedStatus) {
          
          var row_json = new Object();
          getSeq = $(this).attr("id").substr(6);  
          row_json["prod_order_no"] = $("#check_" + getSeq).val();
          row_json["prod_order_seq"] = $("#prod_order_seq_" + getSeq).val();
          row_json["order_seq"] = $("#order_seq_" + getSeq).val();
          row_json["base_addr"] = $("#base_addr_" + getSeq).val();
          row_json["dtl_addr"] = $("#dtl_addr_" + getSeq).val();
          row_json["zip_cd"] = $("#zip_cd_" + getSeq).val();
          row_json["waybil_no"] = $("#waybil_no_" + getSeq).val();
          row_json["echn_waybil_no"] = $("#echn_waybil_no_" + getSeq).val();
          row_json["dtl_cd"] = $("#dtl_cd_" + getSeq).val();
          checked_arr.push(row_json);
        }
      });
      
      $.ajax({
      url : "updateAction.ajax",
      contentType:'application/json',
      type : "POST",
      data : JSON.stringify(checked_arr),
      dataType : "json",
      success : function(data) {
        var result = data.result;
        if (result == "succ") {
          swal({
                title: '<spring:message code="label.delivery.valid.selected.save.success"/>',
                type: "success",
                confirmButtonText: "CLOSE" },function() {
                refreshList();
          });
        } else {
          swal({
                title: '<spring:message code="label.delivery.valid.modifyFail"/>'
            });
        }
      },
      error : function() {
        swal({
              title: '<spring:message code="label.common.fail.action"/>'
          });
      }
      });
    }
  )}
   
   // 선택 건 발송처리
   function selectedShipAction() {
      
      if ($("input[name=checkboxList]:checkbox:checked").length < 1) {
         swal({
              title: '<spring:message code="label.delivery.valid.check.state"/>'
          });         
         return;
      }      

      swal({
           title: '<spring:message code="label.delivery.valid.selected.shipSave"/>',
           type: "warning",
           showCancelButton: true,
           confirmButtonText: "YES",
           cancelButtonText: "NO",
           closeOnConfirm: false
            },function() {               
      
         // checked array
         var checked_arr = [];
         
         // checkbox 아이디(ex:check_1)로 번호를 얻어내기 위한 변수
         var getSeq = 0;
         
         $("input[name=checkboxList]").each(function(){
            var checkedStatus = this.checked;
            if(checkedStatus) {
               // row의 데이터 (삼품주문번호, order_seq, 주소, 상세주소, 우편번호)
               var row_json = new Object();
               
               getSeq = $(this).attr("id").substr(6);   
               row_json["prod_order_no"] = $("#check_" + getSeq).val();
               row_json["prod_order_seq"] = $("#prod_order_seq_" + getSeq).val();
               row_json["waybil_no"] = $("#waybil_no_" + getSeq).val();
               row_json["echn_waybil_no"] = $("#echn_waybil_no_" + getSeq).val();
               row_json["dtl_cd"] = $("#dtl_cd_" + getSeq).val();
               row_json["waybil_no"] = $("#waybil_no_" + getSeq).val();
               checked_arr.push(row_json);
            }
         });
         
         $.ajax({
         url : "updateShipAction.ajax",
         contentType:'application/json',
         type : "POST",
         data : JSON.stringify(checked_arr),
         dataType : "json",
         success : function(data) {
            var result = data.result;
            if (result == "succ") {
               swal({
                    title: '<spring:message code="label.delivery.valid.selected.shipSave.success"/>',
                    type: "success",
                     confirmButtonText: "CLOSE" },function() {
                     refreshList();
               });
            } else {
               swal({
                  title: '<spring:message code="label.delivery.valid.selected.shipSave.chkWaybilState"/>'                    
                });
            }
         },
         error : function() {
            swal({
                 title: '<spring:message code="label.common.fail.action"/>'
             });
         }
         });
      });
      
   }
   
   function objectCount() {
      $("#trcknoMessageCount").html('${trcknoMessageCount}'); // refresh 후 송장번호미입력 카운트
      $("#deliveryMemoCount").html('${deliveryMemoCount}'); // refresh 후 배송메모 카운트
   };
   
   
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
   <div class="g_column w_1_1">
      <h3>
         <span class="title"><spring:message code="label.delivery.list"/></span>
         <div class="fr btnArea middle">
            <select id="perpage_opt" name="perpage_opt">
               <option value="10">10개씩 보기 </option>
               <option value="50">50개씩 보기 </option>
               <option value="100">100개씩 보기 </option>
            </select>            
            <a href="javascript:goExcel();" class="amb_btnstyle white middle"><spring:message code="label.common.export.excel"/></a>
            <c:if test="${userGrup eq 2}">
               <a href="javascript:excelUpload();" class="amb_btnstyle white middle"><spring:message code="label.common.import.excel"/></a>
               <a href="javascript:selectedSaveAction();" class="amb_btnstyle white middle"><spring:message code="label.delivery.selected_save"/></a>
               <a href="javascript:selectedShipAction();" class="amb_btnstyle white middle"><spring:message code="label.delivery.selected_send"/></a>
            </c:if>
         </div>
      </h3>
      <div class="unitBox" style="">
         <table class="amb_table">
            <colgroup>
               <col style="width: 2.5%" />
               <col style="width: 8%" />
               <col style="width: 8.5%" />
               <col style="width: 8%" />
               <col style="width: 8%" />
               <col style="width: 8%" />
               <col style="width: 7%" />
               <col style="width: 8%" />
               <col style="width: 8%" />
               <col style="width: 9%" />
               <col style="width: 8%" />
               <col style="width: 8%" />
               <col style="width: 8%" />
            </colgroup>
            <thead>
               <tr>
                  <th class="center"><input type="checkbox" id="checkboxListAll" name="checkboxListAll"><label for="checkboxListAll" class="inp_func"></th>
                  <th class="center"><spring:message code="label.delivery.search.product_order_number"/></th>
                  <th class="center"><spring:message code="label.product.prod.name"/></th>
                  <th class="center"><spring:message code="label.delivery.search.buyer"/></th>
                  <th class="center"><spring:message code="label.common.addr"/></th>
                  <th class="center"><spring:message code="label.common.addr.detail"/></th>
                  <th class="center"><spring:message code="label.common.postno"/></th>
                  <th class="center"><spring:message code="label.member.join.mobileno"/></th>
                  <th class="center"><spring:message code="label.delivery.memo"/></th>
                  <th class="center"><spring:message code="label.delivery.trackno"/></th>
                  <th class="center"><spring:message code="label.delivery.track_order"/></th>
                  <th class="center"><spring:message code="label.delivery.period.shipdate"/></th>
                  <th class="center"><spring:message code="label.delivery.order.stat"/></th>
               </tr>
            </thead>
            <tbody>
               <c:forEach items="${list}" var="info" varStatus="status">
                  <tr>
                     <td>
                        <input type="checkbox" id="check_${info.rownum}" name="checkboxList" value="${info.prod_order_no}">
                        <label for="check_${info.rownum}" class="inp_func">
                     </td>
                     <td>
                        <a href="javascript:movePage('/admin/order/orderList/detail.ajax', {order_seq: '${info.order_seq}',pageType:'orderList'});">${info.prod_order_no}</a>
                        <input type="hidden" id="prod_order_seq_${info.rownum}" value="${info.prod_order_seq}">
                        <input type="hidden" id="order_seq_${info.rownum}" value="${info.order_seq}">
                        <br/>(${info.ordr_create_datetime})
                     </td>
                     <td class="ellipsis" data-toggle="tooltip" title="${info.prod_name}">
                        <a href="javascript:openModal('/admin/product/detailPopup.ajax' , 'productDetailPopup' , 'prod_id=${info.prod_id}' , '900');">${info.prod_name}</a>                         
                     </td>
                     <td>
                        ${info.user_id}
                        <br/>(${info.user_nm})
                     </td>
                     <td class="ellipsis" data-toggle="tooltip" title="${info.base_addr}">${info.base_addr}</td>
                     <td class="ellipsis" data-toggle="tooltip" title="${info.dtl_addr}">${info.dtl_addr}</td>
                     <td>${info.zip_cd}</td>
                     <td>${info.mobile_no}</td>
                     <td>${info.store_id_memo}</td>
                     <c:if test="${userGrup eq 2}">
                        <td id="waybil_no"><input type="text" id="waybil_no_${info.rownum}" value="${info.waybil_no}" class="inp">
                        <c:if test="${info.dtl_cd eq '210' || info.dtl_cd eq '220' || info.dtl_cd eq '230' || info.dtl_cd eq '240' || info.dtl_cd eq '250'}">
                           <br><br><input type="text" id="echn_waybil_no_${info.rownum}" value="${info.echn_waybil_no}" class="inp" >
                        </c:if>  
                        </td>
                     </c:if>
                     <c:if test="${userGrup eq 1}">
                        <td>${info.waybil_no}
                        <c:if test="${info.dtl_cd eq '210' || info.dtl_cd eq '220' || info.dtl_cd eq '230' || info.dtl_cd eq '240' || info.dtl_cd eq '250'}">
                           <br><br>${info.echn_waybil_no}
                        </c:if>  
                        </td>
                     </c:if>                     
                     <td><a href="javascript:delivery_tracking('${info.waybil_no}')" class="amb_btnstyle green middle">배송조회</a>
                     <c:if test="${info.dtl_cd eq '210' || info.dtl_cd eq '220' || info.dtl_cd eq '230' || info.dtl_cd eq '240' || info.dtl_cd eq '250'}">
                        <br><br><a href="javascript:delivery_tracking('${info.echn_waybil_no}')" class="amb_btnstyle green middle">배송조회</a>
                     </c:if>  
                     </td>
                     <td>${info.dlvy_update_datetime}</td>
                     <td>
                        ${info.dtl_nm}
                        <input type="hidden" id="dtl_cd_${info.rownum}" value="${info.dtl_cd}"/>
                     </td>                     
                  </tr>
               </c:forEach>
               <c:if test="${empty list}">
                  <tr>
                     <td colspan="13"><spring:message code="label.common.empty.list"/></td>
                  </tr>
               </c:if>
            </tbody>
         </table>
      </div>
      <div class="paging center">
         <ul class="paginglist">
            <jsp:include page="/WEB-INF/views/include/paging.jsp" />
         </ul>
      </div>
   </div>
</div>
<!-- rowBox 반복단위 -->