package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.ReplyVo;

public interface ReplyDao {

	List<ReplyVo> listReply(int b_no);
	
	ReplyVo getReply(int r_no);
	
	int insertReply(ReplyVo rv);
	
//	int updateReply(ReplyVo rv);
	
	int deleteReply(ReplyVo rv);
	
	//게시물 삭제시 댓글 삭제
	int deleteBoardReply(int b_no);
	
	int maxRstep(ReplyVo rv);
	
	int updateStep(ReplyVo rv);

	int updateCnt(int r_ref);

	int updateState(int r_no);
	
	int updateReportCnt(int r_no);
}
