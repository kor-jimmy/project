package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.GoodsFilesVo;

public interface GoodsFilesDao {
	
	public int insert(GoodsFilesVo bfv);
	
	public int delete(String uuid);
	
	//게시물 삭제시 파일 테이블 삭제
	public int deleteByGno(int g_no);
	
	public List<GoodsFilesVo> findByGno(int gno);
	
	public List<GoodsFilesVo> checkFiles();
}
