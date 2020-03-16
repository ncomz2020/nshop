package com.ncomz.nshop.dao.admin.popup;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.popup.PopupInfo;

@Component
public interface PopupMapper {
	List<PopupInfo> getPopupList(PopupInfo popupInfo);
	int getPopupCount(PopupInfo popupInfo);
	int insertAction(PopupInfo popupInfo);
	PopupInfo getPopupInfo(PopupInfo popupInfo);
	int updateAction(PopupInfo popupInfo);
	int deleteAction(PopupInfo popupInfo);
}
