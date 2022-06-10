package com.gabia.api;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
//import sun.misc.BASE64Decoder;
//import sun.misc.BASE64Encoder;
import java.util.Base64;

public class Base64Utils {

	/**
	 * Base64Encoding ������� ����Ʈ �迭�� �ƽ�Ű ���ڿ��� ���ڵ��Ѵ�. In-Binany, Out-Ascii
	 * 
	 * @param encodeBytes
	 *            ���ڵ��� ����Ʈ �迭(byte[])
	 * @return ���ڵ��� �ƽ�Ű ���ڿ�(String)
	 */
	public static String encode(byte[] encodeBytes) {
		byte[] buf = null;
		String strResult = null;
//		BASE64Encoder base64Encoder = new BASE64Encoder();
		ByteArrayInputStream bin = new ByteArrayInputStream(encodeBytes);
		ByteArrayOutputStream bout = new ByteArrayOutputStream();

		try {
			strResult = Base64.getEncoder().encodeToString(encodeBytes).trim();
//			base64Encoder.encodeBuffer(bin, bout);
		} catch (Exception e) {
			System.out.println("Exception");
			e.printStackTrace();
		}
//		buf = bout.toByteArray();
//		strResult = new String(buf).trim();
		return strResult;
	}

	/**
	 * Base64Decoding ������� �ƽ�Ű ���ڿ��� ����Ʈ �迭�� ���ڵ��Ѵ�. In-Ascii, Out-Binany
	 * 
	 * @param strDecode
	 *            ���ڵ��� �ƽ�Ű ���ڿ�(String)
	 * @return ���ڵ��� ����Ʈ �迭(byte[])
	 */
	public static byte[] decode(String strDecode) {
		byte[] buf = null;

//		BASE64Decoder base64Decoder = new BASE64Decoder();
		ByteArrayInputStream bin = new ByteArrayInputStream(strDecode.getBytes());
		ByteArrayOutputStream bout = new ByteArrayOutputStream();

		try {
//			base64Decoder.decodeBuffer(bin, bout);
			buf = Base64.getDecoder().decode(strDecode);
		} catch (Exception e) {
			System.out.println("Exception");
			e.printStackTrace();
		}
//		buf = bout.toByteArray();
		return buf;
	}

	public static void main(String args[]) {
		String strOrgin = "Test String";
		String strDecode = null;
		byte[] bytOrgin = strOrgin.getBytes();

		System.out.println("OriginString=" + strOrgin);

		String strEncoded = Base64Utils.encode(bytOrgin);
		System.out.println("EncodedString=" + strEncoded);

		byte[] bytDecoded = Base64Utils.decode(strEncoded);
		strDecode = new String(bytDecoded);
		System.out.println("DecodedString=" + strDecode);
	}
}
