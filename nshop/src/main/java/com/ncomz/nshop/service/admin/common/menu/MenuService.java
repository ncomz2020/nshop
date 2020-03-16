package com.ncomz.nshop.service.admin.common.menu;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nshop.dao.admin.common.menu.MenuMapper;
import com.ncomz.nshop.domain.admin.common.Code;
import com.ncomz.nshop.domain.admin.common.Menu;
import com.ncomz.nshop.domain.admin.common.UserGroup;
import com.ncomz.nshop.domain.common.DynatreeNode;
import com.ncomz.nshop.service.admin.common.code.CodeService;
import com.ncomz.nshop.utillty.MessageUtil;
import com.ncomz.nshop.utillty.StringUtil;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

@Service
public class MenuService {

	@Autowired
	private MenuMapper menuMapper;
	
	@Autowired
	private Ehcache ehcache;
	
	public DynatreeNode getTreeAction() {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		Menu menu = new Menu();
		menu.setLanguage(language);
		DynatreeNode root = new DynatreeNode();
		root.setKey("0");
		root.setTitle(MessageUtil.getMessage("label.menu.manage"));
		root.setIsFolder(true);
		root.setChildren(this.buildTree(menuMapper.getMenuList(menu), "0"));
		return root;
	}
	
	public DynatreeNode getTreeAction(UserGroup userGroup) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		userGroup.setLanguage(language);
		DynatreeNode root = new DynatreeNode();
		root.setKey("0");
		root.setTitle(MessageUtil.getMessage("label.menu.manage"));
		root.setIsFolder(true);
		root.setChildren(this.buildTree(menuMapper.getAllUserGroupMenuList(userGroup), "0"));
		return root;
	}
	
	public List<DynatreeNode> buildTree(List<Menu> menuList, String parentId) {
		List<DynatreeNode> tree = new ArrayList<DynatreeNode>();
		for (int i=0;i<menuList.size();i++) {
			Menu menu = menuList.get(i);
			if (StringUtil.compare(menu.getParent_id(), parentId) == 0) {
				DynatreeNode node = new DynatreeNode();
				node.setKey(menu.getMenu_id());
				node.setTitle(menu.getTitle());
				node.setAuth_tp(menu.getAuth_tp());
				List<DynatreeNode> children = this.buildTree(menuList, menu.getMenu_id());
				node.setChildren(children);
				if (children.size() > 0) {
					node.setIsFolder(true);
				}
				tree.add(node);
			}
		}
		return tree;
	}
	
	public List<Menu> buildMenuTree(List<Menu> menuList, String parentId) {
		List<Menu> tree = new ArrayList<Menu>();
		for (int i=0;i<menuList.size();i++) {
			Menu menu = menuList.get(i);
			if (StringUtil.compare(menu.getParent_id(), parentId) == 0) {
				List<Menu> children = this.buildMenuTree(menuList, menu.getMenu_id());
				menu.setChildren(children);
				tree.add(menu);
			}
		}
		return tree;
	}
	
	@Transactional
	public String insertAction(Menu menu) {
		try {
			menuMapper.insertMenu(menu);
			
			String[] languageCode = menu.getLanguageCode();
			String[] languageTitle = menu.getLanguageTitle();
			for (int i=0;i<languageCode.length;i++) {
				Menu menuLanguage = new Menu();
				menuLanguage.setMenu_id(menu.getMenu_id());
				menuLanguage.setLanguage(languageCode[i]);
				menuLanguage.setTitle(languageTitle[i]);
				menuMapper.insertMenuLanguage(menuLanguage);
			}
			
			this.clearMenuCache();
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	public Menu getMenu(Menu menu) {
		return menuMapper.getMenu(menu);
	}
	
	@Transactional
	public String updateAction(Menu menu) {
		try {
			menuMapper.updateMenuInfo(menu);
			
			menuMapper.deleteMenuLanguage(menu);
			
			String[] languageCode = menu.getLanguageCode();
			String[] languageTitle = menu.getLanguageTitle();
			for (int i=0;i<languageCode.length;i++) {
				Menu menuLanguage = new Menu();
				menuLanguage.setMenu_id(menu.getMenu_id());
				menuLanguage.setLanguage(languageCode[i]);
				menuLanguage.setTitle(languageTitle[i]);
				menuMapper.insertMenuLanguage(menuLanguage);
			}
			
			this.clearMenuCache();
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	@Transactional
	public String moveAction(Menu menu) {
		try {
			Menu old = menuMapper.getMenu(menu);
			// 기존 부모 하위의 display_order 를 업데이트
			menuMapper.updateOldDisplayOrders(old);
			
			// 새로운 부모 하위의 display_order 를 업데이트
			menuMapper.updateNewDisplayOrders(menu);
			
			// category 위치 업데이트
			menuMapper.updateMenuPosition(menu);
			
			this.clearMenuCache();
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	@Transactional
	public String deleteAction(Menu menu) {
		try {
			menuMapper.deleteMenuInfo(menu);
			
			menuMapper.deleteMenuLanguage(menu);
			
			this.clearMenuCache();
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	public void clearMenuCache() {
		Cache menuCache = ehcache.getCacheManager().getCache("menuCache");
		menuCache.removeAll();
	}
	
	@SuppressWarnings("unchecked")
	public List<Menu> getUserGroupMenuList(String usr_grp_id) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		List<Menu> listMenu = null;
		String key = usr_grp_id+"_"+language;
		Cache menuCache = ehcache.getCacheManager().getCache("menuCache");
		Element menuElement = menuCache.get(key);
		if (menuElement != null && menuElement.getObjectValue() != null) {
			listMenu = (List<Menu>)menuElement.getObjectValue();
		} else {
			UserGroup userGroup = new UserGroup();
			userGroup.setUsr_grp_id(usr_grp_id);
			userGroup.setLanguage(language);
			listMenu = this.buildMenuTree(menuMapper.getUserGroupMenuList(userGroup), "0");
			menuElement = new Element(key, listMenu);
			menuCache.put(menuElement);
		}
		return listMenu;
	}
	
	public List<Menu> getMenuLanguageList(Menu menu) {
		return menuMapper.getMenuLanguageList(menu);
	}
	
	public int countMenuAuth(Menu menu) {
		return menuMapper.countMenuAuth(menu);
	}
	
}
