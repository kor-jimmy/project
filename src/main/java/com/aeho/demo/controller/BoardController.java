package com.aeho.demo.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
import com.aeho.demo.service.HateService;
import com.aeho.demo.service.LoveService;
import com.aeho.demo.service.ReplyService;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.CategoryVo;
import com.aeho.demo.vo.HateVo;
import com.aeho.demo.vo.LoveVo;
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
	
	@Autowired
	private LoveService loveService;
	
	@Autowired
	private HateService hateService;
	

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
	public String delete(BoardVo bv) throws Exception{
		String msg = "0";
		System.out.println(bv.getB_no());
		int result = boardService.deleteBoard(bv);
		
		if(result > 0 ) {
			msg = "1";
		}
		
		return msg;
	}
	
	//love insert
	public String loveInsert(LoveVo lv) {
		String result = "0";
		int re = loveService.insertLove(lv);
		if( re > 0 ) {
			result = "1";
		}
		return result;
	}
	
	//hate insert
	public String hateInsert(HateVo hv) {
		String result = "0";
		int re = hateService.insertHate(hv);
		if( re > 0 ) {
			result = "1";
		}
		return result;
	}
}
