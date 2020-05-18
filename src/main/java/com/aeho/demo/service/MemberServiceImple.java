package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.MemberDao;
import com.aeho.demo.vo.MemberVo;

@Service
public class MemberServiceImple implements MemberService {

	@Autowired
	private MemberDao m_dao;
	
	@Override
	public List<MemberVo> listMember() {
		return m_dao.listMember();
	}

	@Override
	public MemberVo getMember(String m_id) {
		return m_dao.getMember(m_id);
	}

	@Override
	public int insertMember(MemberVo mv) {
		return m_dao.insertMember(mv);
	}

	@Override
	public int updateMember(MemberVo mv) {
		return m_dao.updateMember(mv);
	}

	@Override
	public int deleteMember(MemberVo mv) {
		return m_dao.deleteMember(mv);
	}

	@Override
	public MemberVo getMemberByNick(String m_nick) {
		// TODO Auto-generated method stub
		return m_dao.getMemberByNick(m_nick);
	}
}
