package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.ReplyVo;

public interface ReplyService {

	List<ReplyVo> listReply();
	
	int insertReply(ReplyVo rv);
	
	int deleteReply(ReplyVo rv);
}
