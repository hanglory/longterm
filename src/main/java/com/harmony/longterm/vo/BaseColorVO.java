/*    */ package com.harmony.longterm.vo;
/*    */ 
/*    */ 
/*    */ public class BaseColorVO
/*    */ {
/*    */   private int idcolor;
/*    */   private String color_name;
/*    */   private String color_value;
/*    */   private String color_code;
/*    */   private String image;
/*    */   
/*    */   public BaseColorVO() {}
/*    */   
/*    */   public BaseColorVO(int idcolor, String color_name, String color_value, String color_code, String image) {
/* 15 */     this.idcolor = idcolor;
/* 16 */     this.color_name = color_name;
/* 17 */     this.color_value = color_value;
/* 18 */     this.color_code = color_code;
/* 19 */     this.image = image;
/*    */   }
/*    */   
/*    */   public int getIdcolor() {
/* 23 */     return this.idcolor;
/*    */   }
/*    */   
/*    */   public void setIdcolor(int idcolor) {
/* 27 */     this.idcolor = idcolor;
/*    */   }
/*    */   
/*    */   public String getColor_name() {
/* 31 */     return this.color_name;
/*    */   }
/*    */   
/*    */   public void setColor_name(String color_name) {
/* 35 */     this.color_name = color_name;
/*    */   }
/*    */   
/*    */   public String getColor_value() {
/* 39 */     return this.color_value;
/*    */   }
/*    */   
/*    */   public void setColor_value(String color_value) {
/* 43 */     this.color_value = color_value;
/*    */   }
/*    */   
/*    */   public String getColor_code() {
/* 47 */     return this.color_code;
/*    */   }
/*    */   
/*    */   public void setColor_code(String color_code) {
/* 51 */     this.color_code = color_code;
/*    */   }
/*    */   
/*    */   public String getImage() {
/* 55 */     return this.image;
/*    */   }
/*    */   
/*    */   public void setImage(String image) {
/* 59 */     this.image = image;
/*    */   }
/*    */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\vo\BaseColorVO.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */