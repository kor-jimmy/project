package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.CategoryDao;
import com.aeho.demo.vo.CategoryVo;

@Service
public class CategoryServiceImpl implements CategoryService {
	@Autowired
	public CategoryDao categoryDao;
	
	@Override
	public List<CategoryVo> listCategory() {
		return categoryDao.listCategory();
	}

	@Override
	public CategoryVo getCategory(int c_no) {
		return categoryDao.getCategory(c_no);
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

	@Override
	public List<CategoryVo> listGoodsCategory() {
		return categoryDao.listGoodsCategory();
	}

}
