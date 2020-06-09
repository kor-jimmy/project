package com.aeho.demo.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AlarmVo {
	private int a_no;
	private String m_id;
	private int b_no;
	private int g_no;
	private String a_check;
	private Date a_time;
	private int ac_code;
	private String clickid;
	
}
