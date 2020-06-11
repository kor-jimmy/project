package com.aeho.demo.dao;

import com.aeho.demo.vo.LoveVo;

public interface LoveDao {
	
	int insertLove(LoveVo lv);
	
	int deleteLove(LoveVo lv);
	
	int isChecked(LoveVo lv);
	
	int deleteLoveByID(String m_id);
	
}
