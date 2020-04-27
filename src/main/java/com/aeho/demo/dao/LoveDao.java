package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.LoveVo;

public interface LoveDao {

	List<LoveVo> listLove();
	
	int insertLove();
	
	int updateLove();
	
	int deleteLove();
	
}
