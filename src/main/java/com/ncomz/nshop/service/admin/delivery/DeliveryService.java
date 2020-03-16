package com.ncomz.nshop.service.admin.delivery;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellReference;
import org.apache.poi.util.SystemOutLogger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nshop.dao.admin.delivery.DeliveryMapper;
import com.ncomz.nshop.domain.admin.delivery.DeliveryCode;
import com.ncomz.nshop.domain.admin.delivery.DeliveryInfo;
import com.ncomz.nshop.domain.admin.delivery.DeliveryInfoDetail;
import com.ncomz.nshop.domain.admin.delivery.DeliveryInfoMgmt;
import com.ncomz.nshop.utillty.MessageUtil;


@Service
public class DeliveryService {

   @Autowired
   private DeliveryMapper deliveryMapper;
   
    private String url_address = "http://info.sweettracker.co.kr/api/v1/trackingInfo?";

   /**
    * 배송목록 리스트 조회
    * @param deliveryInfoMgmt
    * @return
    */
   public List<DeliveryInfoMgmt> getDeliveryInfoList(DeliveryInfoMgmt deliveryInfoMgmt) {
      Locale locale = LocaleContextHolder.getLocale();
      String language = locale.getLanguage();
      deliveryInfoMgmt.setLanguage(language);
      
      // 송장번호 미입력 & 배송메모
      if(deliveryInfoMgmt.getListType().equals("1") || deliveryInfoMgmt.getListType().equals("2") ) {
    	  deliveryInfoMgmt.setPeriod_opt(null);
          deliveryInfoMgmt.setOrder_opt(null);
          deliveryInfoMgmt.setSearch_opt(null);
          deliveryInfoMgmt.setStart_date(this.getStartDate());
          deliveryInfoMgmt.setEnd_date(this.getEndDate());
      }
      
      return deliveryMapper.list(deliveryInfoMgmt);
   }

   /** 일주일 전
    * @return
    */
   public String getStartDate() {
      return deliveryMapper.getStartDate();
   }
   
   /** 오늘날짜
    * @return
    */
   public String getEndDate() {
      return deliveryMapper.getEndDate();
   }
   
   /**
   * 배송 목록 조회 카운트
   * @return
   */
   public int getDeliveryCount(DeliveryInfoMgmt deliveryInfoMgmt) {
	   
	   // 송장번호 미입력 & 배송메모
	   if(deliveryInfoMgmt.getListType().equals("1") || deliveryInfoMgmt.getListType().equals("2") ) {
		   deliveryInfoMgmt.setPeriod_opt(null);
           deliveryInfoMgmt.setOrder_opt(null);
           deliveryInfoMgmt.setSearch_opt(null);
           deliveryInfoMgmt.setStart_date(this.getStartDate());
           deliveryInfoMgmt.setEnd_date(this.getEndDate());
	   }
	   
	   return deliveryMapper.getDeliveryCount(deliveryInfoMgmt);
	   
   }
   
   /**
    * 엑셀 다운로드
    * @param deliveryInfoMgmt
    * @return
    */
   public List<LinkedHashMap<String, String>> listExcel(DeliveryInfoMgmt deliveryInfoMgmt) {
      Locale locale = LocaleContextHolder.getLocale();
      String language = locale.getLanguage();
      deliveryInfoMgmt.setLanguage(language);
      
      // 송장번호 미입력 & 배송메모
      if(deliveryInfoMgmt.getListType().equals("1") || deliveryInfoMgmt.getListType().equals("2") ) {
    	  deliveryInfoMgmt.setPeriod_opt(null);
          deliveryInfoMgmt.setOrder_opt(null);
          deliveryInfoMgmt.setSearch_opt(null);
          deliveryInfoMgmt.setStart_date(this.getStartDate());
          deliveryInfoMgmt.setEnd_date(this.getEndDate());
      }
      
      return deliveryMapper.listExcel(deliveryInfoMgmt);
   }
   
