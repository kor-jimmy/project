package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.VoteVo;

public interface VoteDao {
	
	
	List<VoteVo> listVote();
	
	VoteVo getVote(VoteVo vv);
	
	List<VoteVo> findByVoteTopic(VoteVo vv);
	
	int insertVote(VoteVo vv);
	
	int updateVote(VoteVo vv);
	
	int deleteVote(VoteVo vv);
	
	List<VoteVo> isChecked(VoteVo vv);
		
}
