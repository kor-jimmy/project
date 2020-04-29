package com.aeho.demo.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class GoodsReplyVo {
	private int gr_no;
	private int g_no;
	private String m_id;
	private String gr_content;
	private Date gr_date;
}

