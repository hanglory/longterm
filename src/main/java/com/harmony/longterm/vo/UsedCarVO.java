package com.harmony.longterm.vo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.harmony.longterm.utils.Paging;
import com.harmony.longterm.utils.SelectBoxVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UsedCarVO {

	private String id;
	private String bcId;
	private String car_no;
	private String maker;
	private String trim_name;
	private String vehicle_year;
	private String period;
	private String deposit;
	private String rentfee;
	private String rentfee_1;
	private String rentfee_24;
	private String trim_price;
	private String acquisition;
	private String ranking;
	private String sell_state;
	private String car_type;
	private String distance;
	private String fuel;
	private String image;
	private String options;
	private String icon;
	private String etc_memo;
	private String accident;
	private String view_cnt;
	private String contents;
	private String resultCode;
	private String detailDesc;

	
	private String imgChartURL;
	private String commentImgURL;
	private String attechFileURL;
	private String[] attechFileBfNos;
	private List<MultipartFile> attechFiles;
	private List<MultipartFile> summernoteImageFiles;
	private String[] summernoteImageFileSeqs;

	private List<SelectBoxVO> prefixList;
	private List<SelectBoxVO> bsMultiFlagList;
	private Paging paging;
	
	public List<SelectBoxVO> getBsMultiFlagList() {
		bsMultiFlagList = new ArrayList<SelectBoxVO>();
		SelectBoxVO SelectBoxVO;

		SelectBoxVO = new SelectBoxVO();
		SelectBoxVO.setValue("N");
		SelectBoxVO.setText("불가능");
		bsMultiFlagList.add(SelectBoxVO);
		
		SelectBoxVO = new SelectBoxVO();
		SelectBoxVO.setValue("Y");
		SelectBoxVO.setText("가능");
		bsMultiFlagList.add(SelectBoxVO);
		
		return bsMultiFlagList;
	}	
	

}
