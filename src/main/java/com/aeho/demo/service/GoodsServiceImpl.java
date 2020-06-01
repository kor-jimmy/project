package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.GoodsDao;
import com.aeho.demo.dao.GoodsFilesDao;
import com.aeho.demo.dao.GoodsReplyDao;
import com.aeho.demo.dao.MemberDao;
import com.aeho.demo.dao.ReportDao;
import com.aeho.demo.domain.Criteria2;
import com.aeho.demo.vo.BoardFilesVo;
import com.aeho.demo.vo.GoodsFilesVo;
import com.aeho.demo.vo.GoodsVo;
import com.aeho.demo.vo.ReportVo;

@Service
public class GoodsServiceImpl implements GoodsService {
	
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	private GoodsReplyDao goodsReplyDao;
	@Autowired
	private GoodsFilesDao goodsFilesDao;
	@Autowired
	private ReportDao reportDao;
	
	public void setGoodsDao(GoodsDao goodsDao) {
		this.goodsDao = goodsDao;
	}

	public void setGoodsReplyDao(GoodsReplyDao goodsReplyDao) {
		this.goodsReplyDao = goodsReplyDao;
	}

	public void setGoodsFilesDao(GoodsFilesDao goodsFilesDao) {
		this.goodsFilesDao = goodsFilesDao;
	}

	@Override
	public List<GoodsVo> listGoods(Criteria2 cri) {
		return goodsDao.paging(cri);
	}

	@Override
	public GoodsVo getGoods(GoodsVo gv) {	
		return goodsDao.getGoods(gv);
	}

	@Override
	public int insertGoods(GoodsVo gv) {
		int re = goodsDao.insertGoods(gv);
		return re;
	}

	@Override
	public int updateGoods(GoodsVo gv) {
		int re = goodsDao.updateGoods(gv);
		List<GoodsFilesVo> fileList = goodsFilesDao.findByGno(gv.getG_no());
		for (GoodsFilesVo gfv : fileList) {
			String g_content = gv.getG_content();
			// contains 함수 문자열이 포함되어 있는지 비교하여 true,false 반환
			if (!g_content.contains(gfv.getUuid())) {
				goodsFilesDao.delete(gfv.getUuid());
			}
		}
		return re;
	}

	@Override
	public int deleteGoods(GoodsVo gv) {
		int result=0;
		if(goodsFilesDao.findByGno(gv.getG_no())!=null) {
			int result_files=goodsFilesDao.deleteByGno(gv.getG_no());//파일 삭제 번호
		}
		if(goodsReplyDao.listGoodsReply(gv.getG_no()) != null) {
			int result_goodsReply = goodsReplyDao.deleteGoodsandReply(gv.getG_no());//댓글 삭제 번호
		}
		if(reportDao.listReport(gv.getG_no(), "goods") != null) {
			int result_report = reportDao.deleteReport(gv.getG_no(), "goods");//신고 삭제 번호
		}
//		int result_goodsReply = goodsReplyDao.deleteGoods(gv.getG_no());
		int result_goods = goodsDao.deleteGoods(gv);
		if(result_goods > 0)
			result = 1;
		return result;
	}

	@Override
	public int getTotalCount(Criteria2 cri) {
		return goodsDao.getTotalCount(cri);
	}

	@Override
	public List<GoodsVo> getReportGoods(Criteria2 cri) {
		return goodsDao.getReportGoods(cri);
	}

	

}
