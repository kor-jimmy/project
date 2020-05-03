package com.aeho.demo.domain;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum;
	private int amount;
	private int categoryNum; // c_no
	/*Criteria 클래스 설명
	  pageNum과 amount 값을 전달하는 용도. 생성자를 통해서 기본값을 1페이지, 30개로 지정
	*/
	
	public Criteria() {
		this(1,30,0);
	}
	
	public Criteria(int pageNum, int amount, int categoryNum) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.categoryNum  = categoryNum;
	}
	
}
