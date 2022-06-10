/*    */ package com.harmony.longterm.controller;
/*    */ 
/*    */ import org.springframework.stereotype.Controller;
/*    */ import org.springframework.web.bind.annotation.RequestMapping;
/*    */ 
/*    */ 
/*    */ @Controller
/*    */ @RequestMapping({"/common"})
/*    */ public class CommonController
/*    */ {
/*    */   @RequestMapping({"/auth-fail"})
/*    */   public String AuthFail() {
/* 13 */     return "/common/auth-fail";
/*    */   }
/*    */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\controller\CommonController.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */