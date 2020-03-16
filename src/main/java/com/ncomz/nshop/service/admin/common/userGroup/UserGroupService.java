package com.ncomz.nshop.service.admin.common.userGroup;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ncomz.nshop.dao.admin.common.userGroup.UserGroupMapper;
import com.ncomz.nshop.domain.admin.common.Menu;
import com.ncomz.nshop.domain.admin.common.UserGroup;
import com.ncomz.nshop.domain.admin.common.UserGroupAuth;
import com.ncomz.nshop.domain.common.DynatreeNode;
import com.ncomz.nshop.service.admin.common.menu.MenuService;
import com.ncomz.nshop.utillty.StringUtil;

@Service
public class UserGroupService {
	
	@Autowired
	private UserGroupMapper userGroupMapper;
	
	@Autowired
	private MenuService menuService;
	
	public int getUserGroupCount(UserGroup userGroup) {
		return userGroupMapper.getUserGroupCount(userGroup);
	}
	
	public List<UserGroup> getUserGroupList(UserGroup userGroup) {
		return userGroupMapper.getUserGroupList(userGroup);
	}
	
	public UserGroup getUserGroup(UserGroup userGroup) {
		return userGroupMapper.getUserGroup(userGroup);
	}
	
	@Transactional
	public String insertAction(UserGroup userGroup) {
		try {
			userGroupMapper.insertUserGroup(userGroup);
			String user_group_auth_string = userGroup.getUser_group_auth_string();
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(user_group_auth_string);
			if (element instanceof JsonArray) {
				JsonArray arr = (JsonArray)element;
				for (int i=0;i<arr.size();i++) {
					JsonObject obj = arr.get(i).getAsJsonObject();
					this.insertUserGroupAuth(userGroup, obj);
				}
			} else {
				JsonObject obj = element.getAsJsonObject();
				this.insertUserGroupAuth(userGroup, obj);
			}
			menuService.clearMenuCache();
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	@Transactional
	public String updateAction(UserGroup userGroup) {
		try {
			userGroupMapper.updateUserGroup(userGroup);
			userGroupMapper.deleteUserGroupAuth(userGroup);
			String user_group_auth_string = userGroup.getUser_group_auth_string();
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(user_group_auth_string);
			if (element instanceof JsonArray) {
				JsonArray arr = (JsonArray)element;
				for (int i=0;i<arr.size();i++) {
					JsonObject obj = arr.get(i).getAsJsonObject();
					this.insertUserGroupAuth(userGroup, obj);
				}
			} else {
				JsonObject obj = element.getAsJsonObject();
				this.insertUserGroupAuth(userGroup, obj);
			}
			menuService.clearMenuCache();
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	@Transactional
	public String deleteAction(UserGroup userGroup) {
		try {
			if (userGroupMapper.countUser(userGroup) > 0) {
				return "사용자가 존재하는 그룹을 삭제할 수 없습니다.";
			}
			userGroupMapper.deleteUserGroup(userGroup);
			userGroupMapper.deleteUserGroupAuth(userGroup);
			menuService.clearMenuCache();
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	public void insertUserGroupAuth(UserGroup userGroup, JsonObject obj) throws Exception {
		Gson gson = new Gson();
		UserGroupAuth userGroupAuth = gson.fromJson(obj, UserGroupAuth.class);
		if (!StringUtil.isEmpty(userGroupAuth.getAuth_tp())) {
			userGroupAuth.setUsr_grp_id(userGroup.getUsr_grp_id());
			userGroupMapper.insertUserGroupAuth(userGroupAuth);
		}
	}
	
}
