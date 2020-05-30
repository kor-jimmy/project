package com.aeho.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aeho.demo.service.MemberServiceSecurity;
import com.aeho.demo.vo.MemberVo;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberServiceSecurity memberServiceSecurity;

	@GetMapping("/insert")
	public void insertMember(HttpServletRequest request ) {
		
	}
	
	@GetMapping("/delete")
	public void deleteMember(HttpServletRequest request ) {
		
	}
	
	@PostMapping("/insert")
	@ResponseBody
	public String insertMember(HttpServletRequest request, MemberVo mv, RedirectAttributes rttr){
		System.out.println("컨트롤러 동작중");
		String msg = "예기치 않은 오류로 회원가입에 실패했습니다. 잠시 후 다시 시도해주시기 바랍니다. 불편을 드려 죄송합니다.";
		int re = memberServiceSecurity.insertMember(mv);
		if(re > 0) {
			msg = "회원가입이 완료되었습니다. 환영합니다!";
		}
		return msg;
	}
	
	//id 존재 여부 검사
	@GetMapping("/isExistMember")
	@ResponseBody
	public String isExistMember(HttpServletRequest request,String m_id) {
		String result = "0";
		//0: 사용 가능하고 글자수 적합 / 1: 사용중인 아이디 / 2: 사용 가능하나 글자수 미달 / 3: 사용 가능하나 글자수 초과 
		if(memberServiceSecurity.getMember(m_id) != null) {
			result = "1";
		}else {
			if(m_id.length() < 5){
				result = "2";
			}else if(m_id.length() > 20) {
				result = "3";
			}
		}
		return result;
	}
	
	//닉네임 존재여부
	@GetMapping("/isExistNick")
	@ResponseBody
	public String isExistNick(HttpServletRequest request, String m_nick) {
		String result = "0";
		if(memberServiceSecurity.getMemberByNick(m_nick) != null) {
			result = "1";
		}else {
			if(m_nick.length() < 1){
				result = "2";
			}else if(m_nick.length() > 20) {
				result = "3";
			}
		}
		return result;
	}
	@GetMapping("/get")
	public void get(HttpServletRequest request, @RequestParam("m_id") String m_id,Model model) {
		System.out.println("member get");
		MemberVo mv = memberServiceSecurity.getMember(m_id);
		model.addAttribute("member", mv);
	}
	
	@GetMapping("/mypage")
	public void myPage(HttpServletRequest request, @RequestParam("m_id") String m_id,Model model) {
		MemberVo mv = memberServiceSecurity.getMember(m_id);
		model.addAttribute("member", mv);
	}
}
