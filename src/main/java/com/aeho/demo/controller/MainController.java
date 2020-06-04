package com.aeho.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.aeho.demo.domain.CategoryDTO;
import com.aeho.demo.domain.Criteria;
import com.aeho.demo.domain.PageDto;
import com.aeho.demo.security.MemberPrincipal;
import com.aeho.demo.service.BoardService;
import com.aeho.demo.service.CategoryService;
import com.aeho.demo.service.GoodsService;
import com.aeho.demo.service.MainServcie;
import com.aeho.demo.service.SlideImagesService;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.CategoryVo;
import com.aeho.demo.vo.GoodsVo;
import com.google.gson.Gson;

@Controller
public class MainController {
	
	@Autowired
	private MainServcie mainService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private SlideImagesService slideImageService;
	
	@GetMapping("/aeho")
	public String main(HttpServletRequest request) {
		return "redirect:/main/main";
	}
	
	@GetMapping("/main/main")
	public void getMain(HttpServletRequest request, Model model) {
		model.addAttribute("slideImageList", slideImageService.listSlideImages());
	}
	
	//인기글
	@ResponseBody
	@GetMapping("/todayBest")
	public String todayBest(HttpServletRequest request) {
		List<BoardVo> list = mainService.todayBest();
		Gson gson = new Gson();
		String todayList = gson.toJson(list);
		return todayList;
	}
	
	@ResponseBody
	@GetMapping("/weekBest")
	public String weekBest(HttpServletRequest request) {
		List<BoardVo> list = mainService.weekBest();
		Gson gson = new Gson();
		String todayList = gson.toJson(list);
		return todayList;
	}
	
	@ResponseBody
	@GetMapping("/monthBest")
	public String monthBest(HttpServletRequest request) {
		List<BoardVo> list = mainService.monthBest();
		Gson gson = new Gson();
		String todayList = gson.toJson(list);
		return todayList;
	}
	
	@ResponseBody
	@GetMapping("/menuCategory")
	public String menuCategory(HttpServletRequest request,CategoryDTO categoryDTO) {
		List<CategoryVo> list = mainService.menuCategory(categoryDTO);
		Gson gson = new Gson();
		String menuCategoryList = gson.toJson(list);
		System.out.println(menuCategoryList);
		return menuCategoryList;
	}
	
	@GetMapping("/access-denied")
	public String loadExceptionPage(HttpServletRequest request, ModelMap model) throws Exception{
		System.out.println("checkAuth작동중....");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		MemberPrincipal memberPrincipal = (MemberPrincipal)auth.getPrincipal();
		
		System.out.println("checkAuth...."+memberPrincipal.getUsername());
		System.out.println("checkAuth...."+memberPrincipal.getAuthorities());
		
		model.addAttribute("name",memberPrincipal.getUsername());
		model.addAttribute("auth",memberPrincipal.getAuthorities());
		model.addAttribute("msg","권한이 없는 접근입니다.");
		
		return "loginError";
	}
	
	@GetMapping("/")
	public String loadAccessdeniedPage(HttpServletRequest request) throws Exception{
		return "loginError";
	}
	
	//공지사항
	@GetMapping("/main/notice")
	public void noticeList(HttpServletRequest request,Criteria cri, Model model) {
		System.out.println(cri.getCategoryNum());
		cri.setAmount(10);
		int total = 0;
		if(cri.getCategoryNum()==10000) {
			total = boardService.getNoticCount(cri);
			System.out.println("이거동작중");
		}else {
			total = boardService.getTotalCount(cri);
		}
		System.out.println("토탈==>>>"+total);
		System.out.println("키워드 ==>"+cri.getKeyword());
		System.out.println("검색타입==>"+cri.getSearchField());
		model.addAttribute("list", boardService.getList(cri));
		model.addAttribute("pageMake", new PageDto(cri, total));
		model.addAttribute("c_no",cri.getCategoryNum());
	}
	
	// 진탁) 0603 메인 페이지용 공지사항
	@GetMapping("/userNotice")
	@ResponseBody
	public String adminNotice(HttpServletRequest request) {
		List<BoardVo> list = boardService.getUserNotice();
		Gson gson = new Gson();
		String str = gson.toJson(list);
		return str;
	}
	
	// 진탁) 0603 메인 페이지용 최신글
	@GetMapping("/mainNewBoard")
	@ResponseBody
	public String mainNewBoard(HttpServletRequest request) {
		List<BoardVo> list = boardService.mainNewBoard();
		System.out.println(list);
		Gson gson = new Gson();
		String str = gson.toJson(list);
		return str;
	}
	
	// 아름) 0603 메인페이지 최신굿즈
	@GetMapping("/mainNewGoods")
	@ResponseBody 
	public String mainNewGoods(HttpServletRequest request) { 
		List<GoodsVo> list = goodsService.mainNewGoods();
		Gson gson = new Gson();
		String str = gson.toJson(list); 
		return str; 
	}
	
	// 진탁) 0603 메인페이지 인기 카테고리
	@GetMapping("/popCategory")
	@ResponseBody
	public String popCategory(HttpServletRequest request) {
		List<CategoryVo> list = categoryService.popCategory();
		Gson gson = new Gson();
		String str = gson.toJson(list);
		return str;
	}

}
