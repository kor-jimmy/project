package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.CategoryVo;
import com.aeho.demo.vo.GoodsVo;

public interface SearchService {

	List<CategoryVo> getCategory(String keyword);
	
	List<BoardVo> getBoard(String keyword);
	
	List<GoodsVo> getGoods(String keyword);

}
