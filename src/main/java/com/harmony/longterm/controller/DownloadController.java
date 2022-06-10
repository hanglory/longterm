package com.harmony.longterm.controller;
import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.stream.Stream;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.harmony.longterm.vo.CarVO;
import com.harmony.longterm.vo.ColorVO;
import com.harmony.longterm.vo.EstimateVO;
import com.harmony.longterm.vo.OptionVO;
import com.harmony.longterm.utils.Utils;
/*    */ 
/*    */ 
/*    */ 
/*    */ @Controller
/*    */ @RequestMapping({"/download"})
/*    */ public class DownloadController
/*    */ {
	@Autowired
	private SqlSessionTemplate sqlSession;

/* 17 */   private static final Logger logger = LoggerFactory.getLogger(DownloadController.class);
/*    */   
/*    */   @RequestMapping({"/file"})
/*    */   public ModelAndView fileDownload(@RequestParam HashMap<Object, Object> params, ModelAndView mv) {
/* 21 */     String fileName = (String)params.get("fileName");
/*    */     
/* 23 */     mv.setViewName("downloadView");
/* 24 */     mv.addObject("downloadFile", fileName);
/*    */     
/* 26 */     return mv;
/*    */   }
/*    */   
/*    */   @RequestMapping({"/list"})
/*    */   public String list() {
/* 31 */     return "/test/filelist";
/*    */   }

/*     */   @RequestMapping({"/pdfEst"})
/*     */   public String pdfEst(Model model, @RequestParam(value = "id", required = false, defaultValue = "0") int estimate_id) {
/* 111 */     List<OptionVO> selOptions = new ArrayList<>();
/* 112 */     EstimateVO estimate = (EstimateVO)this.sqlSession.selectOne("estimate.estimate_one", Integer.valueOf(estimate_id));
			  List<EstimateVO> estimateList = this.sqlSession.selectList("estimate.estimate_one_group", Integer.valueOf(estimate_id));
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
/* 129 */           if (Utils.findInt(opIds, option.getOption_id()) != -1) {
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
			  model.addAttribute("estimateList", estimateList);
/*     */     
/* 141 */     return "admin.estimateDetail";
/*     */   }

/*    */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\controller\DownloadController.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */