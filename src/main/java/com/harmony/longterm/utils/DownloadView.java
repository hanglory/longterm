/*    */ package com.harmony.longterm.utils;
/*    */ 
/*    */ import java.io.File;
/*    */ import java.io.FileInputStream;
/*    */ import java.io.OutputStream;
/*    */ import java.net.URLEncoder;
/*    */ import java.util.Map;
/*    */ import javax.servlet.ServletOutputStream;
/*    */ import javax.servlet.http.HttpServletRequest;
/*    */ import javax.servlet.http.HttpServletResponse;
/*    */ import org.springframework.util.FileCopyUtils;
/*    */ import org.springframework.web.servlet.view.AbstractView;
/*    */ 
/*    */ public class DownloadView
/*    */   extends AbstractView
/*    */ {
/*    */   private String rootPath;
/*    */   
/*    */   public DownloadView(String rootPath) {
/* 20 */     this.rootPath = rootPath;
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
/* 28 */     String reqFileName = (String)model.get("downloadFile");
/* 29 */     String fullPath = String.valueOf(this.rootPath) + "/" + reqFileName;
/*    */     
/* 31 */     File file = new File(fullPath);
/*    */     
/* 33 */     if (file != null) {
/* 34 */       String fileName = null;
/* 35 */       String userAgent = request.getHeader("User-Agent");
/*    */       
/* 37 */       if (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1) {
/* 38 */         fileName = URLEncoder.encode(file.getName(), "utf-8").replaceAll("\\+", "%20");
/* 39 */       } else if (userAgent.indexOf("Chrome") > -1) {
/* 40 */         StringBuffer sb = new StringBuffer();
/* 41 */         for (int i = 0; i < file.getName().length(); i++) {
/* 42 */           char c = file.getName().charAt(i);
/* 43 */           if (c > '~') {
/* 44 */             sb.append(URLEncoder.encode(String.valueOf(c), "UTF-8"));
/*    */           } else {
/* 46 */             sb.append(c);
/*    */           } 
/*    */         } 
/* 49 */         fileName = sb.toString();
/*    */       } else {
/* 51 */         fileName = new String(file.getName().getBytes("utf-8"));
/*    */       } 
/* 53 */       response.setContentType(getContentType());
/* 54 */       response.setContentLength((int)file.length());
/* 55 */       response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
/* 56 */       response.setHeader("Content-Transfer-Encoding", "binary");
/*    */       
/* 58 */       ServletOutputStream servletOutputStream = response.getOutputStream();
/* 59 */       FileInputStream fis = null;
/*    */       try {
/* 61 */         fis = new FileInputStream(file);
/* 62 */         FileCopyUtils.copy(fis, (OutputStream)servletOutputStream);
/* 63 */       } catch (Exception e) {
/* 64 */         e.printStackTrace();
/*    */       } finally {
/* 66 */         if (fis != null) {
/*    */           try {
/* 68 */             fis.close();
/* 69 */           } catch (Exception e) {
/* 70 */             e.printStackTrace();
/*    */           } 
/*    */         }
/*    */         
/* 74 */         if (servletOutputStream != null)
/* 75 */           servletOutputStream.flush(); 
/*    */       } 
/*    */     } 
/*    */   }
/*    */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longter\\utils\DownloadView.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */