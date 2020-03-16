package com.ncomz.nshop.utillty;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class HttpSessionStorageImpl
  implements SessionStorageProvider
{
  public HttpSessionStorageImpl() {}
  
  public Object getAttribute(HttpServletRequest request, String key)
  {
    return request.getSession().getAttribute(key);
  }
  

  public Object getAttribute(String sessionId, String key)
  {
    return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest().getHeader(key);
  }
  


  public void setAttribute(HttpServletRequest request, String key, Object value)
  {
    request.getSession().setAttribute(key, value);
  }

  public void removeAttribute(HttpServletRequest request, String key)
  {
    request.getSession().removeAttribute(key);
  }
}