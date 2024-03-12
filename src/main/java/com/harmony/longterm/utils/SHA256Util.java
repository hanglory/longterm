/*    */ package com.harmony.longterm.utils;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
/*    */ 
/*    */ import java.security.MessageDigest;
/*    */ import java.security.NoSuchAlgorithmException;
/*    */ import java.util.Random;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
//import java.util.Base64;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public class SHA256Util
/*    */ {

/* 현대 캐피탈 */
//	private static final String ENCRYPT_KEY = "E84004533D5E89900B46F27AB2BE763DEA6E77AB460FF38552558162AD914FF6";	//개발
//	private static final String ENCRYPT_IV = "C9E953FA62B1993B94793D98D99F4DBA";									//개발
	private static final String ENCRYPT_KEY = "04023C48960EC97785F28D0D67123951C3143E97A372D0B63151637B58875E4A";	//운영
	private static final String ENCRYPT_IV = "9C5D8A54292A7E58B2B10DA4ACFC8126";									//운영
	
	private static final String CHARACTER_ENCODING = "UTF-8";
	private static final String CIPHER_TRANSFORMATION = "AES/CBC/PKCS5Padding";
	private static final String AES_ENCRYPTION_ALGORITHM = "AES";
	
//	private static final String SK_ENCRYPT_KEY = "axa_aes256_decode_key_info_12345";
//	private static final String SK_ENCRYPT_IV = "0000000000000000"; // 16 bytes
	private static final String S_KEY_256 = "axa_aes256_decode_key_info_12345";
	
	
/*    */   public static String getEncrypt(String source, String salt) {
/* 21 */     return getEncrypt(source, salt.getBytes());
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public static String getEncrypt(String source, byte[] salt) {
/* 32 */     String result = "";
/*    */     
/* 34 */     byte[] a = source.getBytes();
/* 35 */     byte[] bytes = new byte[a.length + salt.length];
/*    */     
/* 37 */     System.arraycopy(a, 0, bytes, 0, a.length);
/* 38 */     System.arraycopy(salt, 0, bytes, a.length, salt.length);
/*    */ 
/*    */     
/*    */     try {
/* 42 */       MessageDigest md = MessageDigest.getInstance("SHA-256");
/* 43 */       md.update(bytes);
/*    */       
/* 45 */       byte[] byteData = md.digest();
/*    */       
/* 47 */       StringBuffer sb = new StringBuffer();
/* 48 */       for (int i = 0; i < byteData.length; i++) {
/* 49 */         sb.append(Integer.toString((byteData[i] & 0xFF) + 256, 16).substring(1));
/*    */       }
/*    */       
/* 52 */       result = sb.toString();
/* 53 */     } catch (NoSuchAlgorithmException e) {
/* 54 */       e.printStackTrace();
/*    */     } 
/*    */     
/* 57 */     return result;
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public static String generateSalt() {
/* 65 */     Random random = new Random();
/*    */     
/* 67 */     byte[] salt = new byte[8];
/* 68 */     random.nextBytes(salt);
/*    */     
/* 70 */     StringBuffer sb = new StringBuffer();
/* 71 */     for (int i = 0; i < salt.length; i++) {
/*    */       
/* 73 */       sb.append(String.format("%02x", new Object[] { Byte.valueOf(salt[i]) }));
/*    */     } 
/*    */     
/* 76 */     return sb.toString();
/*    */   }

/**
     * 
     * Base64 복호화 후 AES복호화
     *
     * @param encryptedText
     * @param key
     * @return
     * @throws UnsupportedEncodingException
     * @throws Exception
 */

	public static String decryptBase64HC(String encryptedText) throws UnsupportedEncodingException, Exception {
	
	    byte[] cipheredBytes = Base64.decodeBase64(encryptedText);
	
	    byte[] keyBytes = getKeyBytes(ENCRYPT_KEY);
	    byte[] ivBytes = getKeyBytesIv(ENCRYPT_IV);
	    String decryptStr = encryptedText;
	    try {
	    	decryptStr = new String(decrypt(cipheredBytes, keyBytes, ivBytes), "UTF-8" );
	    }catch(Exception e){
	    	decryptStr = encryptedText;
	    }
//	    return new String(decrypt(cipheredBytes, keyBytes, ivBytes), "UTF-8" );
	    return decryptStr;
	}
	
	public static byte[] decrypt(byte[] cipherText, byte[] key, byte[] initialVector) throws Exception {
		
		Cipher cipher = Cipher.getInstance(CIPHER_TRANSFORMATION);
	
		SecretKeySpec secretKeySpec = new SecretKeySpec(key, AES_ENCRYPTION_ALGORITHM);
		
		IvParameterSpec ivParameterSpec = new IvParameterSpec(initialVector);
	
		cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, ivParameterSpec);
	
		byte[] returnCipherText = cipher.doFinal(cipherText);
	
		return returnCipherText;
	}
	
	private static byte[] getKeyBytes(String key) throws UnsupportedEncodingException {
		
		byte[] keyBytes = new byte[32];
		byte[] parameterKeyBytes = key.getBytes(CHARACTER_ENCODING);
		System.arraycopy(parameterKeyBytes, 0, keyBytes, 0, Math.min(parameterKeyBytes.length, keyBytes.length));
		return keyBytes;
	}
	private static byte[] getKeyBytesIv(String key) throws UnsupportedEncodingException {
		
		byte[] keyBytes = new byte[16];
		byte[] parameterKeyBytes = key.getBytes(CHARACTER_ENCODING);
		System.arraycopy(parameterKeyBytes, 0, keyBytes, 0, Math.min(parameterKeyBytes.length, keyBytes.length));
		return keyBytes;
	}
	
	public static String encryptBase64HC(String encryptedText) throws UnsupportedEncodingException, Exception {
		
	    byte[] cipheredBytes = Base64.decodeBase64(encryptedText);
	
	    byte[] keyBytes = getKeyBytes(ENCRYPT_KEY);
	    byte[] ivBytes = getKeyBytesIv(ENCRYPT_IV);
	
	    return new String(encrypt(cipheredBytes, keyBytes, ivBytes), "UTF-8" );
	}	
	public static byte[] encrypt(byte[] cipherText, byte[] key, byte[] initialVector) throws Exception {
		
		Cipher cipher = Cipher.getInstance(CIPHER_TRANSFORMATION);
	
		SecretKeySpec secretKeySpec = new SecretKeySpec(key, AES_ENCRYPTION_ALGORITHM);
		
		IvParameterSpec ivParameterSpec = new IvParameterSpec(initialVector);
	
		cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, ivParameterSpec);
	
		byte[] returnCipherText = cipher.doFinal(cipherText);
	
		return returnCipherText;
	}	
	
	/* 현대 Decrypt 종료 */

	
	public static String skEncrypt(String str) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException,
					IllegalBlockSizeException, BadPaddingException{
			String iv_256 = S_KEY_256.substring(0,16);
			byte[] keyBytes = new byte[16];
			byte[] b = S_KEY_256.getBytes("UTF-8");
			int len = b.length;
			
			if(len > keyBytes.length)
				len = keyBytes.length;
			
			System.arraycopy(b, 0, keyBytes, 0, len);
			SecretKeySpec secretKeySpec = new SecretKeySpec(keyBytes, "AES");
			IvParameterSpec ivParameterSpec = new IvParameterSpec(iv_256.getBytes());
	        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, ivParameterSpec);

	        byte[] encryptedBytes = cipher.doFinal(str.getBytes(StandardCharsets.UTF_8));
	        String enStr = new String(Base64.encodeBase64(encryptedBytes));
			
		return enStr;
	}
	
    public static String skDecrypt(String encryptedText) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException,
	IllegalBlockSizeException, BadPaddingException {
    	String iv_256 = S_KEY_256.substring(0, 16);
    	
        byte[] keyBytes = new byte[16];
        byte[] b = S_KEY_256.getBytes("UTF-8");
		int len = b.length;
		if(len > keyBytes.length)
			len = keyBytes.length;

		System.arraycopy(b, 0, keyBytes, 0, len);
        SecretKeySpec secretKeySpec = new SecretKeySpec(keyBytes, "AES");
        IvParameterSpec ivParameterSpec = new IvParameterSpec(iv_256.getBytes());

        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, ivParameterSpec);

        byte[] encryptedBytes = Base64.decodeBase64(encryptedText.getBytes());
        String decryptedStr = new String(cipher.doFinal(encryptedBytes), "UTF-8");
        return  decryptedStr;
    }	
/*	
	public static String skEncrypt(String plaintext) throws Exception {
	        byte[] keyBytes = SK_ENCRYPT_KEY.getBytes(StandardCharsets.UTF_8);
	        byte[] ivBytes = SK_ENCRYPT_IV.getBytes(StandardCharsets.UTF_8);

	        SecretKeySpec secretKeySpec = new SecretKeySpec(keyBytes, "AES");
	        IvParameterSpec ivParameterSpec = new IvParameterSpec(ivBytes);

	        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, ivParameterSpec);

	        byte[] encryptedBytes = cipher.doFinal(plaintext.getBytes(StandardCharsets.UTF_8));
	        return Base64.encodeBase64String(encryptedBytes);
	    }

	    public static String skDecrypt(String encryptedText) throws Exception {
	        byte[] keyBytes = SK_ENCRYPT_KEY.getBytes(StandardCharsets.UTF_8);
	        byte[] ivBytes = SK_ENCRYPT_IV.getBytes(StandardCharsets.UTF_8);

	        SecretKeySpec secretKeySpec = new SecretKeySpec(keyBytes, "AES");
	        IvParameterSpec ivParameterSpec = new IvParameterSpec(ivBytes);

	        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	        cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, ivParameterSpec);

	        byte[] encryptedBytes = Base64.decodeBase64(encryptedText);
	        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
	        return new String(decryptedBytes, StandardCharsets.UTF_8);
	    }
*/	
	
}


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longter\\utils\SHA256Util.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */