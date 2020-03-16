package com.ncomz.nshop.service.admin.mypage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nshop.dao.admin.mypage.MyPageMapper;
import com.ncomz.nshop.dao.login.LoginMapper;
import com.ncomz.nshop.domain.admin.mypage.MyPage;
import com.ncomz.nshop.domain.authorization.User;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.utillty.SHA256Util;


@Service
public class MyPageService {

	@Autowired
	private MyPageMapper myPageMapper;
	
	@Autowired
	private LoginMapper loginMapper;

	@Transactional
	public String modifyPassword(MyPage myPage) {
		String resultMsg="fail";
		try {
			SessionUser sessionUser = loginMapper.login(myPage.getUsrId(), SHA256Util.getEncrypt(myPage.getCurrentPwd()));
			
			if(sessionUser != null){
				myPage.setNewPwd(SHA256Util.getEncrypt(myPage.getNewPwd()));
				if(myPageMapper.modifyPassword(myPage)>0){
					resultMsg="succ";
				}
			}else{
				resultMsg="notmatch";
			}
			return resultMsg;
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	@Transactional
	public User myAccountselect(String user){
		
		User userInfomation = myPageMapper.myaccountselect(user);
		
		return myPageMapper.myaccountselect(user);
		
	}
	
	@Transactional
	public String updateMemberAction(User user) {
		String resultMsg = "";
		try {
			if(myPageMapper.updateMemberInfo(user)){
				System.out.println("test0620success");
				resultMsg = "successUpdate";
			}else{
				resultMsg = "failUpdate";
			}
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			return e.getMessage();
		}
		return resultMsg;
	}
	
	
}
