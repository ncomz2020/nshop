package com.ncomz.nshop.controller.common;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ncomz.nshop.domain.common.CommonCode;
import com.ncomz.nshop.service.common.CommonCodeService;

/**
 * 공통코드 관리용 Controller.
 *
 * <PRE>
 * 1. ClassName: CommonCodeController
 * 2. FileName : CommonCodeController.java
 * 3. Package  : com.ntels.aem.admin.cm.controller.configuration
 * 4. 작성자   : smyun@ntels.com
 * 5. 작성일   : 2014. 4. 8. 오후 5:02:49
 * 6. 변경이력
 *		이름  :		일자	: 변경내용
 *     ———————————————————————————————————
 *		smyun :	2014. 4. 8.	: 신규 개발.
 * </PRE>
*/
@Controller
@RequestMapping(value = "/cm/configuration/code")
public class CommonCodeController {

	/** The logger. */
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	/** The common code service. */
	@Autowired
	private CommonCodeService commonCodeService;
	
	
	/**
	 * 공통 코드를 조회
	 * @param		dataList : dataList
	 * @param		request  : request
	 * @return		List<Map<String,Object>>
	 * @exception
	 * @see
	 */
	@RequestMapping(value = "createComboBox", method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> listCode(
			@RequestBody List<Map<String, String>> dataList, HttpServletRequest request) {

		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

		Map<String, Object> resultMap = null;

		List<Map<String, String>> codeList = null;
		Map<String, String> codeMap = null;
		CommonCode cc = null;
		
		String defaultName 	= "";
		
		for (Map<String, String> requestMap : dataList) {
			
			resultMap = new LinkedHashMap<String, Object>();
			codeList = new ArrayList<Map<String, String>>();
			defaultName = "";
			
			// 공통코드
			if ("category".equals(requestMap.get("codeType"))) 
			{
				codeMap = new LinkedHashMap<String, String>();
				if(StringUtils.isNotBlank(requestMap.get("defaultName"))){
					defaultName = String.valueOf(requestMap.get("defaultName"));
					codeMap.put("key", "");
					codeMap.put("value", defaultName);
					codeList.add(codeMap);
				}
				
				cc = new CommonCode();
				cc.setParent_id(requestMap.get("parent_id"));
				for (CommonCode result : commonCodeService.listCategoryChained(cc)) 
				{
					codeMap = new LinkedHashMap<String, String>();	
					codeMap.put("key", result.getCategory_id());
					codeMap.put("value", result.getTitle());
					codeList.add(codeMap);
				}
			}else if ("commCode".equals(requestMap.get("codeType"))) 
			{
				codeMap = new LinkedHashMap<String, String>();
				if(StringUtils.isNotBlank(requestMap.get("defaultName"))){
					defaultName = String.valueOf(requestMap.get("defaultName"));
					codeMap.put("key", "");
					codeMap.put("value", defaultName);
					codeList.add(codeMap);
				}
				
				for (CommonCode result : commonCodeService.getCommonCodeList(requestMap.get("grp_cd"))) 
				{
					codeMap = new LinkedHashMap<String, String>();	
					codeMap.put("key", result.getDtl_cd());
					codeMap.put("value", result.getDtl_nm());
					codeList.add(codeMap);
				}
			}
			resultMap.put("selectId", requestMap.get("selectId"));
			resultMap.put("defaultName", requestMap.get("defaultName"));
			resultMap.put("defaultValue", requestMap.get("defaultValue"));
			resultMap.put("codeList", codeList);
			resultList.add(resultMap);
		}

		return resultList;
	}
}
