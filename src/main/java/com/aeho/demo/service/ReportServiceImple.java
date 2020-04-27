package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.ReportDao;
import com.aeho.demo.vo.ReportVo;

@Service
public class ReportServiceImple implements ReportService {

	@Autowired
	private ReportDao reportDao;
	
	@Override
	public List<ReportVo> listReport() {
		return reportDao.listReport();
	}

	@Override
	public int insertReport(ReportVo rev) {
		int re = reportDao.insertReport(rev);
		return re;
	}

}
