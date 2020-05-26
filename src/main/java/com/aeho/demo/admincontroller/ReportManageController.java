package com.aeho.demo.admincontroller;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aeho.demo.domain.Criteria;
import com.aeho.demo.domain.PageDto;
import com.aeho.demo.service.BoardService;
import com.aeho.demo.service.ReportService;
import com.aeho.demo.vo.BoardVo;

@RequestMapping("/admin/report/*")
@Controller
public class ReportManageController {
	
	@Autowired
	ReportService reportService;
	
	@Autowired
	BoardService boardService;
	
	@GetMapping("/board")
	public void reportBoard(Criteria cri, Model model) {
		cri.setAmount(30);
		cri.setCategoryNum(0);
		System.out.println(cri);
		System.out.println("카테고리넘버"+cri.getCategoryNum());
		int total = boardService.getReportCount();
		model.addAttribute("list", boardService.getList(cri));
		model.addAttribute("pageMake", new PageDto(cri, total));
		model.addAttribute("c_no",cri.getCategoryNum());
		//model.addAttribute("catkeyword",categoryService.getCategory(cri.getCategoryNum()).getC_dist());
	}
	
	@PostMapping("/chooseBoardDelete")
	@ResponseBody
	public void chooseBoardDelete(@RequestParam(value = "list[]") List<Integer> chooseBno) {
		for(int i=0; i<chooseBno.size(); i++) {
			BoardVo bv = new BoardVo();
			bv.setB_no(chooseBno.get(i));
			boardService.deleteBoard(bv);
		}
		//return "";
	}
	
	@GetMapping("/reply")
	public void reportList() {
		
	}
}
