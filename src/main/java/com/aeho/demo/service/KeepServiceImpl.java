package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.KeepDao;
import com.aeho.demo.vo.KeepVo;

@Service
public class KeepServiceImpl implements KeepDao {

	@Autowired
	private KeepDao keepDao;
	
	@Override
	public List<KeepVo> listKeep(KeepVo kv) {
		return keepDao.listKeep(kv);
	}

	@Override
	public int insertKeep(KeepVo kv) {
		int re = keepDao.insertKeep(kv);
		return re;
	}

	@Override
	public int deleteKeep(KeepVo kv) {
		int re = keepDao.deleteKeep(kv);
		return re;
	}

}
