package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.BoardFilesVo;

public interface BoardFilesSevice {
	public int insert(BoardFilesVo bfv);
	
	public int delete(String uuid);
	
	public List<BoardFilesVo> findByBno(int bno);
	
	public int deleteByBno(int b_no);
}
