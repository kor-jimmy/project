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
@Data
public class ReplyVo {
	private int r_no;
	private int b_no;
	private String m_id;
	private String r_content;
	private String r_date;
	private int r_ref;
	private int r_level;
	private int r_step;
	private int r_reCnt;
	private int r_state;
}

