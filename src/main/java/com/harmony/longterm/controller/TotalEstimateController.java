package com.harmony.longterm.controller;

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

public class TotalEstimateController {
	
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

}
