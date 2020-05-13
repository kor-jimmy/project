package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.domain.CategoryDTO;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.CategoryVo;

public interface MainServcie {
	List<BoardVo> todayBest();
	
	List<BoardVo> weekBest();
	
	List<BoardVo> monthBest();

	List<CategoryVo> menuCategory(CategoryDTO categoryDTO);
}
