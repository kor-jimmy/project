package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.VoteDao;
import com.aeho.demo.vo.VoteVo;

@Service
public class VoteServiceImpl implements VoteService {
	
	@Autowired
	private VoteDao voteDao;

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
		int re = voteDao.insertVote(vv);
		return re;
	}

	@Override
	public int updateVote(VoteVo vv) {
		// TODO Auto-generated method stub
		int re = voteDao.updateVote(vv);
		return re;
	}

	@Override
	public int deleteVote(VoteVo vv) {
		// TODO Auto-generated method stub
		int re = voteDao.deleteVote(vv);
		return re;
	}

}
