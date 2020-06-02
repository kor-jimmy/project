package com.aeho.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aeho.demo.service.CategoryService;
import com.google.gson.Gson;

@Controller
@RequestMapping("/category/*")
public class CategoryController {

	@Autowired
	private CategoryService categoryService;

	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}
	
	@GetMapping({"/manage", "/category"})
	public void list(HttpServletRequest request, Model model) {
		model.addAttribute("list", categoryService.listCategory());
	}
	
	@GetMapping(value = "/goodsCateList", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String goodsList(HttpServletRequest request) {
		String list = new Gson().toJson(categoryService.listGoodsCategory());
		return list;
	}
	
	@GetMapping(value = "/qnaBoardList", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String qnaBoardList(HttpServletRequest request) {
		String list = new Gson().toJson(categoryService.listQnaBoardCategory());
		return list;
	}
	
	@GetMapping(value = "/get", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String get(HttpServletRequest request, int c_no) {
		Gson gson = new Gson();
		return gson.toJson(categoryService.getCategory(c_no));
	}
	
	
	
}
