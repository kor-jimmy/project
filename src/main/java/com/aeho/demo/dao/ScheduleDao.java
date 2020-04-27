package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.ScheduleVo;

public interface ScheduleDao {

	List<ScheduleVo> listSchedule();
	
	int insertSchedule(ScheduleVo sv);

	int updateSchedule(ScheduleVo sv);
	
	int deleteSchedule(ScheduleVo sv);
}
