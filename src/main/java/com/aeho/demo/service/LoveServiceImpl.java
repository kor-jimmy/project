package com.aeho.demo.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.aeho.demo.dao.LoveDao;
import com.aeho.demo.vo.LoveVo;

public class LoveServiceImpl implements LoveService {

	@Autowired
	private LoveDao loveDao;
	
	@Override
	public int insertLove(LoveVo lv) {
		int re = loveDao.insertLove(lv);
		return re;
	}

	@Override
	public int deleteLove(LoveVo lv) {
		int re = loveDao.deleteLove(lv);
		return re;
	}

}
