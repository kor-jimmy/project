package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.MemberVo;

public interface MemberDao {
	
	List<MemberVo> listMember();
	
	MemberVo getMemeber();
	
	int insertMember();
	
	int updateMember();
	
	int deleteMember();
	

}
