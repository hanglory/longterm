/*     */ package com.harmony.longterm.vo;

/*     */ public class CarVO
/*     */ {
/*     */   private int model_id;
/*     */   private String maker;
/*     */   private String model_name;
/*     */   private String lineup;
/*     */   private String image;
/*     */   private int model_ranking;
/*     */   private int trim_id;
/*     */   private String trim_name;
/*     */   private int price;
			private int elec_sub;
/*     */   private String fuel;
/*     */   private int displacement;
/*     */   private String car_type;
/*     */   private float janga24;
/*     */   private float janga36;
/*     */   private float janga48;
/*     */   private String tax_type;
/*     */   private float tax_rate;
/*     */   private int tagsong;
/*     */   private float fees_rate;
/*     */   private float maker_rate;
/*     */   private float cal_rate;
/*     */   private float cal_rate_10_24;
/*     */   private float cal_rate_10_36;
/*     */   private float cal_rate_10_48;
/*     */   private float cal_rate_50_24;
/*     */   private float cal_rate_50_36;
/*     */   private float cal_rate_50_48;
/*     */   private int maintain_fee;
/*     */   private float maintain_fee_10_24;
/*     */   private float maintain_fee_10_36;
/*     */   private float maintain_fee_10_48;
/*     */   private float maintain_fee_50_24;
/*     */   private float maintain_fee_50_36;
/*     */   private float maintain_fee_50_48;
/*     */   
/*     */   public CarVO() {}
/*     */   
/*     */   public CarVO(int model_id, String maker, String model_name, String lineup, String image, int model_ranking, int trim_id, String trim_name, int price, int elec_sub, String fuel, int displacement, String car_type, float janga24, float janga36, float janga48, String tax_type, float tax_rate, int tagsong, float fees_rate, float maker_rate, float cal_rate, float cal_rate_10_24, float cal_rate_10_36, float cal_rate_10_48, float cal_rate_50_24, float cal_rate_50_36, float cal_rate_50_48, int maintain_fee, float maintain_fee_10_24, float maintain_fee_10_36, float maintain_fee_10_48, float maintain_fee_50_24, float maintain_fee_50_36, float maintain_fee_50_48) {
/*  52 */     this.model_id = model_id;
/*  53 */     this.maker = maker;
/*  54 */     this.model_name = model_name;
/*  55 */     this.lineup = lineup;
/*  56 */     this.image = image;
/*  57 */     this.model_ranking = model_ranking;
/*  58 */     this.trim_id = trim_id;
/*  59 */     this.trim_name = trim_name;
/*  60 */     this.price = price;
			  this.elec_sub = elec_sub;
/*  61 */     this.fuel = fuel;
/*  62 */     this.displacement = displacement;
/*  63 */     this.car_type = car_type;
/*  64 */     this.janga24 = janga24;
/*  65 */     this.janga36 = janga36;
/*  66 */     this.janga48 = janga48;
/*  67 */     this.tax_type = tax_type;
/*  68 */     this.tax_rate = tax_rate;
/*  69 */     this.tagsong = tagsong;
/*  70 */     this.fees_rate = fees_rate;
/*  71 */     this.maker_rate = maker_rate;
/*  72 */     this.cal_rate = cal_rate;
/*  73 */     this.cal_rate_10_24 = cal_rate_10_24;
/*  74 */     this.cal_rate_10_36 = cal_rate_10_36;
/*  75 */     this.cal_rate_10_48 = cal_rate_10_48;
/*  76 */     this.cal_rate_50_24 = cal_rate_50_24;
/*  77 */     this.cal_rate_50_36 = cal_rate_50_36;
/*  78 */     this.cal_rate_50_48 = cal_rate_50_48;
/*  79 */     this.maintain_fee = maintain_fee;
/*  80 */     this.maintain_fee_10_24 = maintain_fee_10_24;
/*  81 */     this.maintain_fee_10_36 = maintain_fee_10_36;
/*  82 */     this.maintain_fee_10_48 = maintain_fee_10_48;
/*  83 */     this.maintain_fee_50_24 = maintain_fee_50_24;
/*  84 */     this.maintain_fee_50_36 = maintain_fee_50_36;
/*  85 */     this.maintain_fee_50_48 = maintain_fee_50_48;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getModel_id() {
/*  90 */     return this.model_id;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setModel_id(int model_id) {
/*  95 */     this.model_id = model_id;
/*     */   }
/*     */ 
/*     */   
/*     */   public String getMaker() {
/* 100 */     return this.maker;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setMaker(String maker) {
/* 105 */     this.maker = maker;
/*     */   }
/*     */ 
/*     */   
/*     */   public String getModel_name() {
/* 110 */     return this.model_name;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setModel_name(String model_name) {
/* 115 */     this.model_name = model_name;
/*     */   }
/*     */ 
/*     */   
/*     */   public String getLineup() {
/* 120 */     return this.lineup;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setLineup(String lineup) {
/* 125 */     this.lineup = lineup;
/*     */   }
/*     */ 
/*     */   
/*     */   public String getImage() {
/* 130 */     return this.image;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setImage(String image) {
/* 135 */     this.image = image;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getModel_ranking() {
/* 140 */     return this.model_ranking;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setModel_ranking(int model_ranking) {
/* 145 */     this.model_ranking = model_ranking;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getTrim_id() {
/* 150 */     return this.trim_id;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setTrim_id(int trim_id) {
/* 155 */     this.trim_id = trim_id;
/*     */   }
/*     */ 
/*     */   
/*     */   public String getTrim_name() {
/* 160 */     return this.trim_name;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setTrim_name(String trim_name) {
/* 165 */     this.trim_name = trim_name;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getPrice() {
/* 170 */     return this.price;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setPrice(int price) {
/* 175 */     this.price = price;
/*     */   }
/*     */ 
/*     */   public int getElecSub() {
/* 170 */     return this.elec_sub;
/*     */   }
/*     */   public void setElecSub(int elec_sub) {
/* 175 */     this.elec_sub = elec_sub;
/*     */   }
/*     */   
/*     */   public String getFuel() {
/* 180 */     return this.fuel;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setFuel(String fuel) {
/* 185 */     this.fuel = fuel;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getDisplacement() {
/* 190 */     return this.displacement;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setDisplacement(int displacement) {
/* 195 */     this.displacement = displacement;
/*     */   }
/*     */ 
/*     */   
/*     */   public String getCar_type() {
/* 200 */     return this.car_type;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setCar_type(String car_type) {
/* 205 */     this.car_type = car_type;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getJanga24() {
/* 210 */     return this.janga24;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setJanga24(float janga24) {
/* 215 */     this.janga24 = janga24;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getJanga36() {
/* 220 */     return this.janga36;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setJanga36(float janga36) {
/* 225 */     this.janga36 = janga36;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getJanga48() {
/* 230 */     return this.janga48;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setJanga48(float janga48) {
/* 235 */     this.janga48 = janga48;
/*     */   }
/*     */ 
/*     */   
/*     */   public String getTax_type() {
/* 240 */     return this.tax_type;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setTax_type(String tax_type) {
/* 245 */     this.tax_type = tax_type;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getTax_rate() {
/* 250 */     return this.tax_rate;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setTax_rate(float tax_rate) {
/* 255 */     this.tax_rate = tax_rate;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getTagsong() {
/* 260 */     return this.tagsong;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setTagsong(int tagsong) {
/* 265 */     this.tagsong = tagsong;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getFees_rate() {
/* 270 */     return this.fees_rate;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setFees_rate(float fees_rate) {
/* 275 */     this.fees_rate = fees_rate;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getMaker_rate() {
/* 280 */     return this.maker_rate;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setMaker_rate(float maker_rate) {
/* 285 */     this.maker_rate = maker_rate;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getCal_rate() {
/* 290 */     return this.cal_rate;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setCal_rate(float cal_rate) {
/* 295 */     this.cal_rate = cal_rate;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getCal_rate_10_24() {
/* 300 */     return this.cal_rate_10_24;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setCal_rate_10_24(float cal_rate_10_24) {
/* 305 */     this.cal_rate_10_24 = cal_rate_10_24;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getCal_rate_10_36() {
/* 310 */     return this.cal_rate_10_36;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setCal_rate_10_36(float cal_rate_10_36) {
/* 315 */     this.cal_rate_10_36 = cal_rate_10_36;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getCal_rate_10_48() {
/* 320 */     return this.cal_rate_10_48;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setCal_rate_10_48(float cal_rate_10_48) {
/* 325 */     this.cal_rate_10_48 = cal_rate_10_48;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getCal_rate_50_24() {
/* 330 */     return this.cal_rate_50_24;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setCal_rate_50_24(float cal_rate_50_24) {
/* 335 */     this.cal_rate_50_24 = cal_rate_50_24;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getCal_rate_50_36() {
/* 340 */     return this.cal_rate_50_36;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setCal_rate_50_36(float cal_rate_50_36) {
/* 345 */     this.cal_rate_50_36 = cal_rate_50_36;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getCal_rate_50_48() {
/* 350 */     return this.cal_rate_50_48;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setCal_rate_50_48(float cal_rate_50_48) {
/* 355 */     this.cal_rate_50_48 = cal_rate_50_48;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getMaintain_fee() {
/* 360 */     return this.maintain_fee;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setMaintain_fee(int maintain_fee) {
/* 365 */     this.maintain_fee = maintain_fee;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getMaintain_fee_10_24() {
/* 370 */     return this.maintain_fee_10_24;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setMaintain_fee_10_24(float maintain_fee_10_24) {
/* 375 */     this.maintain_fee_10_24 = maintain_fee_10_24;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getMaintain_fee_10_36() {
/* 380 */     return this.maintain_fee_10_36;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setMaintain_fee_10_36(float maintain_fee_10_36) {
/* 385 */     this.maintain_fee_10_36 = maintain_fee_10_36;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getMaintain_fee_10_48() {
/* 390 */     return this.maintain_fee_10_48;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setMaintain_fee_10_48(float maintain_fee_10_48) {
/* 395 */     this.maintain_fee_10_48 = maintain_fee_10_48;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getMaintain_fee_50_24() {
/* 400 */     return this.maintain_fee_50_24;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setMaintain_fee_50_24(float maintain_fee_50_24) {
/* 405 */     this.maintain_fee_50_24 = maintain_fee_50_24;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getMaintain_fee_50_36() {
/* 410 */     return this.maintain_fee_50_36;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setMaintain_fee_50_36(float maintain_fee_50_36) {
/* 415 */     this.maintain_fee_50_36 = maintain_fee_50_36;
/*     */   }
/*     */ 
/*     */   
/*     */   public float getMaintain_fee_50_48() {
/* 420 */     return this.maintain_fee_50_48;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setMaintain_fee_50_48(float maintain_fee_50_48) {
/* 425 */     this.maintain_fee_50_48 = maintain_fee_50_48;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String toString() {
/* 431 */     return "CarVO [model_id=" + this.model_id + ", maker=" + this.maker + ", model_name=" + this.model_name + ", lineup=" + this.lineup + 
/* 432 */       ", image=" + this.image + ", model_ranking=" + this.model_ranking + ", trim_id=" + this.trim_id + ", trim_name=" + 
/* 433 */       this.trim_name + ", price=" + this.price + ", fuel=" + this.fuel + ", displacement=" + this.displacement + ", car_type=" + 
/* 434 */       this.car_type + ", janga24=" + this.janga24 + ", janga36=" + this.janga36 + ", janga48=" + this.janga48 + ", tax_type=" + 
/* 435 */       this.tax_type + ", tax_rate=" + this.tax_rate + ", tagsong=" + this.tagsong + ", fees_rate=" + this.fees_rate + 
/* 436 */       ", maker_rate=" + this.maker_rate + ", cal_rate=" + this.cal_rate + ", cal_rate_10_24=" + this.cal_rate_10_24 + 
/* 437 */       ", cal_rate_10_36=" + this.cal_rate_10_36 + ", cal_rate_10_48=" + this.cal_rate_10_48 + ", cal_rate_50_24=" + 
/* 438 */       this.cal_rate_50_24 + ", cal_rate_50_36=" + this.cal_rate_50_36 + ", cal_rate_50_48=" + this.cal_rate_50_48 + 
/* 439 */       ", maintain_fee=" + this.maintain_fee + ", maintain_fee_10_24=" + this.maintain_fee_10_24 + 
/* 440 */       ", maintain_fee_10_36=" + this.maintain_fee_10_36 + ", maintain_fee_10_48=" + this.maintain_fee_10_48 + 
/* 441 */       ", maintain_fee_50_24=" + this.maintain_fee_50_24 + ", maintain_fee_50_36=" + this.maintain_fee_50_36 + 
/* 442 */       ", maintain_fee_50_48=" + this.maintain_fee_50_48 + "]";
/*     */   }
/*     */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\vo\CarVO.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */