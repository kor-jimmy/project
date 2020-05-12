package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.BoardVo;

public interface MainDao {
	
	List<BoardVo> todayBest();
	
	List<BoardVo> weekBest();
	
	List<BoardVo> monthBest();

}
