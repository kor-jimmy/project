package com.aeho.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aeho.demo.service.ReportService;
import com.aeho.demo.vo.ReportVo;

@Controller
@RequestMapping("/report/*")
public class ReportController {
	
	@Autowired
	ReportService reportService;
	
	/*게시물*/

	//게시물신고
	@PostMapping("/boardreport")
	@ResponseBody
	public String boardReport(ReportVo reportVo) {
		String msg = "신고 접수에 실패하였습니다.";
		System.out.println(reportVo);
		int re = reportService.insertBoardReport(reportVo);
		if(re>0) {
			msg = "해당 게시물 신고가 접수되었습니다.";
		}
		return msg;
	}

	//게시물 신고 한번만 누룰수 있도록
	@GetMapping("/checkBoard")
	@ResponseBody
	public String checkBoard(ReportVo reportVo) {
		String result = "0";
		int re = reportService.isCheckedBoard(reportVo);
		if(re>0) {
			result = "1";
		}
		return result;
	}
	
	//댓글신고
	@PostMapping("/replyreport")
	@ResponseBody
	public String replyReport(ReportVo reportVo) {
		String msg = "신고 접수에 실패 하였습니다.";
		int re = reportService.insertReplyReport(reportVo);
		if(re>0) {
			msg = "신고 접수에 성공하였습니다!";
		}
		return msg;
	}
	
	//댓글 한번만 누를 수 있도록.
	@GetMapping("/checkReply")
	@ResponseBody
	public String checkReply(ReportVo reportVo) {
		String result = "0";
		int re = reportService.isCheckedReply(reportVo);
		if(re>0) {
			result = "1";
		}
		return result;
	}
	
	/*굿즈*/
	
	@RequestMapping("/checkGoods")
	@ResponseBody
	public String checkGoods(ReportVo rev) {
		String result = "0";
		int re = reportService.isCheckedGoods(rev);
		if(re > 0) {
			result = "1";
		}
		return result;
	}
	
	@RequestMapping("/insertGoodsReport")
	@ResponseBody
	public String insertGoodsReport(ReportVo rev) {
		System.out.println(rev);
		String msg = "신고 접수에 실패했습니다.";
		int re = reportService.insertGoodsReport(rev);
		System.out.println(re);
		if( re > 0 ) {
			msg = "신고 접수가 완료되었습니다.\n더욱 깨끗한 커뮤니티가 될 수 있도록 노력하겠습니다.\n감사합니다.";
		}
		return msg;
	}
	
}
