package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.PicksDao;
import com.aeho.demo.vo.PicksVo;

import lombok.Data;

@Service
@Data
public class PicksServiceImpl implements PicksService {

	@Autowired
	private PicksDao p_dao;
	
	@Override
	public List<PicksVo> listPicks() {
		return p_dao.listPicks();
	}

	@Override
	public int insertPicks(PicksVo pv) {
		return p_dao.insertPicks(pv);
	}

}
