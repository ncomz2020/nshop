package com.ncomz.nshop.service.common;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.ncomz.nshop.domain.common.MailInfo;

/**
 *
 * smtp를 이용한 메일 송신.
 *
 * @author someone
 * @version 1.0.0
 */
@Service
public class SendMail {
	/** the logger. */
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	/** 캐릭터 셋. */
	public static final String CHARSET_UTF8 = "UTF-8";

	/**
	 * MailSender instance.
	 */
	@Autowired
	private JavaMailSender mailSender;

	/** 업로드 파일 경로. */
	@Value("#{configuration['mail.template']}")
	private String fileUploadPath;

	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	/**
	 * MailInfo domain 클래스 multipart 메일 전송.
	 * 메일 전송 에러 발생하여도 Exception 전달 않음
	 *
	 * @param mailInfo MailInfo 메일 정보
	 */
	public void sendMail(final MailInfo mailInfo) {
		try {
			this.sendMail(mailInfo, false);
		} catch (Exception e) {
			logger.error("{}\n", e);
		}
	}

	/**
	 *
	 * MailInfo domain 클래스 multipart 메일 전송.
	 * 메일 전송 에러 발생에 대해 선택적으로 Exceptino 전달
	 *
	 * @warning	[Optional]함수의 제약사항이나 주의해야 할 점
	 * @param mailInfo MailInfo
	 * @param isThrowException boolean
	 * @throws Exception Exception
	 * @see	[Optional]관련 정보(관련 함수, 관련 모듈)
	 */
	public void sendMail(final MailInfo mailInfo, boolean isThrowException) throws Exception {
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, CHARSET_UTF8);
			helper.setFrom(mailInfo.getFrom());
			helper.setTo(mailInfo.getTo());
			helper.setSubject(mailInfo.getSubject());
			helper.setText(mailInfo.getMsg(), true);

			if (mailInfo.getFiles() != null) {
				for (String key : mailInfo.getFiles().keySet()) {
					FileSystemResource res = new FileSystemResource(new File(mailInfo.getFiles().get(key)));
					helper.addInline(key, res);
				}
			}

			if (mailInfo.getAttachmentFiles() != null) {
				for (String key : mailInfo.getAttachmentFiles().keySet()) {
					FileSystemResource res = new FileSystemResource(new File(mailInfo.getAttachmentFiles().get(key)));
					helper.addAttachment(key, res);
				}
			}

			mailSender.send(message);
		} catch (Exception e) {
			logger.error("{}\n", e);

			if (isThrowException)
				throw e;
		}
	}

	/**
	 * 메일 전송.template 화일로 전송
	 *
	 * @param from 송신
	 * @param to 수진
	 * @param subject 제목
	 * @param msg 내용
	 * @throws Exception 
	 */

	public void sendMailTemplate(final MailInfo mailInfo, boolean isThrowException, String imgUrl) throws Exception {
		try {

			String mailMsg = "";

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, CHARSET_UTF8);
			helper.setFrom(mailInfo.getFrom());
			helper.setTo(mailInfo.getTo());
			helper.setSubject(mailInfo.getSubject());
			mailMsg = getEmailTempleteNo(mailInfo.getUserName(), mailInfo.getFileName(), imgUrl);
			helper.setText(mailMsg, true);
			mailSender.send(message);
		} catch (Exception e) {
			logger.error("{}\n", e);

			if (isThrowException)
				throw e;
		}
	}

	/**
	  * Email Templete
	  *
	  * @param	EmailTemplete emailTemplete
	  * @return	EmailTemplete
	  * @exception Exception
	  */
	public String getEmailTempleteNo(String userNm, String fileName, String imgUrl) throws Exception {
		String emailContent = "";

		Reader reader = null;
		BufferedReader bufferedTextFileReader = null;
		try {
			reader = new InputStreamReader(new FileInputStream(fileName));
			bufferedTextFileReader = new BufferedReader(reader);
			StringBuilder contentReceiver = new StringBuilder();
			char[] buf = new char[1024 * 10];
			int numChars;
			while ((numChars = bufferedTextFileReader.read(buf)) >= 0) {
				contentReceiver.append(buf, 0, numChars);
			}
			emailContent = contentReceiver.toString();
			emailContent = emailContent.replaceAll("___IMAGEPATH___", imgUrl);
			emailContent = emailContent.replaceAll("___USER_NM___", userNm);

		} catch (RuntimeException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			emailContent = "";
		} finally {
			if (bufferedTextFileReader != null) {
				try {
					bufferedTextFileReader.close();
				} catch (IOException e) {
					e.printStackTrace();
					emailContent = "";
				}
			}

			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
					logger.info("ioexception==========>", e.getMessage());
				}
			}
		}

		return emailContent;
	}

}
