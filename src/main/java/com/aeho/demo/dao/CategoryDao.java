package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.CategoryVo;

public interface CategoryDao {
	
	List<CategoryVo> listCategory();
	
	CategoryVo getCategory(int c_no);
	
	int insertCategory(CategoryVo cv);
	
	int updateCategory(CategoryVo cv);

	int deleteCategory(CategoryVo cv);

	List<CategoryVo> listGoodsCategory();
	
	List<CategoryVo> popCategory();
	
	List<CategoryVo> listQnaBoardCategory();
}
