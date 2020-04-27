package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.HateVo;

public interface HateDao {

	List<HateVo> listHate();
	
	int insertHate();
	
	int updateHate();
	
	int deleteHate();
}
