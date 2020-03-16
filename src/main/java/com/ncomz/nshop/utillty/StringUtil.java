package com.ncomz.nshop.utillty;

import java.util.UUID;
import org.apache.commons.codec.binary.Base64;

public class StringUtil {

	public static boolean isEmpty(String sSrc) {
		if (sSrc == null || sSrc.length() == 0) {
			return true;
		}
		return false;
	}

	public static void main(String[] args) {
		System.out.println("StringUtil.getLength(\"abc\") --> " + StringUtil.getLength("abc"));
		System.out.println("StringUtil.insertDelimiterReverseOrder(\"1234567\", \",\", 3) --> " + StringUtil.insertDelimiterReverseOrder("1234567", ",", 3));
		System.out.println("StringUtil.trim(\"   abcdef\\n \\r\") --> " + StringUtil.trim("   abcdef\n \r"));
		System.out.println("StringUtil.trimLeft(\"   abcdef\") --> " + StringUtil.trimLeft("   abcdef"));
		System.out.println("StringUtil.trimRight(\"   abcdef\") --> " + StringUtil.trimRight("   abcdef"));
		System.out.println("StringUtil.left(\"abcdef\", \"c\") --> " + StringUtil.left("abcdef", "c"));
		System.out.println("StringUtil.right(\"abcdef\", \"c\") --> " + StringUtil.right("abcdef", "c"));
		System.out.println("StringUtil.left(\"abcdef\", 3) --> " + StringUtil.left("abcdef", 3));
		System.out.println("StringUtil.right(\"abcdef\", 3) --> " + StringUtil.right("abcdef", 3));
		System.out.println("StringUtil.substring(\"abcdef\", 2, 4) --> " + StringUtil.substring("abcdef", 2, 4));
		System.out.println("StringUtil.substring(\"abcdef\", 3) --> " + StringUtil.substring("abcdef", 3));
		System.out.println("StringUtil.replaceExt(\"/home/dir/abcdef.txt\", \"xls\") --> " + StringUtil.replaceExt("/home/dir/abcdef.txt", "xls"));
		System.out.println("StringUtil.getPathName(\"/home/dir/abcdef.txt\") --> " + StringUtil.getPathName("/home/dir/abcdef.txt"));
		System.out.println("StringUtil.getPath(\"/home/dir/abcdef.txt\") --> " + StringUtil.getPath("/home/dir/abcdef.txt"));
		System.out.println("StringUtil.getFileExt(\"/home/dir/abcdef.txt\") --> " + StringUtil.getFileExt("/home/dir/abcdef.txt"));
		System.out.println("StringUtil.getFile(\"/home/dir/abcdef.txt\") --> " + StringUtil.getFile("/home/dir/abcdef.txt"));
		System.out.println("StringUtil.getRandColorCode() --> " + StringUtil.getRandColorCode());
	}

	/**
	 * 문자열의 길이를 반환
	 * StringUtil.getLength("abc") --> 3
	 * @param sSrc
	 * @return
	 */
	public static int getLength(String sSrc) {
		if (sSrc == null) {
			return 0;
		}
		int nLen = sSrc.length();
		return nLen;
	}

	/**
	 * 1234567을 1,234,567 이와 같이 특정 string을 right로부터 left로 특정 interval 간격으로 특정 문자를 insert하는 기능
	 * StringUtil.insertDelimiterReverseOrder("1234567", ",", 3) --> 1,234,567
	 * @param sSrc
	 * @param sDlm
	 * @param nInterval
	 * @return
	 */
	public static String insertDelimiterReverseOrder(String sSrc, String sDlm, int nInterval) {
		String sDest = "";
		int nIdx = 0;
		int nLen = StringUtil.getLength(sSrc);
		for (int i = 1; i <= nLen; i++) {
			char cChar = sSrc.charAt(nLen - i);
			sDest = cChar + sDest;
			nIdx++;
			if (nIdx >= nInterval && i + 1 <= nLen) {
				sDest = sDlm + sDest;
				nIdx = 0;
			}
		}
		return sDest;
	}

