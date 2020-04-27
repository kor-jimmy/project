package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.BoardVo;

public interface BoardService {
	List<BoardVo> listBoard();
	
	BoardVo getBoard(BoardVo bv);
	
	int insertBoard(BoardVo bv);
	
	int updateBoard(BoardVo bv);
	
	int deleteBoard(BoardVo bv);
	
}
