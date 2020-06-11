package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.domain.Criteria;
import com.aeho.demo.vo.MemberVo;

public interface MemberDao {
	
	List<MemberVo> listMember();
	
	MemberVo getMember(String m_id);
	
	//로그인을 하는 ajax를 하기전 회원의 계정 상태여부를 보기위한거
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
	
	int updateLove(String m_id, int m_lovecnt);
	
	int updateHate(String m_id, int m_hatecnt);
	
	List<MemberVo> getMemberByEmail(String email);
}
