package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.KeepVo;

public interface KeepDao {

	List<KeepVo> listKeep();
	
	KeepVo getKeep(KeepVo kv);
	
	int insertKeep(KeepVo kv);
	
	int updateKeep(KeepVo kv);
	
	int deleteKeep(KeepVo kv);
}
