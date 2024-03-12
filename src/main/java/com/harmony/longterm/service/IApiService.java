package com.harmony.longterm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.harmony.longterm.vo.ApiRecvDataVO;

public interface IApiService {
	public List<ApiRecvDataVO> selectApiRecvDataList(Map<String, Object> map) throws Exception;
	public int insertApiRecvData(ApiRecvDataVO boardVO) throws Exception;
	public void deleteApiRecvData( ApiRecvDataVO boardVO) throws Exception;
	public void updateApiRecvData( HttpServletRequest request, HashMap<String, Object> param) throws Exception;
	
}
