package com.ncomz.nshop.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.common.Menu;
import com.ncomz.nshop.domain.common.SessionUser;
import com.ncomz.nshop.service.admin.common.menu.MenuService;
import com.ncomz.nshop.utillty.MessageUtil;
import com.ncomz.nshop.utillty.SessionUtil;
import com.ncomz.nshop.utillty.StringUtil;

public class CustomInterceptor extends HandlerInterceptorAdapter {

	/** The logger. */
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private String redirectPage;
	private List<String> noSession;

	@Autowired
	private MenuService menuService;
	
	// 예외페이지 추후 권한없음 페이지로 변경필요있음
	private String redirectPermissionDeniedPage = "/exception/notfound";


	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		HttpSession session = request.getSession(true);

		// login check start
		String requestUri = request.getRequestURI();
		String[] requestArr = requestUri.split("/");
		boolean bCheckSession = true;
		for (int i = 0; i < noSession.size(); i++) {
			String temp = noSession.get(i).trim();
			String[] arr = temp.split("/");

			if (arr.length == requestArr.length) {
				boolean bSame = true;
				for (int j = 0; j < arr.length; j++) {
					if (!arr[j].equals("*") && !arr[j].equals(requestArr[j])) {
						bSame = false;
						break;
					}
				}

				if (bSame) {
					bCheckSession = false;
					break;
				}
			}
		}

		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		

		if (bCheckSession) {
			if (sessionUser == null) {

				response.sendRedirect(redirectPage);
				return false;
			}
		}
		// login check end
		
		if (sessionUser != null) {
			
			String usr_grp_id = sessionUser.getUsr_grp_id();
			if ( requestArr[1].equals("admin")) {
				Menu menu = new Menu();
				menu.setUrl(requestUri);
				menu.setusrGrpId(usr_grp_id);
				//logger.info("requestUri -> {} ",requestUri);
				//logger.info("isAjaxRequest -> {} ",isAjaxRequest(request));
				if (menuService.countMenuAuth(menu) == 0 && isAjaxRequest(request) == false
			    && requestUri.indexOf("ajax") == -1 && requestUri.indexOf("json") == -1 ) {
			    	// 권한 체크하여 권한이 없으면 permission denied 페이지로
					response.sendRedirect(redirectPermissionDeniedPage);
					return super.preHandle(request, response, handler);
				}
			} else if ( requestUri.indexOf("front") >= 0 ) {
				if ( !usr_grp_id.equals("3") ) {  
					// user 권한일 경우에는 Session 초기화 
					session.invalidate();
					return super.preHandle(request, response, handler);
				}
			}
			List<Menu> menuList = menuService.getUserGroupMenuList(usr_grp_id);
			request.setAttribute("userGroupMenuList", menuList);
			request.setAttribute("language", MessageUtil.getMessage("label.common.language"));

			// get menu end

			// menu activation start

			this.activateMenu(request, menuList, requestUri);
			// menu activation end
		}
		
		

		return super.preHandle(request, response, handler);
	}
		
	public void activateMenu(HttpServletRequest request, List<Menu> menuList, String requestUri) {
		for (int i = 0; i < menuList.size(); i++) {
			Menu menu = menuList.get(i);
			String url = menu.getUrl();
			if (StringUtil.compare(url, requestUri) == 0) {
				request.getSession().setAttribute("activeMenuId", menu.getMenu_id());
				request.getSession().setAttribute("menuAuth", menu.getAuth_tp());
				break;
			}
			this.activateMenu(request, menu.getChildren(), requestUri);
		}
	}

	public String getRedirectPage() {
		return redirectPage;
	}

	public void setRedirectPage(String redirectPage) {
		this.redirectPage = redirectPage;
	}

	public List<String> getNoSession() {
		return noSession;
	}

	public void setNoSession(List<String> noSession) {
		this.noSession = noSession;
	}

    private boolean isAjaxRequest(HttpServletRequest req) {
        String ajaxHeader = "AJAX";
        logger.info("======= call /sessionIntercepter req.getHeader(ajaxHeader) : " + req.getHeader(ajaxHeader) + "=======");
                                return req.getHeader(ajaxHeader) != null && req.getHeader(ajaxHeader).equals(Boolean.TRUE.toString());
    }
}
