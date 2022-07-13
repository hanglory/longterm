package com.harmony.longterm.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.harmony.longterm.utils.CommonUtil;
import com.harmony.longterm.utils.DateUtil;
import com.harmony.longterm.utils.Utils;
import com.harmony.longterm.utils.pdf.PdfHtmlCreator;
import com.harmony.longterm.utils.pdf.PdfHtmlPageEvent;
import com.harmony.longterm.vo.CarVO;
import com.harmony.longterm.vo.ColorVO;
import com.harmony.longterm.vo.EstimateVO;
import com.harmony.longterm.vo.OptionVO;

public class TotalEstimateController {
	
	@Controller
	@RequestMapping({"/total"})
	public class UserController
	{


		@RequestMapping(value = "estimateTotPDFDownload", method = RequestMethod.POST)
		public void estimateTotPDFDownload(HttpServletRequest request, HttpServletResponse response) throws Exception{

			Map mapReq = CommonUtil.getRequestMap(request);
			Map mapParam  = new HashMap();
				
			try {
				
//						 	getVendorNid(request, dataMap);
//						 	getVendorNid(request, mapReq);
//						 	getVendorNid(request, mapParam);
				 	
				//String strUrl = CommonUtil.getDomain(request) + "/contract_management/contractLongFormPDF.act?rent_seq=" + CommonUtil.DSEncode(CommonUtil.nvlMap(mapReq, "pdf_rent_seq"));
				String strUrl = CommonUtil.getDomain(request) + "/total/estimate_tot_pdf?rent_seq=" +  CommonUtil.nvlMap(mapReq, "pdf_rent_seq");
				
				String strHtml = CommonUtil.getHtml( strUrl );
				
				String strRentSeq = CommonUtil.DSDecode(CommonUtil.nvlMap(mapReq, "pdf_rent_seq"));
				
				mapReq.put("rent_seq", strRentSeq);
				
	 
//							Map mapRs = dbSvc.dbDetail("contract_mst.rentContractDetail", mapReq);
				
//							mapParam.put("partner_nid", CommonUtil.nvlMap(mapRs, "RENT_PARTNER_NID"));  // 렌트 이용자
//							Map mapRentRs = dbSvc.dbDetail("contract_mst.partnerDetail", mapParam);					
							
				String strFileNm = CommonUtil.getUniqueId().replaceAll("-", "");
//							String strFileView = CommonUtil.nvlMap(mapRentRs, "PARTNER_NM");
			 
				
				try {
			        
					// 다운로드 파일명
			        Object fileName = "하모니렌트견적서(" + request.getQueryString() + ").pdf";
			        
			       
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
		
		@RequestMapping(value = "estimate_tot_pdf", method = RequestMethod.POST)
		public void estimate_tot_pdf(HttpServletRequest request, HttpServletResponse response) throws Exception{

			Map mapReq = CommonUtil.getRequestMap(request);
			Map mapParam  = new HashMap();
/*				
			List<OptionVO> selOptions = new ArrayList<>();
			EstimateVO estimate = (EstimateVO) this.sqlOSession.selectOne("estimate.estimate_one",Integer.valueOf(estimate_id));
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
//			estimate.setUser_company(expDate);	// estimate.user_company값에 견적유효기간 등록
			model.addAttribute("estimate", estimate);
			model.addAttribute("options", selOptions);
			model.addAttribute("car", car);
			model.addAttribute("color", color);
			model.addAttribute("estimateList", estimateList);
*/
				
		}				
	}

}
