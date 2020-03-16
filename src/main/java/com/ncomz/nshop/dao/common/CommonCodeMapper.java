package com.ncomz.nshop.dao.common;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.common.CommonCode;

@Component
public interface CommonCodeMapper {

	List<CommonCode> getCommonCodeList(@Param("grp_cd")String grp_cd, @Param("language")String language);
	
	/**
	 * 연계코드.
	 * 
	 * @param grpCd 그룹코드
	 * @param langCd 언어코드
	 * @param orderBy 정렬기준
	 * @return HashMap<String,String>
	 */
	List<CommonCode> listCategoryChained(CommonCode commonCode);
	
	/**
	 * 연계코드.
	 * 
	 * @param grpCd 그룹코드
	 * @param langCd 언어코드
	 * @param orderBy 정렬기준
	 * @return HashMap<String,String>
	 */
	List<CommonCode> listCategoryMenu(CommonCode commonCode);
	
}
