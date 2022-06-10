/*     */ package com.harmony.longterm.dao;
/*     */ 
/*     */ import com.harmony.longterm.vo.CarVO;
/*     */ import com.harmony.longterm.vo.ColorVO;
/*     */ import com.harmony.longterm.vo.EstimateVO;
/*     */ import com.harmony.longterm.vo.OptionVO;
/*     */ import java.text.SimpleDateFormat;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Calendar;
/*     */ import java.util.Date;
/*     */ import java.util.HashMap;
/*     */ import java.util.List;
/*     */ import java.util.stream.Stream;
/*     */ import org.mybatis.spring.SqlSessionTemplate;
/*     */ import org.slf4j.Logger;
/*     */ import org.slf4j.LoggerFactory;
/*     */ import org.springframework.beans.factory.annotation.Autowired;
/*     */ import org.springframework.stereotype.Controller;
/*     */ import org.springframework.ui.Model;
/*     */ import org.springframework.web.bind.annotation.PostMapping;
/*     */ import org.springframework.web.bind.annotation.RequestBody;
/*     */ import org.springframework.web.bind.annotation.RequestMapping;
/*     */ import org.springframework.web.bind.annotation.RequestMethod;
/*     */ import org.springframework.web.bind.annotation.RequestParam;
/*     */ import org.springframework.web.bind.annotation.ResponseBody;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ @Controller
/*     */ @RequestMapping({"/esti"})
/*     */ public class Estimate
/*     */ {
/*  34 */   private static final Logger logger = LoggerFactory.getLogger(Estimate.class);
/*     */   
/*  36 */   private final String NS = "estimate.";
/*     */ 
/*     */   
/*     */   @Autowired
/*     */   private SqlSessionTemplate sqlSession;
/*     */ 
/*     */   
/*     */   @PostMapping({"/save"})
/*     */   @ResponseBody
/*     */   public HashMap<String, String> save(@RequestBody HashMap<String, Object> map) {
/*  46 */     HashMap<String, String> returnMap = new HashMap<>();
/*  47 */     returnMap.put("estimate_no", "???");
/*     */     
/*  49 */     SimpleDateFormat sdFormat = new SimpleDateFormat("yyMMdd0000");
/*  50 */     Calendar cal = Calendar.getInstance();
/*  51 */     cal.setTime(new Date());
/*  52 */     String start = sdFormat.format(cal.getTime());
/*  53 */     cal.add(5, 1);
/*  54 */     String end = sdFormat.format(cal.getTime());
/*     */     
/*  56 */     HashMap<String, String> queryMap = new HashMap<>();
/*  57 */     queryMap.put("start", start);
/*  58 */     queryMap.put("end", end);
/*  59 */     Long endValue = (Long)this.sqlSession.selectOne("estimate.estimate_no", queryMap);
/*     */     
/*  61 */     if (endValue == null) {
/*  62 */       endValue = Long.valueOf(Long.parseLong(start));
/*     */     }
/*     */     
/*  83 */     map.put("estimate_no", Long.toString(endValue.longValue() + 1));
/*     */     
/*  85 */     if (this.sqlSession.insert("estimate.insertestimate", map) == 0) {
/*  86 */       returnMap.put("estimate_type", "?");
/*  87 */       return returnMap;
/*     */     } 
/*     */     
/*  90 */     returnMap.put("estimate_no", Long.toString(endValue.longValue() + 1));
/*     */     
/*  97 */     returnMap.put("estimate_type", map.get("estimate_type").toString());
/*  98 */     return returnMap;
/*     */   }

/* 여러 견적서를 한번에 저장 하려면 이용. 하려고 했는데 map구조 변경을 우선 해야 함.
/*     */   @PostMapping({"/saveall"})
/*     */   @ResponseBody
/*     */   public HashMap<String, String> saveall(@RequestBody HashMap<String, Object> map) {
/*  46 */     HashMap<String, String> returnMap = new HashMap<>();
/*  47 */     returnMap.put("estimate_no", "???");
/*     */     
/*  49 */     SimpleDateFormat sdFormat = new SimpleDateFormat("yyMMdd0000");
/*  50 */     Calendar cal = Calendar.getInstance();
/*  51 */     cal.setTime(new Date());
/*  52 */     String start = sdFormat.format(cal.getTime());
/*  53 */     cal.add(5, 1);
/*  54 */     String end = sdFormat.format(cal.getTime());
/*     */     
/*  56 */     HashMap<String, String> queryMap = new HashMap<>();
/*  57 */     queryMap.put("start", start);
/*  58 */     queryMap.put("end", end);
/*  59 */     Long endValue = (Long)this.sqlSession.selectOne("estimate.estimate_no", queryMap);
/*     */     
/*  61 */     if (endValue == null) {
/*  62 */       endValue = Long.valueOf(Long.parseLong(start));
/*     */     }
/*     */     
/*  83 */     map.put("estimate_no", Long.toString(endValue.longValue()));

/*     */     int insSuccCnt = this.sqlSession.insert("estimate.insertestimateall", map);
/*  85 */     if ( insSuccCnt == 0) {
/*  86 */       returnMap.put("estimate_type", "?");
/*  87 */       return returnMap;
/*     */     }
			// 몇개가 입력된줄 모르니 그냥 최대값을 한번더 가져옴
/*  59 */     endValue = (Long)this.sqlSession.selectOne("estimate.estimate_no", queryMap);
/*     */     
/*  90 */     returnMap.put("estimate_no", Long.toString(endValue.longValue()));
/*     */     
/*  97 */     returnMap.put("estimate_type", map.get("estimate_type").toString());
/*  98 */     return returnMap;
/*     */   }
/*     */ 
/*     */   
/*     */   @RequestMapping({"/estimatelist"})
/*     */   @ResponseBody
/*     */   public List<EstimateVO> getEstimateList() {
/* 105 */     return this.sqlSession.selectList("estimate.list");
/*     */   }
/*     */ 
/*     */   
/*     */   @RequestMapping({"/detail"})
/*     */   public String detail(Model model, @RequestParam(value = "estimate_id", required = false, defaultValue = "0") int estimate_id) {
/* 111 */     List<OptionVO> selOptions = new ArrayList<>();
/* 112 */     EstimateVO estimate = (EstimateVO)this.sqlSession.selectOne("estimate.estimate_one", Integer.valueOf(estimate_id));
/* 113 */     CarVO car = (CarVO)this.sqlSession.selectOne("rent.car.trim", Integer.valueOf(estimate.getTrim_id()));
/* 114 */     ColorVO color = (ColorVO)this.sqlSession.selectOne("rent.car.color", Integer.valueOf(estimate.getColor_id()));
/*     */     
/* 116 */     logger.debug(String.valueOf(Integer.toString(estimate_id)) + " " + Integer.toString(estimate.getColor_id()));
/*     */     
/* 118 */     if (estimate != null) {
/* 119 */       String optionStr = estimate.getOptions().trim();
/*     */       
/* 121 */       if (optionStr != null && optionStr.length() != 0) {
/* 122 */         int[] opIds = Stream.<String>of(optionStr.split(" ")).mapToInt(Integer::parseInt).toArray();
/*     */ 
/*     */         
/* 125 */         List<OptionVO> options = this.sqlSession.selectList("rent.car.optionlist", Integer.valueOf(estimate.getTrim_id()));
/* 126 */         for (OptionVO option : options) {
/*     */ 
/*     */           
/* 129 */           if (findInt(opIds, option.getOption_id()) != -1) {
/* 130 */             selOptions.add(option);
/*     */           }
/*     */         } 
/*     */       } 
/*     */     }
/*     */     
/* 136 */     model.addAttribute("estimate", estimate);
/* 137 */     model.addAttribute("options", selOptions);
/* 138 */     model.addAttribute("car", car);
/* 139 */     model.addAttribute("color", color);
/*     */     
/* 141 */     return "/estimate/detail";
/*     */   }
/*     */ 


/*     */   
/*     */   @RequestMapping(value = {"/update"}, method = {RequestMethod.POST})
/*     */   @ResponseBody
/*     */   public HashMap<String, String> update(@RequestBody HashMap<String, String> param) {
/* 148 */     HashMap<String, String> returnMap = new HashMap<>();
/*     */     
/* 150 */     this.sqlSession.update("estimate.update", param);
/* 151 */     returnMap.put("state", "ok");
/* 152 */     return returnMap;
/*     */   }
/*     */   
/*     */   private int findInt(int[] array, int value) {
/* 156 */     for (int i = 0; i < array.length; i++) {
/* 157 */       if (array[i] == value) {
/* 158 */         return i;
/*     */       }
/*     */     } 
/* 161 */     return -1;
/*     */   }
/*     */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\dao\Estimate.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */