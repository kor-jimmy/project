package com.aeho.demo.service;

import com.aeho.demo.vo.LoveVo;

public interface LoveService {
	
	int insertLove(LoveVo lv);
	
	int deleteLove(LoveVo lv);
	
	int isChecked(LoveVo lv);

}
