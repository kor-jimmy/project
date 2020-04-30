package com.aeho.demo.service;

import com.aeho.demo.vo.HateVo;

public interface HateService {	
	
	int insertHate(HateVo hv);
	
	int deleteHate(HateVo hv);
	
	int isChecked(HateVo hv);
}
