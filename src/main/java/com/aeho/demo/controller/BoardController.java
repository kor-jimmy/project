package com.aeho.demo.controller;

import java.io.File;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aeho.demo.domain.Criteria;
import com.aeho.demo.domain.PageDto;
import com.aeho.demo.service.BoardFilesSevice;
import com.aeho.demo.service.BoardService;
import com.aeho.demo.service.CategoryService;
import com.aeho.demo.service.HateService;
import com.aeho.demo.service.LoveService;
import com.aeho.demo.vo.BoardFilesVo;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.HateVo;
import com.aeho.demo.vo.LoveVo;
import com.google.gson.JsonObject;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private LoveService loveService;
	
	@Autowired
	private HateService hateService;
	
	@Autowired
	private BoardFilesSevice boardFilesService;
	
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}
	
//	@GetMapping("/list")
//	public void list(Model model, @RequestParam("catkeyword") String catkeyword,
//			@RequestParam("c_no") int c_no) {
//		model.addAttribute("list", boardService.listCatBoard(catkeyword));
//		model.addAttribute("catkeyword", catkeyword);
//		model.addAttribute("c_no",c_no);
//	}
	
	@GetMapping("/list")
	public void list (HttpServletRequest request, Criteria cri, Model model) {
		int total = boardService.getTotalCount(cri);
		System.out.println("list:"+cri);
		model.addAttribute("list", boardService.getList(cri));
		model.addAttribute("pageMake", new PageDto(cri, total));
		model.addAttribute("c_no",cri.getCategoryNum());
		model.addAttribute("catkeyword",categoryService.getCategory(cri.getCategoryNum()).getC_dist());
	}
	
	@GetMapping("/listAll")
	public void listAll (HttpServletRequest request, Criteria cri, Model model) {
		int total = boardService.totalBoard(cri);
		cri.setCategoryNum(9999);
		System.out.println("list:"+cri);
		model.addAttribute("list", boardService.getList(cri));
		model.addAttribute("pageMake", new PageDto(cri, total));
		model.addAttribute("c_no",cri.getCategoryNum());
	}
	
	@GetMapping("/get")
	public void getBoard(HttpServletRequest request, BoardVo bv, Model model) {
		model.addAttribute("board", boardService.getBoard(bv));
	}
	
	@GetMapping("/insert")
	public void insert(HttpServletRequest request,Model model, @Param("c_no") int c_no) {
		System.out.println(c_no);
		model.addAttribute("c_no",c_no);
	}
	
	@PostMapping(value="/insert")
	@ResponseBody
	public String insert(HttpServletRequest request, BoardVo bv, RedirectAttributes rttr) throws Exception {
		String msg = "게시물 등록에 실패했습니다.";
		int re = boardService.insertBoard(bv);
		if( re > 0 ) {
			msg = "게시물 등록에 성공했습니다.";
		}
		rttr.addFlashAttribute("result", msg);
		rttr.addFlashAttribute("b_no", bv.getB_no());
		String str = categoryService.getCategory(bv.getC_no()).getC_dist();
		String encoding = URLEncoder.encode(str, "UTF-8");
		System.out.println(str);
		//String url = "redirect:/board/list?c_no="+bv.getC_no()+"&catkeyword="+encoding;
		System.out.println(bv.getB_no());
		return bv.getB_no()+"";
	}
	
	@GetMapping("/update")
	public void update(HttpServletRequest request, BoardVo bv, Model model) {
		model.addAttribute("board", boardService.getBoard(bv));
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String update(HttpServletRequest request, BoardVo bv, RedirectAttributes rttr) {
		System.out.println("게시물 수정!");
		String msg = "게시물 수정에 실패했습니다.";
		int re = boardService.updateBoard(bv);
		if( re > 0 ) {
			msg = "게시물 수정에 성공했습니다.";
		}
		rttr.addFlashAttribute("result", msg);
		return bv.getB_no()+"";
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public String delete(HttpServletRequest request, BoardVo bv) throws Exception{
		String msg = "0";
		System.out.println(bv.getB_no());
		int result = boardService.deleteBoard(bv);
		if(result > 0 ) {
			msg = "1";
		}
		System.out.println(msg);
		return msg;
	}
	
	//해당 멤버가 해당 게시물에 love를 누른 적 있는지 판단 
	@GetMapping("/isLoved")
	@ResponseBody
	public String loveCheck(HttpServletRequest request, LoveVo lv) {
		String result = "0";
		int cnt = loveService.isChecked(lv);
		if(cnt > 0) {
			result = "1";
		}
		return result;
	}
	
	// 해당 멤버가 해당 게시물에 hate를 누른 적 있는지 판단
	@GetMapping("/isHated")
	@ResponseBody
	public String hateCheck(HttpServletRequest request, HateVo hv) {
		String result = "0";
		int cnt = hateService.isChecked(hv);
		if(cnt > 0) {
			result = "1";
		}
		return result;
	}
	
	//love insert
	@PostMapping("/insertLove")
	@ResponseBody
	public String insertLove(HttpServletRequest request, LoveVo lv) {
		String result = "0";
		int re = loveService.insertLove(lv);
		if( re > 0 ) {
			result = "1";
		}
		return result;
	}

	
	//love delete
	@PostMapping("/deleteLove")
	@ResponseBody
	public String deleteLove(HttpServletRequest request, LoveVo lv) {
		String result = "0";
		int re = loveService.deleteLove(lv);
		if(re > 0) {
			result = "1";
		}
		return result;
	}
	
	//hate insert
	@PostMapping("/insertHate")
	@ResponseBody
	public String insertHate(HttpServletRequest request, HateVo hv) {
		String result = "0";
		int re = hateService.insertHate(hv);
		if( re > 0 ) {
			result = "1";
		}
		return result;
	}
	
	@PostMapping("/deleteHate")
	@ResponseBody
	public String deleteHate(HttpServletRequest request, HateVo hv) {
		String result = "0";
		int re = hateService.deleteHate(hv);
		if(re > 0) {
			result = "1";
		}
		return result;
	}
	
	//게시물 등록 이미지 콜백 컨트롤러.
	@PostMapping(value="/testUpload", produces = "application/json; charset=utf-8")
	@ResponseBody
	public JsonObject uploadSummernoteImageFile(HttpServletRequest request, @RequestParam("file") MultipartFile multipartFile) {
		JsonObject jsonObject = new JsonObject();
		System.out.println(multipartFile);
		Date date = new Date();
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH", Locale.KOREA);
    	String today = dateFormat.format(date);

    	String year = today.split("/")[0];
    	String month = today.split("/")[1];
    	
		String fileRoot = "C:\\aehoUpload\\board\\";	//저장될 외부 파일 경로
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		//확장자 유효성 검사
		String savedFileName = UUID.randomUUID() +"_"+originalFileName;	//저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);	
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/boardImage/"+savedFileName);
			jsonObject.addProperty("responseCode", "success");
				
		} catch (Exception e) {
			  //저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		
		return jsonObject;
	}
	
	// file DB upload
	@PostMapping(value="fileDBupload")
	@ResponseBody
	public String FileDBupload(HttpServletRequest request, @RequestBody List<BoardFilesVo> files) {
		System.out.println(files);
		for(BoardFilesVo bfv : files) {
			boardFilesService.insert(bfv);
		}
		return "msg";
	}
	

}
