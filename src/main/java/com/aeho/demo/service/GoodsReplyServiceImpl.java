package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.GoodsReplyDao;
import com.aeho.demo.vo.GoodsReplyVo;

@Service
public class GoodsReplyServiceImpl implements GoodsReplyService {
	@Autowired
	public GoodsReplyDao goodsReplyDao;
	
	@Override
	public List<GoodsReplyVo> listGoodsReply(GoodsReplyVo gv) {
		return goodsReplyDao.listGoodsReply(gv);
	}

	@Override
	public int insertGoodsReply(GoodsReplyVo gv) {
		int re = goodsReplyDao.insertGoodsReply(gv);
		return re;
	}

	@Override
	public int deleteGoodsReply(GoodsReplyVo gv) {
		int re = goodsReplyDao.deleteGoodsReply(gv);
		return re;
	}

}
