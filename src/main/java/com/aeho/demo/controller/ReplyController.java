package com.aeho.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.aeho.demo.service.ReplyService;
import com.aeho.demo.vo.ReplyVo;
import com.google.gson.Gson;

@RestController
@RequestMapping("/reply/*")
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;

	public void setReplyService(ReplyService replyService) {
		this.replyService = replyService;
	}
	
	@PostMapping("/insert")
	public String insert(ReplyVo rv) {
		System.out.println("리플라이 인서트 컨트롤러 동작중");
		String msg = "댓글 등록에 실패하였습니다.";
		int re  = replyService.insertReply(rv);
		if(re>0) {
			msg = "댓글 등록에 성공하였습니다.";
		}
		return msg;
	}
	
	@GetMapping(value="/list", produces = "application/json; charset=utf-8")
	public String list(ReplyVo rv) {
		System.out.println("리플라이 리스트 컨트롤러 동작중");
		List<ReplyVo> list = replyService.listReply(rv);
		Gson gson = new Gson();
		return gson.toJson(list);
	}
	
	@GetMapping("/delete")
	public String delete(ReplyVo rv) {
		System.out.println("리플라이 딜리트 컨트롤러 동작중");
		String msg = "댓글 삭제에 실패하였습니다.";
		int re = replyService.deleteReply(rv);
		if (re>0) {
			msg = "댓글 삭제에 성공하였습니다.";
		}
		return msg;
	}
	
}
