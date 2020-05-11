package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.BoardFilesVo;
import com.aeho.demo.vo.GoodsFilesVo;

public interface GoodsFilesSevice {
	public int insert(GoodsFilesVo bfv);
	
	public int delete(String uuid);
	
	public List<GoodsFilesVo> findByGno(int gno);
	
	public int deleteByGno(int g_no);
	
	public List<GoodsFilesVo> checkFiles();
}