	/**
	 * 문자열 좌 우 공백 제거 StringUtil.trim("   abcdef\n \r") --> abcdef
	 * 
	 * @param sSrc
	 * @return
	 */
	public static String trim(String sSrc) {
		if (sSrc == null)
			return null;
		String sTemp = StringUtil.trimLeft(sSrc);
		String sDest = StringUtil.trimRight(sTemp);
		return sDest;
	}

	/**
	 * 문자열 좌측 공백 제거
	 * StringUtil.trimLeft("   abcdef") --> abcdef
	 * @param sSrc
	 * @return
	 */
	public static String trimLeft(String sSrc) {
		if (sSrc == null)
			return null;
		int nLen = sSrc.length();
		int nIdx = -1;
		String sDest = new String();
		int i = 0;
		for (i = 0; i < nLen; i++) {
			char cChar = sSrc.charAt(i);
			if (cChar != ' ' && cChar != '\r' && cChar != '\n' && cChar != '\t') {
				nIdx = i;
				break;
			}
			nIdx = i;
		}
		if (i == nLen)
			return "";
		sDest = sSrc.substring(nIdx, nLen);
		return sDest;
	}

	/**
	 * 문자열 우측 공백 제거
	 * StringUtil.trimRight("abcdef   ") --> abcdef
	 * @param sSrc
	 * @return
	 */
	public static String trimRight(String sSrc) {
		if (sSrc == null)
			return null;
		int nLen = sSrc.length();
		int nIdx = -1;
		int i = 0;
		String sDest = new String();
		for (i = nLen - 1; i >= 0; i--) {
			char cChar = sSrc.charAt(i);
			if (cChar <= ' ') {
				nIdx = i;
				continue;
			} else {
				nIdx = i;
				break;
			}
		}
		if (i < 0)
			return "";
		sDest = sSrc.substring(0, nIdx + 1);
		return sDest;
	}

	/**
	 * 지정 문자열 좌측의 문자열을 반환
	 * StringUtil.left("abcdef", "c") --> ab
	 * @param sSrc
	 * @param sDel
	 * @return
	 */
	public static String left(String sSrc, String sDel) {
		if (sSrc == null)
			return null;
		int nIdx = sSrc.indexOf(sDel);
		if (nIdx >= 0) {
			return StringUtil.substring(sSrc, 0, nIdx);
		}
		return null;
	}

	/**
	 * 지정 문자열 우측의 문자열을 반환
	 * StringUtil.right("abcdef", "c") --> def
	 * @param sSrc
	 * @param sDel
	 * @return
	 */
	public static String right(String sSrc, String sDel) {
		if (sSrc == null)
			return null;
		int nIdx = sSrc.indexOf(sDel);
		if (nIdx >= 0) {
			int nLen = sSrc.length();
			int nDelLen = sDel.length();
			return StringUtil.substring(sSrc, nIdx + nDelLen, nLen);
		}
		return null;
	}

	/**
	 * 지정한 수 만큼의 좌측 문자열을 반환
	 * StringUtil.left("abcdef", 3) --> abc
	 * @param sSrc
	 * @param nLen
	 * @return
	 */
	public static String left(String sSrc, int nLen) {
		if (sSrc == null)
			return null;
		String sRet = sSrc.substring(0, nLen);
		return sRet;
	}

	/**
	 * 지정한 수 만큼의 우측 문자열을 반환
	 * StringUtil.right("abcdef", 3) --> def
	 * @param sSrc
	 * @param nIdx
	 * @return
	 */
	public static String right(String sSrc, int nIdx) {
		if (sSrc == null)
			return null;
		int nLen = StringUtil.getLength(sSrc);
		String sRet = StringUtil.substring(sSrc, nIdx, nLen);
		return sRet;
	}

	/**
	 * nStart 부터 nEnd 까지의 문자열을 반환
	 * StringUtil.substring("abcdef", 2, 4) --> cd
	 * @param sSrc
	 * @param nStart
	 * @param nEnd
	 * @return
	 */
	public static String substring(String sSrc, int nStart, int nEnd) {
		if (sSrc == null)
			return null;
		if (nStart < 0)
			nStart = 0;
		int nSize = sSrc.length();
		if (nEnd > nSize)
			nEnd = nSize;
		String sRet = sSrc.substring(nStart, nEnd);
		return sRet;
	}

