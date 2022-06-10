package com.harmony.longterm.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.harmony.longterm.vo.UsedCarVO;

public interface IUsedCarService {
	public List<UsedCarVO> selectUsedCarList(Map<String, Object> map) throws Exception;
	public void deleteUsedCar( UsedCarVO usedCarVO) throws Exception;
	public String uploadCommentImg(MultipartFile multipartFile, UsedCarVO usedCarVO) throws Exception;
	public void updateUsedCar( UsedCarVO usedCarVO) throws Exception;
	public UsedCarVO selectUsedCar(Map<String, Object> map) throws Exception;
	public int selectUsedCarTotCnt(Map<String, Object> map) throws Exception;
	public void updateUsedCarViewCnt(Map<String, Object> map) throws Exception;
}
