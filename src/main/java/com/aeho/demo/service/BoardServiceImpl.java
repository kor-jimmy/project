package com.aeho.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aeho.demo.dao.BoardDao;
import com.aeho.demo.dao.BoardFilesDao;
import com.aeho.demo.dao.HateDao;
import com.aeho.demo.dao.LoveDao;
import com.aeho.demo.dao.ReplyDao;
import com.aeho.demo.domain.Criteria;
import com.aeho.demo.vo.BoardFilesVo;
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

	@Autowired
	private BoardFilesDao boardFilesDao;

	@Override
	public List<BoardVo> listBoard() {
		return boardDao.listBoard();
	}

	@Override
	public BoardVo getBoard(BoardVo bv) {
		// TODO Auto-generated method stub
		String cntkeyword = "hit";
		// 조회수증가
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
	
	// 파일 수정 관련 로직 추가. 0508 쥔톽~ 아룸~
	@Override
	public int updateBoard(BoardVo bv) {
		// TODO Auto-generated method stub  
		int re = boardDao.updateBoard(bv);
		List<BoardFilesVo> fileList = boardFilesDao.findByBno(bv.getB_no());
		for (BoardFilesVo bfv : fileList) {
			String b_content = bv.getB_content();
			// contains 함수 문자열이 포함되어 있는지 비교하여 true,false 반환
			if (!b_content.contains(bfv.getUuid())) {
				boardFilesDao.delete(bfv.getUuid());
			}
		}
		return re;
	}

	// 게시물 삭제시 댓글 삭제도 추가 , 파일 테이블 db 삭제기능
	@Override
	// @Transactional(rollbackFor=Exception.class)
	public int deleteBoard(BoardVo bv) {
		System.out.println("board service 로직타는중");
		int result = 0;
		
		// 게시물 파일 테이블의 정보부터 삭제. 이유는 자식이니까 부모보다 먼저가야됨 불효자
		// 파일이 없는경우 에러가 난다. 조건문으로 파일이 있는지 없는지 따진다.
		if(boardFilesDao.findByBno(bv.getB_no())!=null) {
			int result_files = boardFilesDao.deleteByBno(bv.getB_no());
			System.out.println("파일 삭제 성공 번호 "+result_files);
		}

		if(replyDao.listReply(bv.getB_no()) != null) {
			int result_reply = replyDao.deleteBoardReply(bv.getB_no());
			System.out.println("댓글 삭제 성공 번호 "+result_reply);	
		}
		
		int result_board = boardDao.deleteBoard(bv);
		System.out.println("게심루 삭제 성공 번호 "+result_board);
		
		if (result_board > 0) {
			result = 1; 
		}
		return result;
	}

	@Override
	public List<BoardVo> getList(Criteria cri) {
		return boardDao.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return boardDao.getTotalCount(cri);
	}

	@Override
	public int getReportCount() {
		// TODO Auto-generated method stub
		return boardDao.getReportCount();
	}

	@Override
	public int getNoticCount(Criteria cri) {
		// TODO Auto-generated method stub
		return boardDao.getNoticCount(cri);
	}

	@Override
	public List<BoardVo> getAdminNotice() {
		// TODO Auto-generated method stub
		return boardDao.getAdminNotice();
	}

	@Override
	public List<BoardVo> getUserNotice() {
		// TODO Auto-generated method stub
		return boardDao.getUserNotice();
	}

	@Override
	public int totalBoard(Criteria cri) {
		// TODO Auto-generated method stub
		return boardDao.totalBoard(cri);
	}

	@Override
	public List<BoardVo> getMypageBoard(String m_id) {
		// TODO Auto-generated method stub
		return boardDao.getMypageBoard(m_id);
	}

	@Override
	public List<BoardVo> mainNewBoard() {
		// TODO Auto-generated method stub
		return boardDao.mainNewBoard();
	}
	
	
	
}
