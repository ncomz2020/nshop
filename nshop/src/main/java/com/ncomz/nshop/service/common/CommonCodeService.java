package com.ncomz.nshop.service.common;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;

import com.ncomz.nshop.dao.common.CommonCodeMapper;
import com.ncomz.nshop.domain.common.CommonCode;

@Service
public class CommonCodeService {

	@Autowired
	private CommonCodeMapper commonCodeMapper;
	
	/**
	 * 코드 목록 조회
	 * @param common_code_list_id
	 * @return
	 */
	public List<CommonCode> getCommonCodeList(String grp_cd) {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		return commonCodeMapper.getCommonCodeList(grp_cd, language);
	}
	
	/**
	 * 연계 공통코드 정보.
	 * 
	 * @param grpCd 	그룹코드
	 * @param langCd 	언어코드
	 * @return List<CommonCode>
	 */
	public List<CommonCode> listCategoryChained(CommonCode commonCode){
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		commonCode.setLanguage(language);
		return commonCodeMapper.listCategoryChained(commonCode);
	}
	/**
	 * 연계 공통코드 정보.
	 * 
	 * @param grpCd 	그룹코드
	 * @param langCd 	언어코드
	 * @return List<CommonCode>
	 */
	public List<CommonCode> listCategoryMenu(CommonCode commonCode){
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		commonCode.setLanguage(language);
		return commonCodeMapper.listCategoryMenu(commonCode);
	}
}
