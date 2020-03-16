package com.ncomz.nshop.controller.front.product;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.domain.admin.statistics.UserAccessStatistics;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.common.code.CodeService;
import com.ncomz.nshop.service.admin.statistics.UserAccessStatisticsService;
import com.ncomz.nshop.service.front.product.ProductListService;
import com.ncomz.nshop.utillty.MessageUtil;

@Controller
@RequestMapping(value = "/front/product")
public class ProductListController {

	private String thisUrl = "front/product";

	@Autowired
	private ProductListService productListService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private UserAccessStatisticsService userAccessStatisticsService;

	/**
	 * 상품정보관리
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list")
	public String list(Model model, ProductInfo productInfo, HttpServletRequest request) {
		
		model.addAttribute("info", productInfo);
		model.addAttribute("pagingObject", productInfo);
		model.addAttribute("category_id", request.getParameter("category_id"));
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		
		return thisUrl + "/list";
	}

	/**
	 * 상품정보관리 목록
	 * @param model
	 * @param advertiserInfo
	 * @return
	 */
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(Model model, ProductInfo productInfo, HttpServletRequest request) {
		/*SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		productInfo.setStore_id(sessionUser.getStore_id());*/
		
		productInfo.setSearch_status("10");	// 판매중인 상품만 검색하도록
		productInfo.setLanguage(MessageUtil.getMessage("label.common.language"));
		model.addAttribute("pagingObject", productInfo);
		model.addAttribute("count", productListService.getProductCount(productInfo));
		model.addAttribute("list", productListService.getProductList(productInfo));
		model.addAttribute("category_path", productListService.getCategoryPath(productInfo).getPath());
		
		return thisUrl + "/listAction";
	}
	
	@RequestMapping(value = "detail", method = RequestMethod.POST)
	public String detail(ProductInfo productInfo, UserAccessStatistics ua, Model model, HttpServletRequest request) throws Exception {
		productInfo.setFile_type(Consts.FILE_TYPE_GROUP.PRODUCT);
		productInfo.setLanguage(MessageUtil.getMessage("label.common.language"));
		model.addAttribute("productInfo", productListService.getProductInfo(productInfo));
		model.addAttribute("categoryInfo", productListService.getProductCategoryList(productInfo));
		model.addAttribute("fileList", productListService.getFileList(productInfo));
		model.addAttribute("languageCodeList", codeService.getLanguageList());
		
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		
		if(sessionUser != null){
			ua.setProd_id(productInfo.getProd_id());
			ua.setStore_id(productInfo.getStore_id());
			ua.setUser_id(sessionUser.getUsr_id());
			
			int result = userAccessStatisticsService.insertAccessInfo(ua);
		}
		//pageType 으로 상품관리 페이지인지 파일관리 페이지에서 온것인지 확인.
		model.addAttribute("pageType", request.getParameter("pageType"));
		return thisUrl + "/detail";
	}
}