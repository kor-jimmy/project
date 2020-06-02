package com.aeho.demo.domain;

import lombok.Data;

@Data
public class Criteria3 {
	private int pageNum;
	private int amount;
	private int categoryNum;
	private String searchField;
	private String searchKeyword;
	private String catKeyword;
	
	public Criteria3() {
		this(1,10,0,"all",null,null);
	}
	
	public Criteria3(int pageNum, int amount, int categoryNum, String searchField, String searchKeyword, String catKeyword) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.categoryNum  = categoryNum;
		this.searchField = searchField;
		this.searchKeyword = searchKeyword;
		this.catKeyword = catKeyword;
	}
	
}
