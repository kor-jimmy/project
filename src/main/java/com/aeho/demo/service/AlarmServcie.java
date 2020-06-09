package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.AlarmVo;

public interface AlarmServcie {

	int insertBoardAlarm(AlarmVo alarmVo);
	
	int insertGoodsAlarm(AlarmVo alarmVo);
	
	List<AlarmVo> listAlarm(String m_id);
	
	int updateCheck(int a_no);
}
