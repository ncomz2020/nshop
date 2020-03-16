package com.ncomz.nshop.dao.admin.common.menu;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.common.Menu;
import com.ncomz.nshop.domain.admin.common.UserGroup;

@Component
public interface MenuMapper {

	List<Menu> getMenuList(Menu menu);
	List<Menu> getAllUserGroupMenuList(UserGroup userGroup);
	List<Menu> getUserGroupMenuList(UserGroup userGroup);
	int insertMenu(Menu menu);
	Menu getMenu(Menu menu);
	int updateMenuInfo(Menu menu);
	int updateOldDisplayOrders(Menu old);
	int updateNewDisplayOrders(Menu old);
	int updateMenuPosition(Menu menu);
	int deleteMenuInfo(Menu menu);
	int insertMenuLanguage(Menu menu);
	int deleteMenuLanguage(Menu menu);
	List<Menu> getMenuLanguageList(Menu menu);
	int countMenuAuth(Menu menu);
	
}