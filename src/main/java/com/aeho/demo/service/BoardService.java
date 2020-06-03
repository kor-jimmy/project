package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.domain.Criteria;
import com.aeho.demo.vo.BoardVo;

public interface BoardService {
	
	List<BoardVo> listBoard();
	
	BoardVo getBoard(BoardVo bv);
	
	int insertBoard(BoardVo bv);
	
	int updateBoard(BoardVo bv);
	
	int deleteBoard(BoardVo bv);
	
	//카테고리별 게시물 
	//List<BoardVo> listCatBoard(String catkeyword);
	
	List<BoardVo> getList(Criteria cri);
	
	int getTotalCount(Criteria cri);
	
	int getReportCount();
	
	int getNoticCount(Criteria cri);
	
	List<BoardVo> getAdminNotice();
	
	List<BoardVo> getUserNotice();
	
	int totalBoard(Criteria cri);
	
	List<BoardVo> getMypageBoard(String m_id);
	
	List<BoardVo> mainNewBoard();
	
}
