package com.ncomz.nshop.controller.admin.common.userGroup;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nshop.domain.admin.common.Menu;
import com.ncomz.nshop.domain.admin.common.UserGroup;
import com.ncomz.nshop.service.admin.common.menu.MenuService;
import com.ncomz.nshop.service.admin.common.userGroup.UserGroupService;

@Controller
@RequestMapping(value = "/admin/common/userGroup")
public class UserGroupController {

	private String thisUrl = "admin/common/userGroup";
	
	@Autowired
	private UserGroupService userGroupService;
	
	@Autowired
	private MenuService menuService;

	@RequestMapping(value = "list", method = RequestMethod.POST)
	public String list(Model model) {
		return thisUrl + "/list";
	}

	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(Model model, UserGroup userGroup) {
		model.addAttribute("pagingObject", userGroup);
		model.addAttribute("count", userGroupService.getUserGroupCount(userGroup));
		model.addAttribute("list", userGroupService.getUserGroupList(userGroup));
		return thisUrl + "/listAction";
	}
	
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String insert(Model model, UserGroup userGroup) {
		return thisUrl + "/insert";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(Model model, UserGroup userGroup) {
		model.addAttribute("userGroup", userGroupService.getUserGroup(userGroup));
		return thisUrl + "/update";
	}
	
	@RequestMapping(value = "getTreeAction", method = RequestMethod.POST)
	public @ResponseBody Object getTreeAction(UserGroup userGroup) {
		return menuService.getTreeAction(userGroup);
	}
	
	@RequestMapping(value = "insertAction", method = RequestMethod.POST)
	public void insertAction(Model model, UserGroup userGroup) {
		model.addAttribute("result", userGroupService.insertAction(userGroup));
	}
	
	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public void updateAction(Model model, UserGroup userGroup) {
		model.addAttribute("result", userGroupService.updateAction(userGroup));
	}
	
	@RequestMapping(value = "deleteAction", method = RequestMethod.POST)
	public void deleteAction(Model model, UserGroup userGroup) {
		model.addAttribute("result", userGroupService.deleteAction(userGroup));
	}

}
