package com.ncomz.nshop.dao.common;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.common.FileInfo;

@Component
public interface FileMapper {

	FileInfo getFileInfo(FileInfo fileInfo);
	int insertFileInfo(FileInfo fileInfo);
	int deleteFile(FileInfo fileInfo);
	int updateFileTempYn(@Param("fileIdList")List<String> fileIdList, @Param("temp_yn")String temp_yn);
	int updateFileType(@Param("fileIdList")List<String> fileIdList, @Param("file_type")String file_type, @Param("key_id")String key_id, @Param("temp_yn")String temp_yn);
	int updateFileTypeTempYn(@Param("file_type")String file_type, @Param("key_id")String key_id, @Param("temp_yn")String temp_yn);
	List<FileInfo> getExpiredTempFileList();
	List<FileInfo> getFileList(FileInfo fileInfo);
	
}
