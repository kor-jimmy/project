package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.CategoryVo;

public interface CategoryService {
	List<CategoryVo> listCategory();
	
	CategoryVo getCategory(CategoryVo cv);
	
	int insertCategory(CategoryVo cv);
	
	int updateCategory(CategoryVo cv);

	int deleteCategory(CategoryVo cv);
	
}
