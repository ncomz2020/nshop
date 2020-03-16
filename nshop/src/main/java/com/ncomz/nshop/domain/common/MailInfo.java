package com.ncomz.nshop.domain.common;

import java.util.Map;

public class MailInfo {
	/** sender. */
	private String from;
	/** resive. */
	private String to;

	/** title. */
	private String subject;

	/** content. */
	private String msg;

	/** 
	 * key = attachmentFileId
	 * value = file Full Path
	 * */
	private Map<String, String> files;
	private Map<String, String> attachmentFiles;

	/** filename. */
	private String fileName;
	/** username**/
	private String userName;
			
	/**
	 * @return the fileName
	 */
	public String getFileName() {
		return fileName;
	}

	/**
	 * @param fileName the fileName to set
	 */
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, String> getFiles() {
		return files;
	}

	public void setFiles(Map<String, String> files) {
		this.files = files;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Map<String, String> getAttachmentFiles() {
		return attachmentFiles;
	}

	public void setAttachmentFiles(Map<String, String> attachmentFiles) {
		this.attachmentFiles = attachmentFiles;
	}

	



}
