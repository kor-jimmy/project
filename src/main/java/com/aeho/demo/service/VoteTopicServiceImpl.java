package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.VoteTopicDao;
import com.aeho.demo.vo.VoteTopicVo;

@Service
public class VoteTopicServiceImpl implements VoteTopicService {

	@Autowired
	private VoteTopicDao votetopicDao;
	
	@Override
	public List<VoteTopicVo> listVoteTopic() {
		// TODO Auto-generated method stub
		return votetopicDao.listVoteTopic();
	}

	@Override
	public VoteTopicVo getVoteTopic(VoteTopicVo vtv) {
		// TODO Auto-generated method stub
		return votetopicDao.getVoteTopic(vtv);
	}

	@Override
	public int insertVoteTopic(VoteTopicVo vtv) {
		// TODO Auto-generated method stub
		int re = votetopicDao.insertVoteTopic(vtv);
		return re;
	}

	@Override
	public int deleteVoteTopic(VoteTopicVo vtv) {
		// TODO Auto-generated method stub
		int re = votetopicDao.deleteVoteTopic(vtv);
		return re;
	}

}
