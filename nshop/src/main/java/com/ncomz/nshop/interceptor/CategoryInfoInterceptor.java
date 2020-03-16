package com.ncomz.nshop.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ncomz.nshop.domain.common.CommonCode;
import com.ncomz.nshop.service.common.CommonCodeService;
import com.ncomz.nshop.utillty.SessionUtil;

/**
 * Menu Navi를 처리하기 위한 Interceptor.
 *
 * <PRE>
 * 1. ClassName: MenuNavigation
 * 2. FileName : MenuNavigation.java
 * 3. Package  : com.ntels.aem.admin.customconfig
 * 4. 작성자   : smyun@ntels.com
 * 5. 작성일   : 2014. 4. 8. 오후 5:02:49
 * 6. 변경이력
 *		이름  :		일자	: 변경내용
 *     ———————————————————————————————————
 *		smyun :	2014. 4. 8.	: 신규 개발.
 * </PRE>
 */
public class CategoryInfoInterceptor extends HandlerInterceptorAdapter {

	/** logger. */
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	/** The common code service. */
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Override
	public boolean preHandle(
			HttpServletRequest request,
			HttpServletResponse response,
			Object handler) throws Exception {
		CommonCode cc = null;		
		cc = new CommonCode();
		cc.setParent_id("0");
		cc.setLanguage(request.getParameter("language"));
		
		List<CommonCode> categoryListTop = commonCodeService.listCategoryChained(cc);
		List<CommonCode> categoryListSub = commonCodeService.listCategoryMenu(cc);
		request.setAttribute("categoryListTop", categoryListTop);
		request.setAttribute("categoryListSub", categoryListSub);
		
		return true;
	}
}
