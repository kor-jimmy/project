package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.GoodsDao;
import com.aeho.demo.dao.GoodsReplyDao;
import com.aeho.demo.vo.GoodsReplyVo;

@Service
public class GoodsReplyServiceImpl implements GoodsReplyService {
	@Autowired
	public GoodsReplyDao goodsReplyDao;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Override
	public List<GoodsReplyVo> listGoodsReply(GoodsReplyVo gv) {
		return goodsReplyDao.listGoodsReply(gv);
	}

	@Override
	public int insertGoodsReply(GoodsReplyVo gv) {
		int re = goodsReplyDao.insertGoodsReply(gv);
		String cntKeyword = "reply";
		goodsDao.updateCnt(gv.getG_no(), cntKeyword);
		return re;
	}

	@Override
	public int deleteGoodsReply(GoodsReplyVo gv) {
		int re = goodsReplyDao.deleteGoodsReply(gv);
		String cntKeyword = "reply";
		goodsDao.updateCnt(gv.getG_no(), cntKeyword);
		return re;
	}

	@Override
	public int deleteGoods(int g_no) {
		// TODO Auto-generated method stub
		return goodsReplyDao.deleteGoods(g_no);
	}

}
