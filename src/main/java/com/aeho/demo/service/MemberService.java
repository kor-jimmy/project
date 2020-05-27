package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.domain.Criteria;
import com.aeho.demo.vo.MemberVo;

public interface MemberService {

	List<MemberVo> listMember();
	
	MemberVo getMember(String m_id);
	
	int insertMember(MemberVo mv);
	
	int updateMember(MemberVo mv);
	
	int deleteMember(MemberVo mv);
	
	MemberVo getMemberByNick(String m_nick);
	
	int totalMember();
	
	List<MemberVo> getListWithPaging(Criteria cri);
	
	int updateMemberState(MemberVo mv);
}
