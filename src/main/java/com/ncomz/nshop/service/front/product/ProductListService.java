package com.ncomz.nshop.service.front.product;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nshop.dao.front.product.ProductListMapper;
import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.domain.common.FileInfo;
import com.ncomz.nshop.service.common.FileService;
import com.ncomz.nshop.utillty.StringUtil;
@Service
public class ProductListService {

	@Autowired
	private ProductListMapper productListMapper;
	
	@Autowired
	private FileService fileService;
	
	
	
	/**
	 * 상품 목록 조회
	 * @param productInfo
	 * @return
	 */
	public List<ProductInfo> getProductList(ProductInfo productInfo) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		productInfo.setLanguage(language);
		List<ProductInfo> productList = productListMapper.getFrontProductList(productInfo);
		for (ProductInfo product : productList) {
			FileInfo fileInfo = new FileInfo();
			fileInfo.setKey_id(product.getProd_id());
			fileInfo.setFile_type("prod");
			product.setImageFileList(fileService.getFileList(fileInfo));
		}
		return productList;
	}
	
	/**
	 * 상품 목록 건수 조회
	 * @param productInfo
	 * @return
	 */
	public int getProductCount(ProductInfo productInfo) {
		return productListMapper.getProductCount(productInfo);
	}
	
	
	
	/**
	 * 상품정보 조회
	 * @param productInfo
	 * @return
	 */
	public ProductInfo getProductInfo(ProductInfo productInfo) {
		return productListMapper.getProductInfo(productInfo);
	}
	
	/**
	 * 카테고리 선택시 카테고리 경로 정보
	 * @param productInfo
	 * @return
	 */
	public ProductInfo getCategoryPath(ProductInfo productInfo) {
		return productListMapper.getCategoryPath(productInfo);
	}
	
	/**
	 * 상품 카테고리 조회
	 * @param productInfo
	 * @return
	 */
	public List<ProductInfo> getProductCategoryList(ProductInfo productInfo) {
		return productListMapper.getProductCategoryList(productInfo);
	}
	
	/**
	 * 상품 파일리스트 조회
	 * @param productInfo
	 * @return
	 */
	public FileInfo getProductFileList(ProductInfo productInfo) {
		return productListMapper.getProductFileList(productInfo);
	}
	
	/**
	 * 상품 파일리스트 조회
	 * @param productInfo
	 * @return
	 */
	public List<FileInfo> getFileList(ProductInfo productInfo) {
		return productListMapper.getFileList(productInfo);
	}
	
}
