package com.harmony.longterm.controller;

<<<<<<< HEAD
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;
=======
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bizmtec.common.pdf.PdfHtmlCreator;
import com.bizmtec.common.pdf.PdfHtmlPageEvent;
import com.harmony.longterm.utils.CommonUtil;
>>>>>>> 7ed72f863bc32ac8b71cbb91951435baecda130d

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.core.appender.rewrite.MapRewritePolicy.Mode;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.harmony.longterm.service.IAdminService;
import com.harmony.longterm.utils.CommonUtil;
import com.harmony.longterm.utils.DateUtil;
import com.harmony.longterm.utils.Utils;
import com.harmony.longterm.utils.pdf.PdfHtmlCreator;
import com.harmony.longterm.utils.pdf.PdfHtmlPageEvent;
import com.harmony.longterm.vo.CarVO;
import com.harmony.longterm.vo.ColorVO;
import com.harmony.longterm.vo.EstimateVO;
import com.harmony.longterm.vo.OptionVO;

@Controller
@RequestMapping({"/total"})
public class TotalEstimateController {
	
<<<<<<< HEAD
		private static final Logger logger = LoggerFactory.getLogger(TotalEstimateController.class);
		@Autowired
		private SqlSessionTemplate sqlSession;
	
		@Autowired
		private IAdminService adminService;
		
		@RequestMapping(value = "estimateTotPDFDownload")
		public void estimateTotPDFDownload(HttpServletRequest request, HttpServletResponse response) throws Exception{

			Map mapReq = CommonUtil.getRequestMap(request);
			Map mapParam  = new HashMap();
				
			try {
				
//						 	getVendorNid(request, dataMap);
//						 	getVendorNid(request, mapReq);
//						 	getVendorNid(request, mapParam);
				 	
				//String strUrl = CommonUtil.getDomain(request) + "/contract_management/contractLongFormPDF.act?rent_seq=" + CommonUtil.DSEncode(CommonUtil.nvlMap(mapReq, "pdf_rent_seq"));
				String strUrl = CommonUtil.getDomain(request) + "/total/estimate_tot_pdf?estimate_id=" +  CommonUtil.nvlMap(mapReq, "estimate_id");
				
				String strHtml = CommonUtil.getHtml( strUrl );
				
//				String strRentSeq = CommonUtil.DSDecode(CommonUtil.nvlMap(mapReq, "estimate_id"));
				
//				mapReq.put("rent_seq", strRentSeq);
				
	 
//							Map mapRs = dbSvc.dbDetail("contract_mst.rentContractDetail", mapReq);
				
//							mapParam.put("partner_nid", CommonUtil.nvlMap(mapRs, "RENT_PARTNER_NID"));  // 렌트 이용자
//							Map mapRentRs = dbSvc.dbDetail("contract_mst.partnerDetail", mapParam);					
							
//				String strFileNm = CommonUtil.getUniqueId().replaceAll("-", "");
//							String strFileView = CommonUtil.nvlMap(mapRentRs, "PARTNER_NM");
			 
				
				try {
			        
					// 다운로드 파일명
			        Object fileName = "하모니렌트견적서(" + CommonUtil.nvlMap(mapReq, "estimate_id") + ").pdf";
			        
			       
			        System.out.print(strHtml);
			        
			        
		    		PdfHtmlCreator pdfCreator = new PdfHtmlCreator();
		    		PdfHtmlPageEvent pdfEvent = new PdfHtmlPageEvent(strHtml, request);
		    		pdfCreator.download(fileName, request, response, pdfEvent, "html.css");
					
				} catch (Exception e) {
					// TODO: handle exception
				    System.out.println( e.toString());
				}					
					
  
			}catch(Exception e){
				e.printStackTrace();
			}
				
		}
		 
