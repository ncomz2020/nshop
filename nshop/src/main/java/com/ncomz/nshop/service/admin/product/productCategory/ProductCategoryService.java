package com.ncomz.nshop.service.admin.product.productCategory;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nshop.dao.admin.product.productCategory.ProductCategoryMapper;
import com.ncomz.nshop.domain.admin.common.Menu;
import com.ncomz.nshop.domain.admin.product.ProductCategory;
import com.ncomz.nshop.domain.common.DynatreeNode;
import com.ncomz.nshop.utillty.MessageUtil;
import com.ncomz.nshop.utillty.StringUtil;

@Service
public class ProductCategoryService {

	@Autowired
	private ProductCategoryMapper productCategoryMapper;
	
	public DynatreeNode getTreeAction() {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		ProductCategory productCategory = new ProductCategory();
		productCategory.setLanguage(language);
		DynatreeNode root = new DynatreeNode();
		root.setKey("0");
		root.setTitle(MessageUtil.getMessage("label.product.category.manage"));
		root.setIsFolder(true);
		root.setExpand(true);
		root.setChildren(this.buildTree(productCategoryMapper.getProductCategoryList(productCategory), "0"));
		return root;
	}
	
	public List<DynatreeNode> buildTree(List<ProductCategory> productCategoryList, String parentId) {
		List<DynatreeNode> tree = new ArrayList<DynatreeNode>();
		for (int i=0;i<productCategoryList.size();i++) {
			ProductCategory productCategory = productCategoryList.get(i);
			if (StringUtil.compare(productCategory.getParent_id(), parentId) == 0) {
				DynatreeNode node = new DynatreeNode();
				node.setKey(productCategory.getCategory_id());
				node.setTitle(productCategory.getTitle());
				if (StringUtil.compare(productCategory.getExpand(), "Y") == 0) {
					node.setExpand(true);
				} else {
					node.setExpand(false);
				}
				List<DynatreeNode> children = this.buildTree(productCategoryList, productCategory.getCategory_id());
				node.setChildren(children);
				if (children.size() > 0) {
					node.setIsFolder(true);
				}
				tree.add(node);
			}
		}
		return tree;
	}
	
	@Transactional
	public String insertAction(ProductCategory productCategory) {
		try {
			productCategoryMapper.insertProductCategory(productCategory);
			
			String[] languageCode = productCategory.getLanguageCode();
			String[] languageTitle = productCategory.getLanguageTitle();
			for (int i=0;i<languageCode.length;i++) {
				ProductCategory productCategoryLanguage = new ProductCategory();
				productCategoryLanguage.setCategory_id(productCategory.getCategory_id());
				productCategoryLanguage.setLanguage(languageCode[i]);
				productCategoryLanguage.setTitle(languageTitle[i]);
				productCategoryMapper.insertProductCategoryLanguage(productCategoryLanguage);
			}
			
			this.expandParentAction(productCategory);
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	/**
	 * 카테고리 등록 또는 수정 시 부모 카테고리를 확장
	 * @param productCategory
	 * @throws Exception
	 */
	public void expandParentAction(ProductCategory productCategory) throws Exception {
		ProductCategory parent = new ProductCategory();
		parent.setCategory_id(productCategory.getParent_id());
		parent.setExpand("Y");
		productCategoryMapper.updateProductCategoryExpand(parent);
	}
	
	public ProductCategory getProductCategory(ProductCategory productCategory) {
		return productCategoryMapper.getProductCategory(productCategory);
	}
	
	@Transactional
	public String updateAction(ProductCategory productCategory) {
		try {
			productCategoryMapper.updateProductCategoryInfo(productCategory);
			
			productCategoryMapper.deleteProductCategoryLanguage(productCategory);
			
			String[] languageCode = productCategory.getLanguageCode();
			String[] languageTitle = productCategory.getLanguageTitle();
			for (int i=0;i<languageCode.length;i++) {
				ProductCategory productCategoryLanguage = new ProductCategory();
				productCategoryLanguage.setCategory_id(productCategory.getCategory_id());
				productCategoryLanguage.setLanguage(languageCode[i]);
				productCategoryLanguage.setTitle(languageTitle[i]);
				productCategoryMapper.insertProductCategoryLanguage(productCategoryLanguage);
			}
			
			this.expandParentAction(productCategory);
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	@Transactional
	public String moveAction(ProductCategory productCategory) {
		try {
			ProductCategory old = productCategoryMapper.getProductCategory(productCategory);
			// 기존 부모 하위의 display_order 를 업데이트
			productCategoryMapper.updateOldDisplayOrders(old);
			
			// 새로운 부모 하위의 display_order 를 업데이트
			productCategoryMapper.updateNewDisplayOrders(productCategory);
			
			// category 위치 업데이트
			productCategoryMapper.updateProductCategoryPosition(productCategory);
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	@Transactional
	public String deleteAction(ProductCategory productCategory) {
		try {
			if (productCategoryMapper.countProductCategoryChildren(productCategory) > 0) {
				return "하위 카테고리가 존재하는 카테고리를 삭제할 수 없습니다.";
			}
			productCategoryMapper.deleteProductCategoryInfo(productCategory);
			productCategoryMapper.deleteProductCategoryLanguage(productCategory);
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	@Transactional
	public String updateExpandAction(ProductCategory productCategory) {
		try {
			productCategoryMapper.updateProductCategoryExpand(productCategory);
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	public List<ProductCategory> getProductCategoryLanguageList(ProductCategory productCategory) {
		return productCategoryMapper.getProductCategoryLanguageList(productCategory);
	}
	
}
