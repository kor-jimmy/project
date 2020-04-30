package com.aeho.demo.service;

import com.aeho.demo.vo.HateVo;

public interface HateService {	
	
	int insertHate(HateVo hv);
	
	int deleteHate(int h_no);
	
	int isChecked(HateVo hv);
	
	int getHateNum(HateVo hv);
}
