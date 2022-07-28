package com.harmony.longterm.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface IAdminService {
	public void getBankAcntExcel( HttpServletRequest request, HttpServletResponse response) throws Exception;
	public Model estimateDetail(Model model,int estimate_id) throws Exception;
}
