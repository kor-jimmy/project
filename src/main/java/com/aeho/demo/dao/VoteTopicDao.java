package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.VoteTopicVo;

public interface VoteTopicDao {
	
	List<VoteTopicVo> listVoteTopic();
	
	int insertVoteTopic(VoteTopicVo vtv);

	int updateVoteTopic(VoteTopicVo vtv);
	
	int deleteVoteTopic(VoteTopicVo vtv);
	
}
