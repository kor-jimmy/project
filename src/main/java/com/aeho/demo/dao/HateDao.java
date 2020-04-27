package com.aeho.demo.dao;

import com.aeho.demo.vo.HateVo;

public interface HateDao {
	
	int insertHate(HateVo hv);
	
	int deleteHate(HateVo hv);
}
