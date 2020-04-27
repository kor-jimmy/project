package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.aeho.demo.dao.GoodsReplyDao;
import com.aeho.demo.vo.GoodsReplyVo;

public class GoodsReplyServiceImpl implements GoodsReplyService {
	@Autowired
	public GoodsReplyDao goodsReplyDao;
	
	@Override
	public List<GoodsReplyVo> listGoodsReply() {
		return goodsReplyDao.listGoodsReply();
	}

	@Override
	public int insertGoodsReply(GoodsReplyVo gv) {
		int re = goodsReplyDao.insertGoodsReply(gv);
		return re;
	}

	@Override
	public int updateGoodsReply(GoodsReplyVo gv) {
		int re = goodsReplyDao.updateGoodsReply(gv);
		return re;
	}

	@Override
	public int deleteGoodsReply(GoodsReplyVo gv) {
		int re = goodsReplyDao.deleteGoodsReply(gv);
		return re;
	}

}
