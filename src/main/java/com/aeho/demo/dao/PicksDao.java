package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.PicksVo;

public interface PicksDao {

	List<PicksVo> listPicks();
	
	int insertPicks(PicksVo pv);
}
