package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.aeho.demo.dao.GoodsDao;
import com.aeho.demo.vo.GoodsVo;

public class GoodsServiceImpl implements GoodsService {
	@Autowired
	private GoodsDao goodsDao;
	
	@Override
	public List<GoodsVo> listGoods() {
		return goodsDao.listGoods();
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
		int re = goodsDao.deleteGoods(gv);
		return re;
	}

}
