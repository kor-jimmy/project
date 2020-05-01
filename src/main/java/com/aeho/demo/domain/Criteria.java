package com.aeho.demo.domain;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum;
	private int amount;
	private String catkeyword;
	/*Criteria 클래스 설명
	  pageNum과 amount 값을 전달하는 용도. 생성자를 통해서 기본값을 1페이지, 10개로 지정
	*/
	
	public Criteria() {
		this(1,10,"");
	}
	
	public Criteria(int pageNum, int amount, String catkeyword) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.catkeyword = catkeyword;
	}
}
