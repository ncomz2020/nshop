package com.ncomz.nshop.dao.admin.common.userGroup;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.common.UserGroup;
import com.ncomz.nshop.domain.admin.common.UserGroupAuth;

@Component
public interface UserGroupMapper {

	public int getUserGroupCount(UserGroup userGroup);
	public List<UserGroup> getUserGroupList(UserGroup userGroup);
	public UserGroup getUserGroup(UserGroup userGroup);
	int insertUserGroup(UserGroup userGroup);
	int updateUserGroup(UserGroup userGroup);
	int deleteUserGroupAuth(UserGroup userGroup);
	int insertUserGroupAuth(UserGroupAuth userGroupAuth);
	int deleteUserGroup(UserGroup userGroup);
	int countUser(UserGroup userGroup);
	
}
