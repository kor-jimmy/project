package com.aeho.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aeho.demo.service.GoodsService;
import com.aeho.demo.vo.GoodsVo;
import com.google.gson.Gson;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/goods/*")
@AllArgsConstructor
public class GoodsController {
	@Autowired
	public GoodsService goodsService;

	public void setGoodsService(GoodsService goodsService) {
		this.goodsService = goodsService;
	}
	
	@GetMapping("/list")
	public void list(Model model) {
		model.addAttribute("list", goodsService.listGoods(null));
	}

	@GetMapping(value = "/listGoods", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String listGoods(String keyword) {
		String list = new Gson().toJson(goodsService.listGoods(keyword));
		return list;
	}

	@GetMapping("/insert")
	public void insert() {

	}

	@PostMapping("/insert")
	public String insert(GoodsVo gv, RedirectAttributes rttr) {
		String str = "상품 등록 실패";
		int re = goodsService.insertGoods(gv);
		if(re > 0) {
			str="상품 등록 성공";
		}
		rttr.addFlashAttribute("result",str);
		return "redirect:/goods/list";
	}

	@GetMapping("/update")
	public void update(GoodsVo gv, Model model) {
		model.addAttribute("goods", goodsService.getGoods(gv));
	}

	@PostMapping("/update")
	public String update(GoodsVo gv, RedirectAttributes rttr) {
		String str ="상품 수정 실패";
		int re = goodsService.updateGoods(gv);
		if(re > 0) {
			str = "상품 수정 성공";
		}
		rttr.addFlashAttribute("result",str);
		return "redirect:/goods/list";
	}

	@GetMapping("/delete")
	@ResponseBody
	public String delete(GoodsVo gv) {
		String str = "상품 삭제 실패";
		int re = goodsService.deleteGoods(gv);
		if(re > 0) {
			str="상품 삭제 성공";
		}
		return str;
	}

	@GetMapping("/get")
	public void get(GoodsVo gv,Model model) {
		model.addAttribute("goods", goodsService.getGoods(gv));
	}




}