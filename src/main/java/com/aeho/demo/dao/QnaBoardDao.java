package com.aeho.demo.dao;

import java.util.HashMap;
import java.util.List;

import com.aeho.demo.domain.Criteria;
import com.aeho.demo.domain.Criteria3;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.QnaBoardVo;

public interface QnaBoardDao {
	List<QnaBoardVo> listQnaBoard();
	//상세보기
	QnaBoardVo getQnaBoard(int pno);
	//등록
	int insertQnaBoard(QnaBoardVo qbv);	
	//수정
	int updateQnaBoard(QnaBoardVo qbv);	
	//삭제
	int deleteQnaBoard(QnaBoardVo qbv);	
	//답변등록
	int replyInsert(QnaBoardVo qbv);
	//페이징 된 모든 리스트
	List<QnaBoardVo> getListWithPaging(Criteria3 cri);		
	//총 페이지
	int getTotalCount(Criteria3 cri);
	
	List<QnaBoardVo> listCatBoard(String catKeyword);
	//step+1
	int updateStep(HashMap map);
	
	int updateQnAWhereID(String m_id);

}
