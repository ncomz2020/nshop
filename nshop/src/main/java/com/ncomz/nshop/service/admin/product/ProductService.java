package com.ncomz.nshop.service.admin.product;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nshop.dao.admin.product.ProductMapper;
import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.domain.common.FileInfo;
import com.ncomz.nshop.service.common.FileService;
import com.ncomz.nshop.utillty.StringUtil;
@Service
public class ProductService {

	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private FileService fileService;
	
	/**
	 * 상품 등록
	 * @param userInfo
	 * @param productInfo
	 * @return
	 */
	@Transactional
	public String addAction(ProductInfo productInfo) {
		try {
			productInfo.setProd_stat("30");
			if (productMapper.insertProduct(productInfo) <= 0) {
				throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
			}
			
			List<String> objectCategoryList = new ArrayList<String>();
			
			String category_info= productInfo.getCategory_info();
			if(StringUtils.isNotEmpty(category_info))
			{
				String[] arrCategory = category_info.split(",");
				for(String category_id : arrCategory){
					objectCategoryList.add(category_id);
				}
				productInfo.setObjectCategoryList(objectCategoryList);
			}
			
			if (productMapper.insertCategoryRef(productInfo) <= 0) {
				throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
			}

			String file_info = productInfo.getFile_info();
			if (!StringUtil.isEmpty(file_info)) {
				String[] fileIdArr = file_info.split(",");
				List<String> fileIdList = Arrays.asList(fileIdArr);
				fileService.updateFileType(fileIdList, Consts.FILE_TYPE_GROUP.PRODUCT, productInfo.getProd_id(), "N");
			}
			fileService.updateImageFile(productInfo.getProd_detail(), Consts.FILE_TYPE_GROUP.PROD_CONTENTS, productInfo.getProd_id());
			fileService.updateImageFile(productInfo.getProd_delivery_info(), Consts.FILE_TYPE_GROUP.PROD_CONTENTS, productInfo.getProd_id());
			fileService.updateImageFile(productInfo.getProd_refund_info(), Consts.FILE_TYPE_GROUP.PROD_CONTENTS, productInfo.getProd_id());
			
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	/**
	 * 상품 목록 조회
	 * @param productInfo
	 * @return
	 */
	public List<ProductInfo> getProductList(ProductInfo productInfo) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		productInfo.setLanguage(language);
		List<ProductInfo> productList = productMapper.getProductList(productInfo);
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
		return productMapper.getProductCount(productInfo);
	}
	
	/**
	 * 책 사용여부 저장
	 * @param bookInfo
	 * @return
	 */
	@Transactional
	public String statusModifyAction(ProductInfo productInfo) {
		try {
			if(!StringUtils.isEmpty(productInfo.getProd_id()))
			{
				
				List<String> objectProdIdList = new ArrayList<String>();
				
				String prod_id= productInfo.getProd_id();
				if(StringUtils.isNotEmpty(prod_id))
				{
					String[] arrProdId = prod_id.split(",");
					for(String product_id : arrProdId){
						objectProdIdList.add(product_id);
					}
					productInfo.setObjectCategoryList(objectProdIdList);
				}
				
				if (productMapper.statusModifyAction(productInfo) <= 0) {
					throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
				}
			}
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	/**
	 * 상품정보 조회
	 * @param productInfo
	 * @return
	 */
	public ProductInfo getProductInfo(ProductInfo productInfo) {
		return productMapper.getProductInfo(productInfo);
	}
	
	/**
	 * 상품 카테고리 조회
	 * @param productInfo
	 * @return
	 */
	public List<ProductInfo> getProductCategoryList(ProductInfo productInfo) {
		return productMapper.getProductCategoryList(productInfo);
	}
	
	/**
	 * 상품 파일리스트 조회
	 * @param productInfo
	 * @return
	 */
	public FileInfo getProductFileList(ProductInfo productInfo) {
		return productMapper.getProductFileList(productInfo);
	}
	
	/**
	 * 상품 수정
	 * @param productInfo
	 * @return
	 */
	@Transactional
	public String modifyAction(ProductInfo productInfo) {
		try {
			productInfo.setProd_stat("30");
			if (productMapper.updateProduct(productInfo) <= 0) {
				throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
			}
			
			List<String> objectCategoryList = new ArrayList<String>();
			
			String category_info= productInfo.getCategory_info();
			if(StringUtils.isNotEmpty(category_info))
			{
				String[] arrCategory = category_info.split(",");
				for(String category_id : arrCategory){
					objectCategoryList.add(category_id);
				}
				productInfo.setObjectCategoryList(objectCategoryList);
			}
			
			if(productMapper.deleteProductRef(productInfo) > 0)
			{
				if (productMapper.insertCategoryRef(productInfo) <= 0) 
				{
					throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
				}				
			}

			fileService.updateFileTypeTempYn(Consts.FILE_TYPE_GROUP.PRODUCT, productInfo.getProd_id(), "Y");
			String file_info = productInfo.getFile_info();
			if (!StringUtil.isEmpty(file_info)) {
				String[] fileIdArr = file_info.split(",");
				List<String> fileIdList = Arrays.asList(fileIdArr);
				fileService.updateFileType(fileIdList, Consts.FILE_TYPE_GROUP.PRODUCT, productInfo.getProd_id(), "N");
			}
			
			fileService.updateFileTypeTempYn(Consts.FILE_TYPE_GROUP.PROD_CONTENTS, productInfo.getProd_id(), "Y");
			
			fileService.updateImageFile(productInfo.getProd_detail(), Consts.FILE_TYPE_GROUP.PROD_CONTENTS, productInfo.getProd_id());
			fileService.updateImageFile(productInfo.getProd_delivery_info(), Consts.FILE_TYPE_GROUP.PROD_CONTENTS, productInfo.getProd_id());
			fileService.updateImageFile(productInfo.getProd_refund_info(), Consts.FILE_TYPE_GROUP.PROD_CONTENTS, productInfo.getProd_id());
			
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	public List<LinkedHashMap<String, String>> listExcel(ProductInfo productInfo) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		productInfo.setLanguage(language);
		return productMapper.listExcel(productInfo);
	}
}
