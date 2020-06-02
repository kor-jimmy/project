package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.QnaBoardFilesDao;
import com.aeho.demo.vo.QnaBoardFilesVo;

@Service
public class QnaBoardFilesServiceImpl implements QnaBoardFilesService {

	@Autowired
	private QnaBoardFilesDao qnaBoardFilesDao;
	
	@Override
	public int insert(QnaBoardFilesVo qbfv) {
		// TODO Auto-generated method stub
		int re = qnaBoardFilesDao.insert(qbfv);
		return re;
	}

	@Override
	public int delete(String uuid) {
		// TODO Auto-generated method stub
		int re = qnaBoardFilesDao.delete(uuid);
		return re;
	}

	@Override
	public List<QnaBoardFilesVo> findByQbno(int qbno) {
		// TODO Auto-generated method stub
		List<QnaBoardFilesVo> list = qnaBoardFilesDao.findByQbno(qbno);
		return list;
	}

	@Override
	public int deleteByQbno(int qb_no) {
		// TODO Auto-generated method stub
		int re = qnaBoardFilesDao.deleteByQbno(qb_no);
		return re;
	}

	@Override
	public List<QnaBoardFilesVo> checkFiles() {
		// TODO Auto-generated method stub
		List<QnaBoardFilesVo> list = qnaBoardFilesDao.checkFiles();
		return list;
	}

}
