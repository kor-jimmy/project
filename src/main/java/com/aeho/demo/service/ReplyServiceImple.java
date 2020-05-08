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

}
