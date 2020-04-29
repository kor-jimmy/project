package com.aeho.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aeho.demo.service.CategoryService;
import com.aeho.demo.vo.CategoryVo;
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
	public void list(Model model) {
		model.addAttribute("list", categoryService.listCategory());
	}
	
	@GetMapping(value = "/goodsCateList", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String goodsList() {
		String list = new Gson().toJson(categoryService.listGoodsCategory());
		return list;
	}
	
	@GetMapping(value = "/get", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String get(int c_no) {
		Gson gson = new Gson();
		return gson.toJson(categoryService.getCategory(c_no));
	}
	
	@PostMapping("/insert")
	@ResponseBody
	public String insert(CategoryVo cv) {
		String msg = "카테고리 등록에 실패했습니다.";
		int re = categoryService.insertCategory(cv);
		if( re > 0 ) {
			msg = "새로운 카테고리가 등록되었습니다.";
		}
		return msg;
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String update(CategoryVo cv) {
		String msg = "카테고리 수정에 실패했습니다.";
		int re = categoryService.updateCategory(cv);
		if( re > 0 ) {
			msg = "카테고리 수정에 성공했습니다.";
		}
		return msg;
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public String delete(CategoryVo cv) {
		String msg = "카테고리 삭제에 실패했습니다.";
		int re = categoryService.deleteCategory(cv);
		if( re > 0 ) {
			msg = "카테고리 삭제에 성공했습니다.";
		}
		return msg;
	}
	
	
}
