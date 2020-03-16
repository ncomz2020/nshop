package com.ncomz.nshop.controller.admin.common.menu;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nshop.domain.admin.common.Menu;
import com.ncomz.nshop.service.admin.common.code.CodeService;
import com.ncomz.nshop.service.admin.common.menu.MenuService;

@Controller
@RequestMapping(value = "/admin/common/menu")
public class MenuController {

	private String thisUrl = "admin/common/menu";
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping(value = "index", method = RequestMethod.POST)
	public String index(Model model) {
		return thisUrl + "/index";
	}
	
	@RequestMapping(value = "getTreeAction", method = RequestMethod.POST)
	public @ResponseBody Object getTreeAction() {
		return menuService.getTreeAction();
	}
	
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String insert(Model model, Menu parent) {
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		model.addAttribute("parent", parent);
		return thisUrl + "/insert";
	}
	
	@RequestMapping(value = "insertAction", method = RequestMethod.POST)
	public void insertAction(Model model, Menu menu) {
		model.addAttribute("result", menuService.insertAction(menu));
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(Model model, Menu menu) {
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		model.addAttribute("menuLanguageList", menuService.getMenuLanguageList(menu));
		model.addAttribute("menu", menuService.getMenu(menu));
		return thisUrl + "/update";
	}
	
	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public void updateAction(Model model, Menu menu) {
		model.addAttribute("result", menuService.updateAction(menu));
	}
	
	@RequestMapping(value = "moveAction", method = RequestMethod.POST)
	public void moveAction(Model model, Menu menu) {
		model.addAttribute("result", menuService.moveAction(menu));
	}
	
	@RequestMapping(value = "deleteAction", method = RequestMethod.POST)
	public void deleteAction(Model model, Menu menu) {
		model.addAttribute("result", menuService.deleteAction(menu));
	}
}
