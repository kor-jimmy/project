package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.GoodsDao;
import com.aeho.demo.dao.GoodsReplyDao;
import com.aeho.demo.vo.GoodsVo;

@Service
public class GoodsServiceImpl implements GoodsService {
	
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	private GoodsReplyDao goodsReplyDao;
	
	@Override
	public List<GoodsVo> listGoods(int gc_code,String keyword) {
		return goodsDao.listGoods(gc_code,keyword);
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
		int re2 = goodsReplyDao.deleteGoods(gv.getG_no());
		int re = goodsDao.deleteGoods(gv);
		return re;
	}

}
