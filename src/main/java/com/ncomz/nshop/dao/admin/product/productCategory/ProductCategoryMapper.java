package com.ncomz.nshop.dao.admin.product.productCategory;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.product.ProductCategory;

@Component
public interface ProductCategoryMapper {

	List<ProductCategory> getProductCategoryList(ProductCategory productCategory);
	int insertProductCategory(ProductCategory productCategory);
	ProductCategory getProductCategory(ProductCategory productCategory);
	int updateProductCategoryInfo(ProductCategory productCategory);
	int updateOldDisplayOrders(ProductCategory old);
	int updateNewDisplayOrders(ProductCategory old);
	int updateProductCategoryPosition(ProductCategory productCategory);
	int deleteProductCategoryInfo(ProductCategory productCategory);
	int updateProductCategoryExpand(ProductCategory productCategory);
	int countProductCategoryChildren(ProductCategory productCategory);
	int insertProductCategoryLanguage(ProductCategory productCategory);
	List<ProductCategory> getProductCategoryLanguageList(ProductCategory productCategory);
	int deleteProductCategoryLanguage(ProductCategory productCategory);
	
}
