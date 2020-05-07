package com.aeho.demo.domain;

import lombok.Data;

@Data
public class Criteria2 {
	private int pageNum;
	private int amount;
	private int gc_code;
	private int categoryNum; //c_no
	private String keyword;
	private String searchField;
	
	public Criteria2() {
		this(1,30,0,0,null,"all");
	}

	public Criteria2(int pageNum, int amount, int gc_code, int categoryNum, String keyword, String searchField) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
		this.gc_code = gc_code;
		this.categoryNum = categoryNum;
		this.keyword = keyword;
		this.searchField = searchField;
	}
	
	
	
}
