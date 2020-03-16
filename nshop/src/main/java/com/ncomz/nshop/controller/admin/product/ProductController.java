package com.ncomz.nshop.controller.admin.product;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.domain.admin.store.StoreInfoMgmt;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.product.ProductService;
import com.ncomz.nshop.utillty.MessageUtil;

@Controller
@RequestMapping(value = "/admin/product")
public class ProductController {

	private String thisUrl = "admin/product";

	@Autowired
	private ProductService productService;

	/**
	 * 상품정보관리
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list")
	public String list(Model model, ProductInfo productInfo) {
		model.addAttribute("info", productInfo);
		model.addAttribute("pagingObject", productInfo);
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
		
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		productInfo.setStore_id(sessionUser.getStore_id());
		productInfo.setDateFormat(MessageUtil.getMessage("label.common.date.pattern"));
		
		model.addAttribute("pagingObject", productInfo);
		model.addAttribute("count", productService.getProductCount(productInfo));
		model.addAttribute("list", productService.getProductList(productInfo));
		return thisUrl + "/listAction";
	}

	/**
	 * 상품정보 등록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "add")
	public String add(Model model, ProductInfo productInfo) {
		return thisUrl + "/add";
	}

	/**
	 * 상품정보 등록 처리
	 * @param model
	 * @param userInfo
	 * @param advertiserInfo
	 * @return
	 */
	@RequestMapping(value = "addAction", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public void addAction(Model model, ProductInfo productInfo, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		productInfo.setCreate_user_id(sessionUser.getUsr_id());
		if (StringUtils.isNotEmpty(sessionUser.getStore_id())) {
			productInfo.setStore_id(sessionUser.getStore_id());
		} else {
			productInfo.setStore_id(sessionUser.getUsr_id());
		}

		model.addAttribute("result", productService.addAction(productInfo));
	}

	/**
	 * 상품정보 다중 상태변경 처리
	 * @param model
	 * @param session
	 * @param bookInfo
	 */
	@RequestMapping(value = "statusModifyAction", method = RequestMethod.POST)
	public void useStatusAction(Model model, HttpSession session, ProductInfo productInfo, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		productInfo.setDelete_user_id(sessionUser.getUsr_id());
		model.addAttribute("result", productService.statusModifyAction(productInfo));
	}

	@RequestMapping(value = "detail", method = RequestMethod.POST)
	public String detail(ProductInfo productInfo, Model model, HttpServletRequest request,
			@CookieValue(value="nshopLanguage", defaultValue="ko") String language
			) throws Exception {
		productInfo.setFile_type(Consts.FILE_TYPE_GROUP.PRODUCT);
		productInfo.setLanguage(language);
		model.addAttribute("productInfo", productService.getProductInfo(productInfo));
		model.addAttribute("categoryInfo", productService.getProductCategoryList(productInfo));
		model.addAttribute("fileInfo", productService.getProductFileList(productInfo));
		
		//pageType 으로 상품관리 페이지인지 파일관리 페이지에서 온것인지 확인.
		model.addAttribute("pageType", request.getParameter("pageType"));
		
		return thisUrl + "/detail";
	}
	
	@RequestMapping(value = "detailPopup", method = RequestMethod.POST)
	public String detailPopup(ProductInfo productInfo, Model model, HttpServletRequest request,
			@CookieValue(value="nshopLanguage", defaultValue="ko") String language
			) throws Exception {
		productInfo.setFile_type(Consts.FILE_TYPE_GROUP.PRODUCT);
		productInfo.setLanguage(language);
		model.addAttribute("productInfo", productService.getProductInfo(productInfo));
		model.addAttribute("categoryInfo", productService.getProductCategoryList(productInfo));
		model.addAttribute("fileInfo", productService.getProductFileList(productInfo));
		
		//pageType 으로 상품관리 페이지인지 파일관리 페이지에서 온것인지 확인.
		model.addAttribute("pageType", request.getParameter("pageType"));
		
		return thisUrl + "/detailPopup";
	}

	@RequestMapping(value = "modify", method = RequestMethod.POST)
	public String modify(ProductInfo productInfo, Model model, HttpServletRequest request,
			@CookieValue(value="nshopLanguage", defaultValue="ko") String language) throws Exception {
		productInfo.setFile_type(Consts.FILE_TYPE_GROUP.PRODUCT);
		model.addAttribute("productInfo", productService.getProductInfo(productInfo));
		model.addAttribute("categoryInfo", productService.getProductCategoryList(productInfo));
		model.addAttribute("fileInfo", productService.getProductFileList(productInfo));
		
		//pageType 으로 상품관리 페이지인지 파일관리 페이지에서 온것인지 확인.
		model.addAttribute("pageType", request.getParameter("pageType"));
		
		return thisUrl + "/modify";
	}

	/**
	 * 상품정보 등록 처리
	 * @param model
	 * @param userInfo
	 * @param advertiserInfo
	 * @return
	 */
	@RequestMapping(value = "modifyAction", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public void modifyAction(Model model, ProductInfo productInfo, HttpServletRequest request) {
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.SessionAttr.USER);
		productInfo.setCreate_user_id(sessionUser.getUsr_id());
		model.addAttribute("result", productService.modifyAction(productInfo));
	}

	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(ProductInfo productInfo, Model model) throws ParseException, UnsupportedEncodingException {

		model.addAttribute("list", productService.listExcel(productInfo));

		return "excelViewer";
	}
}