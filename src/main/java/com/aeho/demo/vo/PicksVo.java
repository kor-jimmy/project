package com.aeho.demo.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PicksVo {

	private int p_no;
	private String p_keyword;
	private Date p_date;
	
	private int cnt;
}
