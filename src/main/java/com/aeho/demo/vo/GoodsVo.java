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
public class GoodsVo {
	private int g_no;
	//상품 코드 분류  
	private int gc_code;
	private String m_id;
	private String g_title;
	private String g_content;
	private int g_price;
	private Date g_date;
	private Date g_updatedate;
	private int g_replycnt;
	private int c_no;
	private String m_nick;
	private String c_dist;
}

