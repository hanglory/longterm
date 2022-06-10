/*     */ package com.harmony.longterm.vo;
/*     */ 
/*     */ import java.util.Date;
/*     */ 
/*     */ 
/*     */ 
/*     */ public class UserVO
/*     */ {
/*     */   private int id;
/*     */   private String name;
/*     */   private String password;
/*     */   private String nickname;
/*     */   private String phone;
/*     */   private String address;
/*     */   private String mail;
/*     */   private String salt;
/*     */   private int level;
/*     */   private String company;
/*     */   private String department;
/*     */   private String manager;
/*     */   private String state;
/*     */   private String regdate;
/*     */   private int timeout;
			private String resultCode;
/*     */   
/*     */   public UserVO() {}
/*     */   
/*     */   public int getTimeout() {
/*  28 */     return this.timeout;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setTimeout(int timeout) {
/*  33 */     this.timeout = timeout;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public UserVO(int id, String name, String password, String nickname, String phone, String address, String mail, String salt, int level, String company, String department, String manager, String state, String regdate, int timeout, String resultCode) {
/*  41 */     this.id = id;
/*  42 */     this.name = name;
/*  43 */     this.password = password;
/*  44 */     this.nickname = nickname;
/*  45 */     this.phone = phone;
/*  46 */     this.address = address;
/*  47 */     this.mail = mail;
/*  48 */     this.salt = salt;
/*  49 */     this.level = level;
/*  50 */     this.company = company;
/*  51 */     this.department = department;
/*  52 */     this.manager = manager;
/*  53 */     this.state = state;
/*  54 */     this.regdate = regdate;
/*  55 */     this.timeout = timeout;
			  this.resultCode = resultCode;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getId() {
/*  60 */     return this.id;
/*     */   }
/*     */   
/*     */   public void setId(int id) {
/*  64 */     this.id = id;
/*     */   }
/*     */   
/*     */   public String getName() {
/*  68 */     return this.name;
/*     */   }
/*     */   
/*     */   public void setName(String name) {
/*  72 */     this.name = name;
/*     */   }
/*     */   
/*     */   public String getPassword() {
/*  76 */     return this.password;
/*     */   }
/*     */   
/*     */   public void setPassword(String password) {
/*  80 */     this.password = password;
/*     */   }
/*     */   
/*     */   public String getNickname() {
/*  84 */     return this.nickname;
/*     */   }
/*     */   
/*     */   public void setNickname(String nickname) {
/*  88 */     this.nickname = nickname;
/*     */   }
/*     */   
/*     */   public String getPhone() {
/*  92 */     return this.phone;
/*     */   }
/*     */   
/*     */   public void setPhone(String phone) {
/*  96 */     this.phone = phone;
/*     */   }
/*     */   
/*     */   public String getAddress() {
/* 100 */     return this.address;
/*     */   }
/*     */   
/*     */   public void setAddress(String address) {
/* 104 */     this.address = address;
/*     */   }
/*     */   
/*     */   public String getMail() {
/* 108 */     return this.mail;
/*     */   }
/*     */   
/*     */   public void setMail(String mail) {
/* 112 */     this.mail = mail;
/*     */   }
/*     */   
/*     */   public String getSalt() {
/* 116 */     return this.salt;
/*     */   }
/*     */   public void setSalt(String salt) {
/* 120 */     this.salt = salt;
/*     */   }
/*     */   
/*     */   public int getLevel() {
/* 124 */     return this.level;
/*     */   }
/*     */   
/*     */   public void setLevel(int level) {
/* 128 */     this.level = level;
/*     */   }
/*     */   
/*     */   public String getCompany() {
/* 132 */     return this.company;
/*     */   }
/*     */   
/*     */   public void setCompany(String company) {
/* 136 */     this.company = company;
/*     */   }
/*     */   
/*     */   public String getDepartment() {
/* 140 */     return this.department;
/*     */   }
/*     */   
/*     */   public void setDepartment(String department) {
/* 144 */     this.department = department;
/*     */   }
/*     */   
/*     */   public String getManager() {
/* 148 */     return this.manager;
/*     */   }
/*     */   
/*     */   public void setManager(String manager) {
/* 152 */     this.manager = manager;
/*     */   }
/*     */   
/*     */   public String getState() {
/* 156 */     return this.state;
/*     */   }
/*     */   
/*     */   public void setState(String state) {
/* 160 */     this.state = state;
/*     */   }
/*     */   
/*     */   public String getRegdate() {
/* 164 */     return this.regdate;
/*     */   }
/*     */   
/*     */   public void setRegdate(String regdate) {
/* 168 */     this.regdate = regdate;
/*     */   }
/*     */   public String getResultCode() {
/* 116 */     return this.resultCode;
/*     */   }
/*     */   public void setResultCode(String resultCode) {
/* 168 */     this.resultCode = resultCode;
/*     */   }
/*     */   

/*     */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\vo\UserVO.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */