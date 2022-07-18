package com.harmony.longterm.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jdom2.Document;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.harmony.longterm.service.ISiteinfoService;
import com.harmony.longterm.service.ISummernoteService;
import com.harmony.longterm.service.IUsedCarService;
import com.harmony.longterm.utils.CommonUtil;
import com.harmony.longterm.utils.DateUtil;
import com.harmony.longterm.utils.ExcelDown;
import com.harmony.longterm.utils.ExcelUtil;
import com.harmony.longterm.utils.Paging;
import com.harmony.longterm.utils.Utils;
import com.harmony.longterm.utils.VOUtils;
import com.harmony.longterm.utils.XmlIbatis;
import com.harmony.longterm.vo.BankAccountVO;
import com.harmony.longterm.vo.BaseColorVO;
import com.harmony.longterm.vo.CarVO;
import com.harmony.longterm.vo.ColorVO;
import com.harmony.longterm.vo.EstimateVO;
import com.harmony.longterm.vo.OptionVO;
import com.harmony.longterm.vo.SiteinfoVO;
import com.harmony.longterm.vo.SummernoteVO;
import com.harmony.longterm.vo.UsedCarVO;
import com.harmony.longterm.vo.UserVO;
import com.mysql.cj.util.StringUtils;

@Controller
@RequestMapping({ "/admin" })
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private ISummernoteService summernoteService;

	@Autowired
	private IUsedCarService usedCarService;
	
	@Autowired
	private ISiteinfoService siteinfoService;

	@RequestMapping({ "/", "/{url}" })
	public String main(@PathVariable(required = false) String url) {
		logger.debug("admin main");

		if (url == null)
			url = "main";
		return "admin." + url;
	}

	@RequestMapping({ "/siteinfoList" })
	public String siteInfoList( Model model, @RequestParam(value = "page", defaultValue = "1") Integer page, @ModelAttribute SiteinfoVO siteinfoVO) throws Exception {

		int pageSize = 20;
		Paging paging = new Paging();
		paging.setPageNo(page.intValue());
		paging.setPageSize(pageSize);
		siteinfoVO.setPage(( page - 1) * 20);
		siteinfoVO.setCount(pageSize);
		siteinfoVO.setPc_type("");
		
		int count = siteinfoService.selectSiteinfoTotCnt(siteinfoVO);
		paging.setTotalCount(count);
		
		List<SiteinfoVO> siteinfoVOList = siteinfoService.selectSiteinfoList(siteinfoVO);
		model.addAttribute("siteinfoVO", siteinfoVOList);
		model.addAttribute("paging", paging);
		
		return "admin.siteinfoList";
	}
	@RequestMapping({ "/siteinfoForm" })
	public String siteinfoForm(Model model, @ModelAttribute SiteinfoVO siteinfoVO)	throws Exception {

		if (!StringUtils.isNullOrEmpty(siteinfoVO.getId())) {
			siteinfoVO= siteinfoService.selectSiteinfo(siteinfoVO);
		}
		model.addAttribute("siteinfoVO", siteinfoVO);

		return "admin.siteinfoForm";
	}
	@RequestMapping({ "/siteinfoAction" })
	@ResponseBody
	public Map<String, Object> siteinfoAction(HttpServletRequest request, Model model,
			@ModelAttribute SiteinfoVO siteinfoVO) throws Exception {

		Map<String, Object> objectAsMap = VOUtils.convert(siteinfoVO, new String[] { "resultCode", "id" });
		int count = siteinfoService.selectSiteinfoTotCnt(siteinfoVO);
		if(count > 0) {
			objectAsMap.put("resultCode", "DUP");
			return objectAsMap;
		}
		// 첨부파일
		SummernoteVO summernoteVO = new SummernoteVO();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

//		if (StringUtils.isNullOrEmpty(siteinfoVO.getId())) {
			MultipartFile headImgFile = multipartRequest.getFile("attechFiles");
			summernoteVO.setGroup1Id("siteinfo");
			summernoteVO.setGroup2Id("layerimg");
			if (headImgFile != null) {
				summernoteVO = summernoteService.imgFileUpload(headImgFile, summernoteVO);
				siteinfoVO.setContents(summernoteVO.getFileURL() + summernoteVO.getFileName());
			}
//		}

		if (StringUtils.isNullOrEmpty(siteinfoVO.getId())) {
			int id = siteinfoService.insertSiteinfo(siteinfoVO);
			if(id > 0) {
				objectAsMap.put("resultCode", "0000");	
			}
		}else {
			siteinfoService.updateSiteinfo(siteinfoVO);
			objectAsMap.put("resultCode", "0000");
		}

		return objectAsMap;
	}	
	
	@RequestMapping({ "/usedcarlist" })
	public String usedcar(Model model, @RequestParam(value = "page", defaultValue = "1") Integer page,
			@RequestParam(value = "id", defaultValue = "") String id,
			@RequestParam(value = "type1", defaultValue = "") String type1,
			@RequestParam(value = "search1", defaultValue = "") String search1,
			@RequestParam(value = "type2", defaultValue = "") String type2,
			@RequestParam(value = "search2", defaultValue = "") String search2,
			@RequestParam(value = "search-start", defaultValue = "") String searchStart,
			@RequestParam(value = "search-end", defaultValue = "") String searchEnd,
			@RequestParam(value = "user_id", defaultValue = "") String user_id) throws ParseException {
		search1 = search1.trim();
		search2 = search2.trim();
		HashMap<String, Object> queryMap = new HashMap<>();
		if (page.intValue() < 1)
			page = Integer.valueOf(1);

		if (searchEnd != null && searchEnd.length() > 0) {
			Calendar cal = Calendar.getInstance();
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			cal.setTime(df.parse(searchEnd));
			cal.add(5, 1);
			searchEnd = df.format(cal.getTime());
		}

		int pageSize = 20;
		Paging paging = new Paging();
		paging.setPageNo(page.intValue());
		paging.setPageSize(pageSize);

		queryMap.put("page", Integer.valueOf((page.intValue() - 1) * 20));
		queryMap.put("id", id);
		queryMap.put("user_id", user_id);
		queryMap.put("count", Integer.valueOf(pageSize));
		queryMap.put("trim_name", search1);
		queryMap.put("rentfee_min", "");
		queryMap.put("rentfee_max", "");
		queryMap.put("maker", "");
		queryMap.put("deposit", "");
		queryMap.put("sell_state", "");
		queryMap.put("car_type", "");
		queryMap.put("car_no", "");

		queryMap.put("searchStart", searchStart);
		queryMap.put("searchEnd", searchEnd);

		int count = ((Integer) this.sqlSession.selectOne("usedcar.selectUsedCarTotCnt", queryMap)).intValue();
		paging.setTotalCount(count);

		List<UsedCarVO> usedCarVO = this.sqlSession.selectList("usedcar.selectUsedCarList", queryMap);
		model.addAttribute("usedCarVO", usedCarVO);
		model.addAttribute("paging", paging);

		return "admin.usedcarlist";
	}

	@RequestMapping({ "/usedcarUpdate" })
	public String usedcarUpdate(Model model, @RequestParam(value = "id", defaultValue = "") String id)
			throws Exception {
//		int id = Integer.parseInt(map.get("id").toString());
		UsedCarVO usedCarVO = new UsedCarVO();
		usedCarVO.setId(id);
		HashMap<String, Object> queryMap = new HashMap<>();
		queryMap.put("id", id);

		usedCarVO = this.sqlSession.selectOne("usedcar.usedcar_one", queryMap);
		model.addAttribute("usedCarVO", usedCarVO);

		return "admin.usedcarUpdate";
	}

	@RequestMapping({ "/usedcarAction" })
	@ResponseBody
	public Map<String, Object> usedcarAction(HttpServletRequest request, Model model,
			@ModelAttribute UsedCarVO usedCarVO) throws Exception {
		SummernoteVO summernoteVO = new SummernoteVO();
//	UsedCarVO usedCarVO = (UsedCarVO) VOUtils.convert(gnrlBoardVO, GnrlBoardBaseVO.class);

//	gnrlBoardBaseVO.setBoardInvokeType(GnrlBoardBaseVO.BOARD_INVOKE_TYPE.SAVE);

		// 첨부파일
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		if (StringUtils.isNullOrEmpty(usedCarVO.getId())) {
			MultipartFile headImgFile = multipartRequest.getFile("attechFiles");
			summernoteVO.setGroup1Id("usedcar");
			summernoteVO.setGroup2Id("title");
			if (headImgFile != null) {
				summernoteVO = summernoteService.imgFileUpload(headImgFile, summernoteVO);
				usedCarVO.setImage(summernoteVO.getFileURL() + summernoteVO.getFileName());
			}
		}
		usedCarService.updateUsedCar(usedCarVO);
//		this.invoke( gnrlBoardBaseVO, usedCarVO, null);

		Map<String, Object> objectAsMap = VOUtils.convert(usedCarVO, new String[] { "resultCode", "id" });

		return objectAsMap;
	}

	@RequestMapping({ "/usedcarDelete" })
	@ResponseBody
//	public Map<String, Object> usedcarDelete(Model model, @ModelAttribute UsedCarVO usedCarVO) throws Exception {
	public Map<String, Object> usedcarDelete(Model model, @RequestBody HashMap<String, Object> map) throws Exception {
//		int id = Integer.parseInt(map.get("id").toString());
		UsedCarVO usedCarVO = new UsedCarVO();
		usedCarVO.setId(map.get("id").toString());
		usedCarService.deleteUsedCar(usedCarVO);
//		this.invoke( gnrlBoardBaseVO, usedCarVO, null);

		Map<String, Object> objectAsMap = VOUtils.convert(usedCarVO, new String[] { "resultCode", "id" });

		return objectAsMap;
	}

	@RequestMapping({ "/userList" })
	public String userList(Model model, @RequestParam(value = "page", defaultValue = "1") Integer page,
			@RequestParam(value = "id", defaultValue = "") String id,
			@RequestParam(value = "type1", defaultValue = "") String type1,
			@RequestParam(value = "search1", defaultValue = "") String search1,
			@RequestParam(value = "type2", defaultValue = "") String type2,
			@RequestParam(value = "search2", defaultValue = "") String search2) throws ParseException {
		search1 = search1.trim();
		search2 = search2.trim();
		HashMap<String, Object> queryMap = new HashMap<>();
		if (page.intValue() < 1)
			page = Integer.valueOf(1);

		int pageSize = 20;
		Paging paging = new Paging();
		paging.setPageNo(page.intValue());
		paging.setPageSize(pageSize);

		queryMap.put("page", Integer.valueOf((page.intValue() - 1) * 20));
		queryMap.put("count", Integer.valueOf(pageSize));
		queryMap.put("name", search1);

		int count = ((Integer) this.sqlSession.selectOne("userdb.selectUserTotCnt", queryMap)).intValue();
		paging.setTotalCount(count);

		List<UserVO> userVO = this.sqlSession.selectList("userdb.selectUserList", queryMap);
		model.addAttribute("userVO", userVO);
		model.addAttribute("paging", paging);

		return "admin.userList";
	}
	@RequestMapping({ "/userUpdate" })
	public String userUpdate(Model model, @RequestParam(value = "id", defaultValue = "0") int id)
			throws Exception {
//		int id = Integer.parseInt(map.get("id").toString());
		UserVO userVO = new UserVO();
		userVO.setId(id);
		HashMap<String, Object> queryMap = new HashMap<>();
		queryMap.put("id", id);

		userVO = this.sqlSession.selectOne("userdb.user_one", queryMap);
		model.addAttribute("userVO", userVO);

		return "admin.userUpdate";
	}
	
	@RequestMapping({ "/userAction" })
	@ResponseBody
	public Map<String, Object> userAction(HttpServletRequest request, Model model,
			@ModelAttribute UserVO userVO) throws Exception {

		this.sqlSession.update("userdb.updateUserInfo", userVO);
//		this.invoke( gnrlBoardBaseVO, usedCarVO, null);

		userVO.setResultCode("0000");
		Map<String, Object> objectAsMap = VOUtils.convert(userVO, new String[] { "resultCode", "id" });

		return objectAsMap;
	}	
	

