/*      */ package com.harmony.longterm.utils;
/*      */ 
/*      */ import java.io.OutputStream;
/*      */ import java.util.ArrayList;
/*      */ import java.util.HashMap;
/*      */ import java.util.List;
/*      */ import javax.servlet.ServletOutputStream;
/*      */ import javax.servlet.http.HttpServletResponse;
/*      */ import org.apache.log4j.Logger;
/*      */ import org.apache.poi.hssf.usermodel.HSSFCell;
/*      */ import org.apache.poi.hssf.usermodel.HSSFCellStyle;
/*      */ import org.apache.poi.hssf.usermodel.HSSFDataFormat;
/*      */ import org.apache.poi.hssf.usermodel.HSSFFont;
/*      */ import org.apache.poi.hssf.usermodel.HSSFRow;
/*      */ import org.apache.poi.hssf.usermodel.HSSFSheet;
/*      */ import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.apache.poi.ss.usermodel.CellType;
/*      */ import org.apache.poi.ss.util.CellRangeAddress;
/*      */ import org.jdom2.Content;
/*      */ import org.jdom2.Document;
/*      */ import org.jdom2.Element;
/*      */ 
/*      */ public class ExcelDown
/*      */ {
/*   47 */   private static Logger log = Logger.getLogger("ExcelDown");
/*      */ 
/*      */   public static void titleMerged(HSSFSheet sheet, String menuCode) throws Exception {}
/*      */   
/*      */   public static void downloadExcel(HttpServletResponse res, String[][] title, String menuCode, String sheetName, String fileName, Document document) throws Exception {
/*  198 */     HSSFWorkbook wb = new HSSFWorkbook();
/*  199 */     HSSFCellStyle style_data = wb.createCellStyle();
/*  200 */     HSSFCellStyle style_left_data = wb.createCellStyle();
/*  201 */     HSSFCellStyle style_top_title = wb.createCellStyle();
/*  202 */     HSSFCellStyle style_title = wb.createCellStyle();
/*  203 */     HSSFCellStyle style_number = wb.createCellStyle();

/*  206 */     HSSFRow row = null;
/*  207 */     HSSFCell cell = null;
/*  208 */     HSSFSheet sheet = wb.createSheet(sheetName);
/*  209 */     int rowStart = 0;
/*      */     
/*  211 */     HSSFCellStyle dateStyle = getDataStyle(wb, style_data);
/*  212 */     HSSFCellStyle dateleftStyle = getDataLeftStyle(wb, style_left_data);
/*      */     
/*  214 */     HSSFCellStyle topTitleStyle = getTopTitleStyle(wb, style_top_title);
/*  215 */     HSSFCellStyle titleStyle = getTitleStyle(wb, style_title);
/*  216 */     HSSFCellStyle numberStyle = getDataStyleNumber(wb, style_number);
/*  217 */     int cnt = 0;
/*  220 */     titleMerged(sheet, menuCode);
/*  223 */     for (int i = 0; i < title.length; i++) {
/*  224 */       if ((title[i]).length > 0) {
/*  225 */         row = sheet.createRow(i);
/*  226 */         rowStart++;
/*      */       } 
/*      */       
/*  229 */       for (int j = 0; j < (title[i]).length; j++) {
/*  230 */         cell = row.createCell(j);
/*  231 */         cell.setCellValue(title[i][j]);
/*      */         
/*  233 */         if ("010101".equals(menuCode) || 
/*  234 */           "020101".equals(menuCode) || 
/*  235 */           "020103".equals(menuCode)) {
/*  236 */           if (!"".equals(title[i][j])) {
/*  237 */             if ("계약내용 현황".equals(title[i][j]) || 
/*  238 */               "영업정보 현황".equals(title[i][j]) || 
/*  239 */               "출퇴근 집계표".equals(title[i][j])) {
/*  240 */               cell.setCellStyle(topTitleStyle);
/*      */             }
/*      */             else {
/*  245 */               cell.setCellStyle(titleStyle);
/*      */             } 
/*      */           }
/*      */         } else {
/*  249 */           cell.setCellStyle(titleStyle);
/*      */         } 
/*  299 */         sheet.autoSizeColumn(j);
/*  303 */         sheet.setColumnWidth(j, sheet.getColumnWidth(j) + 512);
/*  305 */         cnt = j;
/*      */       } 
/*      */     } 
/*  312 */     if ("020101".equals(menuCode) || "010101".equals(menuCode)) {
/*  313 */       xmlContractRowSpanExcel(res, fileName, wb, row, cell, sheet, rowStart, document, dateStyle, numberStyle, cnt, menuCode);
/*  314 */     } else if ("020102".equals(menuCode)) {
/*  315 */       xmlContractVatExcel(res, fileName, wb, row, cell, sheet, rowStart, document, dateStyle, numberStyle, cnt, menuCode);
/*      */     } else {
/*  317 */       xmlExcel(res, fileName, wb, row, cell, sheet, rowStart, document, dateStyle, cnt, menuCode);
/*      */     } 
/*      */   }
/*      */   
/*      */   private static Element addElement(Element parent, String name, String value) {
/*  322 */     Element element = new Element(name);
/*  323 */     element.setText(value);
/*  324 */     parent.addContent((Content)element);
/*      */     
/*  326 */     return parent;
/*      */   }
/*      */ 
/*      */   public static void downloadSampleExcel(HttpServletResponse res, String[][] title, String menuCode, String sheetName, String fileName, List<String[]> list) throws Exception {
/*  360 */     String root_node = "data";
/*  361 */     String child_node = "item";
/*      */     
/*  363 */     Element data = new Element(root_node);
/*  364 */     String[] nameAttr = null;
/*  365 */     for (int i = 0; i < list.size(); i++) {
/*  366 */       String[] z = list.get(i);
/*  367 */       if (i == 0) {
/*  368 */         nameAttr = list.get(i);
/*  369 */       } else if (i > 0) {
/*  370 */         Element element = new Element(child_node);
/*  371 */         for (int k = 0; k < z.length; k++) {
/*  372 */           String name = nameAttr[k];
/*  373 */           String value = z[k];
/*  374 */           addElement(element, name, value);
/*      */         } 
/*  376 */         data.addContent((Content)element);
/*      */       } 
/*      */     } 
/*  382 */     Document document = new Document(data);
/*  385 */     HSSFWorkbook wb = new HSSFWorkbook();
/*  386 */     HSSFCellStyle style1 = wb.createCellStyle();
/*  387 */     HSSFCellStyle style2 = wb.createCellStyle();
/*  388 */     HSSFCellStyle style3 = wb.createCellStyle();
/*  389 */     HSSFCellStyle style4 = wb.createCellStyle();
/*  390 */     HSSFCellStyle style5 = wb.createCellStyle();
/*  391 */     HSSFCellStyle style6 = wb.createCellStyle();
/*  392 */     HSSFRow row = null;
/*  393 */     HSSFCell cell = null;
/*  394 */     HSSFSheet sheet = wb.createSheet(sheetName);
/*  395 */     int rowStart = 0;
/*      */     
/*  397 */     HSSFCellStyle dateStyle = getDataStyle(wb, style1);
/*  398 */     HSSFCellStyle dateStyleCal = getDataStyleCal(wb, style2);
/*      */     
/*  400 */     int cnt = 0;
/*      */ 
/*      */     
/*  403 */     titleMerged(sheet, menuCode);
/*      */ 
/*      */     
/*  406 */     for (int j = 0; j < title.length; j++) {
/*  407 */       if ((title[j]).length > 0) {
/*  408 */         row = sheet.createRow(j);
/*  409 */         rowStart++;
/*      */       } 
/*      */       
/*  412 */       for (int k = 0; k < (title[j]).length; k++) {
/*  413 */         cell = row.createCell(k);
/*  414 */         cell.setCellValue(title[j][k].replace("desc", ""));
/*      */         
/*  416 */         if ("".equals(title[j][k]) || title[j][k].startsWith("desc")) {
/*  417 */           cell.setCellStyle(getTitleStyleDescription(wb, style6));
/*      */         } else {
/*  419 */           cell.setCellStyle(getTitleStyle(wb, style3));
/*      */         } 
/*  421 */         sheet.autoSizeColumn(k);
/*  422 */         if ("fixtures01".equals(menuCode)) {
/*  423 */           if (!"".equals(title[j][k]) && (
/*  424 */             "필수".equals(title[j][k]) || 
/*  425 */             "비품명".equals(title[j][k]))) {
/*  426 */             cell.setCellStyle(getTitleStyleRequired(wb, style5));
/*      */           }
/*      */         } else {
/*      */           
/*  430 */           sheet.setColumnWidth(k, sheet.getColumnWidth(k) + 512);
/*      */         } 
/*  432 */         cnt = k;
/*      */       } 
/*      */     } 
/*  439 */     xmlExcel(res, fileName, wb, row, cell, sheet, rowStart, document, dateStyle, cnt, menuCode);
/*      */   }
/*      */   
/*      */   public static void xmlExcel(HttpServletResponse res, String fileName, HSSFWorkbook wb, HSSFRow pRow, HSSFCell pCell, HSSFSheet sheet, int pVal, Document document, HSSFCellStyle dateStyle, int cnt, String menuCode) throws Exception {
/*  459 */     int i = pVal;
/*  460 */     HSSFRow row = pRow;
/*  461 */     HSSFCell cell = pCell;
/*      */     
/*  463 */     Element root = document.getRootElement();
/*  464 */     List<Element> elements = root.getChildren();
/*      */     

/*  466 */     for (Element element : elements) {
/*  467 */       if (element.getName().equals("item")) {
/*  468 */         int j = 0;
/*  469 */         row = sheet.createRow(i++);
/*  470 */         List<Element> items = element.getChildren();
/*      */         
/*  472 */         for (Element item : items) {
/*  473 */           cell = row.createCell(j++);
/*  474 */           cell.setCellType(1);
//cell.setCellType(null);
/*  475 */           cell.setCellValue(item.getText());
/*  476 */           cell.setCellStyle(dateStyle);
/*      */         } 
/*      */       } 
/*      */     } 
/*      */ 
/*      */     
/*  482 */     if ("fixtures01".equals(menuCode))
/*      */     {
/*  484 */       sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 5));
/*      */     }
/*  486 */     for (int k = 0; k < cnt; k++) {
/*      */       
/*  488 */       sheet.autoSizeColumn(k);
/*  489 */       sheet.setColumnWidth(k, sheet.getColumnWidth(k) + 1000);
/*      */     } 
/*  491 */     getExcelDownload(res, fileName, wb);
/*      */   }
/*      */   
/*      */   public static void xmlContractExcel(HttpServletResponse res, String fileName, HSSFWorkbook wb, HSSFRow pRow, HSSFCell pCell, HSSFSheet sheet, int pVal, Document document, HSSFCellStyle dateStyle, HSSFCellStyle nubmerStyle, int cnt, String menuCode) throws Exception {
/*  520 */     int i = pVal;
/*  521 */     HSSFRow row = pRow;
/*  522 */     HSSFCell cell = pCell;
/*      */     
/*  524 */     Element root = document.getRootElement();
/*  525 */     List<Element> elements = root.getChildren();
/*      */     
/*  527 */     for (Element element : elements) {
/*  528 */       if (element.getName().equals("item")) {
/*  529 */         int j = 0;
/*  530 */         row = sheet.createRow(i++);
/*  531 */         List<Element> items = element.getChildren();
/*      */         
/*  533 */         sheet.addMergedRegion(new CellRangeAddress(2, 3, 12, 12));
/*      */         
/*  535 */         for (Element item : items) {
/*  536 */           cell = row.createCell(j++);
/*      */           
/*  538 */           if (j == 9 || j == 10 || j == 18 || j == 20) {
/*  539 */             cell.setCellType(0);
/*  540 */             cell.setCellStyle(nubmerStyle);
/*  541 */             cell.setCellValue(item.getText());
/*  542 */             String txt = item.getText();
/*  543 */             if (Utils.isStringDouble(txt)) {
/*  544 */               double d = Double.parseDouble(txt);
/*  545 */               cell.setCellValue(d); continue;
/*      */             } 
/*  547 */             cell.setCellValue(txt);
/*      */             
/*      */             continue;
/*      */           } 
/*  551 */           cell.setCellType(1);
/*  552 */           cell.setCellStyle(dateStyle);
/*  553 */           cell.setCellValue(item.getText());
/*      */         } 
/*      */       } 
/*      */     } 
/*  563 */     for (int k = 0; k < cnt; k++) {
/*  564 */       sheet.autoSizeColumn(k);
/*  565 */       sheet.setColumnWidth(k, sheet.getColumnWidth(k) + 1000);
/*      */     } 
/*  567 */     getExcelDownload(res, fileName, wb);
/*      */   }
/*      */ 
/*      */   public static void xmlContractRowSpanExcel(HttpServletResponse res, String fileName, HSSFWorkbook wb, HSSFRow pRow, HSSFCell pCell, HSSFSheet sheet, int pVal, Document document, HSSFCellStyle dateStyle, HSSFCellStyle nubmerStyle, int cnt, String menuCode) throws Exception {
/*  574 */     int i = pVal;
/*  575 */     HSSFRow row = pRow;
/*  576 */     HSSFCell cell = pCell;
/*      */     
/*  578 */     Element root = document.getRootElement();
/*  579 */     List<Element> elements = root.getChildren();
/*      */     
/*  581 */     int rownum = 3;
/*  582 */     for (Element element : elements) {
/*  583 */       if (element.getName().equals("item")) {
/*  584 */         int j = -1;
/*  585 */         row = sheet.createRow(i++);
/*  586 */         List<Element> items = element.getChildren();
/*      */ 
/*      */         
/*  589 */         for (Element item : items) {
/*  590 */           if (j == -1 && (i == 4 || i - 1 == rownum)) {
/*      */             
/*  592 */             int lastRow = rownum + Integer.parseInt(item.getText()) - 1;
/*  595 */             sheet.addMergedRegion(new CellRangeAddress(rownum, (short)lastRow, 12, 12));
/*  597 */             sheet.addMergedRegion(new CellRangeAddress(rownum, (short)lastRow, 13, 13));
/*  599 */             sheet.addMergedRegion(new CellRangeAddress(rownum, (short)lastRow, 14, 14));
/*  601 */             sheet.addMergedRegion(new CellRangeAddress(rownum, (short)lastRow, 15, 15));
/*  603 */             sheet.addMergedRegion(new CellRangeAddress(rownum, (short)lastRow, 16, 16));
/*  605 */             sheet.addMergedRegion(new CellRangeAddress(rownum, (short)lastRow, 17, 17));
/*  607 */             sheet.addMergedRegion(new CellRangeAddress(rownum, (short)lastRow, 18, 18));
/*  609 */             sheet.addMergedRegion(new CellRangeAddress(rownum, (short)lastRow, 19, 19));
/*  612 */             sheet.addMergedRegion(new CellRangeAddress(rownum, (short)lastRow, 20, 20));
/*  615 */             sheet.addMergedRegion(new CellRangeAddress(rownum, (short)lastRow, 21, 21));
/*  618 */             sheet.addMergedRegion(new CellRangeAddress(rownum, (short)lastRow, 22, 22));
/*  620 */             rownum += Integer.parseInt(item.getText());
/*      */             
/*  622 */             j++; continue;
/*      */           } 
/*  624 */           if (j == -1) {
/*  625 */             j++; continue;
/*      */           } 
/*  627 */           cell = row.createCell(j++);
/*      */           
/*  629 */           if (j == 9 || j == 10 || j == 18 || j == 20) {
/*  630 */             cell.setCellType(0);
/*  631 */             cell.setCellStyle(nubmerStyle);
/*  632 */             cell.setCellValue(item.getText());
/*  633 */             String txt = item.getText();
/*  634 */             if (Utils.isStringDouble(txt)) {
/*  635 */               double d = Double.parseDouble(txt);
/*  636 */               cell.setCellValue(d); continue;
/*      */             } 
/*  638 */             cell.setCellValue(txt);
/*      */             
/*      */             continue;
/*      */           } 
/*  642 */           cell.setCellType(1);
/*  643 */           cell.setCellStyle(dateStyle);
/*  644 */           cell.setCellValue(item.getText());
/*      */         } 
/*      */       } 
/*      */     } 
/*  655 */     for (int k = 0; k < cnt; k++) {
/*  656 */       sheet.autoSizeColumn(k);
/*  657 */       sheet.setColumnWidth(k, sheet.getColumnWidth(k) + 1000);
/*      */     } 
/*  659 */     getExcelDownload(res, fileName, wb);
/*      */   }
/*      */   
/*      */   public static void xmlContractVatExcel(HttpServletResponse res, String fileName, HSSFWorkbook wb, HSSFRow pRow, HSSFCell pCell, HSSFSheet sheet, int pVal, Document document, HSSFCellStyle dateStyle, HSSFCellStyle nubmerStyle, int cnt, String menuCode) throws Exception {
/*  666 */     int i = pVal;
/*  667 */     HSSFRow row = pRow;
/*  668 */     HSSFCell cell = pCell;
/*      */     
/*  670 */     Element root = document.getRootElement();
/*  671 */     List<Element> elements = root.getChildren();
/*      */     
/*  673 */     for (Element element : elements) {
/*  674 */       if (element.getName().equals("item")) {
/*  675 */         int j = 0;
/*  676 */         row = sheet.createRow(i++);
/*  677 */         List<Element> items = element.getChildren();
/*      */         
/*  679 */         for (Element item : items) {
/*  680 */           cell = row.createCell(j++);
/*      */           
/*  682 */           if (j == 4) {
/*  683 */             cell.setCellType(0);
/*  684 */             cell.setCellStyle(nubmerStyle);
/*  685 */             cell.setCellValue(item.getText());
/*  686 */             String txt = item.getText();
/*  687 */             if (Utils.isStringDouble(txt)) {
/*  688 */               double d = Double.parseDouble(txt);
/*  689 */               cell.setCellValue(d); continue;
/*      */             } 
/*  691 */             cell.setCellValue(txt);
/*      */             
/*      */             continue;
/*      */           } 
/*  695 */           cell.setCellType(1);
/*  696 */           cell.setCellStyle(dateStyle);
/*  697 */           cell.setCellValue(item.getText());
/*      */         } 
/*      */       } 
/*      */     } 
/*  707 */     for (int k = 0; k < cnt; k++) {
/*  708 */       sheet.autoSizeColumn(k);
/*  709 */       sheet.setColumnWidth(k, sheet.getColumnWidth(k) + 1000);
/*      */     } 
/*  711 */     getExcelDownload(res, fileName, wb);
/*      */   }
/*      */   
/*      */   public static void xmlCalExcel(HttpServletResponse res, String fileName, HSSFWorkbook wb, HSSFRow row, HSSFCell cell, HSSFSheet sheet, int i, Document document, HSSFCellStyle dateStyleCal) throws Exception {
/*  729 */     Element root = document.getRootElement();
/*  730 */     List<Element> elements = root.getChildren();
/*  733 */     for (Element element : elements) {
/*  734 */       if (element.getName().equals("item")) {
/*  735 */         int j = 0;
/*  736 */         row = sheet.createRow(i++);
/*  737 */         row.setHeight((short)1000);
/*  738 */         List<Element> items = element.getChildren();
/*      */         
/*  740 */         for (Element item : items) {
/*  741 */           cell = row.createCell(j++);
/*  742 */           cell.setCellType(1);
/*  743 */           cell.setCellValue(item.getText());
/*  744 */           cell.setCellStyle(dateStyleCal);
/*      */         } 
/*      */       } 
/*      */     } 
/*  750 */     getExcelDownload(res, fileName, wb);
/*      */   }
/*      */   
/*      */   public static void getExcelDownload(HttpServletResponse res, String fileName, HSSFWorkbook wb) throws Exception {
/*      */     ServletOutputStream servletOutputStream = null;
/*  761 */     res.reset();
/*  762 */     res.setContentType("application/octet-stream");
/*  763 */     res.setHeader("Content-Disposition", "attachment;filename=\"" + new String(fileName.getBytes("euc-kr"), "8859_1") + ".xls" + "\"");
/*  768 */     OutputStream out = null;
/*      */     try {
/*  770 */       servletOutputStream = res.getOutputStream();
/*  771 */       wb.write((OutputStream)servletOutputStream);
/*  772 */       servletOutputStream.flush();
/*  773 */     } catch (Exception ex) {
/*  774 */       log.error(ex.getMessage());
/*      */     } finally {
/*  776 */       servletOutputStream.close();
/*      */     } 
/*      */   }
/*      */   
/*      */   private static HSSFCellStyle getTopTitleStyle(HSSFWorkbook wb, HSSFCellStyle style) {
/*  793 */     HSSFFont font = wb.createFont();
/*  794 */     font.setFontHeightInPoints((short)15);
/*  795 */     font.setFontName("맑은 고딕");
/*  796 */     font.setBoldweight((short)700);
/*  797 */     font.setColor(wb.getCustomPalette().findSimilarColor((byte)-1, (byte)-1, (byte)-1).getIndex());
/*      */     
/*  800 */     style.setAlignment((short)2);
/*  801 */     style.setAlignment((short)1);
/*  802 */     style.setBorderBottom((short)1);
/*  803 */     style.setBottomBorderColor((short)8);
/*  804 */     style.setBorderLeft((short)1);
/*  805 */     style.setLeftBorderColor((short)8);
/*  806 */     style.setBorderRight((short)1);
/*  807 */     style.setRightBorderColor((short)8);
/*  808 */     style.setBorderTop((short)1);
/*  809 */     style.setTopBorderColor((short)8);
/*  810 */     style.setAlignment((short)2);
/*  811 */     style.setVerticalAlignment((short)1);
/*  812 */     style.setFont(font);
/*      */     
/*  814 */     style.setFillForegroundColor(wb.getCustomPalette().findSimilarColor((byte)0, -128, -128).getIndex());
/*  815 */     style.setFillPattern((short)1);
/*      */     
/*  817 */     return style;
/*      */   }
/*      */ 
/*      */   private static HSSFCellStyle getTitleStyle(HSSFWorkbook wb, HSSFCellStyle style) {
/*  826 */     HSSFFont font = wb.createFont();
/*  827 */     font.setFontHeightInPoints((short)9);
/*  828 */     font.setFontName("맑은 고딕");
/*  829 */     font.setBoldweight((short)700);
/*  830 */     font.setColor(wb.getCustomPalette().findSimilarColor((byte)-1, (byte)-1, (byte)-1).getIndex());
/*      */     
/*  833 */     style.setAlignment((short)2);
/*  834 */     style.setAlignment((short)1);
/*  835 */     style.setBorderBottom((short)1);
/*  836 */     style.setBottomBorderColor((short)8);
/*  837 */     style.setBorderLeft((short)1);
/*  838 */     style.setLeftBorderColor((short)8);
/*  839 */     style.setBorderRight((short)1);
/*  840 */     style.setRightBorderColor((short)8);
/*  841 */     style.setBorderTop((short)1);
/*  842 */     style.setTopBorderColor((short)8);
/*  843 */     style.setAlignment((short)2);
/*  844 */     style.setVerticalAlignment((short)1);
/*  845 */     style.setFont(font);
/*      */     
/*  847 */     style.setFillForegroundColor(wb.getCustomPalette().findSimilarColor((byte)0, -128, -128).getIndex());
/*  848 */     style.setFillPattern((short)1);
/*      */     
/*  850 */     return style;
/*      */   }
/*      */ 
/*      */   
/*      */   private static HSSFCellStyle getTitleStyleDescription(HSSFWorkbook wb, HSSFCellStyle style) {
/*  855 */     HSSFFont font = wb.createFont();
/*  856 */     font.setFontHeightInPoints((short)9);
/*  857 */     font.setFontName("맑은 고딕");
/*      */     
/*  860 */     style.setAlignment((short)1);
/*  861 */     style.setBorderBottom((short)1);
/*  862 */     style.setBottomBorderColor((short)8);
/*  863 */     style.setBorderLeft((short)1);
/*  864 */     style.setLeftBorderColor((short)8);
/*  865 */     style.setBorderRight((short)1);
/*  866 */     style.setRightBorderColor((short)8);
/*  867 */     style.setBorderTop((short)1);
/*  868 */     style.setTopBorderColor((short)8);
/*  869 */     style.setVerticalAlignment((short)1);
/*  870 */     style.setFont(font);
/*      */     
/*  872 */     style.setFillForegroundColor((short)9);
/*  873 */     style.setFillPattern((short)1);
/*      */     
/*  875 */     return style;
/*      */   }
/*      */ 
/*      */   private static HSSFCellStyle getTitleStyleEditOn(HSSFWorkbook wb, HSSFCellStyle style) {
/*  884 */     HSSFFont font = wb.createFont();
/*  885 */     font.setFontHeightInPoints((short)9);
/*  886 */     font.setFontName("맑은 고딕");
/*  887 */     font.setBoldweight((short)700);
/*  888 */     font.setColor(wb.getCustomPalette().findSimilarColor((byte)-100, (byte)101, (byte)0).getIndex());
/*      */ 
/*  891 */     style.setAlignment((short)2);
/*  892 */     style.setAlignment((short)1);
/*  893 */     style.setBorderBottom((short)1);
/*  894 */     style.setBottomBorderColor((short)8);
/*  895 */     style.setBorderLeft((short)1);
/*  896 */     style.setLeftBorderColor((short)8);
/*  897 */     style.setBorderRight((short)1);
/*  898 */     style.setRightBorderColor((short)8);
/*  899 */     style.setBorderTop((short)1);
/*  900 */     style.setTopBorderColor((short)8);
/*  901 */     style.setAlignment((short)2);
/*  902 */     style.setVerticalAlignment((short)1);
/*  903 */     style.setFont(font);
/*      */     
/*  905 */     style.setFillForegroundColor(wb.getCustomPalette().findSimilarColor((byte)-1, (byte)-21, (byte)-100).getIndex());
/*  906 */     style.setFillPattern((short)1);
/*      */     
/*  908 */     return style;
/*      */   }
/*      */   
/*      */   private static HSSFCellStyle getTitleStyleRequired(HSSFWorkbook wb, HSSFCellStyle style) {
/*  924 */     HSSFFont font = wb.createFont();
/*  925 */     font.setFontHeightInPoints((short)9);
/*  926 */     font.setFontName("맑은 고딕");
/*  927 */     font.setBoldweight((short)700);
/*  928 */     font.setColor(wb.getCustomPalette().findSimilarColor((byte)-100, (byte)101, (byte)0).getIndex());
/*      */ 
/*  931 */     style.setAlignment((short)2);
/*  932 */     style.setAlignment((short)1);
/*  933 */     style.setBorderBottom((short)1);
/*  934 */     style.setBottomBorderColor((short)8);
/*  935 */     style.setBorderLeft((short)1);
/*  936 */     style.setLeftBorderColor((short)8);
/*  937 */     style.setBorderRight((short)1);
/*  938 */     style.setRightBorderColor((short)8);
/*  939 */     style.setBorderTop((short)1);
/*  940 */     style.setTopBorderColor((short)8);
/*  941 */     style.setAlignment((short)2);
/*  942 */     style.setVerticalAlignment((short)1);
/*  943 */     style.setFont(font);
/*      */     
/*  945 */     style.setFillForegroundColor(wb.getCustomPalette().findSimilarColor((byte)-1, (byte)-21, (byte)-100).getIndex());
/*  946 */     style.setFillPattern((short)1);
/*      */     
/*  948 */     return style;
/*      */   }
/*      */ 
/*      */   private static HSSFCellStyle getTitleStyleEditOff(HSSFWorkbook wb, HSSFCellStyle style) {
/*  957 */     HSSFFont font = wb.createFont();
/*  958 */     font.setFontHeightInPoints((short)9);
/*  959 */     font.setFontName("맑은 고딕");
/*  960 */     font.setBoldweight((short)700);
/*  961 */     font.setColor(wb.getCustomPalette().findSimilarColor((byte)0, (byte)97, (byte)0).getIndex());
/*      */     
/*  964 */     style.setAlignment((short)2);
/*  965 */     style.setAlignment((short)1);
/*  966 */     style.setBorderBottom((short)1);
/*  967 */     style.setBottomBorderColor((short)8);
/*  968 */     style.setBorderLeft((short)1);
/*  969 */     style.setLeftBorderColor((short)8);
/*  970 */     style.setBorderRight((short)1);
/*  971 */     style.setRightBorderColor((short)8);
/*  972 */     style.setBorderTop((short)1);
/*  973 */     style.setTopBorderColor((short)8);
/*  974 */     style.setAlignment((short)2);
/*  975 */     style.setVerticalAlignment((short)1);
/*  976 */     style.setFont(font);
/*      */     
/*  978 */     style.setFillForegroundColor(wb.getCustomPalette().findSimilarColor((byte)-58, (byte)-17, (byte)-50).getIndex());
/*  979 */     style.setFillPattern((short)1);
/*      */     
/*  981 */     return style;
/*      */   }
/*      */ 
/*      */   private static HSSFCellStyle getDataStyle(HSSFWorkbook wb, HSSFCellStyle style) {
/*  992 */     HSSFFont font = wb.createFont();
/*  993 */     font.setFontHeightInPoints((short)9);
/*  994 */     font.setFontName("맑은 고딕");
/*      */     
/*  997 */     style.setAlignment((short)1);
/*  998 */     style.setBorderBottom((short)1);
/*  999 */     style.setBottomBorderColor((short)8);
/* 1000 */     style.setBorderLeft((short)1);
/* 1001 */     style.setLeftBorderColor((short)8);
/* 1002 */     style.setBorderRight((short)1);
/* 1003 */     style.setRightBorderColor((short)8);
/* 1004 */     style.setBorderTop((short)1);
/* 1005 */     style.setTopBorderColor((short)8);
/* 1006 */     style.setAlignment((short)2);
/* 1007 */     style.setVerticalAlignment((short)1);
/* 1008 */     style.setFont(font);
/*      */     
/* 1010 */     return style;
/*      */   }
/*      */   
/*      */   private static HSSFCellStyle getDataLeftStyle(HSSFWorkbook wb, HSSFCellStyle style) {
/* 1015 */     HSSFFont font = wb.createFont();
/* 1016 */     font.setFontHeightInPoints((short)9);
/* 1017 */     font.setFontName("맑은 고딕");
/*      */     
/* 1020 */     style.setAlignment((short)1);
/* 1021 */     style.setBorderBottom((short)1);
/* 1022 */     style.setBottomBorderColor((short)8);
/* 1023 */     style.setBorderLeft((short)1);
/* 1024 */     style.setLeftBorderColor((short)8);
/* 1025 */     style.setBorderRight((short)1);
/* 1026 */     style.setRightBorderColor((short)8);
/* 1027 */     style.setBorderTop((short)1);
/* 1028 */     style.setTopBorderColor((short)8);
/* 1029 */     style.setAlignment((short)1);
/* 1030 */     style.setVerticalAlignment((short)1);
/* 1031 */     style.setFont(font);
/*      */     
/* 1033 */     return style;
/*      */   }
/*      */ 
/*      */   private static HSSFCellStyle getDataStyleCal(HSSFWorkbook wb, HSSFCellStyle style) {
/* 1043 */     HSSFFont font = wb.createFont();
/* 1044 */     font.setFontHeightInPoints((short)9);
/* 1045 */     font.setFontName("맑은 고딕");
/*      */ 
/* 1048 */     style.setBorderBottom((short)1);
/* 1049 */     style.setBottomBorderColor((short)8);
/* 1050 */     style.setBorderLeft((short)1);
/* 1051 */     style.setLeftBorderColor((short)8);
/* 1052 */     style.setBorderRight((short)1);
/* 1053 */     style.setRightBorderColor((short)8);
/* 1054 */     style.setBorderTop((short)1);
/* 1055 */     style.setTopBorderColor((short)8);
/* 1056 */     style.setVerticalAlignment((short)0);
/* 1057 */     style.setAlignment((short)1);
/* 1058 */     style.setWrapText(true);
/* 1059 */     style.setFont(font);
/*      */     
/* 1061 */     return style;
/*      */   }
/*      */ 
/*      */   private static HSSFCellStyle getDataStyleNumber(HSSFWorkbook wb, HSSFCellStyle style) {
/* 1072 */     HSSFFont font = wb.createFont();
/* 1073 */     HSSFDataFormat format = wb.createDataFormat();
/* 1074 */     font.setFontHeightInPoints((short)9);
/* 1075 */     font.setFontName("맑은 고딕");
/*      */     
/* 1078 */     style.setBorderBottom((short)1);
/* 1079 */     style.setBottomBorderColor((short)8);
/* 1080 */     style.setBorderLeft((short)1);
/* 1081 */     style.setLeftBorderColor((short)8);
/* 1082 */     style.setBorderRight((short)1);
/* 1083 */     style.setRightBorderColor((short)8);
/* 1084 */     style.setBorderTop((short)1);
/* 1085 */     style.setTopBorderColor((short)8);
/* 1086 */     style.setAlignment((short)3);
/* 1087 */     style.setVerticalAlignment((short)1);
/* 1088 */     style.setWrapText(true);
/* 1089 */     style.setFont(font);
/* 1090 */     style.setDataFormat(format.getFormat("#,##0"));
/*      */     
/* 1092 */     return style;
/*      */   }
/*      */ 
/*      */   public static void titleExcel(HttpServletResponse res, String excelTitle, String fileName, HSSFWorkbook wb, HSSFRow row, HSSFCell cell, ArrayList<HashMap> ary) throws Exception {
/*      */     try {
/* 1141 */       HSSFSheet sheet = wb.createSheet(excelTitle);
/* 1145 */       for (int k = 0; k < ary.size(); k++) {
/*      */         
/* 1147 */         for (int j = 0; j < ((HashMap)ary.get(k)).size(); j++) {
/* 1148 */           cell = row.createCell(j);
/* 1149 */           cell.setCellValue((String)((HashMap)ary.get(k)).get(Integer.valueOf(j)));
/*      */         } 
/*      */       } 
/* 1152 */     } catch (Exception ex) {
/* 1153 */       log.error(ex.getMessage());
/*      */     } 
/*      */   }
/*      */   
/*      */   public static void dataExcel(HttpServletResponse res, String excelTitle, String fileName, HSSFWorkbook wb, HSSFRow row, HSSFCell cell, ArrayList<HashMap> ary) throws Exception {
/*      */     try {
/* 1166 */       HSSFSheet sheet = wb.createSheet(excelTitle);
/* 1171 */       for (int k = 0; k < ary.size(); k++) {
/*      */         
/* 1173 */         for (int j = 0; j < ((HashMap)ary.get(k)).size(); j++) {
/* 1174 */           cell = row.createCell(j);
/* 1175 */           cell.setCellValue((String)((HashMap)ary.get(k)).get(Integer.valueOf(j)));
/* 1176 */           sheet.autoSizeColumn(j);
/* 1177 */           sheet.setColumnWidth(j, sheet.getColumnWidth(j) + 512);
/*      */         } 
/*      */       } 
/*      */       
/* 1181 */       getExcelDownload(res, fileName, wb);
/* 1182 */     } catch (Exception ex) {
/* 1183 */       log.error(ex.getMessage());
/*      */     } 
/*      */   }
/*      */ 
/*      */   public static void downloadExcel(HttpServletResponse res, String excelTitle, String fileName, HSSFWorkbook wb, HSSFRow row, HSSFCell cell, ArrayList<HashMap> ary) throws Exception {
/*      */     try {
/* 1196 */       HSSFSheet sheet = wb.createSheet(excelTitle);
/* 1201 */       for (int k = 0; k < ary.size(); k++) {
/* 1203 */         row = sheet.createRow(k);
/* 1204 */         row.setHeightInPoints(20.0F);
/* 1205 */         sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 2));
/*      */         
/* 1207 */         for (int j = 0; j < ((HashMap)ary.get(k)).size(); j++) {
/* 1208 */           cell = row.createCell(j);
/* 1209 */           cell.setCellValue((String)((HashMap)ary.get(k)).get(Integer.valueOf(j)));
/*      */         } 
/*      */       } 
/*      */       
/* 1213 */       getExcelDownload(res, fileName, wb);
/* 1214 */     } catch (Exception ex) {
/* 1215 */       log.error(ex.getMessage());
/*      */     } 
/*      */   }
/*      */ 
/*      */   public static void main(String[] args) throws Exception {
/* 1222 */     String Location = "down.xls";
/* 1225 */     ExcelDown excelDown = new ExcelDown();
/* 1227 */     HttpServletResponse response = null;
/* 1229 */     String excelTitle = "제목1|제목2|제목3|제목4|제목5|";
/*      */   }
/*      */ }


/* Location:              D:\web\harmonybpm\WebContent\WEB-INF\classes\!\com\bizmteclib\bas\\util\ExcelDown.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */