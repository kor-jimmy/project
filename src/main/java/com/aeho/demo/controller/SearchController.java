package com.aeho.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aeho.demo.service.PicksService;
import com.aeho.demo.service.SearchService;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.CategoryVo;
import com.aeho.demo.vo.GoodsVo;
import com.aeho.demo.vo.PicksVo;

import lombok.var;

@Controller
@RequestMapping("/search")
public class SearchController {
	
	@Autowired
	private SearchService searchService;
	@Autowired
	private PicksService picksService;

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
	
	@RequestMapping("getVLive")
	@ResponseBody
	public String getVLive(String keyword) {
		String str = "";
		//String vList = "";
		System.out.println("keyword:"+keyword);
		try {
			Document doc = Jsoup.connect("https://www.vlive.tv/search/all?query="+keyword).get();
			//System.out.println("doc:"+doc);
			str = doc.select("#content > div.search_result.all > div.video_area.channel > div.inner").html();
			//System.out.println("getInfo: "+str);
			
			//String [] list = str.split(">,");
			
			/*
			for(String d : list) {
				String text = d.substring(d.indexOf(">"), d.indexOf("</"));
				//System.out.println(text);
				//System.out.println(text.indexOf("LIVE"));
				if( text.indexOf("LIVE") != -1 ){
					//System.out.println("v live!!!!!");
					System.out.println(d);
					String vLiveID = (d.substring(d.indexOf("http://www.vlive.tv/channels/")+29, d.indexOf(" target=")-1));
					String vLiveAddress = "https://channels.vlive.tv/"+vLiveID+"/home";
					System.out.println(vLiveAddress);
					Document vLiveDoc = Jsoup.connect(vLiveAddress).get();
					System.out.println(vLiveDoc);
					vList = vLiveDoc.select("#container > channel > div > home-content-list > div > div > ul").html();
				}
			}
			*/
			
			
			
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		
		return str;
	}
	
	@RequestMapping("/getCategory")
	@ResponseBody
	public List<CategoryVo> getCategory(String keyword) {
		if(getRightKeyword(keyword) != null) {
			keyword = getRightKeyword(keyword);
		}
		return searchService.getCategory(keyword);
	}
	
	@RequestMapping("/getBoard")
	@ResponseBody
	public List<BoardVo> getBoard(String keyword){
		List<BoardVo> list = searchService.getBoard(keyword);
		if(getRightKeyword(keyword) != null && list.size() < 1) {
			for(BoardVo b : searchService.getBoard(getRightKeyword(keyword))) {
				list.add(b);
			}
		}
		return list;
	}
	
	@RequestMapping("/getGoods")
	@ResponseBody
	public List<GoodsVo> getGoods(String keyword){
		List<GoodsVo> list = searchService.getGoods(keyword);
		if(getRightKeyword(keyword) != null && list.size() < 1) {
			for(GoodsVo g : searchService.getGoods(getRightKeyword(keyword))) {
				list.add(g);
			}
		}
		return list;
	}
	
	public String getRightKeyword(String keyword) {
		String str = "";
		HashMap<String, String> map = new HashMap();
		
		map.put("방탄", "BTS");
		map.put("방찬", "BTS");
		map.put("방탄소년단", "BTS");
		map.put("ㅂㅌㅅㄴㄷ", "BTS");
		map.put("bts", "BTS");
		map.put("twice", "트와이스");
		map.put("ㅌㅇㅇㅅ", "트와이스");
		map.put("엑소", "EXO");
		
		
		str = map.get(keyword);
		return str;
	}
	
	//인기 검색어
	@RequestMapping("/listPicks")
	@ResponseBody
	public List<PicksVo> listPicks(){
		List<PicksVo> list = picksService.listPicks();
		return list;
	}
	
	@RequestMapping("/insertPicks")
	@ResponseBody
	public int insertPicks(PicksVo pv) {
		return picksService.insertPicks(pv);
	}

}
