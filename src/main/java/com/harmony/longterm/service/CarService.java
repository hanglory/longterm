/*    */ package com.harmony.longterm.service;
/*    */ 
/*    */ import com.harmony.longterm.dao.CarDao;
import com.harmony.longterm.service.ICarService;
/*    */ import com.harmony.longterm.vo.CarVO;
/*    */ import java.util.HashMap;
/*    */ import java.util.List;
/*    */ import org.springframework.beans.factory.annotation.Autowired;
/*    */ import org.springframework.stereotype.Service;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ @Service
/*    */ public class CarService  implements ICarService
/*    */ {
/*    */   @Autowired
/*    */   private CarDao car;
/*    */   HashMap<String, Object> paramMap;
/*    */   
/*    */   public List<CarVO> readTrim(int id) {
/* 22 */     return this.car.selectTrims(Integer.valueOf(id));
/*    */   }
/*    */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\service\impl\CarService.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */