package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.ReportVo;

public interface ReportDao {

	List<ReportVo> listReport();
	
	ReportVo getReport();
	
	int insertReport();
	
	int updateReport();
	
	int deleteReport();
	
}
