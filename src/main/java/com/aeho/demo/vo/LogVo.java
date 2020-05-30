package com.aeho.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class LogVo {
	private int log_no;
	private String log_ip;
	private String log_uri;
	private String log_time;
	
	
	private int cnt;
}
