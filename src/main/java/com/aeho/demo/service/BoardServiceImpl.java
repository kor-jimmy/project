package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aeho.demo.dao.BoardDao;
import com.aeho.demo.dao.ReplyDao;
import com.aeho.demo.vo.BoardVo;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private ReplyDao replyDao; 
	
	@Override
	public List<BoardVo> listBoard() {
		return boardDao.listBoard();
	}

	@Override
	public BoardVo getBoard(BoardVo bv) {
		// TODO Auto-generated method stub
		String cntkeyword = "hit";
		//조회수증가
		boardDao.updateCnt(bv.getB_no(), cntkeyword);
		return boardDao.getBoard(bv);
	}

	@Override
	public int insertBoard(BoardVo bv) {
		// TODO Auto-generated method stub
		int re = boardDao.insertBoard(bv);
		return re;
	}

	@Override
	public int updateBoard(BoardVo bv) {
		// TODO Auto-generated method stub
		int re = boardDao.updateBoard(bv);
		return re;
	}

	//게시물 삭제시 댓글 삭제도 추가
	//트랜잭션 기능 구체화 해야됨.
	@Override
	public int deleteBoard(BoardVo bv) {
		// TODO Auto-generated method stub
		int re2 = replyDao.deleteBoardReply(bv.getB_no());
		int re = boardDao.deleteBoard(bv);
		return re;
	}
	
	@Override
	public List<BoardVo> listCatBoard(String catkeyword){
		List<BoardVo> list = boardDao.listCatBoard(catkeyword);
		return list;
	}

}
