package com.ncomz.nshop.service.common;

import java.io.File;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nshop.dao.common.FileMapper;
import com.ncomz.nshop.domain.common.FileInfo;
import com.ncomz.nshop.utillty.StringUtil;

@Service
public class FileService {

	@Autowired
	private FileMapper fileMapper;

	@Value("#{configuration['fileDirectoryPath']}")
	private String fileDirectoryPath;

	/**
	 * @param file_id
	 * @return
	 * 파일 정보 조회
	 */
	public FileInfo getFileInfo(String file_id) {
		FileInfo fileInfo = new FileInfo();
		fileInfo.setFile_id(file_id);
		return fileMapper.getFileInfo(fileInfo);
	}

	/**
	 * @param fileInfo
	 * @return
	 * 물리 파일 경로
	 * 파일 검색 속도를 위해 하나의 디렉토리에 파일을 100개씩만 저장한다.
	 */
	public String getFilePath(FileInfo fileInfo) {
		int nSubDir = Integer.parseInt(fileInfo.getFile_id()) / 100;
		String sFilePath = fileDirectoryPath + "/" + nSubDir + "/" + fileInfo.getPhy_filename();
		return sFilePath;
	}

	/**
	 * @param file_id
	 * @return
	 * 파일 다운로드
	 */
	public ResponseEntity<byte[]> downloadFile(String file_id) {
		try {
			FileInfo fileInfo = this.getFileInfo(file_id);
			if (fileInfo == null) {
				return null;
			}
			final HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Transfer-Encoding", "binary");
			if (fileInfo.getFile_data() != null) {
				headers.add("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileInfo.getOrg_filename(), "UTF-8") + "\";");
				return new ResponseEntity<byte[]>(fileInfo.getFile_data(), headers, HttpStatus.OK);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	/*public FileSystemResource downloadFile(String file_id) {
	try {
		FileInfo fileInfo = this.getFileInfo(file_id);
		if (fileInfo == null) {
			return null;
		}
	    String fullPath = this.getFilePath(fileInfo);
	    File downloadFile = new File(fullPath);
	    return new FileSystemResource(downloadFile);
	} catch (Exception ex) {
		ex.printStackTrace();
	}
	return null;
	}*/

	public ResponseEntity<byte[]> downloadImage(String file_id) {
		try {
			FileInfo fileInfo = this.getFileInfo(file_id);
			byte[] fileData = null;
			String fileName = null;
			if (fileInfo != null) {
				if (fileInfo.getFile_data() != null) {
					fileName = fileInfo.getOrg_filename();
					fileData = fileInfo.getFile_data();
				}
			}
			if (fileData != null) {
			} else {
				FileSystemResource f = new FileSystemResource("src/main/webapp/img/no_image.png");
				fileName = f.getFilename();
				fileData = Files.readAllBytes(Paths.get(f.getPath()));
			}
			final HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Transfer-Encoding", "binary");
			headers.add("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");
			return new ResponseEntity<byte[]>(fileData, headers, HttpStatus.OK);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	/*public FileSystemResource downloadImage(String file_id) {
		try {
			FileInfo fileInfo = this.getFileInfo(file_id);
			if (fileInfo == null) {
				return null;
			}
	        String fullPath = this.getFilePath(fileInfo);
	        File downloadFile = new File(fullPath);
	        if (downloadFile.exists()) {
	            return new FileSystemResource(downloadFile);
	        } else {
	            return new FileSystemResource("src/main/webapp/img/no_image.png");
	        }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}*/

	public FileInfo saveFile(MultipartFile multipartFile) throws Exception {
		return this.saveFile(multipartFile, "N");
	}

	/**
	 * 파일 저장
	 * @param multipartFile
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public FileInfo saveFile(MultipartFile multipartFile, String temp_yn) throws Exception {
		try {
			String org_filename = multipartFile.getOriginalFilename();
			String phy_filename = StringUtil.getUUID() + "." + StringUtil.getFileExt(org_filename);

			FileInfo fileInfo = new FileInfo();
			fileInfo.setOrg_filename(org_filename);
			fileInfo.setPhy_filename(phy_filename);
			fileInfo.setTemp_yn(temp_yn);
			fileInfo.setFile_data(multipartFile.getBytes());

			if (fileMapper.insertFileInfo(fileInfo) <= 0) {
				throw new Exception("파일 정보를 데이터베이스에 저장하는 도중 오류가 발생하였습니다. 관리자에게 문의하세요.");
			}

			/*int nSubDir = Integer.parseInt(fileInfo.getFile_id()) / 100;
			String sSubDir = fileDirectoryPath + "/" + nSubDir + "/";
			File fSubDir = new File(sSubDir);
			if (!fSubDir.exists()) {
				fSubDir.mkdirs();
			}
			
			String sFilePath =sSubDir + fileInfo.getPhy_filename();
			File file = new File(sFilePath);
			multipartFile.transferTo(file);*/

			return fileInfo;
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new Exception(ex.getMessage());
		}
	}

	/**
	 * 파일 삭제
	 * @param file_id
	 */
	public void deleteFile(String file_id) {
		FileInfo fileInfo = new FileInfo();
		fileInfo.setFile_id(file_id);
		fileInfo = fileMapper.getFileInfo(fileInfo);
		if (fileInfo == null) {
			return;
		}
		/*String sFilePath = this.getFilePath(fileInfo);
		File file = new File(sFilePath);
		if (file.exists()) {
			file.delete();
		}*/
		fileMapper.deleteFile(fileInfo);
	}

	public void updateFileTempYn(List<String> fileIdList, String temp_yn) throws Exception {
		fileMapper.updateFileTempYn(fileIdList, temp_yn);
	}

	public void deleteExpiredTempFiles() {
		List<FileInfo> fileList = fileMapper.getExpiredTempFileList();
		for (FileInfo file : fileList) {
			this.deleteFile(file.getFile_id());
		}
	}

	@Transactional
	public String insertTempImageAction(MultipartFile file) {
		try {
			if (file == null) {
				throw new Exception("이미지 파일이 없습니다.");
			}
			FileInfo fileInfo = this.saveFile(file, "Y");
			return "succ:" + fileInfo.getFile_id();
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}

	/**
	 * 문자열을 파싱하여 파일 ID 를 찾아 해당 파일의 정보를 업데이트한다.
	 * @param contents
	 * @param file_type
	 * @param key_id
	 * @throws Exception
	 */
	public void updateImageFile(String contents, String file_type, String key_id) throws Exception {
		if (StringUtil.isEmpty(contents)) {
			return;
		}
		String findString = "/common/file/downloadImage/";
		List<String> fileIdList = new ArrayList<String>();
		int index = 0;
		while ((index = contents.indexOf(findString)) >= 0) {
			contents = contents.substring(index + findString.length(), contents.length());
			String fileId = "";
			int charIndex = 0;
			while (true) {
				char cChar = contents.charAt(charIndex);
				if (cChar >= '0' && cChar <= '9') {
					fileId += cChar;
				} else {
					break;
				}
				charIndex++;
			}
			fileIdList.add(fileId);
		}
		if (fileIdList.size() > 0) {
			fileMapper.updateFileType(fileIdList, file_type, key_id, "N");
		}
	}

	public void updateFileTypeTempYn(String file_type, String key_id, String temp_yn) throws Exception {
		fileMapper.updateFileTypeTempYn(file_type, key_id, "Y");
	}

	public List<FileInfo> getFileList(FileInfo fileInfo) {
		return fileMapper.getFileList(fileInfo);
	}

	public void updateFileType(List<String> fileIdList, String file_type, String key_id, String temp_yn) throws Exception {
		fileMapper.updateFileType(fileIdList, file_type, key_id, temp_yn);
	}

}
