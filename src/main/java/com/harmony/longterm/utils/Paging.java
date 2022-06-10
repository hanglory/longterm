/*     */ package com.harmony.longterm.utils;
/*     */ 
/*     */ import org.apache.commons.lang.builder.ToStringBuilder;
/*     */ import org.apache.commons.lang.builder.ToStringStyle;
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
/*     */ public class Paging
/*     */ {
/*     */   private int pageSize;
/*     */   private int firstPageNo;
/*     */   private int prevPageNo;
/*     */   private int startPageNo;
/*     */   private int pageNo;
/*     */   private int endPageNo;
/*     */   private int nextPageNo;
/*     */   private int finalPageNo;
/*     */   private int totalCount;
/*     */   
/*     */   public int getPageSize() {
/*  28 */     return this.pageSize;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setPageSize(int pageSize) {
/*  35 */     this.pageSize = pageSize;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int getFirstPageNo() {
/*  42 */     return this.firstPageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFirstPageNo(int firstPageNo) {
/*  49 */     this.firstPageNo = firstPageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int getPrevPageNo() {
/*  56 */     return this.prevPageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setPrevPageNo(int prevPageNo) {
/*  63 */     this.prevPageNo = prevPageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int getStartPageNo() {
/*  70 */     return this.startPageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setStartPageNo(int startPageNo) {
/*  77 */     this.startPageNo = startPageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int getPageNo() {
/*  84 */     return this.pageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setPageNo(int pageNo) {
/*  91 */     this.pageNo = pageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int getEndPageNo() {
/*  98 */     return this.endPageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setEndPageNo(int endPageNo) {
/* 105 */     this.endPageNo = endPageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int getNextPageNo() {
/* 112 */     return this.nextPageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setNextPageNo(int nextPageNo) {
/* 119 */     this.nextPageNo = nextPageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int getFinalPageNo() {
/* 126 */     return this.finalPageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFinalPageNo(int finalPageNo) {
/* 133 */     this.finalPageNo = finalPageNo;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int getTotalCount() {
/* 140 */     return this.totalCount;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setTotalCount(int totalCount) {
/* 147 */     this.totalCount = totalCount;
/* 148 */     makePaging();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private void makePaging() {
/* 155 */     if (this.totalCount == 0)
/* 156 */       return;  if (this.pageNo == 0) setPageNo(1); 
/* 157 */     if (this.pageSize == 0) setPageSize(10);
/*     */     
/* 159 */     int finalPage = (this.totalCount + this.pageSize - 1) / this.pageSize;
/* 160 */     if (this.pageNo > finalPage) setPageNo(finalPage);
/*     */     
/* 162 */     if (this.pageNo < 0 || this.pageNo > finalPage) this.pageNo = 1;
/*     */     
/* 164 */     boolean isNowFirst = (this.pageNo == 1);
/* 165 */     boolean isNowFinal = (this.pageNo == finalPage);
/*     */     
/* 167 */     int startPage = (this.pageNo - 1) / 10 * 10 + 1;
/* 168 */     int endPage = startPage + 10 - 1;
/*     */     
/* 170 */     if (endPage > finalPage) {
/* 171 */       endPage = finalPage;
/*     */     }
/*     */     
/* 174 */     setFirstPageNo(1);
/*     */     
/* 176 */     if (isNowFirst) {
/* 177 */       setPrevPageNo(1);
/*     */     } else {
/* 179 */       setPrevPageNo((this.pageNo - 1 < 1) ? 1 : (this.pageNo - 1));
/*     */     } 
/*     */     
/* 182 */     setStartPageNo(startPage);
/* 183 */     setEndPageNo(endPage);
/*     */     
/* 185 */     if (isNowFinal) {
/* 186 */       setNextPageNo(finalPage);
/*     */     } else {
/* 188 */       setNextPageNo((this.pageNo + 1 > finalPage) ? finalPage : (this.pageNo + 1));
/*     */     } 
/*     */     
/* 191 */     setFinalPageNo(finalPage);
/*     */   }
/*     */ 
/*     */   
/*     */   public String toString() {
/* 196 */     return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
/*     */   }
/*     */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longter\\utils\Paging.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */