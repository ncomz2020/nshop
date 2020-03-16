package com.ncomz.nshop.dao.admin.product;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.domain.common.FileInfo;

@Component
public interface ProductMapper {
	List<ProductInfo> getProductList(ProductInfo productInfo);
	int getProductCount(ProductInfo productInfo);
	int insertProduct(ProductInfo productInfo);
	int insertCategoryRef(ProductInfo productInfo);
	int statusModifyAction(ProductInfo productInfo);
	ProductInfo getProductInfo(ProductInfo productInfo);
	List<ProductInfo> getProductCategoryList(ProductInfo productInfo);
	FileInfo getProductFileList(ProductInfo productInfo);
	int updateProduct(ProductInfo productInfo);
	int deleteProductRef(ProductInfo productInfo);
	List<LinkedHashMap<String, String>> listExcel(ProductInfo productInfo);
}
