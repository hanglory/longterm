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
/*     */ import java.util.ArrayList;
/*     */ import java.util.Calendar;
/*     */ import java.util.List;
/*     */ import java.util.Map;
/*     */ import javax.servlet.http.HttpServletRequest;
/*     */ 
/*     */ 
/*     */ public class PdfGridPageEvent
/*     */   extends PdfPageEventHelper
/*     */ {
/*  24 */   private String title = "Untitled";
/*  25 */   private List<Map<String, Object>> colModelList = new ArrayList<>();
/*  26 */   private List<Map<String, Object>> gridDataList = new ArrayList<>();
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
/*     */   private String isNull(Object source) {
/*  39 */     return isNull(source, "");
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private String isNull(Object source, Object defaultValue) {
/*  49 */     if (source == null || "".equals(source)) {
/*  50 */       return defaultValue.toString();
/*     */     }
/*  52 */     source = String.valueOf(source).replaceAll("<", "〈").replaceAll(">", "〉");
/*  53 */     return source.toString();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public PdfGridPageEvent(Map<String, Object> param, HttpServletRequest request) {
/*  59 */     BaseFont objBaseFont = null;
/*     */ 
/*     */     
/*     */     try {
/*  63 */       if (param.get("title") != null) {
/*  64 */         this.title = isNull(param.get("title"));
/*     */       }
/*  66 */       if (param.get("colModel") != null) {
/*  67 */         this.colModelList = (List<Map<String, Object>>)param.get("colModel");
/*     */       }
/*  69 */       if (param.get("gridData") != null) {
/*  70 */         this.gridDataList = (List<Map<String, Object>>)param.get("gridData");
/*     */       }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*  78 */       String path = PdfGridCreator.class.getClassLoader().getResource("pdf/malgun.ttf").getPath();
/*  79 */       objBaseFont = BaseFont.createFont(path, "Identity-H", true);
/*  80 */       this.objFont10 = new Font(objBaseFont, 10.0F, 0, (BaseColor)new CMYKColor(0, 0, 0, 240));
/*  81 */       this.objFont16 = new Font(objBaseFont, 16.0F, 1, (BaseColor)new CMYKColor(0, 0, 0, 250));
/*     */     }
/*  83 */     catch (Exception e) {
/*  84 */       e.printStackTrace();
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void onStartPage(PdfWriter writer, Document document) {
/*  90 */     this.pagenumber++;
/*  91 */     Rectangle rect = writer.getPageSize();
/*  92 */     ColumnText.showTextAligned(writer.getDirectContent(), 1, new Phrase(this.title, this.objFont16), (rect.getLeft() + rect.getRight()) / 2.0F, rect.getTop() - 50.0F, 0.0F);
/*     */   }
/*     */ 
/*     */   
/*     */   public void onChapter(PdfWriter writer, Document document, float paragraphPosition, Paragraph title) {
/*  97 */     this.pagenumber = 1;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void onEndPage(PdfWriter writer, Document document) {
/* 103 */     Rectangle rect = writer.getPageSize();
/*     */     
/* 105 */     Calendar cal = Calendar.getInstance();
/*     */     
/* 107 */     String ampm = "";
/* 108 */     if (cal.get(9) == 0) {
/* 109 */       ampm = "AM";
/*     */     } else {
/* 111 */       ampm = "PM";
/*     */     } 
/* 113 */     String today = String.format("%04d-%02d-%02d %s %02d:%02d:%02d", new Object[] { Integer.valueOf(cal.get(1)), Integer.valueOf(cal.get(2) + 1), Integer.valueOf(cal.get(5)), ampm, Integer.valueOf(cal.get(10)), Integer.valueOf(cal.get(12)), Integer.valueOf(cal.get(13)) });
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 118 */     ColumnText.showTextAligned(writer.getDirectContent(), 0, new Phrase("Hanwha Q Cells", this.objFont10), rect.getLeft() + 20.0F, rect.getBottom() + 20.0F, 0.0F);
/*     */     
/* 120 */     ColumnText.showTextAligned(writer.getDirectContent(), 1, new Phrase(String.format("- %d -", new Object[] { Integer.valueOf(this.pagenumber) }), this.objFont10), (rect.getLeft() + rect.getRight()) / 2.0F, rect.getBottom() + 20.0F, 0.0F);
/*     */     
/* 122 */     ColumnText.showTextAligned(writer.getDirectContent(), 2, new Phrase(today, this.objFont10), rect.getRight() - 20.0F, rect.getBottom() + 20.0F, 0.0F);
/*     */   }
/*     */   
/*     */   public StringBuilder getHtmlContent() throws Exception {
/* 126 */     int colModelLength = this.colModelList.size();
/* 127 */     int gridDataLength = this.gridDataList.size();
/*     */     
/* 129 */     StringBuilder htmlStr = new StringBuilder();
/*     */     
/* 131 */     htmlStr
/* 132 */       .append("<html><head>")
/* 133 */       .append("<title>")
/* 134 */       .append(this.title)
/* 135 */       .append("</title>")
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 143 */       .append("</head><body>")
/* 144 */       .append("<table style='width:100%;border-collapse:collapse;border-spacing:0;table-layout:fixed;'>");
/*     */ 
/*     */ 
/*     */     
/* 148 */     htmlStr.append("<tr>");
/*     */     
/* 150 */     if (colModelLength == 0) {
/* 151 */       htmlStr.append("<th>NO</th>");
/*     */     }
/*     */     int i;
/* 154 */     for (i = 0; i < colModelLength; i++) {
/* 155 */       htmlStr
/* 156 */         .append("<th>")
/* 157 */         .append(isNull(((Map)this.colModelList.get(i)).get("label")))
/* 158 */         .append("</th>");
/*     */     }
/*     */ 
/*     */     
/* 162 */     htmlStr.append("</tr>");
/*     */ 
/*     */     
/* 165 */     for (i = 0; i < gridDataLength; i++) {
/* 166 */       htmlStr.append("<tr>");
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 174 */       for (int j = 0; j < colModelLength; j++) {
/* 175 */         if ("center".equals(((Map)this.colModelList.get(j)).get("align"))) {
/* 176 */           htmlStr.append("<td style=\"text-align:center;\">");
/* 177 */         } else if ("right".equals(((Map)this.colModelList.get(j)).get("align"))) {
/* 178 */           htmlStr.append("<td style=\"text-align:right;padding-right:5px;\">");
/*     */         } else {
/* 180 */           htmlStr.append("<td style=\"padding-left:5px;\">");
/*     */         } 
/* 182 */         if ("integer".equals(((Map)this.colModelList.get(j)).get("formatter")) || "number".equals(((Map)this.colModelList.get(j)).get("formatter"))) {
/*     */           
/* 184 */           String value = isNull(((Map)this.gridDataList.get(i)).get(((Map)this.colModelList.get(j)).get("name")), "0");
/* 185 */           if (value.lastIndexOf(".") == -1) {
/* 186 */             htmlStr.append(String.format("%,d", new Object[] { Long.valueOf(Long.parseLong(value)) }));
/*     */           } else {
/* 188 */             htmlStr.append(String.format("%,.2f", new Object[] { Double.valueOf(Double.parseDouble(value)) }));
/*     */           } 
/* 190 */         } else if ("currency".equals(((Map)this.colModelList.get(j)).get("formatter"))) {
/* 191 */           String value = isNull(((Map)this.gridDataList.get(i)).get(((Map)this.colModelList.get(j)).get("name")), "0");
/* 192 */           htmlStr.append(String.format("%,.4f", new Object[] { Double.valueOf(Double.parseDouble(value)) }));
/*     */         } else {
/* 194 */           htmlStr.append(isNull(((Map)this.gridDataList.get(i)).get(((Map)this.colModelList.get(j)).get("name"))));
/*     */         } 
/* 196 */         htmlStr.append("</td>");
/*     */       } 
/* 198 */       htmlStr.append("</tr>");
/*     */     } 
/*     */     
/* 201 */     htmlStr.append("</table>");
/* 202 */     htmlStr.append("</body></html>");
/*     */     
/* 204 */     return htmlStr;
/*     */   }
/*     */   
/*     */   public String getFilename() {
/* 208 */     return this.title;
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


/* Location:              D:\web\harmonybpm\WebContent\WEB-INF\classes\!\com\bizmtec\common\pdf\PdfGridPageEvent.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */