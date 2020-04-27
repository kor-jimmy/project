package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.ScheduleDao;
import com.aeho.demo.vo.ScheduleVo;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private ScheduleDao scheduleDao;
	
	@Override
	public List<ScheduleVo> listSchedule() {
		// TODO Auto-generated method stub
		return scheduleDao.listSchedule();
	}

	@Override
	public ScheduleVo getSchedule(ScheduleVo sv) {
		// TODO Auto-generated method stub
		return scheduleDao.getSchedule(sv);
	}

	@Override
	public int insertSchedule(ScheduleVo sv) {
		// TODO Auto-generated method stub
		int re = scheduleDao.insertSchedule(sv);
		return re;
	}

	@Override
	public int updateSchedule(ScheduleVo sv) {
		// TODO Auto-generated method stub
		int re = scheduleDao.updateSchedule(sv);
		return re;
	}

	@Override
	public int deleteSchedule(ScheduleVo sv) {
		// TODO Auto-generated method stub
		int re = scheduleDao.deleteSchedule(sv);
		return re;
	}

}
