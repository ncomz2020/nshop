package com.ncomz.nshop.dao.admin.common.file;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.common.FileMgmt;

@Component
public interface fileMgmtMapper {
	int getFileListCount(FileMgmt fileMgmt);
	List<FileMgmt> getFileList(FileMgmt fileMgmt);
	List<LinkedHashMap<String, String>> listExcel(FileMgmt fileMgmt);
	void deleteTempImg();
}
