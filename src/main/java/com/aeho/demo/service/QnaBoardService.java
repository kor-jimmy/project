package com.aeho.demo.service;

import java.util.HashMap;
import java.util.List;

import com.aeho.demo.domain.Criteria;
import com.aeho.demo.domain.Criteria3;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.QnaBoardVo;

public interface QnaBoardService {

	List<QnaBoardVo> listQnaBoard();
	
	QnaBoardVo getQnaBoard(int pno);
		
	int insertQnaBoard(QnaBoardVo qbv);
	
	int updateQnaBoard(QnaBoardVo qbv);
	
	int deleteQnaBoard(QnaBoardVo qbv);
	
	List<QnaBoardVo> getListWithPaging(Criteria3 cri);
	
	int getTotalCount(Criteria3 cri);
	
	int replyInsert(QnaBoardVo qbv);
	
	int updateStep(HashMap map);
}
