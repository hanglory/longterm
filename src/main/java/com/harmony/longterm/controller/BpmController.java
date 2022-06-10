package com.harmony.longterm.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.harmony.longterm.utils.Paging;
import com.harmony.longterm.vo.BoardVO;
import com.harmony.longterm.vo.UsedCarVO;

@Controller
@RequestMapping({"/bpm"})
public class BpmController {

    /** MAPPER_PATH */
    private final String MAPPER_PATH = "bpm_invtr_car.";	
	@Autowired
	private SqlSessionTemplate sqlSessionbpm;	
	/**
	 * <pre>
	 * 설명 : 신차 등록 리스트
	 * </pre>
	 * @param request
	 * @param model
	 * @throws Exception
	 */
	
	   @RequestMapping({"/NewCarListAjax"})
	   @ResponseBody
	   public List<Object> newCarListAjax(Model model,@RequestBody HashMap<String, Object> map) throws Exception {

//			int pageSize = Integer.parseInt(map.get("pageSize").toString());
//			int page = Integer.parseInt(map.get("page").toString());
//			Paging paging = new Paging();
//			paging.setPageNo(page);
//			paging.setPageSize(pageSize);
//			HashMap<String, Object> queryMap = new HashMap<>();
			/*
			queryMap.put("page", 1);
			queryMap.put("count", Integer.valueOf(pageSize));
			queryMap.put("maker", maker);
			queryMap.put("trim_name", trim_name);
			queryMap.put("deposit", deposit);
			queryMap.put("rentfee_min", rentfee_min);
			queryMap.put("rentfee_max", rentfee_max);
			queryMap.put("sell_state", "판매중");
	*/
		   if(map.get("maker").equals("현대")) {
			   map.put("maker", "M");
		   }else if(map.get("maker").equals("기아")) {
			   map.put("maker", "N");
		   }else if(map.get("maker").equals("로노삼성")) {
			   map.put("maker", "S");
		   }else if(map.get("maker").equals("쉐보레")) {
			   map.put("maker", "L");
		   }else if(map.get("maker").equals("쌍용")) {
			   map.put("maker", "R");
		   }else {
			   map.put("maker", "");
		   }
		   
		   return sqlSessionbpm.selectList(MAPPER_PATH + "productInvtrCarList", map);
	   }
	   

	
}
