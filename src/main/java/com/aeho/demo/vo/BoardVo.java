package com.aeho.demo.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class BoardVo {
	private int b_no;
	private String m_id;
	private int c_no;
	private String b_title;
	private String b_content;
	private Date b_date;
	private Date b_updatedate;
	private int b_hit;
	private int b_replycnt;
	private int b_lovecnt;
	private int b_hatecnt;
	
	//vo에 파일 리스트 추가.
	private List<BoardFilesVo> fileList;
	//메인에 뿌려주기 위해 카테고리 아이디 추가
	private String c_dist;
}
