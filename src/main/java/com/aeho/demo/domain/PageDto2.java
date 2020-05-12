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
public class PageDto2 {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria2 cri;
	
	//페이징 계산을 위한 DTO 클래스	
	public PageDto2(Criteria2 cri, int total) {
		this.cri=cri;
		this.total=total;
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		this.startPage=this.endPage-9; 
		
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));
		
		if(realEnd<this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage>1;
		this.next = this.endPage < realEnd;
	}
}
