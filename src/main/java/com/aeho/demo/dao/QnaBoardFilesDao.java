package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.QnaBoardFilesVo;

public interface QnaBoardFilesDao {

	public int insert(QnaBoardFilesVo qbfv);
	
	public int delete(String uuid);
	
	//게시물 삭제시 파일 테이블 삭제
	public int deleteByQbno(int qb_no);
	
	public List<QnaBoardFilesVo> findByQbno(int qbno);
	
	public List<QnaBoardFilesVo> checkFiles();
}
