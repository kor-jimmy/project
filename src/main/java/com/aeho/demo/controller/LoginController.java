package com.aeho.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aeho.demo.service.MemberService;
import com.aeho.demo.service.MemberServiceSecurity;
import com.aeho.demo.vo.MemberVo;

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
		MemberVo memberVo = memberService.checkMemberState(mv);
		String state = memberVo.getM_state();
		return state;
	}
	
}
