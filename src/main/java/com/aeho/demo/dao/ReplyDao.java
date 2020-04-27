package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.ReplyVo;

public interface ReplyDao {

	List<ReplyVo> listReply();
	
	int insertReply(ReplyVo rv);
	
//	int updateReply(ReplyVo rv);
	
	int deleteReply(ReplyVo rv);
}
