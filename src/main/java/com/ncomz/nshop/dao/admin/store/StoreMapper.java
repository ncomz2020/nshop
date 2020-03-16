package com.ncomz.nshop.dao.admin.store;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.store.StoreInfoMgmt;

@Component
public interface StoreMapper {

	List<StoreInfoMgmt> list(StoreInfoMgmt storeInfoMgmt);
	List<StoreInfoMgmt> getStoreList(StoreInfoMgmt storeInfoMgmt);
	List<LinkedHashMap<String, String>> listExcel(StoreInfoMgmt storeInfoMgmt);
	StoreInfoMgmt getStoreInfo(StoreInfoMgmt storeInfoMgmt);
	int getStoreCount(StoreInfoMgmt storeInfoMgmt);
	int countStore(String store_id);
	
	int insertAction(StoreInfoMgmt StoreInfoMgmt);
	int updateAction(StoreInfoMgmt StoreInfoMgmt);
	int updateStoreAuthStateAction(StoreInfoMgmt StoreInfoMgmt);
	int statUpdateAction(StoreInfoMgmt storeInfoMgmt);
}
