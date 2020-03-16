package com.ncomz.nshop.controller.common;

import java.io.File;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ncomz.nshop.domain.admin.product.ProductInfo;
import com.ncomz.nshop.domain.common.FileInfo;
import com.ncomz.nshop.service.common.FileService;


@Controller
@RequestMapping(value = "/common/file")
public class FileController {
	
	private String thisUrl = "common/file";
	
	@Autowired
	private FileService fileService;

	/**
	 * 파일 다운로드
	 * @param file_id
	 * @return
	 */
	@RequestMapping("/download/{file_id:.+}")
	public @ResponseBody ResponseEntity<byte[]> downloadFile(@PathVariable("file_id")String file_id) {
		return fileService.downloadFile(file_id);
	}
	
	/*@RequestMapping("/download/{file_id:.+}")
	public @ResponseBody FileSystemResource downloadFile(@PathVariable("file_id")String file_id) {
		return fileService.downloadFile(file_id);
	}*/
	
	@RequestMapping("/downloadImage/{file_id:.+}")
	public @ResponseBody ResponseEntity<byte[]> downloadImage(@PathVariable("file_id")String file_id) {
		return fileService.downloadImage(file_id);
	}
	
	/*@RequestMapping("/downloadImage/{file_id:.+}")
	public @ResponseBody FileSystemResource downloadImage(@PathVariable("file_id")String file_id) {
		return fileService.downloadImage(file_id);
	}*/
	
	/**
	 * 파일 다운로드
	 * @param response
	 * @param file_id
	 * @throws Exception
	 */
	@RequestMapping(value="/download", method = RequestMethod.POST)
	public void downloadFile(HttpServletResponse response, String file_id) throws Exception {
		FileInfo fileInfo = fileService.getFileInfo(file_id);
		// String sFilePath = fileService.getFilePath(fileInfo);
		// byte fileByte[] = FileUtils.readFileToByteArray(new File(sFilePath));
		byte fileByte[] = fileInfo.getFile_data();
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileInfo.getOrg_filename(), "UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);
		
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
	@RequestMapping(value="select")
	public String select(Model model) {
		return thisUrl + "/select";
	}
	
	@RequestMapping(value="insertTempImageAction")
	public @ResponseBody String insertTempImageAction(Model model, MultipartFile file) {
		return fileService.insertTempImageAction(file);
	}
	
}
