package com.aeho.demo.service;

import com.aeho.demo.vo.LoveVo;

public interface LoveService {
	
	int insertLove(LoveVo lv);
	
	int deleteLove(int l_no);
	
	int isChecked(LoveVo lv);
	
	int getLoveNum(LoveVo lv);
}
