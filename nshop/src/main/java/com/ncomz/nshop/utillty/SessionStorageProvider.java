package com.ncomz.nshop.utillty;

import javax.servlet.http.HttpServletRequest;

/**
 * 세션 저장소 인터페이스
 *
 * <PRE>
 * 1. ClassName: SessionStorageProvider
 * 2. FileName : SessionStorageProvider.java
 * 3. Package  : com.samsung.mssp.cm.common.util
 * 4. 작성자   : hyperseo
 * 5. 작성일   : 2014. 5. 29. 오후 3:47:52
 * 6. 변경이력
 *		이름	:	일자	: 변경내용
 *     ———————————————————————————————————————————
 *		hyperseo :	2014. 5. 29.	: 신규 개발.
 *
 * </PRE>
 * <br/>
 * <br/>
 * Copyright 2014 by Samsung Electronics, Inc.,
 * 
 * This software is the confidential and proprietary information
 * of Samsung Electronics, Inc. ("Confidential Information").  You
 * shall not disclose such Confidential Information and shall use
 * it only in accordance with the terms of the license agreement
 * you entered into with Samsung.
 */
public interface SessionStorageProvider {
	
	/**
	 * Session 속성을 구한다.
	 *
	 * @param	request : request
	 * @param	key : key
	 * @return	Object
	*/
	public Object getAttribute(HttpServletRequest request, String key);
	
	/**
	 * Session 속성을 구한다.
	 *
	 * @param	sessionId : sessionId
	 * @param	key : key
	 * @return	Object
	*/
	public Object getAttribute(String sessionId, String key);	
	
	/**
	 * Session 속성을 설정한다.
	 *
	 * @param	request : request
	 * @param	key : key
	 * @param	value : value
	 * @return	
	*/
	public void setAttribute(HttpServletRequest request, String key, Object value);
	
	/**
	 * Session 속성을 삭제한다.
	 *
	 * @param	request : request
	 * @param	key : key
	 * @return	
	*/
	public void removeAttribute(HttpServletRequest request, String key);
	
	
}
