package com.aeho.demo.dao;

import com.aeho.demo.vo.LoveVo;

public interface LoveDao {
	
	int insertLove(LoveVo lv);
	
	int deleteLove(int l_no);
	
	int isChecked(LoveVo lv);
	
	int getLoveNum(LoveVo lv);
	
}
