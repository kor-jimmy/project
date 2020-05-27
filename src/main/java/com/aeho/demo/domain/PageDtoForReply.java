package com.aeho.demo.domain;

import lombok.Data;


@Data
public class PageDtoForReply {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private CriteriaForReply cri;
	
	//페이징 계산을 위한 DTO 클래스	
	public PageDtoForReply(CriteriaForReply cri, int total) {
		this.cri=cri;
		this.total=total;
		//페이징의 끝 번호 계산. Math.ceil은 소수점을 올림으로 처리하여 연산.
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		//페이징의 시작 번호 계산 
		//ex) 화면에 페이지를 10개씩 보여준다면 startPage는 endPage에서 9를 뺀 값이 된다.
		//endPage이 20이면 9를 뺀 startPage 11
		this.startPage=this.endPage-9; 
		
		//게시물의 총 개수를 이용하여 마지막 페이지를 계산/
		//게시물이 총 80개이면 80 * 1.0 / Amount(화면당 보여줄 페이지 예로 10)
		//realEnd는 8이 된다.
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));
		
		//전체 데이터수(total)을 이용해 실제로 끝날 페이지(realEnd)가 몇 번까지가 되는지를 계산 한 후
		//끝페이지(realEnd)가 계산해놓은 끝 번호(endPage)보다 작다면 끝 번호(endPage)는 끝페이지(realEnd)가 되어야 한다.
		//만약 전체 게시물 수(total)이 180이고 한 화면에 10개의 페이지가 나오고 페이지당 10개의 게시물(amount)를 보여주고 pageNum이 1이 전달되면
		//endPage는 1/10.0 * 10 = 1이고 Math.ceil 메소드를 통하여 올림수를 취하기 때문에 10이 된다.
		//startPage는 endPage에서 9를 뺀 값이므로 1이되고 게시물 목록 첫 화면에서는 1에서 10까지의 페이지가 나온다.
		//realEnd는 total(180) * 1.0 / amount(10. 페이지당 보여줄 게시물 수) Math.ceil 메소드를 통해 18이란 값이 나온다.
		
		//realEnd가 18이고 11페이지로 이동하였을때 endPage는 20이되므로
		//endPage는 realEnd가 된다.
		if(realEnd<this.endPage) {
			this.endPage = realEnd;
		}
		
		// 이전은 시작 페이지가 1보다 큰경우라면  존재하면 된다.
		this.prev = this.startPage>1;
		// 다음으로 가는 링크의 경우는 realEnd 가 끝번호(endPage)보다 큰 경우에만 존재하게 된다.
		// realEnd가 180이므로 1~10 페이지에서는 다음이 나온다.
		// 그러나 11페이지로 이동했을때의 endPage는 20이 되고 realEnd 18가 되므로 다음버튼은 나오지 않게 설계한다. 
		this.next = this.endPage < realEnd;
	}
}
