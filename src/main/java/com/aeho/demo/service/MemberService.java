package com.aeho.demo.service;

import java.util.List;


import com.aeho.demo.domain.Criteria;
import com.aeho.demo.vo.MemberVo;

public interface MemberService {

	List<MemberVo> listMember();
	
	MemberVo getMember(String m_id);
	
	MemberVo checkMemberState(MemberVo mv);
	
	int insertMember(MemberVo mv);
	
	int updateMember(MemberVo mv);
	
	int deleteMember(MemberVo mv);
	
	MemberVo getMemberByNick(String m_nick);
	
	int totalMember(Criteria cri);
	
	List<MemberVo> getListWithPaging(Criteria cri);
	
	int updateMemberState(MemberVo mv);
	
	int updateRelease(MemberVo mv);
	
	int updateProfileImage(MemberVo mv);
	
	List<MemberVo> getMemberByEmail(String email);
}
