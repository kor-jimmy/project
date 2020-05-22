package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aeho.demo.dao.BoardDao;
import com.aeho.demo.dao.ReplyDao;
import com.aeho.demo.vo.ReplyVo;

@Service
public class ReplyServiceImple implements ReplyService {

	@Autowired
	private ReplyDao replyDao;
	@Autowired
	private BoardDao boardDao;
	
	@Override
	@Transactional(rollbackFor=Exception.class)
	public List<ReplyVo> listReply(int b_no) {
		return replyDao.listReply(b_no);
	}

	@Override
	@Transactional(rollbackFor=Exception.class)
	public int insertReply(ReplyVo rv) {
		
		//답글 일때..
		if(rv.getR_ref()!=0) {
			//부모 댓글
			ReplyVo replyVo = replyDao.getReply(rv.getR_no());
			System.out.println("replyVo"+replyVo);
			rv.setR_step(replyVo.getR_step()+1);

			System.out.println(rv);
	
			//부모댓글 소환  
			System.out.println("누른댓글번호가옴!!==>"+rv.getR_no());

			rv.setR_level(replyVo.getR_level()+1);
			
			//부모스탭
			replyVo.getR_step();
			
			replyDao.updateStep(rv);
			
			//rv.setR_step(rv.getR_step()+1);
			
		}
		
		int re = 0;
		try {
			int result_insert = replyDao.insertReply(rv);
			String cntkeyword = "reply";
			int result_update = boardDao.updateCnt(rv.getB_no(), cntkeyword);
			
			if(result_insert > 0 && result_update > 0) {
				re = 1;
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return re;
	}

	@Override
	public int deleteReply(ReplyVo rv) {
		int re = 0;
		try {
			int result_delete = replyDao.deleteReply(rv);
			String cntkeyword = "reply";
			int result_update = boardDao.updateCnt(rv.getB_no(), cntkeyword);

			if( result_delete > 0 && result_update > 0 ) {
				re = 1;
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return re;
	}
	
	@Override
	public int deleteBoardReply(int b_no) {
		return replyDao.deleteBoardReply(b_no);
	}

	@Override
	public ReplyVo getReply(int r_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int maxRstep(ReplyVo rv) {
		// TODO Auto-generated method stub
		return 0;
	}

}
