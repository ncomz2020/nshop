package com.ncomz.nshop.dao.front.product;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.domain.common.FileInfo;

@Component
public interface ProductListMapper {
	List<ProductInfo> getProductList(ProductInfo productInfo);
	List<ProductInfo> getFrontProductList(ProductInfo productInfo);
	int getProductCount(ProductInfo productInfo);	
	ProductInfo getProductInfo(ProductInfo productInfo);
	ProductInfo getCategoryPath(ProductInfo productInfo);
	List<ProductInfo> getProductCategoryList(ProductInfo productInfo);
	FileInfo getProductFileList(ProductInfo productInfo);
	List<FileInfo> getFileList(ProductInfo productInfo);
	int updateProduct(ProductInfo productInfo);
	int deleteProductRef(ProductInfo productInfo);
	
}