	/**
	 * nIdx부터 끝까지의 문자열을 반환
	 * StringUtil.substring("abcdef", 3) --> def
	 * @param sSrc
	 * @param nIdx
	 * @return
	 */
	public static String substring(String sSrc, int nIdx) {
		if (sSrc == null)
			return null;
		int nLen = StringUtil.getLength(sSrc);
		if (nLen + 1 <= nIdx)
			nIdx = nLen;
		return sSrc.substring(nIdx);
	}

	/**
	 * 파일의 확장자를 변경하여 반환
	 * StringUtil.replaceExt("/home/dir/abcdef.txt", "xls") --> /home/dir/abcdef.xls
	 * @param sSrc
	 * @param sExt
	 * @return
	 */
	public static String replaceExt(String sSrc, String sExt) {
		if (sExt == null)
			return sSrc;
		String sName = getPathName(sSrc);
		String sRet = sName;
		if (sExt.charAt(0) != '.')
			sRet += ".";
		sRet += sExt;
		return sRet;
	}

	/**
	 * 파일 경로 중 파일 확장자를 제외하고 파일 경로와 파일명만 반환
	 * StringUtil.getPathName("/home/dir/abcdef.txt") --> /home/dir/abcdef
	 * @param sSrc
	 * @return
	 */
	public static String getPathName(String sSrc) {
		if (sSrc == null)
			return null;
		int nIdx = 0;
		nIdx = sSrc.lastIndexOf('.');
		if (nIdx >= 0) {
			return sSrc.substring(0, nIdx);
		}
		return sSrc;
	}

	/**
	 * 파일 경로 중 파일명을 제외하고 파일 경로만 반환
	 * StringUtil.getPath("/home/dir/abcdef.txt") --> /home/dir
	 * @param sFilePath
	 * @return
	 */
	public static String getPath(String sFilePath) {
		int nIdx = 0;
		String sPath;
		int nLen = StringUtil.getLength(sFilePath);
		nIdx = sFilePath.lastIndexOf("\\");
		if (nIdx >= 0) {
			if (nIdx == 0 && nLen > 1) {
				sPath = "\\";
			} else {
				sPath = sFilePath.substring(0, nIdx);
			}
			return sPath;
		}
		nIdx = sFilePath.lastIndexOf("/");
		if (nIdx >= 0) {
			if (nIdx == 0 && nLen > 1) {
				sPath = "/";
			} else {
				sPath = sFilePath.substring(0, nIdx);
			}
			return sPath;
		}
		return null;
	}

	/**
	 * 파일 경로 중 파일 확장자만 반환
	 * StringUtil.getFileExt("/home/dir/abcdef.txt") --> txt
	 * @param sFilePath
	 * @return
	 */
	public static String getFileExt(String sFilePath) {
		if (sFilePath == null)
			return null;
		int nIdx = 0;
		String sExt;

		nIdx = sFilePath.lastIndexOf(".");
		if (nIdx >= 0) {
			int nLen = sFilePath.length();
			sExt = sFilePath.substring(nIdx + 1, nLen);
			return sExt;
		}
		return "";
	}

	/**
	 * 파일 경로 중 파일명과 파일 확장자만 반환
	 * StringUtil.getFile("/home/dir/abcdef.txt") --> abcdef.txt
	 * @param sFile
	 * @return
	 */
	public static String getFile(String sFile) {
		if (sFile == null)
			return null;
		int nIdx = 0;
		String sRet;

		nIdx = sFile.lastIndexOf("\\");
		if (nIdx >= 0) {
			int nLen = sFile.length();
			sRet = sFile.substring(nIdx + 1, nLen);
			return sRet;
		}
		nIdx = sFile.lastIndexOf("/");
		if (nIdx >= 0) {
			int nLen = sFile.length();
			sRet = sFile.substring(nIdx + 1, nLen);
			return sRet;
		}
		return sFile;
	}

	/**
	 * 파일 경로 중 파일명만 반환
	 * StringUtil.getFileName("/home/dir/abcdef.txt") --> abcdef
	 * @param sFileExt
	 * @return
	 */
	public static String getFileName(String sFileExt) {
		int nIdx = 0;
		String sFile, sName;
		sFile = getFile(sFileExt);

		nIdx = sFile.lastIndexOf(".");
		if (nIdx >= 0) {
			sName = sFile.substring(0, nIdx);
			return sName;
		}
		return sFileExt;
	}

