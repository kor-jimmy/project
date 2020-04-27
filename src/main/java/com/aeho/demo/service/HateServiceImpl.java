package com.aeho.demo.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.aeho.demo.dao.HateDao;
import com.aeho.demo.vo.HateVo;

public class HateServiceImpl implements HateService {
	
	@Autowired
	private HateDao hateDao;

	@Override
	public int insertHate(HateVo hv) {
		int re = hateDao.insertHate(hv);
		return re;
	}

	@Override
	public int deleteHate(HateVo hv) {
		int re = hateDao.deleteHate(hv);
		return re;
	}
}
