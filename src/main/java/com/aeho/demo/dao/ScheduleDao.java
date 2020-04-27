package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.ScheduleVo;

public interface ScheduleDao {

	List<ScheduleVo> listSchedule();
	
	int insertSchedult(ScheduleVo sv);

	int updateSchedult(ScheduleVo sv);
	
	int deleteSchedult(ScheduleVo sv);
}
