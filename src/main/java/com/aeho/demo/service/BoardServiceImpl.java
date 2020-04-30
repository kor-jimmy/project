package com.aeho.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aeho.demo.dao.BoardDao;
import com.aeho.demo.dao.HateDao;
import com.aeho.demo.dao.LoveDao;
import com.aeho.demo.dao.ReplyDao;
import com.aeho.demo.vo.BoardVo;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private ReplyDao replyDao; 
	
	@Autowired
	private LoveDao loveDao;
	
	@Autowired
	private HateDao hateDao;
	
	
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
		// * board 상세정보를 불러올 때 사용자의 love, hate 클릭 여부 판단해서 int 반환하는 코드 추가 필요.
		// * 로그인한 사용자의 정보를 받아와야 하니 security 구현 이후 추가
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
	@Override
	@Transactional(rollbackFor=Exception.class)
	public int deleteBoard(BoardVo bv) {
		int result = 0;
		try {
			int result_reply = replyDao.deleteBoardReply(bv.getB_no());
			int result_board = boardDao.deleteBoard(bv);
			
			if( result_board > 0 && result_reply > 0 ) {
				result = 1;
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	
	@Override
	public List<BoardVo> listCatBoard(String catkeyword){
		List<BoardVo> list = boardDao.listCatBoard(catkeyword);
		return list;
	}

}