	/**
	 * String 을 int로 변환하여 반환
	 * @param sVal
	 * @return
	 */
	public static int parseInt(String sVal) {
		if (StringUtil.isEmpty(sVal)) {
			return 0;
		}
		int nVal = 0;
		sVal = sVal.trim();
		nVal = Integer.parseInt(sVal);
		return nVal;
	}

	/**
	 * sArg1 과 sArg2 를 비교합니다. 
	 * 동일한 문자열일 경우 0 을 return 합니다.
	 * @param sArg1
	 * @param sArg2
	 * @return
	 */
	public static int compare(String sArg1, String sArg2) {
		if (sArg1 == null || sArg2 == null)
			return -1;
		int nRet = sArg1.compareTo(sArg2);
		return nRet;
	}

	/**
	 * sArg1 과 sArg2 를 대소문자 상관없이 비교합니다. 
	 * 동일한 문자열일 경우 0 을 return 합니다.
	 * @param sArg1
	 * @param sArg2
	 * @return
	 */
	public static int CompareNoCase(String sArg1, String sArg2) {
		if (sArg1 == null && sArg2 == null)
			return 0;
		if (sArg1 == null && !StringUtil.isEmpty(sArg2))
			return -3;
		if (!StringUtil.isEmpty(sArg1) && sArg2 == null)
			return -3;
		int nRet = sArg1.compareToIgnoreCase(sArg2);
		return nRet;
	}

	/**
	 * String을 boolean으로 변환하여 반환
	 * @param sVal
	 * @return
	 */
	public static boolean parseBoolean(String sVal) {
		if (sVal == null)
			return false;
		if (StringUtil.compare(sVal, "true") == 0) {
			return true;
		}
		return false;
	}

	/**
	 * @param sCompareL
	 * @param sCompareR
	 * @return
	 */
	public static boolean equals(String sCompareL, String sCompareR) {
		if (sCompareL == null && sCompareR == null)
			return true;
		else if (sCompareL == null) {
			return false;
		}
		boolean bRet = sCompareL.equals(sCompareR);
		return bRet;
	}

	/**
	 * @param sSrc
	 * @return
	 */
	public static int getByteLength(String sSrc) {
		if (sSrc == null)
			return 0;
		byte btSrc[] = sSrc.getBytes();
		int nSize = btSrc.length;
		return nSize;
	}

	/**
	 * sSrc값이 null인경우 "" empty string을 반환합니다.
	 * @param sSrc
	 * @return
	 */
	public static String nullCheck(String sSrc) {
		if (sSrc == null)
			return "";
		return sSrc;
	}

	/**
	 * sSrc값이 null 또는 "" 인 경우 sDefault 를 반환합니다.
	 * @param sSrc
	 * @param sDefault
	 * @return
	 */
	public static String nullCheck(String sSrc, String sDefault) {
		if (StringUtil.isEmpty(sSrc)) {
			return sDefault;
		}
		return sSrc;
	}

	/**
	 * 주어진 문자 sPattern 를 문자열 sSrc의 앞에서부터 뒤로 찾아 처음으로 나타나는 인덱스를 리턴.
	 * 만약, 주어진 문자가 문자열 내에 존재하지 않으면 -1을 리턴.
	 * @param sSrc
	 * @param sPattern
	 * @return
	 */
	public static int indexOf(String sSrc, String sPattern) {
		if (sSrc == null || sPattern == null)
			return -1;
		int nRet = sSrc.indexOf(sPattern);
		return nRet;
	}

