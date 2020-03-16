package com.ncomz.nshop.controller.admin.popup;


import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nshop.domain.admin.popup.PopupInfo;
import com.ncomz.nshop.service.admin.popup.PopupService;
import com.ncomz.nshop.service.common.CommonService;


@Controller
@RequestMapping(value = "/admin/popup")
public class PopupController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "admin/popup";
	
	@Autowired
	private PopupService popupService;

	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value = "list")// TODO , method = RequestMethod.POST
	public String list(Model model) throws Exception {
		return thisUrl + "/list";
	}
	
	
	@RequestMapping(value = "listAction")// TODO , method = RequestMethod.POST
	public String listAction(Model model, PopupInfo popupInfo) throws Exception {

		model.addAttribute("pagingObject", popupInfo);
		model.addAttribute("count", popupService.getPopupCount(popupInfo));
		model.addAttribute("list", popupService.getPopupList(popupInfo));
		return thisUrl + "/listAction";
		
	}
	
	@RequestMapping(value = "insert")// TODO , method = RequestMethod.POST
	public String insert(Model model, PopupInfo popupInfo) throws Exception {
		model.addAttribute("action_type", "insert");
		return thisUrl + "/update"; 
	}
	
	@RequestMapping(value = "update")// TODO , method = RequestMethod.POST
	public String update(Model model, PopupInfo popupInfo) throws Exception {
		
		model.addAttribute("popupInfo", popupService.getPopupInfo(popupInfo));
		model.addAttribute("action_type", "update");
		return thisUrl + "/update"; 
	}
	
	@RequestMapping(value = "insertAction", produces = "application/json; charset=utf8")// TODO , method = RequestMethod.POST
	public @ResponseBody String insertAction(Model model, PopupInfo popupInfo){
		return popupService.insertAction(popupInfo);
	}
	
	@RequestMapping(value = "updateAction", produces = "application/json; charset=utf8")// TODO , method = RequestMethod.POST
	public @ResponseBody String updateAction(Model model, PopupInfo popupInfo){
		return popupService.updateAction(popupInfo);
	}
	
	@RequestMapping(value = "deleteAction")// TODO , method = RequestMethod.POST
	public @ResponseBody String deleteAction(Model model, PopupInfo popupInfo){
		return popupService.deleteAction(popupInfo);
	}
}
