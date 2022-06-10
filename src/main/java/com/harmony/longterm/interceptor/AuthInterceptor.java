/*    */ package com.harmony.longterm.interceptor;
/*    */ 
/*    */ import javax.servlet.http.HttpServletRequest;
/*    */ import javax.servlet.http.HttpServletResponse;
/*    */ import javax.servlet.http.HttpSession;
/*    */ import org.slf4j.Logger;
/*    */ import org.slf4j.LoggerFactory;
/*    */ import org.springframework.web.servlet.ModelAndView;
/*    */ import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
/*    */ 
/*    */ public class AuthInterceptor
/*    */   extends HandlerInterceptorAdapter
/*    */ {
/* 14 */   private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
/*    */   
/*    */   private void saveDestination(HttpServletRequest request) {
/* 17 */     String uri = request.getRequestURI();
/* 18 */     String query = request.getQueryString();
/* 19 */     if (query == null || query.equals("null")) {
/* 20 */       query = "";
/*    */     } else {
/*    */       
/* 23 */       query = "?" + query;
/*    */     } 
/* 25 */     if (request.getMethod().equals("GET")) {
/* 26 */       request.getSession().setAttribute("destination", String.valueOf(uri) + query);
/* 27 */       request.getSession().setAttribute("destination", request.getServletPath());
/*    */     } 
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
/* 35 */     logger.debug("preHandle " + request.getRequestURI());
/*    */     
/* 37 */     HttpSession session = request.getSession();
/* 38 */     if (session.getAttribute("userLevel") == null || Integer.parseInt(session.getAttribute("userLevel").toString()) <= 0) {
/* 39 */       saveDestination(request);
/* 40 */       response.sendRedirect(String.valueOf(request.getContextPath()) + "/user/login");
/* 41 */       return false;
/*    */     } 
/*    */     
/* 44 */     if (request.getRequestURI().indexOf("admin") > 0 && 
/* 45 */       Integer.parseInt(session.getAttribute("userLevel").toString()) == 1) {
/*    */       
/* 47 */       response.sendRedirect(String.valueOf(request.getContextPath()) + "/common/auth-fail");
/* 48 */       return false;
/*    */     } 
/*    */ 
/*    */     
/* 52 */     return true;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
/* 58 */     logger.debug("postHandle");
/*    */   }
/*    */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\interceptor\AuthInterceptor.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */