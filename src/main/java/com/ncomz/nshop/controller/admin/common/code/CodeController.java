package com.ncomz.nshop.controller.admin.common.code;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.common.Code;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.common.code.CodeService;

@Controller
@RequestMapping(value = "/admin/common/code")
public class CodeController {

	private String thisUrl = "admin/common/code";
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = "index", method = RequestMethod.POST)
	public String index(Model model) {
		return thisUrl + "/index";
	}
	
	@RequestMapping(value = "getTreeAction", method = RequestMethod.POST)
	public @ResponseBody Object getTreeAction() {
		return codeService.getTreeAction();
	}
	
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String insert(Model model, Code parent) {
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		model.addAttribute("parent", codeService.getCode(parent));
		return thisUrl + "/insert";
	}
	
	@RequestMapping(value = "insertAction", method = RequestMethod.POST)
	public void insertAction(Model model, Code code, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		code.setCreate_user_id(sessionUser.getUsr_id());
		model.addAttribute("result", codeService.insertAction(code));
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(Model model, Code code, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser)request.getSession().getAttribute(Consts.SessionAttr.USER);
		code.setUpdate_user_id(sessionUser.getUsr_id());
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		model.addAttribute("codeLanguageList", codeService.getCodeLanguageList(code));
		model.addAttribute("code", codeService.getCode(code));
		return thisUrl + "/update";
	}
	
	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public void updateAction(Model model, Code code) {
		model.addAttribute("result", codeService.updateAction(code));
	}
	
	@RequestMapping(value = "moveAction", method = RequestMethod.POST)	
	public void moveAction(Model model, Code code) {
		model.addAttribute("result", codeService.moveAction(code));
	}
	
	@RequestMapping(value = "deleteAction", method = RequestMethod.POST)
	public void deleteAction(Model model, Code code) {
		model.addAttribute("result", codeService.deleteAction(code));
	}
	
	@RequestMapping(value = "updateUseYnAction", method = RequestMethod.POST)
	public void updateUseYnAction(Model model, Code code) {
		model.addAttribute("result", codeService.updateUseYnAction(code));
	}
	
}
