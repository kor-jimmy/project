package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.BoardVo;

public interface BoardDao {

	List<BoardVo> listBoard();
	
	BoardVo getBoard(BoardVo bv);
	
	int insertBoard(BoardVo bv);
	
	int updateBoard(BoardVo bv);
	
	int deleteBoard(BoardVo bv);
	
	int updateCnt(int b_no, String keyword);
	
}
