package com.aeho.demo.admincontroller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aeho.demo.domain.Criteria;
import com.aeho.demo.domain.PageDto;
import com.aeho.demo.service.MemberService;
import com.aeho.demo.service.MemberServiceSecurity;
import com.aeho.demo.vo.MemberVo;

@Controller
@RequestMapping("/admin/member/*")
public class MemberManageController {
	
	@Autowired
	MemberServiceSecurity memberService;
	
	@GetMapping("/list")
	public void listMember(HttpServletRequest request, Model model, Criteria cri) {
		cri.setAmount(10);
		int memberTotal = memberService.totalMember(cri);
		//model.addAttribute("list", memberService.listMember());
		model.addAttribute("list", memberService.getListWithPaging(cri));
		model.addAttribute("pageMake", new PageDto(cri, memberTotal));
	}
	
	@PostMapping("/updateState")
	@ResponseBody
	public String updateMemberState(HttpServletRequest request, MemberVo memberVo) {
		System.out.println(memberVo);
		int re = memberService.updateMemberState(memberVo);
		return "";
	}
	
}
