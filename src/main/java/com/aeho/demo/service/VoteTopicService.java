package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.VoteTopicVo;

public interface VoteTopicService {
	List<VoteTopicVo> listVoteTopic();
	
	VoteTopicVo getVoteTopic(VoteTopicVo vtv);
	
	int insertVoteTopic(VoteTopicVo vtv);

	//int updateVoteTopic(VoteTopicVo vtv);
	
	int deleteVoteTopic(VoteTopicVo vtv);
}
