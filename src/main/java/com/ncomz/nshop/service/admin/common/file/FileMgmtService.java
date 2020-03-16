package com.ncomz.nshop.service.admin.common.file;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;

import com.ncomz.nshop.dao.admin.common.file.fileMgmtMapper;
import com.ncomz.nshop.domain.admin.common.FileMgmt;
import com.ncomz.nshop.domain.admin.product.ProductInfo;

import net.sf.ehcache.Ehcache;

@Service
public class FileMgmtService {

	@Autowired
	private fileMgmtMapper fileMgmtMapper;
	
	@Autowired
	private Ehcache ehcache;
	
	/** 파일 리스트 조회 카운트
	 * @param FileMgmt
	 * @return int
	 * @throws Exception
	 */
	public int getFileListCount(FileMgmt fileMgmt) {
		return fileMgmtMapper.getFileListCount(fileMgmt);
	}
	
	/** 파일 리스트 데이터 조회
	 * @param  FileMgmt
	 * @return  List<FileMgmt>
	 * @throws Exception
	 */
	public List<FileMgmt> getFileList(FileMgmt fileMgmt) {
		//언어 타입 설정.
		Locale locale = LocaleContextHolder.getLocale();
		fileMgmt.setLang_type(locale.getLanguage());
		
		return fileMgmtMapper.getFileList(fileMgmt);
	}

	
	/** 파일 리스트 엑셀 다운로드
	 * @param  FileMgmt
	 * @return  List<LinkedHashMap<String, String>>
	 * @throws Exception
	 */
	public List<LinkedHashMap<String, String>> listExcel(FileMgmt fileMgmt) {
		//언어 타입 설정.
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		
		fileMgmt.setLanguage(language);
		return fileMgmtMapper.listExcel(fileMgmt);
	}

	
	/** 임시파일 삭제
	 * @return
	 * @throws Exception
	 */
	public void deleteTempImg() {
		fileMgmtMapper.deleteTempImg();
	}

	
}
