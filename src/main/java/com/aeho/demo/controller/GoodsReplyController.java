package com.aeho.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.aeho.demo.service.GoodsReplyService;
import com.aeho.demo.vo.GoodsReplyVo;
import com.google.gson.Gson;

import lombok.AllArgsConstructor;

@RestController
@RequestMapping("/goods/*")
@AllArgsConstructor
public class GoodsReplyController {
	@Autowired
	private GoodsReplyService goodsReplyService;

	public void setGoodsReplyService(GoodsReplyService goodsReplyService) {
		this.goodsReplyService = goodsReplyService;
	}
	
	@GetMapping("/listR")
	public String list() {
		List<GoodsReplyVo> list = goodsReplyService.listGoodsReply();
		Gson gson = new Gson();
		return gson.toJson(list);
	}
	
	@GetMapping("/insertR")
	public void insert() {}
	
	@PostMapping("/insertR")
	public String insert(GoodsReplyVo gv) {
		int re = goodsReplyService.insertGoodsReply(gv);
		String str = "댓글등록 실패";
		if(re>0) {
			str = "댓글등록에 성공했습니다.";
		}
		return str;
	}
	
	@PostMapping("/deleteR")
	public String delete(GoodsReplyVo gv) {
		String str = "회원삭제 실패";
		int re = goodsReplyService.deleteGoodsReply(gv);
		if(re>0) {
			str = "댓글삭제에 성공했습니다.";
		}
		return str;
	}
}
