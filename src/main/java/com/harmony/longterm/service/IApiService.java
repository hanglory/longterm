package com.harmony.longterm.service;

import java.util.List;
import java.util.Map;
import com.harmony.longterm.vo.ApiRecvDataVO;

public interface IApiService {
	public List<ApiRecvDataVO> selectApiRecvDataList(Map<String, Object> map) throws Exception;
	public int insertApiRecvData(ApiRecvDataVO boardVO) throws Exception;
	public void deleteApiRecvData( ApiRecvDataVO boardVO) throws Exception;
	public void updateApiRecvData( ApiRecvDataVO boardVO) throws Exception;
	
}
