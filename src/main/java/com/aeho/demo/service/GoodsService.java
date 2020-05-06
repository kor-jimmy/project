package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.GoodsVo;

public interface GoodsService {
	List<GoodsVo> listGoods(int gc_code,String keyword);
	
	GoodsVo getGoods(GoodsVo gv);
	
	int insertGoods(GoodsVo gv);
	
	int updateGoods(GoodsVo gv);
	
	int deleteGoods(GoodsVo gv);
}