   /**
    * 배송추적 리스트 조회
    * @param deliveryCode
    * @return
    */
    public DeliveryInfo getDeliveryTrackingList(DeliveryCode deliveryCode) {
      
       String t_key = deliveryCode.getT_key();
       String t_code = deliveryCode.getT_code();
       String t_invoice = deliveryCode.getT_invoice();
      
      DeliveryInfo deliveryInfo = null;
      DeliveryInfoDetail deliveryInfoDetail = null;
      ArrayList<DeliveryInfoDetail> list = new ArrayList<DeliveryInfoDetail>();
            
      try {
         URL url = new URL(url_address+"t_key="+t_key+"&t_code="+t_code+"&t_invoice="+t_invoice);
         InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
         JSONObject object = (JSONObject)JSONValue.parse(isr);
                  
         JSONArray trackingDetailArray = (JSONArray)object.get("trackingDetails"); // 배열
            
         for(int i=0; i<trackingDetailArray.size(); i++) {
         JSONObject data = (JSONObject)trackingDetailArray.get(i);
         deliveryInfoDetail = new DeliveryInfoDetail(data.get("timeString").toString(), data.get("where").toString(), data.get("kind").toString());
         list.add(deliveryInfoDetail); 
      }
               
      deliveryInfo = new DeliveryInfo(object.get("invoiceNo").toString(), object.get("recipient").toString(), object.get("senderName").toString(), object.get("receiverAddr").toString(), list);
               
      }catch(Exception e) {
         e.printStackTrace();
      }
            
      return deliveryInfo;
   }
   
      
      public int getDeliveryTracknoMessageCount(DeliveryInfoMgmt deliveryInfoMgmt) {
         
         // 조건 고정
         deliveryInfoMgmt.setListType("1");
         deliveryInfoMgmt.setPeriod_opt(null);
         deliveryInfoMgmt.setOrder_opt(null);
         deliveryInfoMgmt.setSearch_opt(null);
         deliveryInfoMgmt.setStart_date(this.getStartDate());
         deliveryInfoMgmt.setEnd_date(this.getEndDate());
         
         return deliveryMapper.getDeliveryTracknoMessageCount(deliveryInfoMgmt);
      }

