package com.aeho.demo.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.QnaBoardDao;
import com.aeho.demo.dao.QnaBoardFilesDao;
import com.aeho.demo.domain.Criteria;
import com.aeho.demo.domain.Criteria3;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.QnaBoardFilesVo;
import com.aeho.demo.vo.QnaBoardVo;

@Service
public class QnaBoardServiceImpl implements QnaBoardService {
	
	@Autowired
	private QnaBoardDao qnaBoardDao;
	@Autowired
	private QnaBoardFilesDao qnaBoardFilesDao;
	
	@Override
	public List<QnaBoardVo> listQnaBoard() {
		return qnaBoardDao.listQnaBoard();
	}

	@Override
	public QnaBoardVo getQnaBoard(int pno) {
		// TODO Auto-generated method stub
		return qnaBoardDao.getQnaBoard(pno);
	}

	@Override
	public int insertQnaBoard(QnaBoardVo qbv) {
		int re = qnaBoardDao.insertQnaBoard(qbv);
		return re;
	}

	@Override
	public int updateQnaBoard(QnaBoardVo qbv) {
		int re = qnaBoardDao.updateQnaBoard(qbv);
		List<QnaBoardFilesVo> fileList = qnaBoardFilesDao.findByQbno(qbv.getQb_no());
		for(QnaBoardFilesVo qbfv:fileList) {
			String up_qb_content = qbv.getQb_content();
			if(!up_qb_content.contains(qbfv.getUuid())) {
				qnaBoardFilesDao.delete(qbfv.getUuid());
			}
		}
		return re;
	}

	@Override
	public int deleteQnaBoard(QnaBoardVo qbv) {
		int result=0;
		if(qnaBoardFilesDao.findByQbno(qbv.getQb_no())!=null) {
			int result_files=qnaBoardFilesDao.deleteByQbno(qbv.getQb_no());	
		}
		int result_qnaBoard = qnaBoardDao.deleteQnaBoard(qbv);
		if(result_qnaBoard > 0)
			result = 1;
		return result;
	}

	@Override
	public List<QnaBoardVo> getListWithPaging(Criteria3 cri) {
		return qnaBoardDao.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria3 cri) {
		return qnaBoardDao.getTotalCount(cri);
	}

	@Override
	public int replyInsert(QnaBoardVo qbv) {
		int re = -1;
		re = qnaBoardDao.replyInsert(qbv);
		return re;
	}

	@Override
	public int updateStep(HashMap map) {
		return qnaBoardDao.updateStep(map);
	}
}
