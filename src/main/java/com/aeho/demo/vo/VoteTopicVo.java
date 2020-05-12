package com.aeho.demo.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class VoteTopicVo {
	//투표 주제 번호
	private int vt_no;
	//투표 상태 번호
	private int vs_no;
	private String vt_content;
	private Date vt_start;
	private Date vt_end;
}
