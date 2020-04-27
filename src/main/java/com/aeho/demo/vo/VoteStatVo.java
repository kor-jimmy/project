package com.aeho.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class VoteStatVo {
	//투표 상태
	private int vs_no;
	//투표 상태 분류 (진행중, 종료)
	private String vs_dist;
}
