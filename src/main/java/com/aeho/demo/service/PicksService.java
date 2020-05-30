package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.PicksVo;

public interface PicksService {
	
	List<PicksVo> listPicks();
	
	int insertPicks(PicksVo pv);
	

}
