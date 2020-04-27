package com.aeho.demo.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ScheduleVo {

	private int s_no;
	private String s_title;
	private String s_content;
	private Date s_ontime;
	private String s_img;
}
