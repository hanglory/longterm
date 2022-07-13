/*     */ package com.harmony.longterm.utils.pdf;
/*     */ 
/*     */ import com.itextpdf.text.BaseColor;
/*     */ import com.itextpdf.text.Document;
/*     */ import com.itextpdf.text.Font;
/*     */ import com.itextpdf.text.Paragraph;
/*     */ import com.itextpdf.text.Phrase;
/*     */ import com.itextpdf.text.Rectangle;
/*     */ import com.itextpdf.text.pdf.BaseFont;
/*     */ import com.itextpdf.text.pdf.CMYKColor;
/*     */ import com.itextpdf.text.pdf.ColumnText;
/*     */ import com.itextpdf.text.pdf.PdfPageEventHelper;
/*     */ import com.itextpdf.text.pdf.PdfWriter;
/*     */ import java.util.Calendar;
/*     */ import javax.servlet.http.HttpServletRequest;
/*     */ 
/*     */ 
/*     */ public class PdfHtmlPageEvent
/*     */   extends PdfPageEventHelper
/*     */ {
/*  21 */   private String htmlString = "";
/*     */ 
/*     */   
/*     */   private Font objFont10;
/*     */ 
/*     */   
/*     */   private Font objFont16;
/*     */ 
/*     */   
/*     */   private int pagenumber;
/*     */ 
/*     */ 
/*     */   
/*     */   private boolean isEmpty(Object source) {
/*  35 */     if (source == null || "".equals(source)) {
/*  36 */       return true;
/*     */     }
/*  38 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public PdfHtmlPageEvent(String htmlString, HttpServletRequest request) {
/*  43 */     BaseFont objBaseFont = null;
/*     */ 
/*     */     
/*     */     try {
/*  47 */       if (!isEmpty(htmlString)) {
/*  48 */         this.htmlString = htmlString;
/*     */       }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*  56 */       String path = PdfGridCreator.class.getClassLoader().getResource("com/bizmtec/common/pdf/malgun.ttf").getPath();
/*  57 */       objBaseFont = BaseFont.createFont(path, "Identity-H", true);
/*  58 */       this.objFont10 = new Font(objBaseFont, 10.0F, 0, (BaseColor)new CMYKColor(0, 0, 0, 240));
/*  59 */       this.objFont16 = new Font(objBaseFont, 16.0F, 1, (BaseColor)new CMYKColor(0, 0, 0, 250));
/*     */     }
/*  61 */     catch (Exception e) {
/*  62 */       e.printStackTrace();
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void onStartPage(PdfWriter writer, Document document) {
/*  68 */     this.pagenumber++;
/*     */   }
/*     */ 
/*     */   
/*     */   public void onChapter(PdfWriter writer, Document document, float paragraphPosition, Paragraph title) {
/*  73 */     this.pagenumber = 1;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void onEndPage(PdfWriter writer, Document document) {
/*  79 */     Rectangle rect = writer.getPageSize();
/*     */     
/*  81 */     Calendar cal = Calendar.getInstance();
/*  82 */     String ampm = "";
/*  83 */     if (cal.get(9) == 0) {
/*  84 */       ampm = "AM";
/*     */     } else {
/*  86 */       ampm = "PM";
/*     */     } 
/*  88 */     String today = String.format("%04d-%02d-%02d %s %02d:%02d:%02d", new Object[] { Integer.valueOf(cal.get(1)), Integer.valueOf(cal.get(2) + 1), Integer.valueOf(cal.get(5)), ampm, Integer.valueOf(cal.get(10)), Integer.valueOf(cal.get(12)), Integer.valueOf(cal.get(13)) });
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*  93 */     ColumnText.showTextAligned(writer.getDirectContent(), 0, new Phrase("Harmony", this.objFont10), rect.getLeft() + 20.0F, rect.getBottom() + 20.0F, 0.0F);
/*     */     
/*  95 */     ColumnText.showTextAligned(writer.getDirectContent(), 1, new Phrase(String.format("- %d -", new Object[] { Integer.valueOf(this.pagenumber) }), this.objFont10), (rect.getLeft() + rect.getRight()) / 2.0F, rect.getBottom() + 20.0F, 0.0F);
/*     */     
/*  97 */     ColumnText.showTextAligned(writer.getDirectContent(), 2, new Phrase(today, this.objFont10), rect.getRight() - 20.0F, rect.getBottom() + 20.0F, 0.0F);
/*     */   }
/*     */   
/*     */   public String getHtmlContent() throws Exception {
/* 101 */     return this.htmlString;
/*     */   }
/*     */   
/*     */   public void onCloseDocument(PdfWriter writer, Document document) {}
/*     */   
/*     */   public void onParagraph(PdfWriter writer, Document document, float paragraphPosition) {}
/*     */   
/*     */   public void onParagraphEnd(PdfWriter writer, Document document, float paragraphPosition) {}
/*     */   
/*     */   public void onChapterEnd(PdfWriter writer, Document document, float position) {}
/*     */   
/*     */   public void onSection(PdfWriter writer, Document document, float paragraphPosition, int depth, Paragraph title) {}
/*     */   
/*     */   public void onSectionEnd(PdfWriter writer, Document document, float position) {}
/*     */   
/*     */   public void onGenericTag(PdfWriter writer, Document document, Rectangle rect, String text) {}
/*     */   
/*     */   public void onOpenDocument(PdfWriter writer, Document document) {}
/*     */ }


/* Location:              D:\web\harmonybpm\WebContent\WEB-INF\classes\!\com\bizmtec\common\pdf\PdfHtmlPageEvent.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */