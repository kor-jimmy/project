package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.domain.CriteriaForReply;
import com.aeho.demo.vo.ReplyVo;

public interface ReplyService {

	List<ReplyVo> listReply(int b_no);
	
	ReplyVo getReply(int r_no);
	
	int insertReply(ReplyVo rv);
	
	int deleteReply(ReplyVo rv);
	
	int deleteBoardReply(int b_no);
	
	int maxRstep(ReplyVo rv);
	
	int updateCnt(int r_ref);
	
	int updateState(int r_no);
	
	int getReportCnt();
	
	List<ReplyVo> getReportReply(CriteriaForReply cri);
}
