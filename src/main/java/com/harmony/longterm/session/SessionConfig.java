/*    */ package com.harmony.longterm.session;
/*    */ 
/*    */ import java.util.HashMap;
/*    */ import java.util.Map;
/*    */ import java.util.concurrent.ConcurrentHashMap;
/*    */ import javax.servlet.annotation.WebListener;
/*    */ import javax.servlet.http.HttpServletRequest;
/*    */ import javax.servlet.http.HttpSession;
/*    */ import javax.servlet.http.HttpSessionEvent;
/*    */ import javax.servlet.http.HttpSessionListener;
/*    */ import org.mybatis.spring.SqlSessionTemplate;
/*    */ import org.slf4j.Logger;
/*    */ import org.slf4j.LoggerFactory;
/*    */ import org.springframework.web.context.WebApplicationContext;
/*    */ import org.springframework.web.context.request.RequestContextHolder;
/*    */ import org.springframework.web.context.request.ServletRequestAttributes;
/*    */ import org.springframework.web.context.support.WebApplicationContextUtils;
/*    */ 
/*    */ 
/*    */ 
/*    */ @WebListener
/*    */ public class SessionConfig
/*    */   implements HttpSessionListener
/*    */ {
/* 25 */   private static final Logger logger = LoggerFactory.getLogger(SessionConfig.class);
/* 26 */   private static final Map<String, HttpSession> sessions = new ConcurrentHashMap<>();
/* 27 */   private final String NS = "visit.";
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public static synchronized String getSessionidCheck(String type, String compareId) {
/* 34 */     String result = "";
/* 35 */     for (String key : sessions.keySet()) {
/* 36 */       HttpSession hs = sessions.get(key);
/* 37 */       if (hs != null && hs.getAttribute(type) != null && hs.getAttribute(type).toString().equals(compareId)) {
/* 38 */         result = key.toString();
/*    */       }
/*    */     } 
/*    */     
/* 42 */     return result;
/*    */   }
/*    */ 
/*    */   
/*    */   public static void removeSessionForDoubleLogin(String userId) {
/* 47 */     if (userId != null && userId.length() > 0) {
/* 48 */       HttpSession session = sessions.get(userId);
/* 49 */       if (session != null) {
/* 50 */         ((HttpSession)sessions.get(userId)).invalidate();
/* 51 */         sessions.remove(userId);
/*    */       } 
/*    */     } 
/*    */   }
/*    */   
/*    */   public static int getSessionCount() {
/* 57 */     logger.info(Integer.toString(sessions.size()));
/* 58 */     return sessions.size();
/*    */   }
/*    */ 
/*    */   
/*    */   public void sessionCreated(HttpSessionEvent se) {
/* 63 */     sessions.put(se.getSession().getId(), se.getSession());
/* 64 */     logger.info("sessionCreated : " + sessions.size() + "개");
/*    */     
/* 66 */     HttpSession session = se.getSession();
/* 67 */     WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
/* 68 */     HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
/*    */ 
/*    */     
/* 71 */     HashMap<String, String> map = new HashMap<>();
/* 72 */     map.put("addr", request.getRemoteAddr());
/* 73 */     map.put("agent", request.getHeader("User-Agent"));
/* 74 */     map.put("referer", request.getHeader("referer"));
/*    */ 
/*    */ 
/*    */ 
/*    */     
/* 79 */     SqlSessionTemplate sqlSession = (SqlSessionTemplate)wac.getBean("sqlSession");
/* 80 */     int result = sqlSession.insert("visit.visit", map);
/* 81 */     if (result == 0) {
/* 82 */       logger.error("VISIT DB INSERT ERROR");
/*    */     }
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void sessionDestroyed(HttpSessionEvent se) {
/* 89 */     logger.info("sessionDestroyed : " + se.getSession().getAttribute("userId"));
/* 90 */     if (sessions.get(se.getSession().getId()) != null) {
/* 91 */       ((HttpSession)sessions.get(se.getSession().getId())).invalidate();
/* 92 */       sessions.remove(se.getSession().getId());
/*    */     } 
/*    */   }
/*    */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\session\SessionConfig.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */