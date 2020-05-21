package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.VoteTopicVo;

public interface VoteTopicService {
	
	
	List<VoteTopicVo> listVoteTopic();
	
	List<VoteTopicVo> ongoingListVoteTopic();
	
	List<VoteTopicVo> endedListVoteTopic();
	
	VoteTopicVo getVoteTopic(int vt_no);
	
	int insertVoteTopic(VoteTopicVo vtv);

	int updateVoteTopic(VoteTopicVo vtv);
	
	int deleteVoteTopic(int vt_no);
	
	int updateState(VoteTopicVo vtv);
	
}
