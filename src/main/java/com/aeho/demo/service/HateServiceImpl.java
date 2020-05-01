package com.aeho.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aeho.demo.dao.BoardDao;
import com.aeho.demo.dao.HateDao;
import com.aeho.demo.vo.HateVo;

@Service
public class HateServiceImpl implements HateService {
	
	@Autowired
	private HateDao hateDao;
	
	@Autowired
	private BoardDao boardDao;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertHate(HateVo hv) {
		int result = 0;
		String cntkeyword = "hate";
		//hate 증가시 board에서 hatecnt 동시 증가 트랜잭션
		try {
			int result_hate = hateDao.insertHate(hv);
			int result_board = boardDao.updateCnt(hv.getB_no(), cntkeyword);
			
			if( result_board > 0 && result_hate > 0) {
				result = 1;
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteHate(HateVo hv) {
		int result = 0;
		String cntkeyword = "minusHate";
		try {
			int result_hate = hateDao.deleteHate(hv);
			int result_board = boardDao.updateCnt(hv.getB_no(), cntkeyword);
			
			if(result_board > 0 && result_hate > 0) {
				result = 1;
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return result;
	}

	@Override
	public int isChecked(HateVo hv) {
		int re = 0;
		if( hateDao.isChecked(hv) > 0 ) {
			re = 1;
		} 
		return re;
	}

}
