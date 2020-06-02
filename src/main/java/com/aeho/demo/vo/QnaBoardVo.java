package com.aeho.demo.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class QnaBoardVo {

	private int qb_no;
	private String m_id;
	private int c_no;
	private String qb_title;
	private String qb_content;
	private Date qb_date;
	private Date qb_updatedate;
	private int qb_ref;
	private int qb_level;
	private int qb_step;
	
	private List<QnaBoardFilesVo> fileList;
	private String c_dist;
}
