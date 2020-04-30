package com.aeho.demo.dao;

import com.aeho.demo.vo.HateVo;
import com.aeho.demo.vo.LoveVo;

public interface HateDao {
	
	int insertHate(HateVo hv);
	
	int deleteHate(HateVo hv);
	
	int isChecked(HateVo hv);
}
