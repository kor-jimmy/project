package com.aeho.demo.controller;

import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aeho.demo.service.SearchService;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.CategoryVo;
import com.aeho.demo.vo.GoodsVo;

@Controller
@RequestMapping("/search")
public class SearchController {
	
	@Autowired
	private SearchService searchService;

	@RequestMapping("/search")
	public void getSearch(String keyword, Model model) {
		model.addAttribute("keyword", keyword);
	}
	
	@RequestMapping("/newsNaver")	
	@ResponseBody
	public String getNewsNaver(String keyword) {
		
		String str = "";
		System.out.println("keyword:"+keyword);
		try {
			Document doc = Jsoup.connect("https://search.naver.com/search.naver?where=news&sm=tab_jum&query="+keyword).get();
			//System.out.println("doc:"+doc);
			str = doc.select("#main_pack > div.news.mynews.section._prs_nws > ul").html();
			//System.out.println("네이버: "+str);
			
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
				
		return str;
	}
	@RequestMapping("/newsDaum")	
	@ResponseBody
	public String getNewsDaum(String keyword) {
		
		String str = "";
		System.out.println("keyword:"+keyword);
		try {
			Document doc = Jsoup.connect("https://search.daum.net/search?nil_suggest=btn&w=news&DA=SBC&cluster=y&q="+keyword).get();
			//System.out.println("doc:"+doc);
			str = doc.select("#newsColl > div.coll_cont").html();
			//System.out.println("다음: "+str);
			
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		
		return str;
	}
	
	@RequestMapping("/getCategory")
	@ResponseBody
	public List<CategoryVo> getCategory(String keyword) {
		return searchService.getCategory(keyword);
	}
	
	@RequestMapping("/getBoard")
	@ResponseBody
	public List<BoardVo> getBoard(String keyword){
		return searchService.getBoard(keyword);
	}
	
	@RequestMapping("/getGoods")
	@ResponseBody
	public List<GoodsVo> getGoods(String keyword){
		return searchService.getGoods(keyword);
	}
	

}