	public static String stringToScript(String sSrc) {
		if (sSrc == null)
			return null;
		if (StringUtil.isEmpty(sSrc))
			return "";
		StringBuffer sDest = new StringBuffer();
		int nMaxLineChar = 256;
		int nLineChar = 0;
		int nLen = sSrc.length();
		for (int i = 0; i < nLen; i++) {
			if (nLineChar >= nMaxLineChar) {
				sDest.append("\"\n+\"");
				nLineChar = 0;
			}
			nLineChar++;
			char cChar = sSrc.charAt(i);
			if (cChar == '"') {
				sDest.append("\\");
				sDest.append(cChar);
				continue;
			} else if (cChar == '\\') {
				sDest.append("\\");
				sDest.append(cChar);
				continue;
			} else if (cChar == '\n') {
				sDest.append("\\");
				sDest.append("n");
				sDest.append("\"\n+\"");
				nLineChar = 0;
				continue;
			} else if (cChar == '\r') {
				sDest.append("\\");
				sDest.append("r");
				continue;
			} else if (cChar == '<') {
				sDest.append("<\"+\"");
				continue;
			} else if (cChar == '>') {
				sDest.append("\"+\">\"\n+\""); // line break
				nLineChar = 0;
				continue;
			}
			sDest.append(cChar);
		}
		return sDest.toString();
	}

	public static byte hexaByte(int nVal) {
		byte[] szHexaByte = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
		if (nVal > 15) {
			nVal = 0;
		}
		return szHexaByte[nVal];
	}

	public static boolean isUrlConvertChar(byte btByte) {
		if (btByte < 32) // (32 : space)
		{
			return true;
		} else if (btByte >= 33 && btByte <= 44) // (33 : !) ~ (44 : ,) , (45 : -)
		{
			return true;
		} else if (btByte >= 46 && btByte <= 47) // (46 : .) ~ (47 : /)
		{
			return true;
		} else if (btByte >= 58 && btByte <= 64) // (58 : :) ~ (64 : @)
		{
			return true;
		} else if (btByte >= 91 && btByte <= 96) // (91 : [) ~ (96 : `)
		{
			return true;
		} else if (btByte > 122) // (122 : z) , (123 : {)
		{
			return true;
		}
		return false;
	}

	/**
	 * 문자열을 url 형태로 encoding 하여 return 합니다.
	 * @param sArg
	 * @return
	 */
	public static String insertUrlEsc(String sArg) {
		if (sArg == null)
			return "";
		StringBuffer sRet = new StringBuffer();
		byte[] szSrc = sArg.getBytes();
		int nCount = szSrc.length;
		byte btBuf1[] = new byte[1];
		byte btBuf2[] = new byte[2];
		byte btByte;
		int nByte;
		for (int i = 0; i < nCount; i++) {
			btByte = szSrc[i];
			if (btByte < 0) {
				// hangul or double byte code
				// signed byte -> unsigned byte
				nByte = btByte < 0 ? (Byte.MAX_VALUE + 1) * 2 + btByte : btByte;
				// WCLog.printLog("nByte="+nByte);
				btBuf2[0] = StringUtil.hexaByte(nByte / 16);
				btBuf2[1] = StringUtil.hexaByte(nByte % 16);
				String sCode = "%" + new String(btBuf2);
				// WCLog.printLog("sCode="+sCode);
				sRet.append(sCode);
			} else {
				btBuf1[0] = btByte;
				if (btBuf1[0] == 32) {
					sRet.append("+");
				} else if (StringUtil.isUrlConvertChar(btByte)) {
					nByte = btByte;
					btBuf2[0] = StringUtil.hexaByte(nByte / 16);
					btBuf2[1] = StringUtil.hexaByte(nByte % 16);
					String sCode = "%" + new String(btBuf2);
					sRet.append(sCode);
				} else {
					String sCode = new String(btBuf1);
					sRet.append(sCode);
				}
			}
		}
		return sRet.toString();
	}

	public static String stringToHtmlText(String sSrc) {
		if (StringUtil.isEmpty(sSrc))
			return "";
		StringBuffer sBuf = new StringBuffer();
		int nCount = sSrc.length();
		for (int i = 0; i < nCount; i++) {
			char cChar = sSrc.charAt(i);
			// &#34; = " 
			if (cChar == '\"') {
				sBuf.append("&#34;");
				continue;
			}
			// &#39; = ' 
			if (cChar == '\'') {
				sBuf.append("&#39;");
				continue;
			}
			if (cChar == '#') {
				sBuf.append("&#35;");
				continue;
			}
			if (cChar == '&') {
				sBuf.append("&#38;");
				continue;
			}
			if (cChar == '<') {
				sBuf.append("&#60;");
				continue;
			}
			if (cChar == '>') {
				sBuf.append("&#62;");
				continue;
			}
			if (cChar == '\\') {
				sBuf.append("\\\\");
				continue;
			}
			if (cChar == '\t') {
				sBuf.append("\\t");
				continue;
			}
			if (cChar == '\r') {
				sBuf.append("\\r");
				continue;
			}
			if (cChar == '\n') {
				sBuf.append("\\n");
				continue;
			}
			sBuf.append("" + sSrc.charAt(i));
		}
		return sBuf.toString();
	}

