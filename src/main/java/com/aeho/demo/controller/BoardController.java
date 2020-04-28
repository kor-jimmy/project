package com.aeho.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aeho.demo.service.BoardService;
import com.aeho.demo.vo.BoardVo;
import com.google.gson.Gson;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	@Autowired
	private BoardService boardService;

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	@GetMapping("/list")
	public void list(Model model) {
		model.addAttribute("list", boardService.listBoard());
	}
	
	@GetMapping("/get")
	public void getBoard(BoardVo bv, Model model) {
		model.addAttribute("board", boardService.getBoard(bv));
	}
	
	@GetMapping("/insert")
	public void insert() {
	}
	
	@PostMapping("/insert")
	public String insert(BoardVo bv, RedirectAttributes rttr) {
		String str = "게시물 등록에 실패했습니다.";
		int re = boardService.insertBoard(bv);
		if( re > 0 ) {
			str = "게시물 등록에 성공했습니다.";
		}
		rttr.addFlashAttribute("result", str);
		return "redirect:/board/list";
	}
	
	@GetMapping("/update")
	public void update(BoardVo bv, Model model) {
		model.addAttribute("board", boardService.getBoard(bv));
	}
	
	@PostMapping("/update")
	public String update(BoardVo bv, RedirectAttributes rttr) {
		System.out.println("게시물 수정!");
		String str = "게시물 수정에 실패했습니다.";
		int re = boardService.updateBoard(bv);
		if( re > 0 ) {
			str = "게시물 수정에 성공했습니다.";
		}
		rttr.addFlashAttribute("result", str);
		return "redirect:/board/get?b_no="+bv.getB_no();
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public String delete(BoardVo bv) {
		String str = "게시물 삭제에 실패했습니다.";
		int re = boardService.deleteBoard(bv);
		if( re > 0 ) {
			str = "게시물 삭제에 성공했습니다.";
		}
		return str;
	}
}
