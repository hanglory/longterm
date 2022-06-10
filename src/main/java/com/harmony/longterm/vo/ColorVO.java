/*    */ package com.harmony.longterm.vo;
/*    */ 
/*    */ 
/*    */ public class ColorVO
/*    */ {
/*    */   private int idtrimcolor;
/*    */   private int model_id;
/*    */   private int color_id;
/*    */   private int price;
/*    */   private String color_name;
/*    */   private String color_value;
/*    */   
/*    */   public ColorVO() {}
/*    */   
/*    */   public ColorVO(int idtrimcolor, int model_id, int color_id, int price, String color_name, String color_value) {
/* 16 */     this.idtrimcolor = idtrimcolor;
/* 17 */     this.model_id = model_id;
/* 18 */     this.color_id = color_id;
/* 19 */     this.price = price;
/* 20 */     this.color_name = color_name;
/* 21 */     this.color_value = color_value;
/*    */   }
/*    */   
/*    */   public int getIdtrimcolor() {
/* 25 */     return this.idtrimcolor;
/*    */   }
/*    */   
/*    */   public void setIdtrimcolor(int idtrimcolor) {
/* 29 */     this.idtrimcolor = idtrimcolor;
/*    */   }
/*    */   
/*    */   public int getModel_id() {
/* 33 */     return this.model_id;
/*    */   }
/*    */   
/*    */   public void setModel_id(int model_id) {
/* 37 */     this.model_id = model_id;
/*    */   }
/*    */   
/*    */   public int getColor_id() {
/* 41 */     return this.color_id;
/*    */   }
/*    */   
/*    */   public void setColor_id(int color_id) {
/* 45 */     this.color_id = color_id;
/*    */   }
/*    */   
/*    */   public int getPrice() {
/* 49 */     return this.price;
/*    */   }
/*    */   
/*    */   public void setPrice(int price) {
/* 53 */     this.price = price;
/*    */   }
/*    */   
/*    */   public String getColor_name() {
/* 57 */     return this.color_name;
/*    */   }
/*    */   
/*    */   public void setColor_name(String color_name) {
/* 61 */     this.color_name = color_name;
/*    */   }
/*    */   
/*    */   public String getColor_value() {
/* 65 */     return this.color_value;
/*    */   }
/*    */   
/*    */   public void setColor_value(String color_value) {
/* 69 */     this.color_value = color_value;
/*    */   }
/*    */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\vo\ColorVO.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */