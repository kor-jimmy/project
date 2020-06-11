package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.domain.Criteria;
import com.aeho.demo.vo.BoardVo;

public interface BoardDao {

	List<BoardVo> listBoard();
	
	BoardVo getBoard(BoardVo bv);
	
	int insertBoard(BoardVo bv);
	
	int updateBoard(BoardVo bv);
	
	int deleteBoard(BoardVo bv);
	
	int updateCnt(int b_no, String cntkeyword);
	
	//카테고리별 게시물
	List<BoardVo> listCatBoard(String catkeyword);
	
	//페이징처리 위한거
	List<BoardVo> getListWithPaging(Criteria cri);
	
	//카테고리별 토탈 게시물 수를 구하기 위한거
	int getTotalCount(Criteria cri);
	
	//신고 5이상 게시물 총 개수 페이징을 위한 토탈
	int getReportCount();
	
	//공지사항 토탈 개수
	int getNoticCount(Criteria cri);
	
	//관리자 메인 페이지 공지사항
	List<BoardVo> getAdminNotice();
	
	//관리자 메인 페이지 유저 공지사항
	List<BoardVo> getUserNotice();
	
	//전체 모든 게시글 수 
	int totalBoard(Criteria cri);
	
	//회원 게시글 5개뽑는용도 마이페이지!
	List<BoardVo> getMypageBoard(String m_id);
	
	//메인 페이지용 최신 게시글
	List<BoardVo> mainNewBoard();
	
	//알람용 글번호로 해당 글 정보 찾는거
	BoardVo boardAlarm(int b_no);
	
	int loveTotal(String m_id);
	
	int hateTotal(String m_id);
	
	int updateBoardWhereID(String m_id);
	
}
