package com.aeho.demo.controller;

import javax.validation.constraints.Positive;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aeho.demo.service.MemberService;
import com.aeho.demo.service.MemberServiceSecurity;
import com.aeho.demo.vo.MemberVo;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberServiceSecurity memberServiceSecurity;

	@GetMapping("/insert")
	public void insertMember() {
		
	}
	
	@PostMapping("/insert")
	public String insertMember(MemberVo mv, RedirectAttributes rttr) {
		System.out.println("컨트롤러 동작중");
		memberServiceSecurity.insertMember(mv);
		return "redirect:/aeho";
	}
	
}
