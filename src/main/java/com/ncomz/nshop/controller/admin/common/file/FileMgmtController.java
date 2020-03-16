package com.ncomz.nshop.controller.admin.common.file;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nshop.domain.admin.common.FileMgmt;
import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.service.admin.common.file.FileMgmtService;
import com.ncomz.nshop.service.common.CommonCodeService;
import com.ncomz.nshop.service.common.CommonService;

@Controller
@RequestMapping(value = "/admin/common/file")
public class FileMgmtController {

	private String thisUrl = "admin/common/file";
	
	@Autowired
	private FileMgmtService fileservice;
	
	@Autowired
	private CommonService commonService;

	@Autowired
	private CommonCodeService commonCodeService;

	
	/** 파일관리 페이지 조회
	 * @param HttpServletRequest
	 * @param model
	 * @return  String
	 * @throws Exception
	 */
	@RequestMapping(value = "list", method = RequestMethod.POST)
	public String list( HttpServletRequest request
			           ,Model model) throws Exception {
		
		model.addAttribute( "startDate"	, commonService.getStartDate());
		model.addAttribute( "endDate"	, commonService.getEndDate());
		
		//파일유형 공통코드 조회
		model.addAttribute("opt_fileTypes", commonCodeService.getCommonCodeList("F001"));
		
		return thisUrl + "/list"; 
	}
	
	/** 파일 리스트 조회
	 * @param FileMgmt
	 * @param model
	 * @param HttpServletRequest
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(FileMgmt fileMgmt, Model model, HttpServletRequest request) throws Exception {
		
		model.addAttribute("pagingObject", fileMgmt);
		model.addAttribute("count", fileservice.getFileListCount(fileMgmt));
		model.addAttribute("list", fileservice.getFileList(fileMgmt));
		
		return thisUrl + "/listAction";
	}
	
	/** 엑셀 다운로드
	 * @param FileMgmt
	 * @param model
	 * @param HttpServletRequest
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(FileMgmt fileMgmt, Model model) throws ParseException, UnsupportedEncodingException {

		model.addAttribute("list", fileservice.listExcel(fileMgmt));

		return "excelViewer";
	}
	
	/** 임시파일 삭제
	 * @param FileMgmt
	 * @param model
	 * @param HttpServletRequest
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "deleteTempImg", method = RequestMethod.POST)
	public String deleteTempImg(FileMgmt fileMgmt, Model model) throws ParseException, UnsupportedEncodingException {

		fileservice.deleteTempImg();
		
		return thisUrl + "/listAction";
	}
	
}
