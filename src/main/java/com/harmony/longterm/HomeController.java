package com.harmony.longterm;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	

	/**
	 * Simply selects the home view to render by returning its name.
	 */
//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	
//	public ModelAndView main(ModelAndView mv) {
//		mv.setViewName("/main/home");
//		mv.addObject("setHeader", "타일즈테스트");
//		System.out.println(trimService.getModelID("1000"));
//		return mv;
//	}
//	
//
//	public String home(Model model, Locale locale) {
//		logger.info("Welcome home! The client locale is {}.", locale);
//		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );
//		
//		return "home";
//	}
	
	@RequestMapping(value="/{page}.do")
	public String base(@PathVariable String page) {
		logger.info("Welcome home! " + page + ".do" );
		
		return "base/" + page;
	}
/*	
	@RequestMapping(value="/stringify")
	@ResponseBody
	public Object stringify( Jamong jamong) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		logger.info(jamong.name + jamong.age);
		map.put("name", jamong.name);
		map.put("age", jamong.age);
		return map;
	}
*/	
}
