package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.BoardDao;
import com.aeho.demo.vo.BoardVo;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
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

	@Override
	public int deleteBoard(BoardVo bv) {
		// TODO Auto-generated method stub
		int re = boardDao.deleteBoard(bv);
		return re;
	}

}
