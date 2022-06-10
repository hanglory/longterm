/*    */ package com.harmony.longterm.vo;
/*    */ 
/*    */ 
/*    */ public class OptionVO
/*    */ {
/*    */   private int id;
/*    */   private String name;
/*    */   private int price;
/*    */   private int active;
/*    */   private int trim_id;
/*    */   private int ranking;
/*    */   private String exc;
/*    */   
/*    */   public OptionVO() {}
/*    */   
/*    */   public OptionVO(int option_id, String name, int price, int active, int trim_id, int ranking, String exc) {
/* 17 */     this.id = option_id;
/* 18 */     this.name = name;
/* 19 */     this.price = price;
/* 20 */     this.active = active;
/* 21 */     this.trim_id = trim_id;
/* 22 */     this.ranking = ranking;
/* 23 */     this.exc = exc;
/*    */   }
/*    */   
/*    */   public int getOption_id() {
/* 27 */     return this.id;
/*    */   }
/*    */   
/*    */   public void setOption_id(int option_id) {
/* 31 */     this.id = option_id;
/*    */   }
/*    */   
/*    */   public String getName() {
/* 35 */     return this.name;
/*    */   }
/*    */   
/*    */   public void setName(String name) {
/* 39 */     this.name = name;
/*    */   }
/*    */   
/*    */   public int getPrice() {
/* 43 */     return this.price;
/*    */   }
/*    */   
/*    */   public void setPrice(int price) {
/* 47 */     this.price = price;
/*    */   }
/*    */   
/*    */   public int getActive() {
/* 51 */     return this.active;
/*    */   }
/*    */   
/*    */   public void setActive(int active) {
/* 55 */     this.active = active;
/*    */   }
/*    */   
/*    */   public int getTrim_id() {
/* 59 */     return this.trim_id;
/*    */   }
/*    */   
/*    */   public void setTrim_id(int trim_id) {
/* 63 */     this.trim_id = trim_id;
/*    */   }
/*    */   
/*    */   public int getRanking() {
/* 67 */     return this.ranking;
/*    */   }
/*    */   
/*    */   public void setRanking(int ranking) {
/* 71 */     this.ranking = ranking;
/*    */   }
/*    */   
/*    */   public String getExc() {
/* 75 */     return this.exc;
/*    */   }
/*    */   
/*    */   public void setExc(String exc) {
/* 79 */     this.exc = exc;
/*    */   }
/*    */ 
/*    */   
/*    */   public String toString() {
/* 84 */     return "OptionVO [option_id=" + this.id + ", name=" + this.name + ", price=" + this.price + ", active=" + this.active + 
/* 85 */       ", trim_id=" + this.trim_id + ", ranking=" + this.ranking + ", exc=" + this.exc + "]";
/*    */   }
/*    */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\vo\OptionVO.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */