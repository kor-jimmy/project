package com.aeho.demo.domain;

import lombok.Data;

@Data
public class Criteria2 {
	private int pageNum;
	private int amount;
	private int gc_code;
	private String keyword;
	
	public Criteria2() {
		this(1,30,0,null);
	}

	public Criteria2(int pageNum, int amount, int gc_code, String keyword) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
		this.gc_code = gc_code;
		this.keyword = keyword;
	}
	
	
	
}
