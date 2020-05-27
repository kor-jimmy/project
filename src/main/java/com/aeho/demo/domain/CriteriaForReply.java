package com.aeho.demo.domain;

import java.util.Date;
import java.util.List;

import com.aeho.demo.vo.BoardFilesVo;
import com.aeho.demo.vo.BoardVo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
public class CriteriaForReply {
	private int pageNum;
	private int amount;
	private String searchField;
	private String keyword;
	/*Criteria 클래스 설명
	  pageNum과 amount 값을 전달하는 용도. 생성자를 통해서 기본값을 1페이지, 30개로 지정
	*/
	
	public CriteriaForReply() {
		this(1,30, "all", "");
	}
	
	public CriteriaForReply(int pageNum, int amount, String searchField, String keyword) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.searchField = searchField;
		this.keyword = keyword;
	}
	
}
