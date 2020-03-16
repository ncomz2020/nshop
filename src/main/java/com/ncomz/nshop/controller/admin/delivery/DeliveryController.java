package com.ncomz.nshop.controller.admin.delivery;


import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.delivery.DeliveryCode;
import com.ncomz.nshop.domain.admin.delivery.DeliveryInfoMgmt;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.delivery.DeliveryService;
import com.ncomz.nshop.utillty.MessageUtil;

@Controller
@RequestMapping(value = "/admin/delivery")
public class DeliveryController {

   private String thisUrl = "admin/delivery";

   @Autowired
   private DeliveryService deliveryService;
   

   /**
    * 상품정보관리
    * @param model
    * @return
    */
   @RequestMapping(value = "list")
   public String list(HttpServletRequest request, Model model, DeliveryInfoMgmt deliveryInfoMgmt) {
      
      SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
      deliveryInfoMgmt.setStore_id(sessionUser.getStore_id());
      
      String startDate = deliveryService.getStartDate();  // 일주일전
      String endDate = deliveryService.getEndDate();   // 오늘
      
      deliveryInfoMgmt.setStart_date(startDate);
      deliveryInfoMgmt.setEnd_date(endDate);
      
      model.addAttribute("userGrup", sessionUser.getUsr_grp_id());
      model.addAttribute("info", deliveryInfoMgmt);
      model.addAttribute("pagingObject", deliveryInfoMgmt);
      return thisUrl + "/list";
   }
   
   @RequestMapping(value = "listAction", method = RequestMethod.POST )
   public String listAction(Model model, DeliveryInfoMgmt deliveryInfoMgmt, HttpServletRequest request) {
      SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
      deliveryInfoMgmt.setStore_id(sessionUser.getStore_id());
      deliveryInfoMgmt.setDateFormat(MessageUtil.getMessage("label.common.date.pattern"));
      
      model.addAttribute("userGrup", sessionUser.getUsr_grp_id());
      model.addAttribute("pagingObject", deliveryInfoMgmt);
      model.addAttribute("count", deliveryService.getDeliveryCount(deliveryInfoMgmt)); 
      model.addAttribute("list", deliveryService.getDeliveryInfoList(deliveryInfoMgmt)); // TableList
      model.addAttribute("trcknoMessageCount", deliveryService.getDeliveryTracknoMessageCount(deliveryInfoMgmt)); // 송장번호미입력 카운트
      model.addAttribute("deliveryMemoCount", deliveryService.getDeliveryMemoCount(deliveryInfoMgmt)); // 배송메모 카운트
      
      return thisUrl + "/listAction";
   }
   
   /**
   * 배송추적 리스트 조회
   * @param model
   * @param deliveryCode
   * @param request
   * @return
   * @throws Exception
   */
   @RequestMapping(value = "delivery_tracking", method = RequestMethod.POST)
   public String deliveryTracking(Model model, DeliveryCode deliveryCode) throws Exception {

	   model.addAttribute("deliveryInfo", deliveryService.getDeliveryTrackingList(deliveryCode));
   
      return thisUrl + "/delivery_tracking"; 
   }
      
   /**
   * 엑셀 다운로드
   * @param deliveryInfoMgmt
   * @param model
   * @return
   * @throws ParseException
   * @throws UnsupportedEncodingException
   */
   @RequestMapping(value = "exportAction", method = RequestMethod.POST)
   public String exportAction(DeliveryInfoMgmt deliveryInfoMgmt, Model model, HttpServletRequest request) throws ParseException, UnsupportedEncodingException {
       
      SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
      deliveryInfoMgmt.setStore_id(sessionUser.getStore_id());
      
      model.addAttribute("list", deliveryService.listExcel(deliveryInfoMgmt));
      
      return "excelViewer";
   }
         
   
   /**
   * 선택 건 저장
   * @param deliveryInfoMgmt
   * @param model
   * @param request
   * @return
   * @throws ParseException
   * @throws UnsupportedEncodingException
   */
   @RequestMapping(value = "updateAction", method = RequestMethod.POST)
   public String updateAction(@RequestBody ArrayList<DeliveryInfoMgmt> list, Model model) throws ParseException, UnsupportedEncodingException {
              
      model.addAttribute("result", deliveryService.selectedUpadte(list));
      
      return thisUrl + "/listAction";
   }
      
   /**
   * 선택 건 발송 처리
   * @param deliveryInfoMgmt
   * @param model
   * @param request
   * @return
   * @throws ParseException
   * @throws UnsupportedEncodingException
   */
   @RequestMapping(value = "updateShipAction", method = RequestMethod.POST)
   public String updateShipAction(@RequestBody ArrayList<DeliveryInfoMgmt> list, Model model, HttpServletRequest request) throws ParseException, UnsupportedEncodingException {
      model.addAttribute("result", deliveryService.selectedShipCheck(list));
      return thisUrl + "/listAction";
   }
      
    /**
     * 엑셀 업로드  
     * @param file
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "excelUploadInfo", method = RequestMethod.POST)
    public @ResponseBody List<ArrayList<String>> excelUploadAjax(MultipartFile file, Model model ,HttpServletRequest request) throws Exception {
       
        return deliveryService.getExcelUploadInfo(file);
        
    }

}