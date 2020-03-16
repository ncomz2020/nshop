package com.ncomz.nshop.service.common;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SecurityService {

	@Autowired
	private HttpSession session;
	
	public static final int KEY_SIZE	= 512;
	
	/**
	 * 키 생성
	 * @param session
	 * @return
	 */
	public Map<String, String> makeDummy() {
		Map<String, String> dummy = new HashMap<String, String>();
		String publicKeyModulus 	= null;
   		String publicKeyExponent 	= null;
        try {
			KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
			generator.initialize(KEY_SIZE);

			KeyPair keyPair = generator.genKeyPair();
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");

			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();

			// 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
			session.setAttribute("rsaPrivateKey", privateKey);
			
			// 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);

			publicKeyModulus 	= publicSpec.getModulus().toString(16);
			publicKeyExponent 	= publicSpec.getPublicExponent().toString(16);
		}
        catch (Exception ex) {
			ex.printStackTrace();
		}
		
		dummy.put("publicKeyModulus", publicKeyModulus);
		dummy.put("publicKeyExponent", publicKeyExponent);
		return dummy;
	}
	
	/**
	 * @param privateKey
	 * @param securedValue
	 * @return
	 * @throws Exception
	 * 복호화
	 */
	public String decryptRsa(String securedValue) throws Exception {
		PrivateKey privateKey = (PrivateKey) session.getAttribute("rsaPrivateKey");
        Cipher cipher = Cipher.getInstance("RSA");
        byte[] encryptedBytes = this.hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
        return decryptedValue;
    }
	
	/**
	 * 16진 문자열을 byte 배열로 변환한다.
	 */
	public byte[] hexToByteArray(String hex) {
	    if (hex == null || hex.length() % 2 != 0) {
	        return new byte[]{};
	    }
	
	    byte[] bytes = new byte[hex.length() / 2];
	    for (int i = 0; i < hex.length(); i += 2) {
	        byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
	        bytes[(int) Math.floor(i / 2)] = value;
	    }
	    return bytes;
	}
	
}
