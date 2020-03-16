package com.ncomz.nshop.controller.admin.product.productCategory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nshop.domain.admin.product.ProductCategory;
import com.ncomz.nshop.service.admin.common.code.CodeService;
import com.ncomz.nshop.service.admin.product.productCategory.ProductCategoryService;

@Controller
@RequestMapping(value = "/admin/product/productCategory")
public class ProductCategoryController {

	private String thisUrl = "admin/product/productCategory";
	
	@Autowired
	private ProductCategoryService productCategoryService;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = "index", method = RequestMethod.POST)
	public String index(Model model) {
		return thisUrl + "/index";
	}
	
	@RequestMapping(value = "getTreeAction", method = RequestMethod.POST)
	public @ResponseBody Object getTreeAction() {
		return productCategoryService.getTreeAction();
	}
	
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String insert(Model model, ProductCategory parent) {
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		model.addAttribute("parent", parent);
		return thisUrl + "/insert";
	}
	
	@RequestMapping(value = "insertAction", method = RequestMethod.POST)
	public void insertAction(Model model, ProductCategory productCategory) {
		model.addAttribute("result", productCategoryService.insertAction(productCategory));
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(Model model, ProductCategory productCategory) {
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		model.addAttribute("productCategoryLanguageList", productCategoryService.getProductCategoryLanguageList(productCategory));
		model.addAttribute("productCategory", productCategoryService.getProductCategory(productCategory));
		return thisUrl + "/update";
	}
	
	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public void updateAction(Model model, ProductCategory productCategory) {
		model.addAttribute("result", productCategoryService.updateAction(productCategory));
	}
	
	@RequestMapping(value = "moveAction", method = RequestMethod.POST)
	public void moveAction(Model model, ProductCategory productCategory) {
		model.addAttribute("result", productCategoryService.moveAction(productCategory));
	}

	@RequestMapping(value = "deleteAction", method = RequestMethod.POST)
	public void deleteAction(Model model, ProductCategory productCategory) {
		model.addAttribute("result", productCategoryService.deleteAction(productCategory));
	}
	
	@RequestMapping(value = "updateExpandAction", method = RequestMethod.POST)
	public void updateExpandAction(Model model, ProductCategory productCategory) {
		model.addAttribute("result", productCategoryService.updateExpandAction(productCategory));
	}
	
	@RequestMapping(value = "select", method = RequestMethod.POST)
	public String select(Model model) {
		return thisUrl + "/select";
	}
	
}
