package com.aeho.demo.controller;

import java.io.Console;
import java.io.File;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.management.loading.PrivateClassLoader;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aeho.demo.domain.Criteria2;
import com.aeho.demo.domain.PageDto;
import com.aeho.demo.domain.PageDto2;
import com.aeho.demo.service.CategoryService;
import com.aeho.demo.service.GoodsFilesSevice;
import com.aeho.demo.service.GoodsService;
import com.aeho.demo.service.MemberService;
import com.aeho.demo.vo.CategoryVo;
import com.aeho.demo.vo.GoodsFilesVo;
import com.aeho.demo.vo.GoodsVo;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/goods/*")
@AllArgsConstructor
public class GoodsController {
	@Autowired
	public GoodsService goodsService;	
	public void setGoodsService(HttpServletRequest request, GoodsService goodsService) {
		this.goodsService = goodsService;
	}
		
	@Autowired
	public CategoryService categoryService;
	public void setCategoryService(HttpServletRequest request, CategoryService categoryService) {
		this.categoryService = categoryService;
	}
	
	@Autowired
	public GoodsFilesSevice goodsFilesService;
	public void setGoodsFilesService(HttpServletRequest request, GoodsFilesSevice goodsFilesService) {
		this.goodsFilesService = goodsFilesService;
	}
	
	@GetMapping("/list")
	public void list(HttpServletRequest request) {
	}
/*
	@GetMapping(value = "/listGoods", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String listGoods(int gc_code,String keyword) {
		String list = new Gson().toJson(goodsService.listGoods(gc_code,keyword));
		return list;
	}
*/
	@GetMapping(value = "/listGoods", produces = "application/json; charset=utf-8")
	@ResponseBody
	public HashMap listGoods(HttpServletRequest request, Criteria2 cri) {
		int total = goodsService.getTotalCount(cri);		
		List<GoodsVo> l = goodsService.listGoods(cri);
		for (GoodsVo g : l) {
			//System.out.println(g.getM_nick());
			//System.out.println("글번호:"+g.getG_no());
		}
		PageDto2 dto = new PageDto2(cri, total);
		System.out.println(cri);
		System.out.println(total);
		String list = new Gson().toJson(goodsService.listGoods(cri));
		System.out.println(list);
		HashMap hm = new HashMap();
		hm.put("dto", dto);
		hm.put("list", list);
		return hm;
	}
	@GetMapping("/insert")
	public void insert(HttpServletRequest request, Model model, @Param("c_no")int c_no) {
		CategoryVo cv = categoryService.getCategory(c_no);
		model.addAttribute("cv", cv);
	}

	@PostMapping(value = "/insert")
	@ResponseBody
	public String insert(HttpServletRequest request, GoodsVo gv, RedirectAttributes rttr) throws Exception {
//		String msg = "상품 등록에 실패했습니다.";
		int re = goodsService.insertGoods(gv);
//		if(re > 0) {
//			msg="상품을 등록했습니다.";
//		}
//		rttr.addFlashAttribute("result",msg);
//		rttr.addFlashAttribute("g_no",gv.getG_no());
		
		System.out.println(gv.getG_no());
		return gv.getG_no()+"";
	}
	
	@PostMapping(value = "/testUpload", produces = "application/json; charset=utf-8")
	@ResponseBody
	public JsonObject uploadSummernoteImageFile(HttpServletRequest request, @RequestParam("file") MultipartFile multipartFile) {
		JsonObject jsonObject = new JsonObject();
		
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH",Locale.KOREA);
		String today = dateFormat.format(date);
		
		String year = today.split("/")[0];
		String month= today.split("/")[1];
		
		String fileRoot = "C:\\aehoUpload\\goods\\"+year+"\\"+month+"\\";
		String originalFileName=multipartFile.getOriginalFilename();
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		
		String savedFileName = UUID.randomUUID()+"_"+originalFileName;
		
		File targetFile = new File(fileRoot+savedFileName);
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/goodsImage/"+savedFileName);
			jsonObject.addProperty("responseCode", "success");
		} catch (Exception e) {
			// 테스트 저장 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		return jsonObject;		
	}
	
	@PostMapping(value = "fileDBupload")
	@ResponseBody
	public String FileDBupload(HttpServletRequest request, @RequestBody List<GoodsFilesVo> files) {
		for(GoodsFilesVo gfv : files) {
			goodsFilesService.insert(gfv);
		}
		return "msg";
	}

	@GetMapping("/update")
	public void update(HttpServletRequest request, GoodsVo gv, Model model) {
		model.addAttribute("goods", goodsService.getGoods(gv));
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String update(HttpServletRequest request, GoodsVo gv, RedirectAttributes rttr) {
		String str ="상품 수정 실패";
		int re = goodsService.updateGoods(gv);
		if(re > 0) {
			str = "상품 수정 성공";
		}
		rttr.addFlashAttribute("result",str);
		return gv.getG_no()+"";
	}

	@PostMapping("/delete")
	@ResponseBody
	public String delete(HttpServletRequest request, GoodsVo gv) {
		String str = "오류로 인해 게시물 삭제에 실패했습니다.";
		int re = goodsService.deleteGoods(gv);
		if(re > 0) {
			str="게시물이 삭제되었습니다.";
		}
		return str;
	}

	@GetMapping("/get")
	public void get(HttpServletRequest request, GoodsVo gv,Model model) {
		model.addAttribute("goods", goodsService.getGoods(gv));
	}

	
}