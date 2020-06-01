package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.SlideImagesVo;

public interface SlideimagesDao {

	List<SlideImagesVo> listSlideImages();
	
	SlideImagesVo getSlideImages(int s_no);
	
	int insertSlideImages(SlideImagesVo sv);
	
	int updateSlideImages(SlideImagesVo sv);
	
	int deleteSlideImages(int s_no);
}