@RequestMapping({ "/estimatelist" })
public String estimate(Model model, @RequestParam(value = "page", defaultValue = "1") Integer page,
			@RequestParam(value = "estimate_no", defaultValue = "") String estimate_no,
			@RequestParam(value = "type1", defaultValue = "") String type1,
			@RequestParam(value = "search1", defaultValue = "") String search1,
			@RequestParam(value = "type2", defaultValue = "") String type2,
			@RequestParam(value = "search2", defaultValue = "") String search2,
			@RequestParam(value = "search-start", defaultValue = "") String searchStart,
			@RequestParam(value = "search-end", defaultValue = "") String searchEnd,
			@RequestParam(value = "user_id", defaultValue = "") String user_id) throws ParseException {
	search1 = search1.trim();
	search2 = search2.trim();
	HashMap<String, Object> queryMap = new HashMap<>();
	if (page.intValue() < 1)
		page = Integer.valueOf(1);

	if (searchEnd != null && searchEnd.length() > 0) {
		Calendar cal = Calendar.getInstance();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		cal.setTime(df.parse(searchEnd));
		cal.add(5, 1);
		searchEnd = df.format(cal.getTime());
	}

	int pageSize = 20;
	Paging paging = new Paging();
	paging.setPageNo(page.intValue());
	paging.setPageSize(pageSize);

	queryMap.put("page", Integer.valueOf((page.intValue() - 1) * 20));
	queryMap.put("estimate_no", estimate_no);
	queryMap.put("user_id", user_id);
	queryMap.put("count", Integer.valueOf(pageSize));
	queryMap.put("type1", type1);
	queryMap.put("search1", search1);
	queryMap.put("type2", type2);
	queryMap.put("search2", search2);
	queryMap.put("searchStart", searchStart);
	queryMap.put("searchEnd", searchEnd);

	int count = ((Integer) this.sqlSession.selectOne("estimate.count", queryMap)).intValue();
	paging.setTotalCount(count);

	List<EstimateVO> estimate = this.sqlSession.selectList("estimate.list", queryMap);
	model.addAttribute("estimates", estimate);
	model.addAttribute("paging", paging);

	return "admin.estimatelist";
}

