package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.domain.Criteria;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.LogVo;

public interface LogDao {
	int insertLog(LogVo logVo);
	
	List<LogVo> listLogs();
}
