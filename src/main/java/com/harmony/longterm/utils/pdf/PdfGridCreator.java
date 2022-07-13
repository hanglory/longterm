/*     */ package com.harmony.longterm.utils.pdf;
/*     */ import com.itextpdf.text.Document;
/*     */ import com.itextpdf.text.FontProvider;
/*     */ import com.itextpdf.text.PageSize;
/*     */ import com.itextpdf.text.Rectangle;
/*     */ import com.itextpdf.text.pdf.PdfPageEvent;
/*     */ import com.itextpdf.text.pdf.PdfWriter;
/*     */ import com.itextpdf.tool.xml.Pipeline;
/*     */ import com.itextpdf.tool.xml.XMLWorker;
/*     */ import com.itextpdf.tool.xml.XMLWorkerFontProvider;
/*     */ import com.itextpdf.tool.xml.XMLWorkerHelper;
/*     */ import com.itextpdf.tool.xml.css.CssFile;
/*     */ import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
/*     */ import com.itextpdf.tool.xml.html.CssAppliers;
/*     */ import com.itextpdf.tool.xml.html.CssAppliersImpl;
/*     */ import com.itextpdf.tool.xml.html.Tags;
/*     */ import com.itextpdf.tool.xml.parser.XMLParser;
/*     */ import com.itextpdf.tool.xml.parser.XMLParserListener;
/*     */ import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
/*     */ import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
/*     */ import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
/*     */ import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
/*     */ import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;
/*     */ import java.io.FileInputStream;
/*     */ import java.io.OutputStream;
/*     */ import java.io.StringReader;
/*     */ import java.net.URLEncoder;
/*     */ import java.nio.charset.Charset;
/*     */ import javax.servlet.ServletOutputStream;
/*     */ import javax.servlet.http.HttpServletRequest;
/*     */ import javax.servlet.http.HttpServletResponse;
/*     */ import org.apache.commons.io.output.ByteArrayOutputStream;
/*     */ import org.slf4j.Logger;
/*     */ import org.slf4j.LoggerFactory;
/*     */ 
/*     */ public class PdfGridCreator {
/*  37 */   private static final Logger LOGGER = LoggerFactory.getLogger(PdfGridCreator.class);
/*     */   
/*     */   private Document document;
/*     */ 
/*     */   
/*     */   public PdfGridCreator() {
/*  43 */     this.document = new Document(PageSize.A4.rotate(), 20.0F, 20.0F, 80.0F, 50.0F);
/*     */   }
/*     */ 
/*     */   
/*     */   public PdfGridCreator(Rectangle pageSize, int marginLeft, int marginRight, int marginTop, int marginBottom) {
/*  48 */     this.document = new Document(pageSize, marginLeft, marginRight, marginTop, marginBottom);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public byte[] getBinaryData(HttpServletRequest request, HttpServletResponse response, PdfGridPageEvent event) throws Exception {
/*  61 */     ByteArrayOutputStream bos = new ByteArrayOutputStream();
/*  62 */     PdfWriter writer = PdfWriter.getInstance(this.document, (OutputStream)bos);
/*  63 */     writer.setInitialLeading(12.5F);
/*  64 */     writer.setPageEvent((PdfPageEvent)event);
/*     */ 
/*     */     
/*  67 */     this.document.open();
/*     */ 
/*     */     
/*  70 */     StyleAttrCSSResolver styleAttrCSSResolver = new StyleAttrCSSResolver();
/*  71 */     XMLWorkerHelper.getInstance(); CssFile cssFile = XMLWorkerHelper.getCSS(new FileInputStream(PdfGridCreator.class.getClassLoader().getResource("com/bizmtec/common/pdf/grid.css").getPath()));
/*  72 */     styleAttrCSSResolver.addCss(cssFile);
/*     */ 
/*     */     
/*  75 */     XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider("￼");
/*  76 */     String path = PdfGridCreator.class.getClassLoader().getResource("com/bizmtec/common/pdf/malgun.ttf").getPath();
/*  77 */     fontProvider.register(path, "MalgunGothic");
/*  78 */     CssAppliersImpl cssAppliersImpl = new CssAppliersImpl((FontProvider)fontProvider);
/*     */     
/*  80 */     HtmlPipelineContext htmlContext = new HtmlPipelineContext((CssAppliers)cssAppliersImpl);
/*  81 */     htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
/*     */ 
/*     */     
/*  84 */     PdfWriterPipeline pdf = new PdfWriterPipeline(this.document, writer);
/*  85 */     HtmlPipeline html = new HtmlPipeline(htmlContext, (Pipeline)pdf);
/*  86 */     CssResolverPipeline css = new CssResolverPipeline((CSSResolver)styleAttrCSSResolver, (Pipeline)html);
/*     */     
/*  88 */     XMLWorker worker = new XMLWorker((Pipeline)css, true);
/*  89 */     XMLParser xmlParser = new XMLParser((XMLParserListener)worker, Charset.forName("UTF-8"));
/*     */     
/*  91 */     String htmlContent = event.getHtmlContent().toString();
/*  92 */     if (htmlContent == null || htmlContent.length() == 0) {
/*  93 */       htmlContent = "<html><head><body><h3>NO PDF DATA</h3></body></head></html>";
/*     */     }
/*     */     
/*  96 */     StringReader strReader = new StringReader(htmlContent);
/*  97 */     xmlParser.parse(strReader);
/*     */     
/*  99 */     this.document.close();
/* 100 */     writer.close();
/*     */     
/* 102 */     byte[] pdfBinary = bos.toByteArray();
/* 103 */     bos.close();
/*     */     
/* 105 */     return pdfBinary;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void download(Object fileName, HttpServletRequest request, HttpServletResponse response, PdfGridPageEvent event) throws Exception {
/* 118 */     String filename = String.valueOf(fileName);
/* 119 */     if (filename.lastIndexOf(".pdf") == -1) filename = String.valueOf(filename) + ".pdf";
/*     */ 
/*     */     
/* 122 */     String browser = request.getHeader("User-Agent");
/* 123 */     if (browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")) {
/* 124 */       filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
/*     */     } else {
/* 126 */       filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
/*     */     } 
/*     */ 
/*     */     
/* 130 */     response.setContentType("application/pdf");
/* 131 */     response.setHeader("Content-Transfer-Encoding", "binary;");
/* 132 */     response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
/*     */     
/* 134 */     ServletOutputStream servletOutputStream = response.getOutputStream();
/*     */     
/* 136 */     byte[] binary = getBinaryData(request, response, event);
/*     */     
/* 138 */     LOGGER.info("PDF File Download >> " + filename + " [" + binary.length + " Byte]");
/*     */     
/* 140 */     servletOutputStream.write(binary);
/* 141 */     servletOutputStream.flush();
/* 142 */     servletOutputStream.close();
/*     */   }
/*     */ }


/* Location:              D:\web\harmonybpm\WebContent\WEB-INF\classes\!\com\bizmtec\common\pdf\PdfGridCreator.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */