package com.aeho.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aeho.demo.dao.AlarmDao;
import com.aeho.demo.dao.BoardDao;
import com.aeho.demo.dao.LoveDao;
import com.aeho.demo.dao.MemberDao;
import com.aeho.demo.vo.AlarmVo;
import com.aeho.demo.vo.LoveVo;

@Service
public class LoveServiceImpl implements LoveService {

	@Autowired
	private LoveDao loveDao;
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private AlarmDao alarmDao;
	
	@Autowired
	private MemberDao memberDao;
	
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
		
		//진탁) 06-09댓글 알람 등록
		//본인 작성글이면 알람안되게!
		//b_no로 작성자를 찾는거
		String writer = boardDao.boardAlarm(lv.getB_no()).getM_id();
		if(!writer.equals(lv.getM_id())) {
			AlarmVo alarmVo = new AlarmVo();
			//댓글은 1번 좋아요는 2번 싫어요는 3번
			alarmVo.setAc_code(2);
			alarmVo.setB_no(lv.getB_no());
			alarmVo.setClickid(lv.getM_id());
			alarmVo.setM_id(writer);
			int alarmResult = alarmDao.insertBoardAlarm(alarmVo);
		}
		
		return result;
	}

	@Override
	public int deleteLove(LoveVo lv) {
		int result = 0;
		String cntkeyword = "love";
		try {
			int result_love = loveDao.deleteLove(lv);
			int result_board = boardDao.updateCnt(lv.getB_no(), cntkeyword);
			
			if( result_board > 0 && result_love > 0 ) {
				result = 1;
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return result;
	}

	@Override
	public int isChecked(LoveVo lv) {
		int re = 0;
		if( loveDao.isChecked(lv) > 0 ) {
			re = 1;
		} 
		return re;
	}

}
