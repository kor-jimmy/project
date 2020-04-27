package com.aeho.demo.controller;

import javax.validation.constraints.Positive;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aeho.demo.service.MemberService;
import com.aeho.demo.vo.MemberVo;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@GetMapping("/list")
	public void list(Model model) {
		model.addAttribute("list", memberService.listMember());
	}
	
	@GetMapping({"/get","/update"})
	public void getMember(MemberVo mv, Model model) {
		model.addAttribute("member", memberService.getMemeber(mv));
	}
	
	@GetMapping("/insert")
	public void insert() {
	}
	
	@PostMapping("/insert")
	public String insert(MemberVo mv, RedirectAttributes rttr) {
		String str = "회원 등록 실패";
		int re = memberService.insertMember(mv);
		if(re > 0) {
			str="회원 등록 성공";
		}
		rttr.addFlashAttribute("result", str);
		return "redirect:/member/list";
	}
	
	@PostMapping("/update")
	public String update(MemberVo mv, RedirectAttributes rttr) {
		String str ="회원 수정 실패";
		int re = memberService.updateMember(mv);
		if(re > 0) {
			str="회원 수정 성공";
		}
		rttr.addFlashAttribute("result",str);
		return "redirect:/member/list";
	}
	
	@PostMapping("/delete")
	public String delete(MemberVo mv, RedirectAttributes rttr) {
		String str = "회원 삭제 실패";
		int re = memberService.deleteMember(mv);
		if(re > 0) {
			str = "회원 삭제 성공";
		}
		rttr.addFlashAttribute("result",str);
		return "redirect:/member/list";
	}
	
	

}
