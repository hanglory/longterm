/*     */ package com.harmony.longterm.vo;
/*     */ 
/*     */ import java.util.Date;
/*     */ 
/*     */ 
/*     */ public class EstimateVO
/*     */ {
/*     */   private int id;
/*     */   private String type;
/*     */   private String estimate_no;
/*     */   private Date regdate;
/*     */   private int trim_id;
/*     */   private String user_id;
/*     */   private String user_company;
/*     */   private String user_name;
/*     */   private float deposit_ratio;
/*     */   private int deposit;
/*     */   private int period;
/*     */   private int distance;
/*     */   private int rentfee;
/*     */   private float agent_fee_rate;
/*     */   private int agent_fee;
/*     */   private int option_price;
/*     */   private String options;
/*     */   private int color_id;
/*     */   private String maker;
/*     */   private String name;
/*     */   private String lineup;
/*     */   private String trim;
/*     */   private int acquisition;
/*     */   private String tagsong;
/*     */   private String blackbox;
/*     */   private int etcprice;
/*     */   private String state;
/*     */   private String memo;
/*     */   private String customer;
/*     */   private String tel;
/*     */   private String email;
			private String user_manager;
			private String prepayment;
			private String trim_price;
/*     */   
/*     */   public EstimateVO() {}
/*     */   
/*     */   public EstimateVO(int id, String type, String estimate_no, Date regdate, int trim_id, String user_id, String user_company, String user_name, float deposit_ratio, int deposit, int period, int distance, int rentfee, float agent_fee_rate, int agent_fee, int option_price, String options, int color_id, String maker, String name, String lineup, String trim, int acquisition, String tagsong, String blackbox, int etcprice, String state, String memo, String customer, String tel, String email, String user_manager, String prepayment, String trim_price) {
/*  47 */     this.id = id;
/*  48 */     this.type = type;
/*  49 */     this.estimate_no = estimate_no;
/*  50 */     this.regdate = regdate;
/*  51 */     this.trim_id = trim_id;
/*  52 */     this.user_id = user_id;
/*  53 */     this.user_company = user_company;
/*  54 */     this.user_name = user_name;
/*  55 */     this.deposit_ratio = deposit_ratio;
/*  56 */     this.deposit = deposit;
/*  57 */     this.period = period;
/*  58 */     this.distance = distance;
/*  59 */     this.rentfee = rentfee;
/*  60 */     this.agent_fee_rate = agent_fee_rate;
/*  61 */     this.agent_fee = agent_fee;
/*  62 */     this.option_price = option_price;
/*  63 */     this.options = options;
/*  64 */     this.color_id = color_id;
/*  65 */     this.maker = maker;
/*  66 */     this.name = name;
/*  67 */     this.lineup = lineup;
/*  68 */     this.trim = trim;
/*  69 */     this.acquisition = acquisition;
/*  70 */     this.tagsong = tagsong;
/*  71 */     this.blackbox = blackbox;
/*  72 */     this.etcprice = etcprice;
/*  73 */     this.state = state;
/*  74 */     this.memo = memo;
/*  75 */     this.customer = customer;
/*  76 */     this.tel = tel;
/*  77 */     this.email = email;
			  this.user_manager = user_manager;
			  this.prepayment = prepayment;
			  this.trim_price = trim_price;
/*     */   }
/*     */   
/*     */   public int getId() {
/*  81 */     return this.id;
/*     */   }
/*     */   
/*     */   public void setId(int id) {
/*  85 */     this.id = id;
/*     */   }
/*     */   
/*     */   public String getType() {
/*  89 */     return this.type;
/*     */   }
/*     */   
/*     */   public void setType(String type) {
/*  93 */     this.type = type;
/*     */   }
/*     */   
/*     */   public String getEstimate_no() {
/*  97 */     return this.estimate_no;
/*     */   }
/*     */   
/*     */   public void setEstimate_no(String estimate_no) {
/* 101 */     this.estimate_no = estimate_no;
/*     */   }
/*     */   
/*     */   public Date getRegdate() {
/* 105 */     return this.regdate;
/*     */   }
/*     */   
/*     */   public void setRegdate(Date regdate) {
/* 109 */     this.regdate = regdate;
/*     */   }
/*     */   
/*     */   public int getTrim_id() {
/* 113 */     return this.trim_id;
/*     */   }
/*     */   
/*     */   public void setTrim_id(int trim_id) {
/* 117 */     this.trim_id = trim_id;
/*     */   }
/*     */   
/*     */   public String getUser_id() {
/* 121 */     return this.user_id;
/*     */   }
/*     */   
/*     */   public void setUser_id(String user_id) {
/* 125 */     this.user_id = user_id;
/*     */   }
/*     */   
/*     */   public String getUser_company() {
/* 129 */     return this.user_company;
/*     */   }
/*     */   
/*     */   public void setUser_company(String user_company) {
/* 133 */     this.user_company = user_company;
/*     */   }
/*     */   
/*     */   public String getUser_name() {
/* 137 */     return this.user_name;
/*     */   }
/*     */   
/*     */   public void setUser_name(String user_name) {
/* 141 */     this.user_name = user_name;
/*     */   }
/*     */   
/*     */   public float getDeposit_ratio() {
/* 145 */     return this.deposit_ratio;
/*     */   }
/*     */   
/*     */   public void setDeposit_ratio(float deposit_ratio) {
/* 149 */     this.deposit_ratio = deposit_ratio;
/*     */   }
/*     */   
/*     */   public int getDeposit() {
/* 153 */     return this.deposit;
/*     */   }
/*     */   
/*     */   public void setDeposit(int deposit) {
/* 157 */     this.deposit = deposit;
/*     */   }
/*     */   
/*     */   public int getPeriod() {
/* 161 */     return this.period;
/*     */   }
/*     */   
/*     */   public void setPeriod(int period) {
/* 165 */     this.period = period;
/*     */   }
/*     */   
/*     */   public int getDistance() {
/* 169 */     return this.distance;
/*     */   }
/*     */   
/*     */   public void setDistance(int distance) {
/* 173 */     this.distance = distance;
/*     */   }
/*     */   
/*     */   public int getRentfee() {
/* 177 */     return this.rentfee;
/*     */   }
/*     */   
/*     */   public void setRentfee(int rentfee) {
/* 181 */     this.rentfee = rentfee;
/*     */   }
/*     */   
/*     */   public float getAgent_fee_rate() {
/* 185 */     return this.agent_fee_rate;
/*     */   }
/*     */   
/*     */   public void setAgent_fee_rate(float agent_fee_rate) {
/* 189 */     this.agent_fee_rate = agent_fee_rate;
/*     */   }
/*     */   
/*     */   public int getAgent_fee() {
/* 193 */     return this.agent_fee;
/*     */   }
/*     */   
/*     */   public void setAgent_fee(int agent_fee) {
/* 197 */     this.agent_fee = agent_fee;
/*     */   }
/*     */   
/*     */   public int getOption_price() {
/* 201 */     return this.option_price;
/*     */   }
/*     */   
/*     */   public void setOption_price(int option_price) {
/* 205 */     this.option_price = option_price;
/*     */   }
/*     */   
/*     */   public String getOptions() {
/* 209 */     return this.options;
/*     */   }
/*     */   
/*     */   public void setOptions(String options) {
/* 213 */     this.options = options;
/*     */   }
/*     */   
/*     */   public int getColor_id() {
/* 217 */     return this.color_id;
/*     */   }
/*     */   
/*     */   public void setColor_id(int color_id) {
/* 221 */     this.color_id = color_id;
/*     */   }
/*     */   
/*     */   public String getMaker() {
/* 225 */     return this.maker;
/*     */   }
/*     */   
/*     */   public void setMaker(String maker) {
/* 229 */     this.maker = maker;
/*     */   }
/*     */   
/*     */   public String getName() {
/* 233 */     return this.name;
/*     */   }
/*     */   
/*     */   public void setName(String name) {
/* 237 */     this.name = name;
/*     */   }
/*     */   
/*     */   public String getLineup() {
/* 241 */     return this.lineup;
/*     */   }
/*     */   
/*     */   public void setLineup(String lineup) {
/* 245 */     this.lineup = lineup;
/*     */   }
/*     */   
/*     */   public String getTrim() {
/* 249 */     return this.trim;
/*     */   }
/*     */   
/*     */   public void setTrim(String trim) {
/* 253 */     this.trim = trim;
/*     */   }
/*     */   
/*     */   public int getAcquisition() {
/* 257 */     return this.acquisition;
/*     */   }
/*     */   
/*     */   public void setAcquisition(int acquisition) {
/* 261 */     this.acquisition = acquisition;
/*     */   }
/*     */   
/*     */   public String getTagsong() {
/* 265 */     return this.tagsong;
/*     */   }
/*     */   
/*     */   public void setTagsong(String tagsong) {
/* 269 */     this.tagsong = tagsong;
/*     */   }
/*     */   
/*     */   public String getBlackbox() {
/* 273 */     return this.blackbox;
/*     */   }
/*     */   
/*     */   public void setBlackbox(String blackbox) {
/* 277 */     this.blackbox = blackbox;
/*     */   }
/*     */   
/*     */   public int getEtcprice() {
/* 281 */     return this.etcprice;
/*     */   }
/*     */   
/*     */   public void setEtcprice(int etcprice) {
/* 285 */     this.etcprice = etcprice;
/*     */   }
/*     */   
/*     */   public String getState() {
/* 289 */     return this.state;
/*     */   }
/*     */   
/*     */   public void setState(String state) {
/* 293 */     this.state = state;
/*     */   }
/*     */   
/*     */   public String getMemo() {
/* 297 */     return this.memo;
/*     */   }
/*     */   
/*     */   public void setMemo(String memo) {
/* 301 */     this.memo = memo;
/*     */   }
/*     */   
/*     */   public String getCustomer() {
/* 305 */     return this.customer;
/*     */   }
/*     */   
/*     */   public void setCustomer(String customer) {
/* 309 */     this.customer = customer;
/*     */   }
/*     */   
/*     */   public String getTel() {
/* 313 */     return this.tel;
/*     */   }
/*     */   
/*     */   public void setTel(String tel) {
/* 317 */     this.tel = tel;
/*     */   }
/*     */   
/*     */   public String getEmail() {
/* 321 */     return this.email;
/*     */   }
/*     */   
/*     */   public void setEmail(String email) {
/* 325 */     this.email = email;
/*     */   }
/*     */ 
			public String getUser_manager() {
				return this.user_manager;
			}
			public String getPrepayment() {
				return this.prepayment;
			}
			public String setTrim_price() {
				return this.trim_price;
			}
			public void setUser_manager(String user_manager) {
				this.user_manager = user_manager;
			}
			public void setPrepayment(String prepayment) {
				this.prepayment = prepayment;
			}
			public void setTrim_price(String trim_price) {
				this.trim_price = trim_price;
			}
			
/*     */   
/*     */   public String toString() {
/* 330 */     return "EstimateVO [id=" + this.id + ", type=" + this.type + ", estimate_no=" + this.estimate_no + ", regdate=" + this.regdate + 
/* 331 */       ", trim_id=" + this.trim_id + ", user_id=" + this.user_id + ", user_company=" + this.user_company + ", user_name=" + 
/* 332 */       this.user_name + ", deposit_ratio=" + this.deposit_ratio + ", deposit=" + this.deposit + ", period=" + this.period + 
/* 333 */       ", distance=" + this.distance + ", rentfee=" + this.rentfee + ", agent_fee_rate=" + this.agent_fee_rate + 
/* 334 */       ", agent_fee=" + this.agent_fee + ", option_price=" + this.option_price + ", options=" + this.options + ", color_id=" + 
/* 335 */       this.color_id + ", maker=" + this.maker + ", name=" + this.name + ", lineup=" + this.lineup + ", trim=" + this.trim + 
/* 336 */       ", acquisition=" + this.acquisition + ", tagsong=" + this.tagsong + ", blackbox=" + this.blackbox + ", etcprice=" + 
/* 337 */       this.etcprice + ", state=" + this.state + ", memo=" + this.memo + ", customer=" + this.customer + ", tel=" + this.tel + 
/* 338 */       ", email=" + this.email + ", user_manager=" + this.user_manager + ", prepayment=" + this.prepayment + ", trim_price=" + this.trim_price + "]";
/*     */   }
/*     */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\vo\EstimateVO.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */