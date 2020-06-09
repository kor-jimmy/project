package com.aeho.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.aeho.demo.service.BoardService;
import com.aeho.demo.service.ReplyService;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.ReplyVo;
import com.google.gson.Gson;

import lombok.AllArgsConstructor;

@RestController
@RequestMapping("/reply/*")
@AllArgsConstructor
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	@Autowired
	private BoardService boardService;

	public void setReplyService(ReplyService replyService) {
		this.replyService = replyService;
	}
	
	@PostMapping("/insert")
	public String insert(HttpServletRequest request, ReplyVo rv) {
		System.out.println("리플라이 인서트 컨트롤러 동작중");
		System.out.println(rv);
		String msg = "댓글 등록에 실패하였습니다.";
		int re  = replyService.insertReply(rv);
		if(re>0) {
			msg = "댓글 등록에 성공하였습니다.";
		}
		return msg;
	}
	
	@GetMapping(value="/list", produces = "application/json; charset=utf-8")
	public String list(HttpServletRequest request, ReplyVo rv) {
		System.out.println("리플라이 리스트 컨트롤러 동작중");
		System.out.println("들어온 비노우==>"+rv.getB_no());
		List<ReplyVo> list = replyService.listReply(rv.getB_no());
		System.out.println("해당 글 댓글 목록 ==>"+list);
		Gson gson = new Gson();
		return gson.toJson(list);
	}
	
	@PostMapping("/delete")
	public String delete(HttpServletRequest request, ReplyVo rv) {
		System.out.println("리플라이 딜리트 컨트롤러 동작중");
		String msg = "댓글 삭제에 실패하였습니다.";
		int re = replyService.deleteReply(rv);
		if (re>0) {
			msg = "댓글 삭제에 성공하였습니다.";
		}
		return msg;
	}
	
}
