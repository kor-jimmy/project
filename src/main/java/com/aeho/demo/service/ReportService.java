package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.ReportVo;

public interface ReportService {

	List<ReportVo> listReport();
	
	int insertReport(ReportVo rev);
}
