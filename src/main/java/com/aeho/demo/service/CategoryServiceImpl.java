package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.aeho.demo.dao.CategoryDao;
import com.aeho.demo.vo.CategoryVo;

public class CategoryServiceImpl implements CategoryService {
	@Autowired
	public CategoryDao categoryDao;
	
	@Override
	public List<CategoryVo> listCategory() {
		return categoryDao.listCategory();
	}

	@Override
	public CategoryVo getCategory(CategoryVo cv) {
		return categoryDao.getCategory(cv);
	}

	@Override
	public int insertCategory(CategoryVo cv) {
		int re = categoryDao.insertCategory(cv);
		return re;
	}

	@Override
	public int updateCategory(CategoryVo cv) {
		int re = categoryDao.updateCategory(cv);
		return re;
	}

	@Override
	public int deleteCategory(CategoryVo cv) {
		int re = categoryDao.deleteCategory(cv);
		return re;
	}

}
