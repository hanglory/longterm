/*     */ package com.harmony.longterm.controller;
import com.harmony.longterm.utils.DateUtil;
/*     */ 
/*     */ import com.harmony.longterm.utils.Paging;
import com.harmony.longterm.utils.Utils;
import com.harmony.longterm.vo.CarVO;
import com.harmony.longterm.vo.ColorVO;
/*     */ import com.harmony.longterm.vo.EstimateVO;
import com.harmony.longterm.vo.OptionVO;
/*     */ import com.harmony.longterm.vo.UserVO;
/*     */ import java.text.DateFormat;
/*     */ import java.text.ParseException;
/*     */ import java.text.SimpleDateFormat;
import java.util.ArrayList;
/*     */ import java.util.Calendar;
/*     */ import java.util.HashMap;
/*     */ import java.util.List;
import java.util.stream.Stream;

/*     */ import javax.servlet.http.HttpServletRequest;
/*     */ import javax.servlet.http.HttpSession;
/*     */ import org.mybatis.spring.SqlSessionTemplate;
/*     */ import org.slf4j.Logger;
/*     */ import org.slf4j.LoggerFactory;
/*     */ import org.springframework.beans.factory.annotation.Autowired;
/*     */ import org.springframework.mobile.device.Device;
/*     */ import org.springframework.mobile.device.DeviceUtils;
/*     */ import org.springframework.stereotype.Controller;
/*     */ import org.springframework.ui.Model;
/*     */ import org.springframework.web.bind.annotation.PathVariable;
/*     */ import org.springframework.web.bind.annotation.RequestMapping;
/*     */ import org.springframework.web.bind.annotation.RequestParam;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ @Controller
/*     */ @RequestMapping({"/member"})
/*     */ public class MemberController
/*     */ {
/*  33 */   private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
/*     */   @Autowired
/*     */   private SqlSessionTemplate sqlSession;
/*     */   
/*     */   @RequestMapping({"/", "/{url}"})
/*     */   public String main(HttpServletRequest request, @PathVariable(required = false) String url) {
/*  39 */     if (url == null) url = "main"; 
/*  40 */     String prefix = "member.";
/*     */ 
/*     */     
/*  43 */     Device device = DeviceUtils.getCurrentDevice(request);
/*  44 */     if (device.isMobile()) {
/*  45 */       prefix = "m-member.";
/*  46 */     } else if (device.isTablet()) {
/*  47 */       prefix = "m-member.";
/*     */     } 
/*     */     
/*  50 */     logger.debug(String.valueOf(prefix) + url);
/*  51 */     return String.valueOf(prefix) + url;
/*     */   }
/*     */   
/*     */   @RequestMapping({"/information"})
/*     */   public String information() {
/*  56 */     return "information";
/*     */   }
/*     */   
/*     */   @RequestMapping({"/{member}/estimate"})
/*     */   public String estimate(HttpServletRequest request, @RequestParam HashMap<String, String> map, Model model) {
/*  61 */     logger.debug(map.toString());
/*     */     
/*  63 */     model.addAllAttributes(map);
/*     */     
/*  65 */     HttpSession session = request.getSession();
/*  66 */     if (session.getAttribute("userId") != null) {
/*  67 */       UserVO user = (UserVO)this.sqlSession.selectOne("userdb.user", session.getAttribute("userId"));
/*  68 */       model.addAttribute("phone", user.getPhone());
/*     */     } 
/*  72 */     return "member.estimate";
/*     */   }
/*     */ 
/*     */   @RequestMapping({"/{member}/estimate_tot"})
/*     */   public String estimate_tot(HttpServletRequest request, @RequestParam HashMap<String, String> map, Model model) {
/*  61 */     logger.debug(map.toString());
/*     */     
/*  63 */     model.addAllAttributes(map);
/*     */     
/*  65 */     HttpSession session = request.getSession();
/*  66 */     if (session.getAttribute("userId") != null) {
/*  67 */       UserVO user = (UserVO)this.sqlSession.selectOne("userdb.user", session.getAttribute("userId"));
/*  68 */       model.addAttribute("phone", user.getPhone());
/*     */     } 
/*  72 */     return "member.estimate_tot";
/*     */   }

/*     */   
/*     */   @RequestMapping({"/{member}/estimatelist"})
/*     */   public String estimatelist(HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") Integer page, @RequestParam(value = "estimate_no", defaultValue = "") String estimate_no, @RequestParam(value = "type1", defaultValue = "") String type1, @RequestParam(value = "search1", defaultValue = "") String search1, @RequestParam(value = "type2", defaultValue = "") String type2, @RequestParam(value = "search2", defaultValue = "") String search2, @RequestParam(value = "search-start", defaultValue = "") String searchStart, @RequestParam(value = "search-end", defaultValue = "") String searchEnd, @PathVariable(required = false) String member, Model model) throws ParseException {
/*  88 */     search1 = search1.trim();
/*  89 */     search2 = search2.trim();
/*  90 */     String prefix = "member.";
			String isMobile = "0";
/*  91 */     Device device = DeviceUtils.getCurrentDevice(request);
/*  92 */     if (device.isMobile()) {
/*  93 */       prefix = "m-member.";
				isMobile = "1";
/*  94 */     } else if (device.isTablet()) {
/*  95 */       prefix = "m-member.";
				isMobile = "1";
/*     */     } 
/*     */     
/*  98 */     if (searchEnd != null && searchEnd.length() > 0) {
/*  99 */       Calendar cal = Calendar.getInstance();
/* 100 */       DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
/* 101 */       cal.setTime(df.parse(searchEnd));
/* 102 */       cal.add(5, 1);
/* 103 */       searchEnd = df.format(cal.getTime());
/*     */     } 
/* 105 */     HttpSession session = request.getSession();
/* 106 */     if (session.getAttribute("userId") != null && session.getAttribute("userId").equals(member)) {
/*     */       
/* 108 */       HashMap<String, Object> queryMap = new HashMap<>();
/* 109 */       if (page.intValue() < 1) page = Integer.valueOf(1);
/*     */ 
/*     */       
/* 112 */       int pageSize = 20;
/* 113 */       Paging paging = new Paging();
/* 114 */       paging.setPageNo(page.intValue());
/* 115 */       paging.setPageSize(pageSize);
/*     */       
/* 117 */       queryMap.put("page", Integer.valueOf((page.intValue() - 1) * pageSize));
/* 118 */       queryMap.put("estimate_no", estimate_no);
/* 119 */       queryMap.put("user_id", member);
/* 120 */       queryMap.put("count", Integer.valueOf(pageSize));
/* 121 */       queryMap.put("type1", type1);
/* 122 */       queryMap.put("search1", search1);
/* 123 */       queryMap.put("type2", type2);
/* 124 */       queryMap.put("search2", search2);
/* 125 */       queryMap.put("searchStart", searchStart);
/* 126 */       queryMap.put("searchEnd", searchEnd);
/*     */       
/* 128 */       System.out.printf("%s %s %s %s %s %s %s\n", new Object[] { member, type1, search1, type2, search2, searchStart, searchStart });
/*     */       
/* 130 */       int count = ((Integer)this.sqlSession.selectOne("estimate.count", queryMap)).intValue();
/* 131 */       paging.setTotalCount(count);
/* 132 */       logger.info(Integer.toString(count));
/*     */ 
/*     */       
/* 135 */       List<EstimateVO> estimate = this.sqlSession.selectList("estimate.list", queryMap);
/* 136 */       model.addAttribute("estimates", estimate);
/*     */       model.addAttribute("isMobile",isMobile);
/* 138 */       model.addAttribute("paging", paging);
/*     */     } 
/*     */     
/* 141 */     return String.valueOf(prefix) + "estimatelist";
/*     */   }
/*     */ 
@RequestMapping({ "/{member}/estimateDetail" })
public String estimateDetail(HttpServletRequest request, Model model, @RequestParam(value = "estimate_id", required = false, defaultValue = "0") int estimate_id) {
	String prefix = "member.";
	String isMobile = "0";
	Device device = DeviceUtils.getCurrentDevice(request);
	if (device.isMobile()) {
		prefix = "m-member.";
		isMobile = "1";
	} else if (device.isTablet()) {
		prefix = "m-member.";
		isMobile = "1";
    } 	
	List<OptionVO> selOptions = new ArrayList<>();
	EstimateVO estimate = (EstimateVO) this.sqlSession.selectOne("estimate.estimate_one",
	Integer.valueOf(estimate_id));
	List<EstimateVO> estimateList = this.sqlSession.selectList("estimate.estimate_one_group",
	Integer.valueOf(estimate_id));
	CarVO car = (CarVO) this.sqlSession.selectOne("rent.car.trim",
	Integer.valueOf(estimate.getTrim_id()));
	ColorVO color = (ColorVO) this.sqlSession.selectOne("rent.car.color",
	Integer.valueOf(estimate.getColor_id()));

	logger.debug(String.valueOf(Integer.toString(estimate_id)) + " " + Integer.toString(estimate.getColor_id()));
	if (estimate != null) {
		String optionStr = estimate.getOptions().trim();

		if (optionStr != null && optionStr.length() != 0) {
			int[] opIds = Stream.<String>of(optionStr.split(" ")).mapToInt(Integer::parseInt).toArray();
			List<OptionVO> options = this.sqlSession.selectList("rent.car.optionlist",
			Integer.valueOf(estimate.getTrim_id()));
			for (OptionVO option : options) {
				if (Utils.findInt(opIds, option.getOption_id()) != -1) {
					selOptions.add(option);
				}
			}
		}
	}
	SimpleDateFormat formatter = new SimpleDateFormat("YYYY-MM-dd");
	String regDate = formatter.format(estimate.getRegdate()) + " 00:00:00";
	String expDate = DateUtil.addDays(regDate, (int) 7);
	model.addAttribute("expdate", expDate.substring(0,10));	
	model.addAttribute("estimate", estimate);
	model.addAttribute("options", selOptions);
	model.addAttribute("car", car);
	model.addAttribute("color", color);
	model.addAttribute("estimateList", estimateList);
	return String.valueOf(prefix) +"estimateDetail";
}
/*     */   
/*     */   @RequestMapping({"/{member}/{url}"})
/*     */   public String estimate(HttpServletRequest request, Model model, @PathVariable(required = false) String member, @PathVariable(required = false) String url) {
/* 149 */     logger.debug(String.valueOf(member) + " " + url);
/* 150 */     HttpSession session = request.getSession();
/*     */     
/* 152 */     String prefix = "member.";
/* 153 */     Device device = DeviceUtils.getCurrentDevice(request);
/* 154 */     if (device.isMobile()) {
/* 155 */       prefix = "m-member.";
/* 156 */     } else if (device.isTablet()) {
/* 157 */       prefix = "m-member.";
/*     */     } 
/*     */     
/* 160 */     if (url.equals("main")) url = "memberpage";
/*     */     
/* 162 */     return String.valueOf(prefix) + url;
/*     */   }
/*     */ }


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\controller\MemberController.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */