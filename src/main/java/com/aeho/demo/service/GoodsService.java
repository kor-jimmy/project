package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.domain.Criteria2;
import com.aeho.demo.vo.GoodsVo;

public interface GoodsService {
//	List<GoodsVo> listGoods(int gc_code,String keyword);
	List<GoodsVo> listGoods(Criteria2 cri);
	
	int getTotalCount(Criteria2 cri);
	
	GoodsVo getGoods(GoodsVo gv);
	
	int insertGoods(GoodsVo gv);
	
	int updateGoods(GoodsVo gv);
	
	int deleteGoods(GoodsVo gv);
	
	List<GoodsVo> getReportGoods(Criteria2 cri);
	
}
