package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.ScheduleVo;

public interface ScheduleService {
	
	List<ScheduleVo> listSchedule();
	
	ScheduleVo getSchedule(ScheduleVo sv);
	
	int insertSchedule(ScheduleVo sv);

	int updateSchedule(ScheduleVo sv);
	
	int deleteSchedule(ScheduleVo sv);
}
