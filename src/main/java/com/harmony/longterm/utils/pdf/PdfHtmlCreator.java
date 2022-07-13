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
/*     */ public class PdfHtmlCreator {
/*  37 */   private static final Logger LOGGER = LoggerFactory.getLogger(PdfHtmlCreator.class);
/*     */   
/*     */   private Document document;
/*     */ 
/*     */   
/*     */   public PdfHtmlCreator() {
/*  43 */     this.document = new Document(PageSize.A4, 20.0F, 20.0F, 20.0F, 50.0F);
/*     */   }
/*     */ 
/*     */   
/*     */   public PdfHtmlCreator(Rectangle pageSize, int marginLeft, int marginRight, int marginTop, int marginBottom) {
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
/*     */   
/*     */   public byte[] getBinaryData(HttpServletRequest request, HttpServletResponse response, PdfHtmlPageEvent event, String cssFileName) throws Exception {
/*  62 */     ByteArrayOutputStream bos = new ByteArrayOutputStream();
/*  63 */     PdfWriter writer = PdfWriter.getInstance(this.document, (OutputStream)bos);
/*  64 */     writer.setInitialLeading(12.5F);
/*  65 */     writer.setPageEvent((PdfPageEvent)event);
/*     */ 
/*     */     
/*  68 */     this.document.open();
/*     */ 
/*     */     
/*  71 */     StyleAttrCSSResolver styleAttrCSSResolver = new StyleAttrCSSResolver();
/*  72 */     if (cssFileName != null) {
/*  73 */       XMLWorkerHelper.getInstance(); CssFile cssFile = XMLWorkerHelper.getCSS(new FileInputStream(PdfHtmlCreator.class.getClassLoader().getResource("com/bizmtec/common/pdf/" + cssFileName).getPath()));
/*  74 */       styleAttrCSSResolver.addCss(cssFile);
/*     */     } 
/*     */ 
/*     */     
/*  78 */     XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider("￼");
/*  79 */     String path = PdfHtmlCreator.class.getClassLoader().getResource("com/bizmtec/common/pdf/malgun.ttf").getPath();
/*  80 */     fontProvider.register(path, "MalgunGothic");
/*  81 */     CssAppliersImpl cssAppliersImpl = new CssAppliersImpl((FontProvider)fontProvider);
/*     */     
/*  83 */     HtmlPipelineContext htmlContext = new HtmlPipelineContext((CssAppliers)cssAppliersImpl);
/*  84 */     htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
/*     */ 
/*     */     
/*  87 */     PdfWriterPipeline pdf = new PdfWriterPipeline(this.document, writer);
/*  88 */     HtmlPipeline html = new HtmlPipeline(htmlContext, (Pipeline)pdf);
/*  89 */     CssResolverPipeline css = new CssResolverPipeline((CSSResolver)styleAttrCSSResolver, (Pipeline)html);
/*     */     
/*  91 */     XMLWorker worker = new XMLWorker((Pipeline)css, true);
/*  92 */     XMLParser xmlParser = new XMLParser((XMLParserListener)worker, Charset.forName("UTF-8"));
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*  98 */     String htmlContent = event.getHtmlContent().toString();
/*  99 */     if (htmlContent == null || htmlContent.length() == 0) {
/* 100 */       htmlContent = "<html><head><body><h3>NO PDF DATA</h3></body></head></html>";
/*     */     }
/*     */ 
/*     */     
/* 104 */     StringReader strReader = new StringReader(htmlContent);
/*     */     
/* 106 */     xmlParser.parse(strReader);
/*     */     
/* 108 */     this.document.close();
/* 109 */     writer.close();
/*     */     
/* 111 */     byte[] pdfBinary = bos.toByteArray();
/* 112 */     bos.close();
/*     */     
/* 114 */     return pdfBinary;
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
/*     */   public void download(Object fileName, HttpServletRequest request, HttpServletResponse response, PdfHtmlPageEvent event, String cssFileName) throws Exception {
/* 127 */     String filename = String.valueOf(fileName);
/* 128 */     if (filename.lastIndexOf(".pdf") == -1) filename = String.valueOf(filename) + ".pdf";
/*     */ 
/*     */     
/* 131 */     String browser = request.getHeader("User-Agent");
/* 132 */     if (browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")) {
/* 133 */       filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
/*     */     } else {
/* 135 */       filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
/*     */     } 
/*     */ 
/*     */     
/* 139 */     response.setContentType("application/pdf");
/* 140 */     response.setHeader("Content-Transfer-Encoding", "binary;");
/* 141 */     response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
/*     */     
/* 143 */     ServletOutputStream servletOutputStream = response.getOutputStream();
/*     */     
/* 145 */     byte[] binary = getBinaryData(request, response, event, cssFileName);
/*     */     
/* 147 */     LOGGER.info("PDF File Download >> " + filename + " [" + binary.length + " Byte]");
/*     */     
/* 149 */     servletOutputStream.write(binary);
/* 150 */     servletOutputStream.flush();
/* 151 */     servletOutputStream.close();
/*     */   }
/*     */ }


/* Location:              D:\web\harmonybpm\WebContent\WEB-INF\classes\!\com\bizmtec\common\pdf\PdfHtmlCreator.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */