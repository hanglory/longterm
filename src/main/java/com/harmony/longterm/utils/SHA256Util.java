/*    */ package com.harmony.longterm.utils;
/*    */ 
/*    */ import java.security.MessageDigest;
/*    */ import java.security.NoSuchAlgorithmException;
/*    */ import java.util.Random;
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
/*    */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longter\\utils\SHA256Util.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */