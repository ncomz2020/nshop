package com.ncomz.nshop.utillty;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.utillty.HttpSessionStorageImpl;
import com.ncomz.nshop.utillty.SessionStorageProvider;

public final class SessionUtil {

	/** Logger. */
	private static final Logger LOG = LoggerFactory.getLogger(SessionUtil.class);


	/** 세션 저장소 provider. */
	private static final List<SessionStorageProvider> SESSION_STORAGE_PROVIDERS = new ArrayList<SessionStorageProvider>();

	//private static final String SESSION_COOKIE_NAME = PropertiesUtil.get("config", "aws.elb.cookie.name");

	/** 세션 타입. */
	private static final String SESSION_STORAGE = "was";


	/**
	 * 생성자 생성불가.
	 */
	private SessionUtil() {
		throw new AssertionError("Unacceptable Constructor");
	}

	/**
	 * 세션제공자를 최기화 한다.
	 *
	 * @param
     * @warning
	 * @exception	RuntimeException
     * @see
	*/
	public static void initProvider() {

		synchronized (SessionUtil.class) {
			if (SESSION_STORAGE_PROVIDERS.size() > 0) {
				return;
			}

			LOG.debug("SessionUtil.initProvider SESSION_STORAGE := [{}]", SESSION_STORAGE);
			SessionStorageProvider sessionProvider = new HttpSessionStorageImpl();
			SESSION_STORAGE_PROVIDERS.add(sessionProvider);

			LOG.debug("Session Providers SESSION_STORAGE_PROVIDERS := {}", SESSION_STORAGE_PROVIDERS.toString());

			if (SESSION_STORAGE_PROVIDERS.size() == 0) {
				throw new RuntimeException("The property 'session.storage' was not defined !!!.");
			}
		}
	}

	/**
	 * 세션값을 구한다.
	 *
	 * @param request request
	 * @param key key
	 * @return Object
	 */
	public static Object getAttribute(final HttpServletRequest request, final String key) {
		for (SessionStorageProvider sessionProvider : SESSION_STORAGE_PROVIDERS) {
			Object obj = sessionProvider.getAttribute(request, key);
			if (obj != null) {
				return obj;
			} else {
				continue;
			}
		}

		return null;
	}

	/**
	 * getAttribute.
	 *
	 * @param key key
	 * @return Object
	 */
	public static Object getAttribute(final String key) {
		for (SessionStorageProvider sessionProvider : SESSION_STORAGE_PROVIDERS) {
			Object obj = sessionProvider.getAttribute("", key);
			if (obj != null) {
				return obj;
			} else {
				continue;
			}
		}

		return null;
	}


	/**
	 * 분산환경에서 세션값을 저장한다.
	 *
	 * @param request request
	 * @param key key
	 * @param value value
	 */
	public static void setAttribute(final HttpServletRequest request, final String key, final Object value) {
		for (SessionStorageProvider sessionProvider : SESSION_STORAGE_PROVIDERS) {
			sessionProvider.setAttribute(request, key, value);
		}
	}

	/**
	 * 세션값을 삭제한다.
	 *
	 * @param request request
	 * @param key key
	 */
	public static void removeAttribute(final HttpServletRequest request, final String key) {
		for (SessionStorageProvider sessionProvider : SESSION_STORAGE_PROVIDERS) {
			sessionProvider.removeAttribute(request, key);
		}
	}

	/**
	 * 세션에서 SessionUser VO를 구한다.
	 *
	 * @param request request
	 * @return SessionUser
	 */
	public static SessionUser getSessionUser(final HttpServletRequest request) {
		return (SessionUser) SessionUtil.getAttribute(request, Consts.SessionAttr.USER);
	}

	/**
	 * 세션에서 sessionCountry String를 구한다.
	 *
	 * @param request request
	 * @return String
	 */
	public static String getSessionCountry(final HttpServletRequest request) {
		return (String) SessionUtil.getAttribute(request, Consts.SessionAttr.COUNTRY);
	}	
	
	/**
	 * 세션에서 SessionLanguage String를 구한다.
	 *
	 * @param request request
	 * @return String
	 */
	public static String getSessionLanguage(final HttpServletRequest request) {
		return (String) SessionUtil.getAttribute(request, Consts.SessionAttr.LANG);
	}	
	
	
	/**
	 * 세션에서 SessionUser VO를 구한다.
	 *
	 * @return SessionUser
	 */
	public static SessionUser getSessionUser() {
		return (SessionUser)getAttribute(Consts.SessionAttr.USER);
	}

	/**
	 * 로그인 여부를 구한다.
	 *
	 * @param request request
	 * @return boolean
	 */
	public static boolean isLogged(final HttpServletRequest request) {
		final SessionUser user = SessionUtil.getSessionUser(request);
		boolean ret = false;
		if ((user == null) || (StringUtils.isEmpty(user.getUsr_id()))) {
			ret = false;
		} else {
			ret = true;
		}
		return ret;
	}
	
	/**
	 * AWS환경에서 Locale 가져옴
	 * CM, UP 사용
	 *
	 *
	 *
	 */
	public static Locale getLocale(final HttpServletRequest request) {
		Locale locale = null;
		if (getAttribute(request, "locale") != null) {
			locale = (Locale) getAttribute(request, "locale");
		} else {
			locale = new Locale(request.getLocale().getLanguage(), request.getLocale().getCountry());
		}
		return locale;
	}

	/**
	 * AWS환경에서 Locale 가져옴
	 * AH, CI, DS, SP 서버에서만 사용
	 */
	public static Locale getLocale() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		Locale locale = null;
		if ("was".equals(SESSION_STORAGE) && request.getHeader("langcd") != null && request.getHeader("cntrycd") != null) {
			locale = new Locale(request.getHeader("langcd"), request.getHeader("cntrycd"));
			LOG.debug("[AA] WAS OK!!! getLocale : [{}]", locale);
		} else if (getAttribute(request, "locale") != null) {
			locale = (Locale) getAttribute(request, "locale");
			LOG.debug("[AA] ElastiCache OK!!! getAttribute(request, locale) : [{}]", locale);
		} else {
			locale = new Locale(request.getLocale().getLanguage(), request.getLocale().getCountry());
			LOG.debug("[AA] ElastiCache OK!!! new Locale : [{}]", locale);
		}

		return locale;
	}
}
