package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.MainDao;
import com.aeho.demo.domain.CategoryDTO;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.CategoryVo;

@Service
public class MainServiceImpl implements MainServcie {
	
	@Autowired
	private MainDao mainDao;
	
	@Override
	public List<BoardVo> todayBest() {
		// TODO Auto-generated method stub
		return mainDao.todayBest();
	}

	@Override
	public List<BoardVo> weekBest() {
		// TODO Auto-generated method stub
		return mainDao.weekBest();
	}

	@Override
	public List<BoardVo> monthBest() {
		// TODO Auto-generated method stub
		return mainDao.monthBest();
	}

	@Override
	public List<CategoryVo> menuCategory(CategoryDTO categoryDTO) {
		// TODO Auto-generated method stub
		return mainDao.menuCategory(categoryDTO);
	}

}