      public int getDeliveryMemoCount(DeliveryInfoMgmt deliveryInfoMgmt) {
         
         // 조건 고정
         deliveryInfoMgmt.setListType("2");
         deliveryInfoMgmt.setPeriod_opt(null);
         deliveryInfoMgmt.setOrder_opt(null);
         deliveryInfoMgmt.setSearch_opt(null);
         deliveryInfoMgmt.setStart_date(this.getStartDate());
         deliveryInfoMgmt.setEnd_date(this.getEndDate());

         return deliveryMapper.getDeliveryMemoCount(deliveryInfoMgmt);
      }
      
      
      /**
      * 선택 건 저장
      * @param DeliveryInfoMgmt(List)
      * @return
      */
      @Transactional
      public String selectedUpadte(ArrayList<DeliveryInfoMgmt> list) {
         
         try {            
           
            String result = "";
            
            for (int i = 0; i < list.size(); i++) {
               
               if( list.get(i).getDtl_cd().equals("020") || list.get(i).getDtl_cd().equals("220") ) {
                  result = "succ";
               }
               else {
                  result = "fail";
                  break;
               }
            }
            
            if(result.equals("succ")) {
               for (int i = 0; i < list.size(); i++) {
                  DeliveryInfoMgmt deliveryInfoMgmt = new DeliveryInfoMgmt();
                  deliveryInfoMgmt.setBase_addr(list.get(i).getBase_addr());
                  deliveryInfoMgmt.setDtl_addr(list.get(i).getDtl_addr());
                  deliveryInfoMgmt.setZip_cd(list.get(i).getZip_cd());
                  deliveryInfoMgmt.setOrder_seq(list.get(i).getOrder_seq());
                  deliveryInfoMgmt.setWaybil_no(list.get(i).getWaybil_no());
                  deliveryInfoMgmt.setEchn_waybil_no(list.get(i).getEchn_waybil_no());
                  deliveryInfoMgmt.setProd_order_seq(list.get(i).getProd_order_seq());
                  deliveryMapper.selectedAddrUpadte(deliveryInfoMgmt);
                  deliveryMapper.selectedWaybilUpadte(deliveryInfoMgmt);
               }
            }   
            
            return result;
            
         } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            return e.getMessage();
         }
      }
      
      
      /**
      * 선택 건 발송 처리(송장번호가 존재하는지, 상품준비중 or 교환준비중 인지 확인 후 update)
      * @param DeliveryInfoMgmt(List)
      * @return
      */
      @Transactional
      public String selectedShipCheck(ArrayList<DeliveryInfoMgmt> list) {
         try {
            String result = "fail";
            // 선택된 로우들이 운송장번호가 제대로(12자리) 입력됐는지, 배송상태가 상품준비중이거나 교환준비중인지 확인
            for (int i = 0; i < list.size(); i++) {
               // 배송준비중일 경우
               if(list.get(i).getDtl_cd().equals("020") && list.get(i).getWaybil_no().length() == 12) {
                  result = "succ";
               }
               else if(list.get(i).getDtl_cd().equals("220") && list.get(i).getWaybil_no().length() == 12 && list.get(i).getEchn_waybil_no().length() == 12) {
                  result = "succ";
               }                            
               else {
                  result = "fail";
                  break;
               }
            }
            
            if(result.equals("succ")) {
               for(int i = 0; i < list.size(); i++) {
                  DeliveryInfoMgmt deliveryInfoMgmt = new DeliveryInfoMgmt();
                  deliveryInfoMgmt.setWaybil_no(list.get(i).getWaybil_no());
                  deliveryInfoMgmt.setProd_order_no(list.get(i).getProd_order_no());
                  
                  deliveryInfoMgmt.setEchn_waybil_no(list.get(i).getEchn_waybil_no());
                  deliveryInfoMgmt.setProd_order_seq(list.get(i).getProd_order_seq());
                  deliveryMapper.selectedWaybilUpadte(deliveryInfoMgmt);
                  
                  deliveryMapper.selectedShipUpdate(deliveryInfoMgmt); 
               }
            }   
            
            return result;
                         
         } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            return e.getMessage();
         }
      }

      /**
       * 엑셀 업로드
       * @param fileName
       * @return
       */
	  public List<ArrayList<String>> getExcelUploadInfo(MultipartFile file) {
	      
		   HSSFWorkbook workbook = null;
		   
		   List<String> list = null;
		   List<ArrayList<String>> lists = null;
		   
		   try {
		      workbook = new HSSFWorkbook(file.getInputStream());
		   } catch (Exception e) {
		      e.printStackTrace();
		   }
		   int rowindex = 0;
		   int columnindex = 0;
		   
		   int firstNum = 0;
		   int secondNum = 0;
		   
		   //시트 수 (첫번째에만 존재하므로 0을 준다)
		   //만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		   HSSFSheet sheet = workbook.getSheetAt(0);
		   //행의 수
		   int rows = sheet.getPhysicalNumberOfRows();
		   
		   lists = new ArrayList<ArrayList<String>>();
		   
		   HSSFRow firstRow = sheet.getRow(0);
		   
		   if (firstRow != null) {
			   int firstCells = firstRow.getPhysicalNumberOfCells();
			   
			   for( int cellIndexNo=0; cellIndexNo<=firstCells; cellIndexNo++) {
				   HSSFCell firstCell = firstRow.getCell(cellIndexNo);
				   if(firstCell == null) {
					   continue;
				   }else {
					   if( firstCell.getStringCellValue().equals(MessageUtil.getMessage("label.delivery.num") ) ) {
						   firstNum = cellIndexNo;
					   }else if (firstCell.getStringCellValue().equals(MessageUtil.getMessage("label.delivery.trackno") ) ) {
						   secondNum = cellIndexNo;
					   }else {
						   continue;
					   }
				   }
			   }
		   }
		   
		   for( rowindex=1; rowindex<rows; rowindex++){
		       //행을 읽는다
		   HSSFRow row = sheet.getRow(rowindex);
		   
		   if(row !=null){
			   
		       //셀의 수
		       int cells = row.getPhysicalNumberOfCells();
		       list = new ArrayList<String>();
		      
		       for( columnindex=0; columnindex<=cells; columnindex++ ){
		    	   
		    	   if ( columnindex == firstNum || columnindex == secondNum ) {
		    		   
		    		   HSSFCell cell = row.getCell(columnindex);
		    		   String value = "";
		    		   //셀이 빈값일경우를 위한 널체크
		    		   if(cell == null){
		    			   continue;
		    		   }else{
		    			   //타입별로 내용 읽기
		    			   switch (cell.getCellType()){
		    			   case HSSFCell.CELL_TYPE_FORMULA:
		    				   value=cell.getCellFormula();
		    				   break;
		    			   case HSSFCell.CELL_TYPE_NUMERIC:
		    				   cell.setCellType(HSSFCell.CELL_TYPE_STRING);
		    				   value=cell.getStringCellValue()+"";
		    				   break;
		    			   case HSSFCell.CELL_TYPE_STRING:
		    				   value=cell.getStringCellValue()+"";
		    				   break;
		    			   case HSSFCell.CELL_TYPE_BLANK:
		    				   value="";
		    				   break;
		    			   case HSSFCell.CELL_TYPE_ERROR:
		    				   value=cell.getErrorCellValue()+"";
		    				   break;
		    			   }
		    		   }
		    		   
		    		   list.add(value);
		    		   
		    	   }else {
		    		   continue;
		    	   }
               }
           }
		   lists.add((ArrayList<String>) list);
   	       }
		   
	   	   return lists;
	  }
}