package com.ncomz.nshop.dao.admin.member;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.common.FileMgmt;
import com.ncomz.nshop.domain.authorization.User;


@Component
public interface MemberMapper {

	/*일반고객*/
	List<User> getUserList(User user);
	List<User> getUserInfo(User user);
	int getUserListCount(User user);
	int deleteUser(String usr_id);
	
	/*일반고객 export*/
	List<LinkedHashMap<String, String>> listcustomerExcel(User user);
	
	/*판매자*/
	List<User> getsellerUserList(User user);
	List<User> getsellerUserInfo(User user);
	int getsellerUserListCount(User user);

	/*판매자 export*/
	List<LinkedHashMap<String, String>> listsellerExcel(User user);
}