		@RequestMapping(value = {"estimate_tot_pdf", "pdfForm"})
		public String estimate_tot_pdf(Model model,	@RequestParam(value = "id", required = false, defaultValue = "0") int id) throws Exception{
			model = adminService.estimateDetail(model, id);
			/*
			List<OptionVO> selOptions = new ArrayList<>();
			EstimateVO estimate = (EstimateVO) this.sqlSession.selectOne("estimate.estimate_one",Long.valueOf(estimate_id));
			List<EstimateVO> estimateList = this.sqlSession.selectList("estimate.estimate_one_group",Long.valueOf(estimate_id));
			CarVO car = (CarVO) this.sqlSession.selectOne("rent.car.trim", Integer.valueOf(estimate.getTrim_id()));
			ColorVO color = (ColorVO) this.sqlSession.selectOne("rent.car.color", Integer.valueOf(estimate.getColor_id()));

			//cal_price를 가지고 요율을 결정함
			int price = car.getPrice() + estimateList.get(0).getOption_price();
		    int reg_car_price = (int)(price / 1.1D / (1.0F + car.getTax_rate()));
		    float cal_tax_rate = 0.0455F;
		    int cal_price = 0;
		    if (car.getTax_type().equals("면세")) {
		      cal_price = (int)(reg_car_price * 1.1D);
		    }
		    else if (car.getFuel().equals("전기")) {
		      cal_price = (int)(reg_car_price * 1.1D);
		    } else {
		      cal_price = (int)((reg_car_price * (1.0F + cal_tax_rate)) * 1.1D);
		    }
			logger.debug(String.valueOf(Long.toString(estimate_id)) + " " + Integer.toString(estimate.getColor_id()));

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
//			estimate.setUser_company(expDate);	// estimate.user_company값에 견적유효기간 등록
			model.addAttribute("estimate", estimate);
			model.addAttribute("options", selOptions);
			model.addAttribute("car", car);
			model.addAttribute("color", color);
			model.addAttribute("cal_price", cal_price);
			model.addAttribute("estimateList", estimateList);
			*/
			return "estimate_tot_pdf";
		}	
		
		@RequestMapping(value = "uploadFile", method = RequestMethod.POST)
		public void uploadFile(HttpServletRequest request, HttpServletResponse response) throws Exception{

			Map mapReq = CommonUtil.getRequestMap(request);
			Map mapParam  = new HashMap();
			
			//첨부파일
			MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;
			MultipartFile attechFiles = multipartRequest.getFile("attechFiles");
			/*
			boardVO.setAttechFiles(attechFiles);

			if(attechFiles != null) {
				String resultCd = boardService.uploadAddFile(attechFiles, boardVO);
				objectAsMap.put("resultCode", resultCd);
//					return objectAsMap;
			}
			*/

				
		}				
=======
	@Controller
	@RequestMapping({"/total"})
	public class UserController
	{
		 @RequestMapping(value = "estimateTotPDFDownload", method = RequestMethod.POST)
			public void estimateTotPDFDownload(HttpServletRequest request, @RequestParam HashMap<String, String> map, Model model) throws Exception{

					Map mapReq = CommonUtil.getRequestMap(request);
//					Map mapParam  = new HashMap();
					
					try {
						
//						 	getVendorNid(request, dataMap);
//						 	getVendorNid(request, mapReq);
//						 	getVendorNid(request, mapParam);
						 	
							//String strUrl = CommonUtil.getDomain(request) + "/contract_management/contractLongFormPDF.act?rent_seq=" + CommonUtil.DSEncode(CommonUtil.nvlMap(mapReq, "pdf_rent_seq"));
							String strUrl = CommonUtil.getDomain(request) + "/contract_management/contractLongFormPDF.act?rent_seq=" +  CommonUtil.nvlMap(mapReq, "pdf_rent_seq");
							
							String strHtml = CommonUtil.getHtml( strUrl );
							
							String strRentSeq = CommonUtil.DSDecode(CommonUtil.nvlMap(mapReq, "pdf_rent_seq"));
							
							mapReq.put("rent_seq", strRentSeq);
							
				 
							Map mapRs = dbSvc.dbDetail("contract_mst.rentContractDetail", mapReq);
							
							mapParam.put("partner_nid", CommonUtil.nvlMap(mapRs, "RENT_PARTNER_NID"));  // 렌트 이용자
							Map mapRentRs = dbSvc.dbDetail("contract_mst.partnerDetail", mapParam);					
										
							String strFileNm = CommonUtil.getUniqueId().replaceAll("-", "");
							String strFileView = CommonUtil.nvlMap(mapRentRs, "PARTNER_NM");
						 
							
							try {
						        
								// 다운로드 파일명
						        Object fileName = "하모니렌트계약서(" + strFileView + ").pdf";
						       
						        System.out.print(strHtml);
						        
						        
					    		PdfHtmlCreator pdfCreator = new PdfHtmlCreator();
					    		PdfHtmlPageEvent pdfEvent = new PdfHtmlPageEvent(strHtml, request);
					    		pdfCreator.download(fileName, request, response, pdfEvent, "html.css");
								
							} catch (Exception e) {
								// TODO: handle exception
							    System.out.println( e.toString());
							}					
							
		  
					  }catch(Exception e){
					   e.printStackTrace();
					  }
					 		
					
					
			}		
		    		
	}
>>>>>>> 7ed72f863bc32ac8b71cbb91951435baecda130d

}
