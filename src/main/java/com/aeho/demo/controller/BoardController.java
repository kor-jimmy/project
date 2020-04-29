package com.aeho.demo.controller;

import java.net.URLEncoder;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aeho.demo.service.BoardService;
import com.aeho.demo.service.CategoryService;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.CategoryVo;
import com.google.gson.Gson;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CategoryService categoryService;

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}
	
	@GetMapping("/list")
	public void list(Model model, @RequestParam("catkeyword") String catkeyword,
			@RequestParam("c_no") int c_no) {
		model.addAttribute("list", boardService.listCatBoard(catkeyword));
		model.addAttribute("catkeyword", catkeyword);
		model.addAttribute("c_no",c_no);
	}
	
	@GetMapping("/get")
	public void getBoard(BoardVo bv, Model model) {
		model.addAttribute("board", boardService.getBoard(bv));
	}
	
	@GetMapping("/insert")
	public void insert(Model model, @Param("c_no") int c_no) {
		System.out.println(c_no);
		model.addAttribute("c_no",c_no);
	}
	
	@PostMapping(value="/insert")
	public String insert(BoardVo bv, RedirectAttributes rttr) throws Exception {
		String msg = "게시물 등록에 실패했습니다.";
		int re = boardService.insertBoard(bv);
		if( re > 0 ) {
			msg = "게시물 등록에 성공했습니다.";
		}
		rttr.addFlashAttribute("result", msg);
		String str = categoryService.getCategory(bv.getC_no()).getC_dist();
		String encoding = URLEncoder.encode(str, "UTF-8");
		System.out.println(str);
		String url = "redirect:/board/list?c_no="+bv.getC_no()+"&catkeyword="+encoding;
		return url;
	}
	
	@GetMapping("/update")
	public void update(BoardVo bv, Model model) {
		model.addAttribute("board", boardService.getBoard(bv));
	}
	
	@PostMapping("/update")
	public String update(BoardVo bv, RedirectAttributes rttr) {
		System.out.println("게시물 수정!");
		String msg = "게시물 수정에 실패했습니다.";
		int re = boardService.updateBoard(bv);
		if( re > 0 ) {
			msg = "게시물 수정에 성공했습니다.";
		}
		rttr.addFlashAttribute("result", msg);
		return "redirect:/board/get?b_no="+bv.getB_no();
	}
	
	@GetMapping("/delete")
	@ResponseBody
	public String delete(BoardVo bv) {
		String msg = "게시물 삭제에 실패했습니다.";
		System.out.println(bv.getB_no());
		int re = boardService.deleteBoard(bv);
		if( re > 0 ) {
			msg = "게시물 삭제에 성공했습니다.";
		}
		return msg;
	}

}
