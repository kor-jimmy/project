package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.BoardFilesVo;

public interface BoardFilesDao {
	
	public int insert(BoardFilesVo bfv);
	
	public int delete(String uuid);
	
	//게시물 삭제시 파일 테이블 삭제
	public int deleteByBno(int b_no);
	
	public List<BoardFilesVo> findByBno(int bno);
	
	public List<BoardFilesVo> checkFiles();
}
