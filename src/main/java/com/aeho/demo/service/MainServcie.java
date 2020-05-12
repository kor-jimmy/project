package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.BoardVo;

public interface MainServcie {
	List<BoardVo> todayBest();
	
	List<BoardVo> weekBest();
	
	List<BoardVo> monthBest();

}
