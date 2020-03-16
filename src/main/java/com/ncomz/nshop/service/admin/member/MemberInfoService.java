package com.ncomz.nshop.service.admin.member;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nshop.dao.admin.member.MemberMapper;
import com.ncomz.nshop.domain.admin.common.FileMgmt;
import com.ncomz.nshop.domain.authorization.User;
import com.ncomz.nshop.service.common.SecurityService;

@Service
public class MemberInfoService {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private MemberMapper MemberMapper;
	private SecurityService securityservice;
	
	
	/*일반고객회원리스트*/
	public List<User> getUserList(User user){
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		user.setLang_cd(language);
		
		List<User> userList = MemberMapper.getUserList(user);
		
		return userList;
	}
	/*판매자회원리스트*/
	public List<User> getsellerUserList(User user){
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		user.setLang_cd(language);
		
		List<User> userList = MemberMapper.getsellerUserList(user);
		
		return userList;
	}
	
	/*일반고객회원정보*/
	public List<User> getUserInfo(User user){
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		user.setLang_cd(language);
		
		List<User> userList = MemberMapper.getUserInfo(user);
		
		return userList;
	}
	
	/*판매자회원정보*/
	public List<User> getsellerUserInfo(User user){
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		user.setLang_cd(language);
		
		List<User> userList = MemberMapper.getsellerUserInfo(user);
		
		return userList;
	}
	
	/*일반고객회원 수*/
	public int getUserListCount(User user) {
		return MemberMapper.getUserListCount(user);
	}
	
	/*판매자회원 수*/
	public int getsellerUserListCount(User user) {
		return MemberMapper.getsellerUserListCount(user);
	}
	
	/*회원 탈퇴처리*/
	@Transactional
	public String deleteUser(String usr_id){
		
		try {
			if(MemberMapper.deleteUser(usr_id) == 1){
				return "success";
			}
			else{
				return "error";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			return "error";
		}	
	}
	
	/*data export*/
	public List<LinkedHashMap<String, String>> listsellerExcel(User user) {
		//언어 타입 설정.
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		
		user.setLang_cd(language);
		return MemberMapper.listsellerExcel(user);
	}
	/*data export*/
	public List<LinkedHashMap<String, String>> listcustomerExcel(User user) {
		//언어 타입 설정.
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		
		user.setLang_cd(language);
		return MemberMapper.listcustomerExcel(user);
	}
}