	/**
	 * 문자열을 html로 변환합니다.
	 * string 안에 있는 '>' character code를 &#62; 으로 변환합니다.
	 * @param sSrc
	 * @return
	 */
	public static String toHtmlTagValue(String sSrc) {
		if (StringUtil.isEmpty(sSrc))
			return "";
		StringBuffer sBuf = new StringBuffer();
		int nCount = sSrc.length();
		for (int i = 0; i < nCount; i++) {
			char cChar = sSrc.charAt(i);
			// &#34; = " 
			if (cChar == '\"') {
				sBuf.append("&#34;");
				continue;
			}
			// &#39; = ' 
			if (cChar == '\'') {
				sBuf.append("&#39;");
				continue;
			}
			if (cChar == '#') {
				sBuf.append("&#35;");
				continue;
			}
			if (cChar == '&') {
				sBuf.append("&#38;");
				continue;
			}
			if (cChar == '<') {
				sBuf.append("&#60;");
				continue;
			}
			if (cChar == '>') {
				sBuf.append("&#62;");
				continue;
			}
			sBuf.append("" + sSrc.charAt(i));
		}
		return sBuf.toString();
	}

	/**
	 * 문자열을 html로 변환합니다.
	 * string 안에 있는 '>' character code를 &#62; 으로 변환합니다.
	 * @param sSrc
	 * @return
	 */
	public static String stringToHtml(String sSrc) {
		if (StringUtil.isEmpty(sSrc))
			return "";
		StringBuffer sBuf = new StringBuffer();
		int nCount = sSrc.length();
		for (int i = 0; i < nCount; i++) {
			char cChar = sSrc.charAt(i);
			// &#34; = " 
			if (cChar == '\"') {
				sBuf.append("&#34;");
				continue;
			}
			// &#39; = ' 
			if (cChar == '\'') {
				sBuf.append("&#39;");
				continue;
			}
			if (cChar == '#') {
				sBuf.append("&#35;");
				continue;
			}
			if (cChar == '&') {
				sBuf.append("&#38;");
				continue;
			}
			if (cChar == '<') {
				sBuf.append("&#60;");
				continue;
			}
			if (cChar == '>') {
				sBuf.append("&#62;");
				continue;
			}
			if (cChar == '\n') {
				sBuf.append("<br>\n");
				continue;
			}
			sBuf.append("" + sSrc.charAt(i));
		}
		return sBuf.toString();
	}

	/**
	 * byte array를 string으로 변환합니다.
	 * @param btBuf
	 * @param nLen
	 * @return
	 */
	public static String toString(byte btBuf[], int nLen) {
		if (btBuf == null || nLen < 0)
			return null;
		String sRet = new String(btBuf);
		sRet = sRet.substring(0, nLen);
		return sRet;
	}

	public static byte[] setByte(byte btBuf[], int nIdx, byte btChar) {
		int nSize = 0;
		if (btBuf != null)
			nSize = btBuf.length;
		if (nIdx >= nSize) {
			int nMax = nIdx + 1;
			byte btNew[] = new byte[nMax];
			for (int i = 0; i < nMax; i++) {
				btNew[i] = 0;
			}
			for (int i = 0; i < nSize; i++) {
				btNew[i] = btBuf[i];
			}
			btNew[nIdx] = btChar;
			btBuf = btNew;
		} else {
			btBuf[nIdx] = btChar;
		}
		return btBuf;
	}

