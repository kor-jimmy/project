package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.SlideimagesDao;
import com.aeho.demo.vo.SlideImagesVo;

@Service
public class SlideImagesServiceImpl implements SlideImagesService {

	@Autowired
	private SlideimagesDao s_dao;
	
	@Override
	public List<SlideImagesVo> listSlideImages() {
		return s_dao.listSlideImages();
	}
	
	@Override
	public SlideImagesVo getSlideImages(int s_no) {
		return s_dao.getSlideImages(s_no);
	}

	@Override
	public int insertSlideImages(SlideImagesVo sv) {
		return s_dao.insertSlideImages(sv);
	}

	@Override
	public int updateSlideImages(SlideImagesVo sv) {
		// TODO Auto-generated method stub
		return s_dao.updateSlideImages(sv);
	}

	@Override
	public int deleteSlideImages(int s_no) {
		return s_dao.deleteSlideImages(s_no);
	}
}
