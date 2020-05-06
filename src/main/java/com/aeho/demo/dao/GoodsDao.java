package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.GoodsVo;

public interface GoodsDao {

	List<GoodsVo> listGoods(int gc_code,String keyword);
	
	GoodsVo getGoods(GoodsVo gv);
	
	int insertGoods(GoodsVo gv);
	
	int updateGoods(GoodsVo gv);
	
	int deleteGoods(GoodsVo gv);
	
}
