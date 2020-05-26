package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.ReportVo;

public interface ReportDao {

	List<ReportVo> listReport();
	
	int insertBoardReport(ReportVo rev);
	
	int insertReplyReport(ReportVo rev);
	
	int insertGoodsReport(ReportVo rev);
	
	int isCheckedBoard(ReportVo rev);
	
	int isCheckedReply(ReportVo rev);
	
	int isCheckedGoods(ReportVo rev);
}
