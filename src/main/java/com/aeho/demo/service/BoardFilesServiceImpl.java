package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.BoardFilesDao;
import com.aeho.demo.vo.BoardFilesVo;

@Service
public class BoardFilesServiceImpl implements BoardFilesSevice {

	@Autowired
	private BoardFilesDao boardFilesDao;
	
	@Override
	public int insert(BoardFilesVo bfv) {
		// TODO Auto-generated method stub
		int re  = boardFilesDao.insert(bfv);
		return re;
	}

	@Override
	public int delete(String uuid) {
		// TODO Auto-generated method stub
		int re = boardFilesDao.delete(uuid);
		return re;

	}

	@Override
	public List<BoardFilesVo> findByBno(int bno) {
		// TODO Auto-generated method stub
		List<BoardFilesVo> list = boardFilesDao.findByBno(bno);
		return list;
	}
	
	@Override
	public int deleteByBno(int b_no) {
		int re = boardFilesDao.deleteByBno(b_no);
		return re;
	}

	@Override
	public List<BoardFilesVo> checkFiles() {
		List<BoardFilesVo> list = boardFilesDao.checkFiles();
		return list;
	}

}
