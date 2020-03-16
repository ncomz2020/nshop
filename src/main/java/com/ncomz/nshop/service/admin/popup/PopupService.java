package com.ncomz.nshop.service.admin.popup;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nshop.dao.admin.popup.PopupMapper;
import com.ncomz.nshop.domain.admin.popup.PopupInfo;
import com.ncomz.nshop.domain.common.FileInfo;
import com.ncomz.nshop.service.common.FileService;
@Service
public class PopupService {

	@Autowired
	private PopupMapper popupMapper;
	
	@Autowired
	private FileService fileService;
	

	@Transactional
	public String insertAction(PopupInfo popupInfo) {
		try {
			
			MultipartFile file = popupInfo.getFile1();
			if (file != null) {
				FileInfo fileInfo = fileService.saveFile(popupInfo.getFile1());
				popupInfo.setFile_id(fileInfo.getFile_id());
			}
			if (popupMapper.insertAction(popupInfo) <= 0) {
				throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
			}

			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	

	public List<PopupInfo> getPopupList(PopupInfo popupInfo) {
		List<PopupInfo> popupList = popupMapper.getPopupList(popupInfo);
		return popupList;
	}


	public int getPopupCount(PopupInfo popupInfo) {
		return popupMapper.getPopupCount(popupInfo);
	}

	
	public PopupInfo getPopupInfo(PopupInfo popupInfo) {
		return popupMapper.getPopupInfo(popupInfo);
	}
	
	
	@Transactional
	public String updateAction(PopupInfo popupInfo) {
		try {
			MultipartFile file = popupInfo.getFile1();
			if (file != null) {
				fileService.deleteFile(popupInfo.getFile_id());
				FileInfo fileInfo = fileService.saveFile(file);
				popupInfo.setFile_id(fileInfo.getFile_id());
			}
			if (popupMapper.updateAction(popupInfo) <= 0) {
				throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
			}
			
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	

	
	@Transactional
	public String deleteAction(PopupInfo popupInfo) {
		try {
			if (popupMapper.deleteAction(popupInfo) <= 0) {
				throw new Exception("오류가 발생하였습니다. 관리자에게 문의하세요.");
			}
			
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
}
