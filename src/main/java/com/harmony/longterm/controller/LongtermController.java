package com.harmony.longterm.controller;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
/*    */ import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*    */ import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
/*    */ import org.slf4j.Logger;
/*    */ import org.slf4j.LoggerFactory;
/*    */ import org.springframework.beans.factory.annotation.Autowired;
/*    */ import org.springframework.mobile.device.Device;
/*    */ import org.springframework.mobile.device.DeviceUtils;
/*    */ import org.springframework.stereotype.Controller;
/*    */ import org.springframework.ui.Model;
/*    */ import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
/*    */ import org.springframework.web.bind.annotation.RequestMapping;
/*    */ import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.harmony.longterm.service.CarService;
import com.harmony.longterm.service.ISiteinfoService;
import com.harmony.longterm.service.IUsedCarService;
import com.harmony.longterm.utils.DateUtil;
import com.harmony.longterm.utils.Paging;
import com.harmony.longterm.vo.SiteinfoVO;
import com.harmony.longterm.vo.UsedCarVO;


@Controller
@RequestMapping({"/"})
public class LongtermController
{
	private static final Logger logger = LoggerFactory.getLogger(LongtermController.class);
  
	@Autowired
	private CarService carService;

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private ISiteinfoService siteinfoService;
	
	@Autowired
	private IUsedCarService usedCarService;	
/*    */   
/*    */   @RequestMapping({"/", "/{menu}"})
/*    */   public String index(HttpServletRequest request, @PathVariable(value = "menu", required = false) String menu) {
/* 33 */    if (menu == null) {
//				menu = "main"; 
				return "redirect:/main";
			}
/* 34 */     String prefix = "rent.";
// logger.debug("longtermControler" + String.valueOf(prefix) + menu);
/*    */     
/* 36 */     if (menu.contains("admin"))
/*    */     {
/* 38 */       return "redirect:/admin/";
/*    */     }
/* 40 */     if (menu.contains("member"))
/*    */     {
/* 42 */       return "redirect:/member/";
/*    */     }
/* 40 */     if (menu.contains("bbs"))
/*    */     {
/* 42 */       return "redirect:/bbs/";
/*    */     }

/* 44 */     Device device = DeviceUtils.getCurrentDevice(request);
/* 45 */     if (device.isMobile()) {
/* 48 */       prefix = "m-rent.";
/* 49 */     } else if (device.isTablet()) {
/* 50 */       prefix = "m-rent.";
/* 51 */ //      logger.debug("tablet");
/*    */     } 
/*    */     
/* 57 */  //   logger.debug(String.valueOf(prefix) + menu);
/* 58 */     return String.valueOf(prefix) + menu;
/*    */   }
/*    */   
/*    */   @RequestMapping({"/estimate"})
/*    */   public String estimate(@RequestParam HashMap<String, String> map, Model model) {
/* 63 *///     logger.debug(map.toString());
/*    */     
/* 65 */     model.addAllAttributes(map);
//     model.addAttribute("phone", "1661-9763");

/* 67 */     return "rent.estimate";
/*    */   }
/*    */   @RequestMapping({"/estimate_tot"})
/*    */   public String estimate_tot(HttpServletRequest request, @RequestParam HashMap<String, String> map, Model model) {
/* 63 *///     logger.debug(map.toString());
			String expdate="";
			Date now = new Date();
			SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.setTime(now);
			cal.add(Calendar.DATE,7);
			HttpSession session = request.getSession();
			
			expdate = ft.format(cal.getTime());
/* 65 */     model.addAllAttributes(map);
			model.addAttribute("expdate",ft.format(cal.getTime()));
			model.addAttribute("userLevel", session.getAttribute("userLevel"));
/* 67 */     return "rent.estimate_tot";
/*    */   }
@RequestMapping({"/main"})
public String main_view(HttpServletRequest request, @RequestParam HashMap<String, String> map, Model model) throws Exception {

//	Date now = new Date();
	SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	Calendar cal = Calendar.getInstance();
	String to_day = ft.format(cal.getTime());
	String prefix = "rent.";
	SiteinfoVO siteinfoVO = new SiteinfoVO();
    Device device = DeviceUtils.getCurrentDevice(request);
    if (device.isMobile()) {
    	siteinfoVO.setPc_type("2");    	
       prefix = "m-rent.";
    } else if (device.isTablet()) {
    	siteinfoVO.setPc_type("2");    	
    	prefix = "m-rent.";
    }else {
    	siteinfoVO.setPc_type("1");    	
    }
    HashMap<String, Object> queryMap = new HashMap<>();
    queryMap.put("sell_state", "판매중");
	queryMap.put("car_type", "신차");
	queryMap.put("page", 1);
	queryMap.put("count", 3);
	List<UsedCarVO> newUsedCarVO = usedCarService.selectUsedCarList(queryMap);
	queryMap.put("car_type", "중고차");
	List<UsedCarVO> oldUsedCarVO = usedCarService.selectUsedCarList(queryMap);

	siteinfoVO.setStart_date(to_day);
	siteinfoVO.setEnd_date(to_day);
	siteinfoVO = siteinfoService.selectSiteinfo(siteinfoVO);
	model.addAttribute("siteinfoVO", siteinfoVO);
	model.addAttribute("newUsedCarVO", newUsedCarVO);
	model.addAttribute("oldUsedCarVO", oldUsedCarVO);

	return prefix+"main";
}
// 150줄 입력 잘 되나요?

/*
   @RequestMapping({"/usedcarReal"})
   public String usedcarReal(Model model,@RequestParam(value = "page", defaultValue = "1") Integer page, @RequestParam(value = "maker", defaultValue = "") String maker, 
		   @RequestParam(value = "rentfee_min", defaultValue = "") String rentfee_min, @RequestParam(value = "rentfee_max", defaultValue = "") String rentfee_max, 
		   @RequestParam(value = "deposit", defaultValue = "") String deposit, @RequestParam(value = "trim_name", defaultValue = "") String trim_name, 
		   @RequestParam(value = "orderby", defaultValue = "") String orderby) {

		int pageSize = 200;
		Paging paging = new Paging();
//		paging.setPageNo(page.intValue());
//		paging.setPageSize(pageSize);

		HashMap<String, Object> queryMap = new HashMap<>();
		queryMap.put("page", 1);
		queryMap.put("count", Integer.valueOf(pageSize));
		queryMap.put("maker", maker);
		queryMap.put("trim_name", trim_name);
		queryMap.put("deposit", deposit);
		queryMap.put("rentfee_min", rentfee_min);
		queryMap.put("rentfee_max", rentfee_max);
		queryMap.put("sell_state", "판매중");

		int count = ((Integer)this.sqlSession.selectOne("usedcar.selectUsedCarTotCnt", queryMap)).intValue();
		paging.setTotalCount(count);

		List<UsedCarVO> usedCarVO = this.sqlSession.selectList("usedcar.selectUsedCarList", queryMap);
		model.addAttribute("usedCarVO", usedCarVO);
		model.addAttribute("queryMap", queryMap);

		return "rent.usedcarReal";     
   }
*/
@RequestMapping({"/usedcarDetail"})
public String usedcarReal(Model model,@RequestParam(value = "page", defaultValue = "1") Integer page, @RequestParam(value = "car_id", defaultValue = "") String id) {

		int pageSize = 200;
		Paging paging = new Paging();
//		paging.setPageNo(page.intValue());
//		paging.setPageSize(pageSize);

		HashMap<String, Object> queryMap = new HashMap<>();
		queryMap.put("page", 1);
		queryMap.put("count", Integer.valueOf(pageSize));
		queryMap.put("id", id);
		queryMap.put("sell_state", "판매중");

		this.sqlSession.update("usedcar.updateUsedCarViewCnt", queryMap);
		UsedCarVO usedCarVO = this.sqlSession.selectOne("usedcar.selectUsedCar", queryMap);
		model.addAttribute("usedCarVO", usedCarVO);
		model.addAttribute("queryMap", queryMap);

		return "bbs.usedcarDetail";     
}
   @RequestMapping({"/usedcarAjax"})
   @ResponseBody
   public List<UsedCarVO> usedcarAjax(Model model,@RequestBody HashMap<String, Object> map) {

		int pageSize = 200;
		Paging paging = new Paging();
//		paging.setPageNo(page.intValue());
//		paging.setPageSize(pageSize);
/*
		HashMap<String, Object> queryMap = new HashMap<>();
		queryMap.put("page", 1);
		queryMap.put("count", Integer.valueOf(pageSize));
		queryMap.put("maker", maker);
		queryMap.put("trim_name", trim_name);
		queryMap.put("deposit", deposit);
		queryMap.put("rentfee_min", rentfee_min);
		queryMap.put("rentfee_max", rentfee_max);
		queryMap.put("sell_state", "판매중");
*/
		map.put("sell_state", "판매중");
		map.put("page", 0);
		map.put("count", Integer.valueOf(pageSize));
		int count = ((Integer)this.sqlSession.selectOne("usedcar.selectUsedCarTotCnt", map)).intValue();
		paging.setTotalCount(count);

		List<UsedCarVO> usedCarVO = this.sqlSession.selectList("usedcar.selectUsedCarList", map);
//		model.addAttribute("usedCarVO", usedCarVO);
//		model.addAttribute("queryMap", queryMap);
		return usedCarVO;     
   }

   /**
    * 봇 크롤링 
    */
   @RequestMapping(value = "/robots.txt")
   @ResponseBody
   public void robotsBlock(HttpServletRequest request, HttpServletResponse response) {
   	try {
   		response.getWriter().write("User-agent: *\nAllow: /\n \n #DaumWebMasterTool:3b027cea3769a1793e235832277edc7c711f324e8d3d06c9e348bbb0dd731555:kcSTJreB+fP+plExwbhoPg==");
   	} catch (IOException e) {
   		logger.debug( "error" + e);
   	}
   }   
   
   
}


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\controller\LongtermController.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */