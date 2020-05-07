package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.BoardFilesVo;

public interface BoardFilesDao {
	
	public int insert(BoardFilesVo bfv);
	
	public int delete(String uuid);
	
	public List<BoardFilesVo> findByBno(int bno);
}
