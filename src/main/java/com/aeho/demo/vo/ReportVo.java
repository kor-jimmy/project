package com.aeho.demo.vo;

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
public class ReportVo {
	
	//신고 번호
	private int r_no;
	//신고 코드 번호( 게시물 / 굿즈 )
	private int rc_code;
	private String m_id;
	private int b_no;
	private int g_no;
}
