package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.VoteTopicVo;

public interface VoteTopicDao {
	
	List<VoteTopicVo> listVoteTopic();
	
	List<VoteTopicVo> ongoingListVoteTopic();
	
	List<VoteTopicVo> endedListVoteTopic();
	
	VoteTopicVo getVoteTopic(int vt_no);
	
	int insertVoteTopic(VoteTopicVo vtv);

	int updateVoteTopic(VoteTopicVo vtv);
	
	int deleteVoteTopic(VoteTopicVo vtv);
	
	int updateCount(int vt_no);
	
}