@RequestMapping({ "/estimateDetail" })
public String estimateDetail(Model model,
		@RequestParam(value = "estimate_id", required = false, defaultValue = "0") int estimate_id) {
	List<OptionVO> selOptions = new ArrayList<>();
	EstimateVO estimate = (EstimateVO) this.sqlSession.selectOne("estimate.estimate_one",Integer.valueOf(estimate_id));
	List<EstimateVO> estimateList = this.sqlSession.selectList("estimate.estimate_one_group",Integer.valueOf(estimate_id));
	CarVO car = (CarVO) this.sqlSession.selectOne("rent.car.trim", Integer.valueOf(estimate.getTrim_id()));
	ColorVO color = (ColorVO) this.sqlSession.selectOne("rent.car.color", Integer.valueOf(estimate.getColor_id()));

	logger.debug(String.valueOf(Integer.toString(estimate_id)) + " " + Integer.toString(estimate.getColor_id()));

	if (estimate != null) {
		String optionStr = estimate.getOptions().trim();

		if (optionStr != null && optionStr.length() != 0) {
			int[] opIds = Stream.<String>of(optionStr.split(" ")).mapToInt(Integer::parseInt).toArray();

			List<OptionVO> options = this.sqlSession.selectList("rent.car.optionlist", Integer.valueOf(estimate.getTrim_id()));
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
//	estimate.setUser_company(expDate);	// estimate.user_company값에 견적유효기간 등록
	model.addAttribute("estimate", estimate);
	model.addAttribute("options", selOptions);
	model.addAttribute("car", car);
	model.addAttribute("color", color);
	model.addAttribute("estimateList", estimateList);

	return "admin.estimateDetail";
}

@RequestMapping({ "/bankAccount" })
public String bankAccount(HttpServletRequest request, Model model,@RequestParam(value = "page", defaultValue = "1") Integer page,
		@RequestParam(value = "type1", defaultValue = "") String type1,
		@RequestParam(value = "search1", defaultValue = "") String search1 ) { 
	HttpSession session = request.getSession();
	HashMap<String, Object> queryMap = new HashMap<>();
	if (page.intValue() < 1) page = Integer.valueOf(1);

//    if (session.getAttribute("userId") != null) {
//    }
    int pageSize = 20;
    Paging paging = new Paging();
    paging.setPageNo(page.intValue());
    paging.setPageSize(pageSize);
    queryMap.put("page", Integer.valueOf((page.intValue() - 1) * pageSize));
//    queryMap.put("reg_id", session.getAttribute("userId"));
    queryMap.put("count", Integer.valueOf(pageSize));
    queryMap.put(type1, search1);
    int count = ((Integer)this.sqlSession.selectOne("admin.selectAccountCount",  queryMap)).intValue();
    List<BankAccountVO> bankAccountVo  = this.sqlSession.selectList("admin.selectAccount", queryMap);
    model.addAttribute("BankAccountVO", bankAccountVo);
    model.addAttribute("paging", paging);
    model.addAttribute("type1", type1);
    model.addAttribute("search1", search1);
    paging.setTotalCount(count);

	return "admin.bankAccount";
}

@RequestMapping({ "/bankAccountUpdate" })
public String bankAccountUpdate(HttpServletRequest request, Model model, @RequestParam(value = "seqno", defaultValue = "0") Integer seqno) {
	HttpSession session = request.getSession();
	HashMap<String, Object> queryMap = new HashMap<>();

    queryMap.put("page", 0);
    queryMap.put("count", 1);
    queryMap.put("seqno",seqno);
    
    BankAccountVO bankAccountVo  = this.sqlSession.selectOne("admin.selectAccount", queryMap);
    model.addAttribute("bankAccountVo", bankAccountVo);

	return "admin.bankAccountUpdate";
}

@RequestMapping({ "/bankAccountAction" })
@ResponseBody
public Map<String, Object> bankAccountAction(HttpServletRequest request, Model model,
		@ModelAttribute BankAccountVO bankAccountVo) throws Exception {

	this.sqlSession.update("admin.updateAccountBySeqno", bankAccountVo);

	bankAccountVo.setResultCode("0000");
	Map<String, Object> objectAsMap = VOUtils.convert(bankAccountVo, new String[] { "resultCode", "id" });

	return objectAsMap;
}

@RequestMapping({"/bankAccountExcelDown"})
public void bankAccountExcelDown(HttpServletRequest request, HttpServletResponse response) throws Exception{
	
	Map mapReq = CommonUtil.getRequestMap(request);
	Map mapParam = new HashMap();
	
	
	int  nRowCount =0;
	
	try{ 

//        String strGbnIn = CommonUtil.DecodeXSS( CommonUtil.nvlMap(mapReq, "autocare_gbn_in"));
		
//        mapReq.put("autocare_gbn_in", strGbnIn);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<?> xmlResult = null;
    	String sheetName 	= "가상계좌리스트";
		String fileName 	= sheetName + "-"+sdf.format(new Date());
		
        XmlIbatis xmlIbatis = new XmlIbatis();
        Document document   = new Document();
        String menuCode     = "";
        
//    	xmlResult 	= dbSvc.dbList("contract_mst.autoCareExcelDown", mapReq);
//        List<BankAccountVO> bankAccountVo 
//        xmlResult = this.sqlSession.selectList("admin.selectAccountExcel", "");
        List<Map<String, Object>> bankAccountVo = this.sqlSession.selectList("admin.selectAccountExcel", "");
        
        ExcelUtil excelUtil = new ExcelUtil();

        excelUtil.createExcelToResponse(
        		bankAccountVo,
                String.format("%s-%s", "data", LocalDate.now().toString()),
                response
        );        
        
        
    	String[][] title 	= {{"기본정보"},{""},{"번호", "은행명", "계좌", "차량번호", "사용자명", "관리자명", "관리자ID", "날짜", "메모"}};
//    	document =  xmlIbatis.iBATISForMake(xmlResult);
    	document =  (Document) bankAccountVo;
        	
    	ExcelDown.downloadExcel(response, title, menuCode, sheetName, fileName, document);
		
	    request.setAttribute("mapReq", mapReq);

	}catch (Exception e) {	 
//		BaseLog.logError(this.getClass().getName()+"autocareExcelDown==>" , e);
	}finally{
		 
	}
	 
}		







	/*     */ @RequestMapping({ "/member" })
	/*     */ public String user(Model model) {
		/* 102 */ List<UserVO> users = this.sqlSession.selectList("userdb.list");
		/* 103 */ model.addAttribute("users", users);
		/*     */
		/* 105 */ return "admin.member";
		/*     */ }

	/*     */
	/*     */
	/*     */ @RequestMapping({ "/modellist" })
	/*     */ public String modellist(Model model, @RequestParam(value = "maker", defaultValue = "") String maker) {
		/* 111 */ List<CarVO> cars = this.sqlSession.selectList("admin.modellist", maker);
		/* 112 */ model.addAttribute("cars", cars);
		/*     */
		/* 114 */ return "admin.modellist";
		/*     */ }

	/*     */
	/*     */
	/*     */
	/*     */
	/*     */ @RequestMapping({ "/lineuplist" })
	/*     */ public String lineuplist(Model model, @RequestParam(value = "maker", defaultValue = "") String maker,
			@RequestParam(value = "model_name", defaultValue = "") String model_name) {
		/* 122 */ HashMap<String, String> param = new HashMap<>();
		/* 123 */ param.put("maker", maker);
		/* 124 */ param.put("model_name", model_name);
		/* 125 */ List<CarVO> cars = this.sqlSession.selectList("admin.lineuplist", param);
		/*     */
		/*     */
		/*     */
		/* 129 */ model.addAttribute("cars", cars);
		/*     */
		/* 131 */ List<BaseColorVO> basecolors = this.sqlSession.selectList("admin.basecolorlist");
		/* 132 */ model.addAttribute("basecolors", basecolors);
		/* 133 */ return "admin.lineuplist";
		/*     */ }

	/*     */
	/*     */
	/*     */
	/*     */ @RequestMapping({ "/trimlist" })
	/*     */ public String trimlist(Model model,
			@RequestParam(value = "model_id", defaultValue = "") String model_id) {
		/* 140 */ List<CarVO> trims = this.sqlSession.selectList("rent.car.trimlist", model_id);
		/* 141 */ model.addAttribute("trims", trims);
		/*     */
		/* 143 */ return "admin.trimlist";
		/*     */ }

	/*     */
	/*     */
	/*     */ @RequestMapping({ "/optionlist" })
	/*     */ public String optionlist(Model model,
			@RequestParam(value = "trim_id", defaultValue = "") String trim_id) {
		/* 149 */ List<OptionVO> options = this.sqlSession.selectList("rent.car.optionlist", trim_id);
		/* 150 */ model.addAttribute("options", options);
		/* 151 */ System.out.println(options.size());
		/* 152 */ return "admin.optionlist";
		/*     */ }

	/*     */
	/*     */
	/*     */
	/*     */
	/*     */ @RequestMapping({ "/memberchange" })
	/*     */ @ResponseBody
	/*     */ public String memberChange(HashMap<String, Object> map) {
		/* 161 */ System.out.println(map.get("id"));
		/* 162 */ System.out.println(map.get("level"));
		/* 163 */ System.out.println(map.get("state"));
		/* 164 */ return "ok";
		/*     */ }
	/*
	 * private int findInt(int[] array, int value) { 156 for (int i = 0; i <
	 * array.length; i++) { 157 if (array[i] == value) { 158 return i; } } 161
	 * return -1; }
	 */

	
	/*     */ }

/*
 * Location: D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\controller\
 * AdminController.class Java compiler version: 8 (52.0) JD-Core Version: 1.1.3
 */