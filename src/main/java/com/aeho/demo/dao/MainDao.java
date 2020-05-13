package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.domain.CategoryDTO;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.CategoryVo;

public interface MainDao {
	
	List<BoardVo> todayBest();
	
	List<BoardVo> weekBest();
	
	List<BoardVo> monthBest();

	List<CategoryVo> menuCategory(CategoryDTO categoryDTO);
}
