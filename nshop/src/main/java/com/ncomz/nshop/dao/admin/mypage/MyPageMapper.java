package com.ncomz.nshop.dao.admin.mypage;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.mypage.MyPage;
import com.ncomz.nshop.domain.authorization.User;

@Component
public interface MyPageMapper {
	int modifyPassword(MyPage myPage);
	
	User myaccountselect(String user);

	boolean updateMemberInfo(User user);
}
