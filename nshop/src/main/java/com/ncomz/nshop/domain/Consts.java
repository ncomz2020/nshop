package com.ncomz.nshop.domain;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;


/**
 * 시스템 상수 정의 클래스
 *
 * <PRE>
 * 1. ClassName: Consts
 * 2. FileName : Consts.java
 * 3. Package  : com.ntels.aem.domain
 * 4. 작성자   : smyun
 * 5. 작성일   : 2015. 3. 11. 오전 15:30:00
 * 6. 변경이력
 *		이름	:	일자	: 변경내용
 *     ———————————————————————————————————————————
 *		kgw :	2015. 3. 11.	: 신규 개발.
 *
 * </PRE>
 */
public abstract class Consts {
	/** 사용자 생성 이메일 발신자. */
	public static final String ADDUSER_MAIL_FROM = "sender@ntels.com";
	/** 사용자 생성 이메일. */
	public static final String ADDUSER_MAIL_SUBJECT = "Smart Signage  신규 계정 발급이 완료되었습니다.";
	/** 어드민 사용자 레벨. */
	public static final String ADMIN_USER_LEVEL = "00";
	/** 사용자 그룹코드. */
	public static final String ADMIN_USER_TYPE = "USR001";
	/**
	 * 세션항목.
	 *
	 * <PRE>
	 * 1. ClassName: SessionAttr
	 * 2. FileName : Consts.java
	 * 3. Package  : com.ntels.aem.domain
	 * 4. 작성자   : smyun
	 * 5. 작성일   : 2015. 3. 10. 오후 15:30:00
	 * 6. 변경이력
	 *		이름	:	일자	: 변경내용
	 *     ———————————————————————————————————————————
	 *		smyun :	2015. 3. 10.	: 신규 개발.
	 *
	 * </PRE>
	 */
	public abstract static class SessionAttr {
		/** 세션 사용자 정보. */
		public static final String USER = "session_user";

		/** 세션 국가 정보. */
		public static final String COUNTRY = "sessionCountry";

		/** 세션 언어 정보. */
		public static final String LANG = "sessionLanguage";
		
		/** 세션 언어 정보. */
		public static final String CATGRY = "categoryList";
	}

	/**
	 * 공통_그룹_코드.
	 *
	 * <PRE>
	 * 1. ClassName: COMMON_GROUP_CODE
	 * 2. FileName : Consts.java
	 * 3. Package  : com.ntels.aem.domain
	 * 4. 작성자   : kkw
	 * 5. 작성일   : 2015. 3. 10. 오후 15:30:00
	 * 6. 변경이력
	 *		이름	:	일자	: 변경내용
	 *     ———————————————————————————————————————————
	 *		smyun :	2015. 3. 10.	: 신규 개발.
	 *
	 * </PRE>
	 */
	public abstract static class COMMON_GROUP_CODE {
		/** 국가그룹코드. */
		public static final String PRODUCT_STATUS_CODE 	= "P001";
	}
	
	/**
	 *
	 * 파일구분코드.
	 *
	 * @author kgw
	 *
	 */
	public abstract static class FILE_TYPE_GROUP {

		/** 영어. */
		public static final String PRODUCT 		= "prod";
		public static final String PROD_CONTENTS		= "prod_contents";
		
		public static final String STORE_LOGO        ="stroe logo";           // 상점로고
		public static final String STORE_COMP_REG    ="stroe comp reg copy";  // 사업자등록증사본
	}


	/**
	 *
	 * 언어코드.
	 *
	 * @author kgw
	 *
	 */
	public abstract static class CountryCode {

		/** 영어. */
		public static final String ENGLISH 		= "US";

		/** 한국어. */
		public static final String KOREAN 		= "KR";

		/** 러시아어. */
		public static final String RUSSIA       = "RU";

		/** 우즈벡어. */
		public static final String UZBEKISTAN   = "UZ";
	}

	/**
	 *
	 * 언어코드.
	 *
	 * @author kenu
	 *
	 */
	public abstract static class LanguageCode {
		
		public static final String GROUPCODE = "LANGUAGE";

		/** 영어. */
		public static final String ENGLISH 		= "en";

		/** 한국어. */
		public static final String KOREAN 		= "ko";

		/** 러시아어. */
		public static final String RUSSIA       = "ru";

		/** 우즈벡어. */
		public static final String UZBEKISTAN   = "uz";
	}



	/**
	 *
	 * TODO: 언어 코드 맵 : 서비스 국가 확장시에 확장되는 언어코드를 추가해줘야한다.
	 *
	 * 1. 구성관리 >> 공통코드 국가코드 추가
	 * 2. 구성관리 >> 공통코드 언어코드 추가
	 * 3. 구성관리 >> 국가별 언어 >> 언어 추가
	 * 4. 아래 소스 코드 추가
	 */
	public static final Map<String, String> LANGUAGE_CODE_MAP;
	static {
		Map<String, String> map = new HashMap<String, String>();
		map.put(LanguageCode.ENGLISH, "en");
		map.put(LanguageCode.KOREAN, "ko");
		map.put(LanguageCode.RUSSIA, "ru");
		map.put(LanguageCode.UZBEKISTAN, "uz");
		LANGUAGE_CODE_MAP = Collections.unmodifiableMap(map);
	}
		
}
