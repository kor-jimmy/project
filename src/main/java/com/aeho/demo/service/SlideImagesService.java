package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.SlideImagesVo;

public interface SlideImagesService {

	List<SlideImagesVo> listSlideImages();
	
	SlideImagesVo getSlideImages(int s_no);
	
	int insertSlideImages(SlideImagesVo sv);
	
	int updateSlideImages(SlideImagesVo sv);
	
	int deleteSlideImages(int s_no);
}
