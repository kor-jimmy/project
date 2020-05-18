package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.MemberVo;

public interface MemberDao {
	
	List<MemberVo> listMember();
	
	MemberVo getMember(String m_id);
	
	int insertMember(MemberVo mv);
	
	int updateMember(MemberVo mv);
	
	int deleteMember(MemberVo mv);
	
	MemberVo getMemberByNick(String m_nick);
}
