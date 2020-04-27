package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public List<ReplyVo> listReply() {
		return replyDao.listReply();
	}

	@Override
	public int insertReply(ReplyVo rv) {
		int re = replyDao.insertReply(rv);
		String cntkeyword = "reply";
		boardDao.updateCnt(rv.getB_no(), cntkeyword);
		return re;
	}

	@Override
	public int deleteReply(ReplyVo rv) {
		// TODO Auto-generated method stub
		return replyDao.deleteReply(rv);
	}

}
