package com.ncomz.nshop.controller.admin.store;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.store.StoreInfoMgmt;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.store.StoreService;
import com.ncomz.nshop.service.common.CommonService;


@Controller
@RequestMapping(value = "/admin/store/storeInfoMgmt")
public class StoreController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/store/storeInfoMgmt";
	
	@Autowired
	private StoreService storeService;

	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value = "list", method = RequestMethod.POST)
	public String list( HttpServletRequest request
			           ,Model model) throws Exception {
		
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		
		String startDate 	= commonService.getStartDate();  // 한달전
		String endDate = commonService.getEndDate();   // 오늘
		
		model.addAttribute( "startDate"	, startDate );
		model.addAttribute( "endDate"	, endDate );
		
		String resultUrl ="/list";
		if("1".equals(sessionUser.getUsr_grp_id())) {
			// ADMIN => 리스트
			
			model.addAttribute( "approval_stat"	, commonService.listApprovalState("APPROVAL_STAT") );
			model.addAttribute( "operational_stat"	, commonService.listApprovalState("OPER_STAT") );
		}
		
		if("2".equals(sessionUser.getUsr_grp_id())) {
			// Stroe 그룹 => myStore INfo 
			StoreInfoMgmt storeInfoMgmt = new StoreInfoMgmt();
			storeInfoMgmt.setStore_id(sessionUser.getUsr_id());
			if( storeService.getStoreInfoCount(storeInfoMgmt) > 0){ //상점등록= 상세보기 
				storeInfoMgmt = storeService.getStoreInfo(storeInfoMgmt);
				model.addAttribute( "storeInfo", storeInfoMgmt );
				resultUrl ="/detailView";
			}else{//상점미등록=> 상점등록으로
				model.addAttribute("action_type", "insert");
				resultUrl ="/update";
			}
		}
		
		return thisUrl + resultUrl; 
	}
	
	
	/** 리스트 조회
	 * @param storeInfoMgmt
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction( StoreInfoMgmt storeInfoMgmt, Model model, HttpServletRequest request) throws Exception {

		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		if("2".equals(sessionUser.getUsr_grp_id())) {
			storeInfoMgmt.setStore_id(sessionUser.getUsr_id());
		}
		
		model.addAttribute("pagingObject", storeInfoMgmt);
		model.addAttribute("count", storeService.getStoreInfoCount(storeInfoMgmt));
		model.addAttribute("list", storeService.getStoreInfoList(storeInfoMgmt));
		return thisUrl + "/listAction";
		
	}
	
	@RequestMapping(value = "detailView", method = RequestMethod.POST)
	public String insert(StoreInfoMgmt storeInfoMgmt, Model model, HttpServletRequest request) throws Exception {
		StoreInfoMgmt storeInfo = storeService.getStoreInfo(storeInfoMgmt);
		model.addAttribute( "storeInfo", storeInfo );
		
		//pageType 으로 상품관리 페이지인지 파일관리 페이지에서 온것인지 확인.
		model.addAttribute("pageType", request.getParameter("pageType"));
		System.out.println("::::::::::::::::   " + request.getParameter("pageType"));
		
		return thisUrl + "/detailView"; 
	}
	
	
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(
			StoreInfoMgmt storeInfoMgmt,
			Model model, 
			HttpServletRequest request)  throws ParseException, UnsupportedEncodingException {
		
		List<LinkedHashMap<String, String>> list = storeService.listExcel(storeInfoMgmt);
		model.addAttribute("list", list);
		
		return "excelViewer";
	}
	

	/** 승인,운영 상태변경
	 * @param model
	 * @param storeInfoMgmt
	 */
	@RequestMapping(value = "statUpdateAction", method = RequestMethod.POST)
	public void statUpdateAction(Model model, StoreInfoMgmt storeInfoMgmt) {
		model.addAttribute("result", storeService.statUpdateAction(storeInfoMgmt));
	}
	
	
	
	
	
	
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String insert(Model model, StoreInfoMgmt storeInfoMgmt, HttpServletRequest request) throws Exception {
		model.addAttribute("action_type", "insert");
		return thisUrl + "/update"; 
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(Model model, StoreInfoMgmt storeInfoMgmt, HttpServletRequest request) throws Exception {
		
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		if("2".equals(sessionUser.getUsr_grp_id())) {
			storeInfoMgmt.setStore_id(sessionUser.getUsr_id());
		}
		
		model.addAttribute("storeInfoMgmt", storeService.getStoreInfo(storeInfoMgmt));
		model.addAttribute("action_type", "update");
		//pageType 으로 상품관리 페이지인지 파일관리 페이지에서 온것인지 확인.
		model.addAttribute("pageType", request.getParameter("pageType"));
		
		return thisUrl + "/update"; 
	}
	
	@RequestMapping(value = "insertAction", method = RequestMethod.POST)
	public @ResponseBody String insertAction(Model model, StoreInfoMgmt storeInfoMgmt){
		return storeService.insertAction(storeInfoMgmt);
	}
	
	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public @ResponseBody String updateAction(Model model, StoreInfoMgmt storeInfoMgmt){
		return storeService.updateAction(storeInfoMgmt);
	}
	
	
	@RequestMapping(value = "updateStoreAuthStateAction", method = RequestMethod.POST)
	public void updateStoreAuthStateAction(Model model, StoreInfoMgmt storeInfoMgmt) {
		model.addAttribute("result", storeService.updateStoreAuthStateAction(storeInfoMgmt));
	}
}