	public static String htmlToString(String sSrc) {
		if (StringUtil.isEmpty(sSrc)) {
			return "";
		}
		String sData = sSrc; // "&#60;script 123&#62;123";
		byte m_btData[];
		m_btData = sData.getBytes();
		int nSize = m_btData.length;
		int m_nLen = nSize;
		byte btDest[] = null;
		int nDestIdx = 0;
		int nSrcIdx = 0;

		while (true) {
			byte cLex = 0;
			cLex = m_btData[nSrcIdx];
			nSrcIdx++;
			// WCLog.printLog(""+nSrcIdx+" "+cLex);
			if (cLex != '&') {
				btDest = StringUtil.setByte(btDest, nDestIdx, cLex);
				nDestIdx++;
			} else {
				if (nSrcIdx >= m_nLen)
					break;
				cLex = m_btData[nSrcIdx];
				nSrcIdx++;
				if (cLex == '#') {
					int nTok = 0;
					byte btTok[] = null;
					while (true) {
						if (nSrcIdx >= m_nLen)
							break;
						cLex = m_btData[nSrcIdx];
						nSrcIdx++;
						if (cLex == ';') {
							char cChar = (char) StringUtil.parseInt(toString(btTok, nTok));
							byte btCode = (byte) cChar;
							btDest = StringUtil.setByte(btDest, nDestIdx, btCode);
							nDestIdx++;
							break;
						}
						btTok = StringUtil.setByte(btTok, nTok, cLex);
						nTok++;
					}
				}
			}
			if (nSrcIdx >= m_nLen)
				break;
		}
		String sRet = new String(btDest);
		return sRet;
	}

	/**
	 * dbPcnt=96.23134
	 * nPrecision=3
	 * return=96.231
	 * @param dbPcnt
	 * @param nPrecision
	 * @return
	 */
	public static String formatPercent(double dbPcnt, int nPrecision) {
		if (nPrecision < 0) {
			return null;
		}
		String sPcnt = "" + dbPcnt;
		int nIdx = StringUtil.indexOf(sPcnt, ".");
		if (nIdx < 0) {
			return sPcnt;
		}
		String sInt = StringUtil.substring(sPcnt, 0, nIdx);
		String sFloat = StringUtil.substring(sPcnt, nIdx + 1, nIdx + 1 + nPrecision);
		String sRet = sInt + "." + sFloat;
		return sRet;
	}

	public static String getRandColorCode() {
		byte btColor[] = new byte[6];
		int nRand;
		nRand = (((int) (Math.random() * 10000))) % 16;
		btColor[0] = StringUtil.hexaByte(nRand);
		nRand = (((int) (Math.random() * 10000))) % 16;
		btColor[1] = StringUtil.hexaByte(nRand);
		nRand = (((int) (Math.random() * 10000))) % 16;
		btColor[2] = StringUtil.hexaByte(nRand);
		nRand = (((int) (Math.random() * 10000))) % 16;
		btColor[3] = StringUtil.hexaByte(nRand);
		nRand = (((int) (Math.random() * 10000))) % 16;
		btColor[4] = StringUtil.hexaByte(nRand);
		nRand = (((int) (Math.random() * 10000))) % 16;
		btColor[5] = StringUtil.hexaByte(nRand);
		String sCode = "#" + StringUtil.toString(btColor, 6);
		return sCode;
	}

	public static String getUUID() {
		return UUID.randomUUID().toString();
	}

	public static String nvl(String src) {
		return nvl(src, "");
	}

	public static String nvl(String src, String tgt) {
		String res = tgt;
		if (tgt == null)
			res = "";
		if (src == null)
			return res;
		if (src.equals("")) {
			return res;
		}
		return src;
	}

	public static String decode(String src) {
		if (nvl(src).equals("")) {
			return "";
		}
		return new String(Base64.decodeBase64(Base64.decodeBase64(Base64.decodeBase64(src))));
	}

	public static boolean isInteger(String s) {
		try {
			Integer.parseInt(s);
		} catch (Exception e) {
			return false;
		}
		return true;
	}
	
	public static boolean isFloat(String s) {
		try {
			Float.parseFloat(s);
		} catch (Exception e) {
			return false;
		}
		return true;
	}
	
	public static boolean isLong(String s){
		try {
			Long.parseLong(s);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

}
