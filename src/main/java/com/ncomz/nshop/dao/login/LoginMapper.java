package com.ncomz.nshop.dao.login;

import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.authorization.User;
import com.ncomz.nshop.domain.common.SessionUser;

@Component
public interface LoginMapper {

	/**
	 * 사용자 계정 잠금 여부 확인.
	 *
	 * @param usrId 사용자ID
	 * @return String
	 */
	String getAccountLock(@Param("usrId")String usrId);
	
	/**
	 * 세션 유저 조회.
	 *
	 * @param usrId 사용자ID
	 * @param password 비밀번호
	 * @return SessionUser
	 */
	SessionUser login(@Param("usrId")String usrId, @Param("pswd")String pswd);

	SessionUser loginfront(@Param("usrId")String usrId, @Param("pswd")String pswd);

	/**
	 * 최종 로그인 시간 저장.
	 *
	 * @param sessionUser 세션 유저
	 */
	void updateLastLoginDateTime(@Param("sessionUser")SessionUser sessionUser);
	
	/**
	 * 로그인 일자 조회.
	 *
	 * @param usrId 사용자ID
	 * @return Map<String,String>
	 */
	Map<String, String>	getLoginDate(@Param("usrId") String usrId);

	
	/**
	 * 로그인 실패 횟수 저장.
	 *
	 * @param usrId 사용자ID
	 * @return int
	 */
	int updateLoginFailCount(@Param("usrId")String usrId);

	/**
	 * 사용자 계정 잠금 처리.
	 *
	 * @param usrId 사용자ID
	 * @return int
	 */
	int setAccountLock(@Param("usrId")String usrId);

	/**
	 * 로그인 실패 횟수 조회.
	 *
	 * @param usrId 사용자ID
	 * @return Integer
	 */
	int getLoginFailCount(@Param("usrId") String usrId);

	/**
	 * Email 존재 유무 확인 
	 * 
	 * @param email
	 * @return
	 */
	int countEmail(@Param("email")String email);

	/**
	 * ID 중복 체크
	 * 
	 * @param usr_id
	 */
	int chkId(String usr_id);
	
	/**
	 * Email 중복 체크
	 * 
	 * @param usr_id
	 */
	int chkEmail(String email);

	/**
	 * 새로운 계정 생성
	 * 
	 * @param user
	 * @return
	 */
	boolean insertNewMember(User user);

	
	/**
	 * 유저 존재 유무 확인
	 * 
	 * @param textId
	 * @return
	 */
	int countPresenceId(String textId);

	/**
	 * 임시 비밀번호 설정
	 * 
	 * @param email, newPswd
	 * @return
	 */
	boolean updatePswd(User user);
	
	/**
	 * 임시 비밀번호 설정 - 이름, 메일 두개 값 받음
	 * 
	 * @param email, usr_nm, newPswd
	 * @return
	 */
	boolean updatePsw(User user);
	/**
	 * 사용자 아이디 찾기.
	 *
	 * @param usrNm 사용자이름 , email 메일
	 * @return String
	 */
	String searchId(@Param("usr_nm")String usr_nm, @Param("email")String email);
}
