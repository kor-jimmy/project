package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aeho.demo.dao.AlarmDao;
import com.aeho.demo.dao.BoardDao;
import com.aeho.demo.dao.GoodsDao;
import com.aeho.demo.dao.GoodsReplyDao;
import com.aeho.demo.dao.HateDao;
import com.aeho.demo.dao.LoveDao;
import com.aeho.demo.dao.MemberDao;
import com.aeho.demo.dao.QnaBoardDao;
import com.aeho.demo.dao.ReplyDao;
import com.aeho.demo.dao.ReportDao;
import com.aeho.demo.dao.VoteDao;
import com.aeho.demo.domain.Criteria;
import com.aeho.demo.security.MemberPrincipal;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.GoodsVo;
import com.aeho.demo.vo.MemberVo;
import com.aeho.demo.vo.ReplyVo;
import com.aeho.demo.vo.ReportVo;

@Service
public class MemberServiceSecurity implements MemberService, UserDetailsService {
	
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private ReportDao reportDao;
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	private GoodsReplyDao goodaReplyDao;
	@Autowired
	private ReplyDao replyDao;
	@Autowired
	private AlarmDao alarmDao;
	@Autowired
	private VoteDao voteDao;
	@Autowired
	private QnaBoardDao qnaboardDao;
	@Autowired
	private LoveDao loveDao;
	@Autowired
	private HateDao hateDao;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("접속시도한 로그인 아이디 확인 ==>" + username);
		MemberVo memberVo = memberDao.getMember(username);
		if(memberVo == null) {
			throw new UsernameNotFoundException(username+" id는 존재하지 않는 아이디 입니다!");
		}
		return new MemberPrincipal(memberVo);
	}
	
	@Override
	public List<MemberVo> listMember() {
		return memberDao.listMember();
	}

	@Override
	public MemberVo getMember(String m_id) {
		int m_lovecnt = boardDao.loveTotal(m_id);
		int hateTotal = boardDao.hateTotal(m_id);
		memberDao.updateLove(m_id, m_lovecnt);
		memberDao.updateHate(m_id, hateTotal);
		
		return memberDao.getMember(m_id);
	}
	
	@Override
	public List<MemberVo> getMemberByEmail(String email) {
		return memberDao.getMemberByEmail(email);
	}

	@Override
	public int insertMember(MemberVo mv) {
		System.out.println(mv.getM_pwd());
		mv.setM_pwd(passwordEncoder.encode(mv.getM_pwd()));
		System.out.println(mv.getM_pwd());
		return memberDao.insertMember(mv);
	}
	

	@Override
	public int updateMember(MemberVo mv) {
		int re = 0;
		/*
		String m_id = mv.getM_id();
		MemberVo member = memberDao.getMember(m_id);
		//입력받은 암호와 저장된 암호 비교
		boolean pwdChk = passwordEncoder.matches(mv.getM_pwd(), member.getM_pwd());
		//입력받은 비밀번호가 올바르면 받아온 정보들로 update를 진행한다
		//이때, newPwd값이 null이 아니라면 pwd에 newPwd값을 set해주어 비밀번호 수정
		if(pwdChk) {
			if(mv.getNewPwd() != null) {
				mv.setM_pwd(mv.getNewPwd());
			}
			re = memberDao.updateMember(mv);
		}
		*/
		MemberVo member = memberDao.getMember(mv.getM_id());
		if(mv.getM_pwd() == null || mv.getM_pwd() == "") {
			mv.setM_pwd(member.getM_pwd());
		}
		if(mv.getM_nick() == null || mv.getM_nick() == "") {
			mv.setM_nick(member.getM_nick());
		}
		mv.setM_pwd(passwordEncoder.encode(mv.getM_pwd()));
		re = memberDao.updateMember(mv);
		return re;
	}

	@Override
	public int deleteMember(MemberVo mv) {
		return memberDao.deleteMember(mv);
	}
	
	@Override
	public MemberVo getMemberByNick(String m_nick) {
		return memberDao.getMemberByNick(m_nick);
	}

	@Override
	public int totalMember(Criteria cri) {
		return memberDao.totalMember(cri);
	}

	@Override
	public List<MemberVo> getListWithPaging(Criteria cri) {
		// TODO Auto-generated method stub
		return memberDao.getListWithPaging(cri);
	}

	@Override
	public int updateMemberState(MemberVo mv) {
		// TODO Auto-generated method stub
		return memberDao.updateMemberState(mv);
	}

	@Override
	public MemberVo checkMemberState(MemberVo mv) {
		// TODO Auto-generated method stub
		return memberDao.checkMemberState(mv);
	}

	@Override
	public int updateRelease(MemberVo mv) {
		// TODO Auto-generated method stub
		return memberDao.updateRelease(mv);
	}

	@Override
	public int updateProfileImage(MemberVo mv) {
		return memberDao.updateProfileImage(mv);
	}

	@Override
	@Transactional(rollbackFor=Exception.class)
	public int deleteMember(String m_id) {
		int re = 0;
		
		try {
			//해당 회원의 게시물, 댓글, 굿즈, 신고, 좋아요, 싫어요 모두 탈퇴회원으로 변경
			boardDao.updateBoardWhereID(m_id);
			goodsDao.updateGoodsWhereID(m_id);
			replyDao.updateReplyWhereID(m_id);
			reportDao.updateReportWhereID(m_id);
			goodaReplyDao.updateGoodsReplyWhereID(m_id);
			qnaboardDao.updateQnAWhereID(m_id);
			voteDao.updateVoteWhereID(m_id);
			alarmDao.updateAlarmWhereID(m_id);
			//좋아요, 싫어요는 삭제처리
			loveDao.deleteLoveByID(m_id);
			hateDao.deleteHateByID(m_id);

			//이후 삭제
			re = memberDao.deleteMember(m_id);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return re;
	}
	

}
