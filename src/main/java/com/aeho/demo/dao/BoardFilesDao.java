package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.BoardFilesVo;

public interface BoardFilesDao {
	
	public void insert(BoardFilesVo bfv);
	
	public void delete(String uuid);
	
	public List<BoardFilesVo> findByBno(int bno);
}
