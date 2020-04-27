package com.aeho.demo.vo;

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
	private String gr_date;
}
