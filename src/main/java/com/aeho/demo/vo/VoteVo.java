package com.aeho.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class VoteVo {
	private int v_no;
	private String m_id;
	private int vt_no;
	
	private int v_result;
	
}
