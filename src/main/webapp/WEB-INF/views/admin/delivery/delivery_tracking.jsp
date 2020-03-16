<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
   <div class="modal-content">
      <!-- style="width:1000px;" 는 최대 1000px를 넘지 말아야 합니다. 1000px을 넘어도 css에 최대 1000px로 처리 되어있습니다. -->
      <h1 class="popupHeader">
         <span class="usr_grp_nm"><spring:message code="label.delivery.tracking"/></span>
         <a href="javascript:;" class="close" onClick="javascript:closeModal(this);">
            <i class="ambicon-015_mark_times"></i>
         </a>
      </h1>
   
      <div id="content" class="content">
         <div class="rowBox" style="margin-top:0px !important">
            <div class="g_column w_1_1">
               <div class="unitBox" style="margin-bottom:20px !important">
                  <table>
                     <tbody>
                        <tr>
                           <th style="width:80px !important"><spring:message code="label.delivery.invoice"/></th>
                           <td>${deliveryInfo.invoiceNo}</td>
                        </tr>
                        <tr>
                           <th><spring:message code="label.delivery.recipient"/></th>
                           <td>${deliveryInfo.recipient}</td>
                        </tr>
                        <tr>
                           <th><spring:message code="label.delivery.senderName"/></th>
                           <td>${deliveryInfo.senderName}</td>
                        </tr>
                        <tr>
                           <th><spring:message code="label.delivery.receiverAddr"/></th>
                           <td>${deliveryInfo.receiverAddr}</td>
                        </tr>
                     </tbody>
                  </table>
               </div>
            </div>
         </div>
         
         
         <div class="rowBox">
            <div class="g_column w_1_1">
               <div class="unitBox" style="">
                  <table class="amb_table" >   
                     <colgroup>
                        <col style="width:40%" />
                        <col style="width:30%" />
                        <col style="width:30%" />
                     </colgroup>               
                     <thead>
                        <tr>
                           <th class="center"><spring:message code="label.delivery.time"/></th>
                           <th class="center"><spring:message code="label.delivery.where"/></th>
                           <th class="center"><spring:message code="label.delivery.kind"/></th>
                        </tr>
                     </thead>
                     <tbody>
                        
                        <c:forEach items="${deliveryInfo.deliveryInfoDetail}" var="deliveryList" varStatus="status">
                           <tr>
                              <td>${deliveryList.time}</td>
                              <td>${deliveryList.where}</td>
                              <td>${deliveryList.kind}</td>
                           </tr>
                        </c:forEach>
                        <c:if test="${empty deliveryInfo.deliveryInfoDetail}">
                           <tr>
                              <td colspan="3"><spring:message code="label.common.empty.list"/></td>
                           </tr>
                        </c:if>
                        
                     </tbody>
                  </table>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>