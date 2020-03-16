package com.ncomz.nshop.service.admin.store;

import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nshop.dao.admin.store.StoreMapper;
import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.store.StoreInfoMgmt;
import com.ncomz.nshop.domain.common.FileInfo;
import com.ncomz.nshop.service.common.FileService;
import com.ncomz.nshop.utillty.StringUtil;


@Service
public class StoreService {

	@Autowired
	private StoreMapper storeMapper;
	@Autowired
	private FileService fileService;


	public int getStoreInfoCount(StoreInfoMgmt storeInfoMgmt) {
		return storeMapper.getStoreCount(storeInfoMgmt);
	}
	
	public List<StoreInfoMgmt> getStoreInfoList(StoreInfoMgmt storeInfoMgmt) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		storeInfoMgmt.setLanguage(language);
		return storeMapper.list(storeInfoMgmt);
	}
	
	public List<StoreInfoMgmt> getStoreList(StoreInfoMgmt storeInfoMgmt) {
		return storeMapper.getStoreList(storeInfoMgmt);
	}
	
	public int getStoreCount(StoreInfoMgmt storeInfoMgmt) {
		return storeMapper.getStoreCount(storeInfoMgmt);
	}
	
	public List<LinkedHashMap<String, String>> listExcel(StoreInfoMgmt storeInfoMgmt) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		storeInfoMgmt.setLanguage(language);
		return storeMapper.listExcel(storeInfoMgmt);
	}
	
	
	public StoreInfoMgmt getStoreInfo(StoreInfoMgmt storeInfoMgmt) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		storeInfoMgmt.setLanguage(language);
		return storeMapper.getStoreInfo(storeInfoMgmt);
	}
	
	
	@Transactional
	public String statUpdateAction(StoreInfoMgmt storeInfoMgmt) {
		try {
			storeMapper.statUpdateAction(storeInfoMgmt);
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	
	@Transactional
	public String insertAction(StoreInfoMgmt storeInfoMgmt) {
		try {

			if (!StringUtil.isEmpty(storeInfoMgmt.getComp_reg_copy())) {
				List<String> fileIdList = Arrays.asList(storeInfoMgmt.getComp_reg_copy());
				fileService.updateFileType(fileIdList, Consts.FILE_TYPE_GROUP.STORE_COMP_REG, storeInfoMgmt.getStore_id(), "N");
			}
			
			if (!StringUtil.isEmpty(storeInfoMgmt.getStore_logo())) {
				List<String> fileIdList = Arrays.asList(storeInfoMgmt.getStore_logo());
				fileService.updateFileType(fileIdList, Consts.FILE_TYPE_GROUP.STORE_LOGO, storeInfoMgmt.getStore_id(), "N");
			}
			
			storeMapper.insertAction(storeInfoMgmt);
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	
	@Transactional
	public String updateAction(StoreInfoMgmt storeInfoMgmt) {
		try {
			
			MultipartFile file = storeInfoMgmt.getFile1();
			if (!StringUtil.isEmpty(storeInfoMgmt.getComp_reg_copy())) {
				fileService.updateFileTypeTempYn(Consts.FILE_TYPE_GROUP.STORE_COMP_REG, storeInfoMgmt.getStore_id(), "Y");
				List<String> compFileIdList = Arrays.asList(storeInfoMgmt.getComp_reg_copy());
				fileService.updateFileType(compFileIdList, Consts.FILE_TYPE_GROUP.STORE_COMP_REG, storeInfoMgmt.getStore_id(), "N");
				
			}
			
			if (!StringUtil.isEmpty(storeInfoMgmt.getStore_logo())) {
				fileService.updateFileTypeTempYn(Consts.FILE_TYPE_GROUP.STORE_LOGO, storeInfoMgmt.getStore_id(), "Y");
				List<String> fileIdList = Arrays.asList(storeInfoMgmt.getStore_logo());
				fileService.updateFileType(fileIdList, Consts.FILE_TYPE_GROUP.STORE_LOGO, storeInfoMgmt.getStore_id(), "N");
			}
			
			storeMapper.updateAction(storeInfoMgmt);
			return "succ";
			
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	
	@Transactional
	public String updateStoreAuthStateAction(StoreInfoMgmt storeInfoMgmt) {
		try {
			storeMapper.updateStoreAuthStateAction(storeInfoMgmt);
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
}
