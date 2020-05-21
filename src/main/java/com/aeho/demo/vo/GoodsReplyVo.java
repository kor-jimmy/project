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
public class GoodsReplyVo {
	private int gr_no;
	private int g_no;
	private String m_id;
	private String gr_content;
	private Date gr_date;
	private int gr_ref;
	private int gr_level;
	private int gr_step;
	private String gr_refid;
	private int gr_reCnt;
	private int gr_state;
}

