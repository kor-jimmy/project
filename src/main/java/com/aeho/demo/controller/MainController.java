package com.aeho.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.aeho.demo.domain.CategoryDTO;
import com.aeho.demo.service.MainServcie;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.CategoryVo;
import com.google.gson.Gson;

@Controller
public class MainController {
	
	@Autowired
	private MainServcie mainService;
	
	@GetMapping("/aeho")
	public String main() {
		return "redirect:/main/main";
	}
	
	@GetMapping("/main/main")
	public void getMain() {
		
	}
	
	//인기글
	@ResponseBody
	@GetMapping("/todayBest")
	public String todayBest() {
		List<BoardVo> list = mainService.todayBest();
		Gson gson = new Gson();
		String todayList = gson.toJson(list);
		return todayList;
	}
	
	@ResponseBody
	@GetMapping("/weekBest")
	public String weekBest() {
		List<BoardVo> list = mainService.weekBest();
		Gson gson = new Gson();
		String todayList = gson.toJson(list);
		return todayList;
	}
	
	@ResponseBody
	@GetMapping("/monthBest")
	public String monthBest() {
		List<BoardVo> list = mainService.monthBest();
		Gson gson = new Gson();
		String todayList = gson.toJson(list);
		return todayList;
	}
	
	@ResponseBody
	@GetMapping("/menuCategory")
	public String menuCategory(CategoryDTO categoryDTO) {
		List<CategoryVo> list = mainService.menuCategory(categoryDTO);
		Gson gson = new Gson();
		String menuCategoryList = gson.toJson(list);
		System.out.println(menuCategoryList);
		return menuCategoryList;
	}
}
