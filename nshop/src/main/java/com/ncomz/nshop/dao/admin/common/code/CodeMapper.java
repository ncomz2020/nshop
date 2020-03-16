package com.ncomz.nshop.dao.admin.common.code;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.common.Code;

@Component
public interface CodeMapper {

	List<Code> getCodeList(Code code);
	int insertCode(Code code);
	Code getCode(Code code);
	int updateCodeInfo(Code code);
	int updateOldDisplayOrders(Code old);
	int updateNewDisplayOrders(Code old);
	int updateCodePosition(Code code);
	int deleteCodeInfo(Code code);
	int checkDuplicate(Code code);
	int getChildrenCount(Code code);
	int updateCodeUseYn(Code code);
	List<Code> getGroupCodeList(@Param("grp_cd")String grp_cd);
	int insertCodeLanguage(Code code);
	List<Code> getCodeLanguageList(Code code);
	int deleteCodeLanguage(Code code);
	
}
