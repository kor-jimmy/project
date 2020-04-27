package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.CategoryVo;

public interface CategoryDao {
	
	List<CategoryVo> listCategory();
	
	CategoryVo getCategory(CategoryVo cv);
	
	int insertCategory(CategoryVo cv);
	
	int updateCategory(CategoryVo cv);

	int deleteCategory(CategoryVo cv);
}
