package com.ncomz.nshop.controller.common;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nshop.service.common.SecurityService;

@Controller
@RequestMapping(value = "/common/security")
public class SecurityController {
	
	@Autowired
	private SecurityService securityService;

	/**
	 * 암호화를 위한 키 생성
	 * @return
	 */
	@RequestMapping(value = "makeDummy", method = RequestMethod.POST)
	public Map<String, String> makeDummy() {
   		return securityService.makeDummy();
    }
	
}
