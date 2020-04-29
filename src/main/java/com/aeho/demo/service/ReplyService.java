package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.ReplyVo;

public interface ReplyService {

	List<ReplyVo> listReply(ReplyVo rv);
	
	int insertReply(ReplyVo rv);
	
	int deleteReply(ReplyVo rv);
	
	int deleteBoardReply(int b_no);
}
