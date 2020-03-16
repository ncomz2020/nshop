package com.ncomz.nshop.dao.login;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.login.LoginHistory;

@Component
public interface LoginHistoryMapper {
	/**
	 * 등록.
	 *
	 * @param loginHistory 로그인이력정보
	 * @return int
	 */
   	int insert(LoginHistory loginHistory);
}
