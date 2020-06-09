package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.AlarmDao;
import com.aeho.demo.vo.AlarmVo;

@Service
public class AlarmServiceImpl implements AlarmServcie {

	@Autowired
	private AlarmDao alarmDao;
	
	@Override
	public int insertBoardAlarm(AlarmVo alarmVo) {
		// TODO Auto-generated method stub
		return alarmDao.insertBoardAlarm(alarmVo);
	}

	@Override
	public int insertGoodsAlarm(AlarmVo alarmVo) {
		// TODO Auto-generated method stub
		return alarmDao.insertGoodsAlarm(alarmVo);
	}

	@Override
	public List<AlarmVo> listAlarm(String m_id) {
		// TODO Auto-generated method stub
		System.out.println("알람서비스=>"+alarmDao.listAlarm(m_id));
		return alarmDao.listAlarm(m_id);
	}

	@Override
	public int updateCheck(int a_no) {
		// TODO Auto-generated method stub
		return alarmDao.updateCheck(a_no);
	}

	@Override
	public int deleteBoardAlarm(int b_no) {
		// TODO Auto-generated method stub
		return alarmDao.deleteBoardAlarm(b_no);
	}

	@Override
	public int deleteGoodsAlarm(int g_no) {
		// TODO Auto-generated method stub
		return alarmDao.deleteGoodsAlarm(g_no);
	}
	
	

}
