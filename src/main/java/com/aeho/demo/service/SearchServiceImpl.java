package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.SearchDao;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.CategoryVo;
import com.aeho.demo.vo.GoodsVo;

@Service
public class SearchServiceImpl implements SearchService {
	
	@Autowired
	private SearchDao s_dao;

	@Override
	public List<CategoryVo> getCategory(String keyword) {
		return s_dao.getCategory(keyword);
	}

	@Override
	public List<BoardVo> getBoard(String keyword) {
		return s_dao.getBoard(keyword);
	}

	@Override
	public List<GoodsVo> getGoods(String keyword) {
		return s_dao.getGoods(keyword);
	}
	

}
