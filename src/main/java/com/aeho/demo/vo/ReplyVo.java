package com.aeho.demo.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@AllArgsConstructor
@NoArgsConstructor
@Data
public class ReplyVo {

	private int r_no;
	private int b_no;
	private String m_id;
	private String r_content;
	private Date r_date;
}
