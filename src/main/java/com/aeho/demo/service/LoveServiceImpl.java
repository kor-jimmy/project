package com.aeho.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aeho.demo.dao.BoardDao;
import com.aeho.demo.dao.LoveDao;
import com.aeho.demo.vo.LoveVo;

@Service
public class LoveServiceImpl implements LoveService {

	@Autowired
	private LoveDao loveDao;
	
	@Autowired
	private BoardDao boardDao;
	
	@Override
	@Transactional(rollbackFor=Exception.class)
	public int insertLove(LoveVo lv) {
		int result = 0;
		String cntkeyword = "love";
		//love 증가시 board에서 lovecnt 동시 증가 트랜잭션
		try {
			int result_love = loveDao.insertLove(lv);
			int result_board = boardDao.updateCnt(lv.getB_no(), cntkeyword);
			
			if( result_board > 0 && result_love > 0) {
				result = 1;
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	@Override
	public int deleteLove(int l_no) {
		int re = loveDao.deleteLove(l_no);
		return re;
	}

	@Override
	public int isChecked(LoveVo lv) {
		int re = 0;
		if( loveDao.isChecked(lv) > 0 ) {
			re = 1;
		} 
		return re;
	}

	@Override
	public int getLoveNum(LoveVo lv) {
		int l_no = loveDao.getLoveNum(lv);
		return l_no;
	}

}
