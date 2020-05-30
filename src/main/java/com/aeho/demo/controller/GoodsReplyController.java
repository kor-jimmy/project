package com.aeho.demo.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.aeho.demo.service.GoodsReplyService;
import com.aeho.demo.service.GoodsService;
import com.aeho.demo.vo.GoodsReplyVo;
import com.aeho.demo.vo.HateVo;
import com.google.gson.Gson;

import lombok.AllArgsConstructor;

@RestController
@RequestMapping("/goodsReply/*")
@AllArgsConstructor
public class GoodsReplyController {
	@Autowired
	private GoodsReplyService goodsReplyService;
	
	public void setGoodsReplyService(HttpServletRequest request, GoodsReplyService goodsReplyService) {
		this.goodsReplyService = goodsReplyService;
	}
	
	@GetMapping(value = "/list", produces = "application/json; charset=utf-8")
	public String list(HttpServletRequest request, int g_no) {
		List<GoodsReplyVo> list = goodsReplyService.listGoodsReply(g_no);
		Gson gson = new Gson();
		return gson.toJson(list);
	}
	
	
	@PostMapping("/insert")
	public String insert(HttpServletRequest request, GoodsReplyVo gv) {
		String str = "댓글등록 실패";
		int re = goodsReplyService.insertGoodsReply(gv);
		if(re>0) {
			str = "댓글등록에 성공했습니다.";
		}
		return str;
	}
	
	@PostMapping("/delete")
	public HashMap delete(HttpServletRequest request, int gr_no) {
		GoodsReplyVo gv = goodsReplyService.getGoodsReply(gr_no);
		String str = "댓글삭제 실패";
		int re = goodsReplyService.deleteGoodsReply(gv);
		if(re>0) {
			str = "댓글삭제에 성공했습니다.";
		}
		HashMap map = new HashMap();
		map.put("str", str);
		map.put("re", re);
		return map;
	}
		
	@GetMapping("/getGoodsReply")
	@ResponseBody
	public String getGoodsReply(HttpServletRequest request, int gr_no) {
		GoodsReplyVo grv = goodsReplyService.getGoodsReply(gr_no);
		String goodsReply = new Gson().toJson(grv);
		return goodsReply;
	}
	
	

}
