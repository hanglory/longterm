package com.harmony.longterm.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.openxml4j.util.ZipSecureFile;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.harmony.longterm.service.IAdminService;
import com.harmony.longterm.utils.DateUtil;
import com.harmony.longterm.utils.Utils;
import com.harmony.longterm.vo.BankAccountVO;
import com.harmony.longterm.vo.CarVO;
import com.harmony.longterm.vo.ColorVO;
import com.harmony.longterm.vo.EstimateVO;
import com.harmony.longterm.vo.OptionVO;

@Service
public class AdminService implements IAdminService {
	private static final Logger logger = LoggerFactory.getLogger(AdminService.class);
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private void setHeaderCS(CellStyle cs, Font font, Cell cell) {
		  cs.setAlignment(CellStyle.ALIGN_CENTER);
		  cs.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		  cs.setBorderTop(CellStyle.BORDER_THIN);
		  cs.setBorderBottom(CellStyle.BORDER_THIN);
		  cs.setBorderLeft(CellStyle.BORDER_THIN);
		  cs.setBorderRight(CellStyle.BORDER_THIN);
		  cs.setFillForegroundColor(HSSFColor.GREY_80_PERCENT.index);
		  cs.setFillPattern(CellStyle.SOLID_FOREGROUND);
		  setHeaderFont(font, cell);
		  cs.setFont(font);
		  cell.setCellStyle(cs);
	}
		 
	private void setHeaderFont(Font font, Cell cell) {
		  font.setBoldweight((short) 700);
		  font.setColor(HSSFColor.WHITE.index);
	}
		 
	private void setCmmnCS2(CellStyle cs, Cell cell) {
		  cs.setAlignment(CellStyle.ALIGN_LEFT);
		  cs.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		  cs.setBorderTop(CellStyle.BORDER_THIN);
		  cs.setBorderBottom(CellStyle.BORDER_THIN);
		  cs.setBorderLeft(CellStyle.BORDER_THIN);
		  cs.setBorderRight(CellStyle.BORDER_THIN);
		  cell.setCellStyle(cs);
	}
	
	@Override
	public void getBankAcntExcel( HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<BankAccountVO> list = this.sqlSession.selectList("admin.selectAccountExcel", "");
		ZipSecureFile.setMinInflateRatio(0);
		SXSSFWorkbook wb = new SXSSFWorkbook();
		Sheet sheet = wb.createSheet();
		  sheet.setColumnWidth((short) 0, (short) 2000);	//번호
		  sheet.setColumnWidth((short) 1, (short) 3000);	//은행
		  sheet.setColumnWidth((short) 2, (short) 8000);	//계좌번호
		  sheet.setColumnWidth((short) 3, (short) 3000);	//차량번호
		  sheet.setColumnWidth((short) 4, (short) 8000);	//계약자명
		  sheet.setColumnWidth((short) 5, (short) 5000);	//담당자명
		  sheet.setColumnWidth((short) 6, (short) 3000);	//담당자ID
		  sheet.setColumnWidth((short) 7, (short) 5000);	//등록일시
		  sheet.setColumnWidth((short) 8, (short) 3000);	//참조
		  
		  Row row = sheet.createRow(0);
		  Cell cell = null;
		  CellStyle cs = wb.createCellStyle();
		  Font font = wb.createFont();
		  cell = row.createCell(0);
		  cell.setCellValue("가상계좌 관리 - 전체 리스트");
		  setHeaderCS(cs, font, cell);
		  sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 0, 8));
		  
		  row = sheet.createRow(1);
		  cell = null;
		  cs = wb.createCellStyle();
		  font = wb.createFont();
		  
		  cell = row.createCell(0);
		  cell.setCellValue("번호");
		  setHeaderCS(cs, font, cell);
		 
		  cell = row.createCell(1);
		  cell.setCellValue("은행");
		  setHeaderCS(cs, font, cell);
		  
		  cell = row.createCell(2);
		  cell.setCellValue("계좌번호");
		  setHeaderCS(cs, font, cell);
		  
		  cell = row.createCell(3);
		  cell.setCellValue("차량번호");
		  setHeaderCS(cs, font, cell);
		  
		  cell = row.createCell(4);
		  cell.setCellValue("계약자명");
		  setHeaderCS(cs, font, cell);
		  
		  cell = row.createCell(5);
		  cell.setCellValue("담당자명");
		  setHeaderCS(cs, font, cell);
		  
		  cell = row.createCell(6);
		  cell.setCellValue("담당자ID");
		  setHeaderCS(cs, font, cell);
		  
		  cell = row.createCell(7);
		  cell.setCellValue("등록일시");
		  setHeaderCS(cs, font, cell);

		  cell = row.createCell(8);
		  cell.setCellValue("참조");
		  setHeaderCS(cs, font, cell);
		 
		  int i = 2;
		  int ii = list.size();
		  for (BankAccountVO vo : list) {
		      
	//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	//		String cretDate = sdf.format(vo.getCret_date());
			 
			  row = sheet.createRow(i);
			  cell = null;
			  cs = wb.createCellStyle();
			  font = wb.createFont();
			 
			  cell = row.createCell(0);
			  cell.setCellValue(vo.getSeqno());
			  setCmmnCS2(cs, cell);
			  
			  cell = row.createCell(1);
			  cell.setCellValue(vo.getBank_name());
			  setCmmnCS2(cs, cell);
			  
			  cell = row.createCell(2);
			  cell.setCellValue(vo.getAccount());
			  setCmmnCS2(cs, cell);
			  
			  cell = row.createCell(3);
			  cell.setCellValue(vo.getCarno());
			  setCmmnCS2(cs, cell);
			  
			  cell = row.createCell(4);
			  cell.setCellValue(vo.getUser_name());
			  setCmmnCS2(cs, cell);

			  cell = row.createCell(5);
			  cell.setCellValue(vo.getName());
			  setCmmnCS2(cs, cell);

			  cell = row.createCell(6);
			  cell.setCellValue(vo.getReg_id());
			  setCmmnCS2(cs, cell);
	
			  cell = row.createCell(7);
			  cell.setCellValue(vo.getRecv_date());
			  setCmmnCS2(cs, cell);
	
			  cell = row.createCell(8);
			  cell.setCellValue(vo.getMemo());
			  setCmmnCS2(cs, cell);
			  
			  i++;
			  ii--;
		}

		  response.setHeader("Set-Cookie", "fileDownload=true; path=/");
		  response.setHeader("Content-Disposition", String.format("attachment; filename=\"bankAccount.xlsx\""));
		  wb.write(response.getOutputStream());
		 
		}
		
	@Override
	public Model estimateDetail(Model model, int estimate_id) throws Exception{
		
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
//		estimate.setUser_company(expDate);	// estimate.user_company값에 견적유효기간 등록
		model.addAttribute("estimate", estimate);
		model.addAttribute("options", selOptions);
		model.addAttribute("car", car);
		model.addAttribute("color", color);
		model.addAttribute("cal_price", cal_price);
		model.addAttribute("estimateList", estimateList);
		return model;
	}
}
