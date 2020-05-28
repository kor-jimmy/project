package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.BoardDao;
import com.aeho.demo.dao.GoodsDao;
import com.aeho.demo.dao.ReplyDao;
import com.aeho.demo.dao.ReportDao;
import com.aeho.demo.vo.ReportVo;

@Service
public class ReportServiceImple implements ReportService {

	@Autowired
	private ReportDao reportDao;
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private ReplyDao replyDao;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Override
	public List<ReportVo> listReport() {
		//return reportDao.listReport();
		return null;
	}

	@Override
	public int insertBoardReport(ReportVo rev) {
		int re = reportDao.insertBoardReport(rev);
		int cnt = boardDao.updateCnt(rev.getB_no(), "report");
		return re;
	}
	
	@Override
	public int insertReplyReport(ReportVo rev) {
		// TODO Auto-generated method stub
		int re = reportDao.insertReplyReport(rev);
		int cnt = replyDao.updateReportCnt(rev.getRe_no());
		return re;
	}

	@Override
	public int insertGoodsReport(ReportVo rev) {
		int re = reportDao.insertGoodsReport(rev);
		goodsDao.updateCnt(rev.getG_no(), "report");
		return re;
	}

	@Override
	public int isCheckedBoard(ReportVo rev) {
		// TODO Auto-generated method stub
		int re = reportDao.isCheckedBoard(rev);
		return re;
	}

	@Override
	public int isCheckedReply(ReportVo rev) {
		// TODO Auto-generated method stub
		int re = reportDao.isCheckedReply(rev);
		return re;
	}

	@Override
	public int isCheckedGoods(ReportVo rev) {
		// TODO Auto-generated method stub
		int re = reportDao.isCheckedGoods(rev);
		return re;
	}



}
