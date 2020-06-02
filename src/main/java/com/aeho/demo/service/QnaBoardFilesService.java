package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.QnaBoardFilesVo;

public interface QnaBoardFilesService {
	
	public int insert(QnaBoardFilesVo qbfv);
	
	public int delete(String uuid);
	
	public List<QnaBoardFilesVo> findByQbno(int qbno);
	
	public int deleteByQbno(int qb_no);
	
	public List<QnaBoardFilesVo> checkFiles();

}
