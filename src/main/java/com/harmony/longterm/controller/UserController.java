/*     */ package com.harmony.longterm.controller;
/*     */ 
/*     */ import com.harmony.longterm.session.SessionConfig;
/*     */ import com.harmony.longterm.utils.SHA256Util;
/*     */ import com.harmony.longterm.vo.UserVO;
/*     */ import java.util.HashMap;
/*     */ import java.util.Map;
/*     */ import javax.servlet.http.HttpServletRequest;
/*     */ import javax.servlet.http.HttpSession;
/*     */ import org.mybatis.spring.SqlSessionTemplate;
/*     */ import org.slf4j.Logger;
/*     */ import org.slf4j.LoggerFactory;
/*     */ import org.springframework.beans.factory.annotation.Autowired;
/*     */ import org.springframework.stereotype.Controller;
/*     */ import org.springframework.ui.Model;
/*     */ import org.springframework.web.bind.annotation.PostMapping;
/*     */ import org.springframework.web.bind.annotation.RequestMapping;
/*     */ import org.springframework.web.bind.annotation.RequestMethod;
/*     */ import org.springframework.web.bind.annotation.RequestParam;
/*     */ import org.springframework.web.bind.annotation.ResponseBody;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ @Controller
/*     */ @RequestMapping({"/user"})
/*     */ public class UserController
/*     */ {
/*     */   @Autowired
/*     */   private SqlSessionTemplate sqlSession;
/*  31 */   private final String NS = "userdb.";
/*     */   
/*  33 */   static final Logger logger = LoggerFactory.getLogger(UserController.class);
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   @RequestMapping({"/login"})
/*     */   public String login(HttpServletRequest request) {
/*  43 */     HttpSession session = request.getSession();
/*  44 */     String id = null;
/*  45 */     if (session.getAttribute("userId") != null)
/*  46 */       id = session.getAttribute("userId").toString(); 
/*  47 */     if (id != null) {
/*  48 */       String str = SessionConfig.getSessionidCheck("userId", id);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*  57 */     return "/user/login";
/*     */   }
/*     */   
/*     */   @RequestMapping(value = {"regist"}, method = {RequestMethod.GET})
/*     */   public String registform() {
/*  62 */     return "/user/registform";
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   @RequestMapping(value = {"newuser"}, method = {RequestMethod.POST})
/*     */   public String newuser(HttpServletRequest request, Model mv) {
/*  72 */     HttpSession session = request.getSession();
/*  73 */     String destination = (String)session.getAttribute("destination");
/*     */     
/*  75 */     String pw = request.getParameter("password");
/*  76 */     String salt = SHA256Util.generateSalt();
/*  77 */     String username = request.getParameter("username");
/*  78 */     String nickname = request.getParameter("nickname");
/*  79 */     String calPassword = SHA256Util.getEncrypt(pw, salt);
/*  80 */     String company = request.getParameter("company");
/*  81 */     String phone = request.getParameter("phone");
/*  82 */     String manager = request.getParameter("manager");
/*  83 */     logger.info(String.format("%s %s ", new Object[] { username, nickname }));
/*  84 */     logger.info(String.format("%s %s %s", new Object[] { pw, salt, calPassword }));
/*     */     
/*  86 */     UserVO login = (UserVO)this.sqlSession.selectOne("userdb.user", nickname);
/*     */     
/*  88 */     if (login != null) {
/*  89 */       mv.addAttribute("Message", "ID");
/*  90 */       return "/user/registform";
/*     */     } 
/*     */     
/*  93 */     Map<String, String> param = new HashMap<>();
/*  94 */     param.put("name", username);
/*  95 */     param.put("nickname", nickname);
/*  96 */     param.put("password", calPassword);
/*  97 */     param.put("salt", salt);
/*  98 */     param.put("company", company);
/*  99 */     param.put("phone", phone);
/* 100 */     param.put("manager", manager);
/*     */     
/* 102 */     int result = this.sqlSession.insert("userdb.insertuser", param);
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 111 */     if (destination == null)
/* 112 */       destination = "/user/login"; 
/* 113 */     return "redirect:" + destination;
/*     */   }
/*     */   
/*     */   @PostMapping({"checknewuser"})
/*     */   @ResponseBody
/*     */   private Map<String, String> checkUser(HttpServletRequest request) {
/* 119 */     HashMap<String, String> map = new HashMap<>();
/* 120 */     String pw = request.getParameter("password");
/* 121 */     String salt = SHA256Util.generateSalt();
/* 122 */     String username = request.getParameter("username");
/* 123 */     String nickname = request.getParameter("nickname");
/* 124 */     String calPassword = SHA256Util.getEncrypt(pw, salt);
/*     */     
/* 126 */     if (username == null || username.length() == 0) {
/* 127 */       map.put("error", "이름을 입력하세요");
/*     */     }
/*     */     
/* 130 */     if (pw == null || pw.length() == 0) {
/* 131 */       map.put("error", "암호를 입력하세요");
/*     */     }
/* 133 */     logger.info(String.format("%s [%s] %d", new Object[] { username, nickname, Integer.valueOf(nickname.length()) }));
/* 134 */     logger.info(String.format("%s %s %s", new Object[] { pw, salt, calPassword }));
/*     */     
/* 136 */     if (nickname == null || nickname.length() == 0) {
/* 137 */       map.put("state", "fail");
/* 138 */       map.put("error", "ID를 입력하세요");
/* 139 */       return map;
/*     */     } 
/*     */     
/* 142 */     UserVO login = (UserVO)this.sqlSession.selectOne("userdb.user", nickname);
/*     */     
/* 144 */     if (login != null) {
/*     */       
/* 146 */       map.put("state", "fail");
/* 147 */       map.put("error", "이미 존재하는 ID 입니다.");
/*     */     }
/*     */     else {
/*     */       
/* 151 */       map.put("state", "ok");
/*     */     } 
/*     */     
/* 154 */     return map;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   @PostMapping({"/loginPost"})
/*     */   public String loginPost(@RequestParam("name") String id, @RequestParam("password") String pw, HttpServletRequest request, Model model) {
/* 162 */     HttpSession session = request.getSession();
/*     */     
/* 164 */     if (id.trim().length() == 0) {
/* 165 */       logger.debug("ID 입력 필요");
/* 166 */       return "/user/login";
/*     */     } 
/*     */     
/* 169 */     UserVO login = (UserVO)this.sqlSession.selectOne("userdb.user", id);
/*     */     
/* 171 */     if (login != null) {
/*     */       
/* 173 */       String calPassword = SHA256Util.getEncrypt(pw, login.getSalt());
/* 174 */       logger.debug(login.toString());
/* 175 */       logger.debug(login.getSalt());
/* 176 */       logger.debug(calPassword);
/*     */ 
/*     */       
/* 179 */       if (login.getPassword().equals(calPassword)) {
/* 180 */         if (!login.getState().equals("승인")) {
/* 181 */           session.setAttribute("userLevel", Integer.valueOf(-1));
/* 182 */           return "/user/login";
/*     */         }
/*     */       
/*     */       }
/*     */       else {
/*     */         
/* 188 */         session.setAttribute("userLevel", Integer.valueOf(0));
/* 189 */         return "/user/login";
/*     */       } 
/*     */     } else {
/*     */       
/* 193 */       logger.debug(String.format("NO USER FOUND [%s - %s]", new Object[] { id, pw }));
/* 194 */       return "/user/login";
/*     */     } 
/*     */ 
/*     */     
/* 198 */     String storedSession = SessionConfig.getSessionidCheck("userId", id);
/* 199 */     if (storedSession == session.toString()) {
/* 200 */       logger.info("SAME SESSION " + storedSession);
/*     */     }
/* 202 */     else if (storedSession.length() > 0) {
/* 203 */       logger.debug(Integer.toString(login.getLevel()));
/*     */       
/* 205 */       if (login.getLevel() <= 1) {
/* 206 */         SessionConfig.removeSessionForDoubleLogin(storedSession);
/* 207 */         logger.info("REMOVE SESSION " + storedSession.length());
/*     */       } 
/*     */     } 
/*     */ 
/*     */     
/* 212 */     session.setAttribute("userId", id);
/* 213 */     session.setAttribute("userLevel", Integer.valueOf(login.getLevel()));
/* 213 */     session.setAttribute("userPhone", login.getPhone());
/*     */     
/* 215 */     logger.debug(Integer.toString(login.getTimeout()));
/*     */     
/* 217 */     int timeout = login.getTimeout();
/*     */     
/* 219 */     session.setMaxInactiveInterval(timeout);
/* 220 */     String destination = (String)session.getAttribute("destination");
/*     */     
/* 222 */     if (destination == null) {
/* 223 */       destination = "/user/login";
/*     */     }
/*     */     
//			destination = "/member/main";
				destination = "/";
/* 227 */     return "redirect:" + destination;
/*     */   }
/*     */   
/*     */   @RequestMapping({"/logout"})
/*     */   public String logout(HttpServletRequest request, String path) {
/* 232 */     request.getSession().invalidate();
/* 233 */     SessionConfig.removeSessionForDoubleLogin(request.getSession().toString());
/* 234 */     saveDestination(request);
/* 235 */     return "redirect:/member";
/*     */   }
/*     */   
/*     */   @RequestMapping({"/searchid"})
/*     */   public String searchId() {
/* 240 */     return "/user/searchid";
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   @RequestMapping({"/setpassword"})
/*     */   public String setPassword() {
/* 247 */     return "/user/setpassword";
/*     */   }
/*     */ 
/*     */   
/*     */   @PostMapping({"/setnewpassword"})
/*     */   @ResponseBody
/*     */   public HashMap<String, String> setNewPassword(HttpServletRequest request) {
/* 254 */     String nickname = request.getParameter("nickname");
/* 255 */     String password = request.getParameter("password");
/* 256 */     HashMap<String, String> map = new HashMap<>();
/*     */     
/* 258 */     System.out.println(nickname);
/*     */     
/* 260 */     UserVO login = (UserVO)this.sqlSession.selectOne("userdb.user", nickname);
/* 261 */     if (login == null) {
/* 262 */       map.put("state", "fail");
/* 263 */       return map;
/*     */     } 
/* 265 */     System.out.println(login.toString());
/*     */     
/* 267 */     if (login.getPassword().length() == 0) {
/* 268 */       String calPassword = SHA256Util.getEncrypt(password, login.getSalt());
/* 269 */       System.out.println(calPassword);
/* 270 */       HashMap<String, String> queryMap = new HashMap<>();
/* 271 */       queryMap.put("nickname", nickname);
/* 272 */       queryMap.put("password", calPassword);
/* 273 */       this.sqlSession.update("userdb.updatepassword", queryMap);
/*     */ 
/*     */       
/* 276 */       request.getSession().invalidate();
/* 277 */       map.put("state", "ok");
/*     */     } else {
/*     */       
/* 280 */       map.put("state", "fail");
/*     */     } 
/*     */     
/* 283 */     return map;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private void saveDestination(HttpServletRequest request) {
/* 289 */     String referer = request.getHeader("referer");
/*     */     
/* 291 */     if (referer != null) {
/*     */       
/* 293 */       String[] relativePath = referer.split(request.getContextPath());
/*     */       
/* 295 */       request.getSession().setAttribute("destination", relativePath[1]);
/*     */     } 
/*     */   }
/*     */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\controller\UserController.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */