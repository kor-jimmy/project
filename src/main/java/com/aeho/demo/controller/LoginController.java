package com.aeho.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aeho.demo.service.MemberService;
import com.aeho.demo.service.MemberServiceSecurity;
import com.aeho.demo.vo.MemberVo;
import com.google.gson.Gson;

@Controller
public class LoginController {
	
	@Autowired
	MemberServiceSecurity memberService;


	@GetMapping("/loginCustom")
	public void login() {
		
	}
	
	@GetMapping("/loginError")
	public void loginError() {
		
	}
	
	@GetMapping("/checkMemberSatate")
	@ResponseBody
	public String checkMemberState(MemberVo mv) {
		System.out.println("회원 상테 체크...컨트롤ㄹ..동작중....");
		System.out.println(mv);
		MemberVo memberVo = memberService.getMember(mv.getM_id());
		String str = "null";
		if(memberVo != null) {
			Gson gson = new Gson();
			str = gson.toJson(memberVo);
		}
		return str;
	}
	
	@PostMapping("/updateRelease")
	public void updateRelease(MemberVo mv) {
		System.out.println("릴리즈 작동중.....");
		mv.setM_state("ACTIVATE"); 
		int re = memberService.updateRelease(mv);
		
	}
	
}
