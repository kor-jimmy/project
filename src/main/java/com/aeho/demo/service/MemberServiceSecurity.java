package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.MemberDao;
import com.aeho.demo.domain.Criteria;
import com.aeho.demo.security.MemberPrincipal;
import com.aeho.demo.vo.MemberVo;

@Service
public class MemberServiceSecurity implements MemberService, UserDetailsService {
	
	@Autowired
	private MemberDao memberDao;
	
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
		return memberDao.getMember(m_id);
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
		return memberDao.updateMember(mv);
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
	public int totalMember() {
		return memberDao.totalMember();
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
	
	

}
