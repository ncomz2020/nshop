package com.ncomz.nshop.utillty;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * 
 * The Class MessageUtil.
 *
 * <PRE>
 * 1. ClassName: MessageUtil
 * 2. FileName : MessageUtil.java
 * 3. Package  : com.samsung.mssp.nisf.util.message
 * 4. 작성자   : kgw
 * 5. 작성일   : 2014. 6. 17. 오후 2:38:46
 * 6. 변경이력
 *		이름	:	일자	: 변경내용
 *     ———————————————————————————————————————————
 *		kgw :	2014. 6. 17.	: 신규 개발.
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
public class MessageUtil {

	/** The ms acc. */
	private static MessageSourceAccessor msAcc = null;
	
	/**
	 * Sets the message source accessor.
	 *
	 * @param msAcc : the new message source accessor
	 * @return 
	 */
	// prevent kgw -> smyun.id
	public void setMessageSourceAccessor(MessageSourceAccessor _msAcc) {
		if (msAcc == null) {
			msAcc = _msAcc;
		}
	}
	
	/**
	 * 키에 해당하는 메세지 반환
	 *
	 * @param key : the key
	 * @return String : the message
	 */
	public static String getMessage(String key) {
		Locale locale = LocaleContextHolder.getLocale();
		return msAcc.getMessage(key, locale);
	}
	
	/**
	 * 키에 해당하는 메세지 반환 (파라미터 포함)
	 *
	 * @param key : the key
	 * @param objs : the objs
	 * @return String : the message
	 */
	public static String getMessage(String key, Object[] objs) {
		Locale locale = LocaleContextHolder.getLocale();
		return msAcc.getMessage(key, objs, locale);
	}
}
