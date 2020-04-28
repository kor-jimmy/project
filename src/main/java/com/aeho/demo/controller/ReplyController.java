package com.aeho.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@GetMapping("/list")
	public String list(ReplyVo rv) {
		List<ReplyVo> list = replyService.listReply(rv);
		Gson gson = new Gson();
		return gson.toJson(list);
	}
	

}
