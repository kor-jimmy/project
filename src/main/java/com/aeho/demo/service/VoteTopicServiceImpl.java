package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.VoteDao;
import com.aeho.demo.dao.VoteTopicDao;
import com.aeho.demo.vo.VoteTopicVo;
import com.aeho.demo.vo.VoteVo;

@Service
public class VoteTopicServiceImpl implements VoteTopicService {

	@Autowired
	private VoteTopicDao votetopicDao;
	@Autowired
	private VoteDao voteDao;
	
	@Override
	public List<VoteTopicVo> listVoteTopic() {
		// TODO Auto-generated method stub
		return votetopicDao.listVoteTopic();
	}
	
	@Override
	public List<VoteTopicVo> ongoingListVoteTopic() {
		// TODO Auto-generated method stub
		return votetopicDao.ongoingListVoteTopic();
	}

	@Override
	public List<VoteTopicVo> endedListVoteTopic() {
		// TODO Auto-generated method stub
		return votetopicDao.endedListVoteTopic();
	}

	@Override
	public VoteTopicVo getVoteTopic(int vt_no) {
		// TODO Auto-generated method stub
		return votetopicDao.getVoteTopic(vt_no);
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
		int re = 0;
		int result_deleteV = 0;
		VoteVo vv = new VoteVo();
		vv.setVt_no(vtv.getVt_no());
		if(voteDao.findByVoteTopic(vv).size() > 0) {
			result_deleteV = voteDao.deleteVote(vv);
			System.out.println("투표 삭제 결과: " + result_deleteV);
		}else if(voteDao.findByVoteTopic(vv).size() == 0){
			result_deleteV = 1;
		}
		 
		System.out.println("voteDao.findByVoteTopic(vv): " + voteDao.findByVoteTopic(vv));
		int result_deleteVT = votetopicDao.deleteVoteTopic(vtv);

		if( result_deleteVT > 0 && result_deleteV > 0) {
			re = 1;
		}
		
		System.out.println(re);
		return re;
	}

	@Override
	public int updateVoteTopic(VoteTopicVo vtv) {
		// TODO Auto-generated method stub
		return votetopicDao.updateVoteTopic(vtv);
	}

}
