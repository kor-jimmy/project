package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.KeepVo;

public interface KeepService {

	List<KeepVo> listKeep(KeepVo kv);
	int insertKeep(KeepVo kv);
	int deleteKeep(KeepVo kv);
}
