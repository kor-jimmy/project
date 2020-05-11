package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.GoodsDao;
import com.aeho.demo.dao.GoodsFilesDao;
import com.aeho.demo.dao.GoodsReplyDao;
import com.aeho.demo.domain.Criteria2;
import com.aeho.demo.vo.GoodsVo;

@Service
public class GoodsServiceImpl implements GoodsService {
	
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	private GoodsReplyDao goodsReplyDao;
	@Autowired
	private GoodsFilesDao goodsFilesDao;
	
	
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
		return re;
	}

	@Override
	public int deleteGoods(GoodsVo gv) {
		int result=0;
		if(goodsFilesDao.findByGno(gv.getG_no())!=null) {
			int result_files=goodsFilesDao.deleteByGno(gv.getG_no());	//파일 삭제 번호
		}
		if(goodsReplyDao.listGoodsReply(gv.getG_no()) != null) {
			int result_goodsReply = goodsReplyDao.deleteGoods(gv.getG_no());//댓글 삭제 번호
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

	

}
