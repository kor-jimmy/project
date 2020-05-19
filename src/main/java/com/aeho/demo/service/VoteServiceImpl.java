package com.aeho.demo.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.VoteDao;
import com.aeho.demo.dao.VoteTopicDao;
import com.aeho.demo.vo.VoteVo;

@Service
public class VoteServiceImpl implements VoteService {
	
	@Autowired
	private VoteDao voteDao;
	@Autowired
	private VoteTopicDao voteTopicDao;

	@Override
	public List<VoteVo> listVote() {
		// TODO Auto-generated method stub
		return voteDao.listVote();
	}

	@Override
	public VoteVo getVote(VoteVo vv) {
		// TODO Auto-generated method stub
		return voteDao.getVote(vv);
	}

	@Override
	public int insertVote(VoteVo vv) {
		// TODO Auto-generated method stub
		int result_insertVote = voteDao.insertVote(vv);
		int result_updateCount = voteTopicDao.updateCount(vv.getVt_no());

		int result = 0;
		if(result_insertVote > 0 && result_updateCount > 0) {
			result = 1;
		}
		return result;
	}

	@Override
	public int updateVote(VoteVo vv) {
		// TODO Auto-generated method stub
		int re = 0;
		int result_updateVote = voteDao.updateVote(vv);
		int result_updateVoteTopic = voteTopicDao.updateCount(vv.getVt_no());
		
		if(result_updateVote > 0 && result_updateVoteTopic > 0) {
			re = 1;
		}
		return re;
	}

	@Override
	public int deleteVote(VoteVo vv) {
		// TODO Auto-generated method stub
		int re = voteDao.deleteVote(vv);
		return re;
	}

	@Override
	public List<VoteVo> isChecked(VoteVo vv) {
		// TODO Auto-generated method stub
		return voteDao.isChecked(vv);
	}

	@Override
	public List<VoteVo> findByVoteTopic(VoteVo vv) {
		return voteDao.findByVoteTopic(vv);
	}

}
