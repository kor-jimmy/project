package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.CategoryVo;

public interface CategoryService {
	List<CategoryVo> listCategory();
	
	List<CategoryVo> listGoodsCategory();
	
	List<CategoryVo> listQnaBoardCategory();
	
	CategoryVo getCategory(int c_no);
	
	int insertCategory(CategoryVo cv);
	
	int updateCategory(CategoryVo cv);

	int deleteCategory(CategoryVo cv);
	
	List<CategoryVo> popCategory();
	
}
