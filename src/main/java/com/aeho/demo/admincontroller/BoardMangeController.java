package com.aeho.demo.admincontroller;

import java.io.File;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

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

import com.aeho.demo.domain.Criteria;
import com.aeho.demo.domain.PageDto;
import com.aeho.demo.service.BoardFilesSevice;
import com.aeho.demo.service.BoardService;
import com.aeho.demo.service.CategoryService;
import com.aeho.demo.vo.BoardFilesVo;
import com.aeho.demo.vo.BoardVo;
import com.google.gson.JsonObject;

@Controller
@RequestMapping("/admin/*")
public class BoardMangeController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	BoardFilesSevice boardFilesService;
	
	@Autowired
	CategoryService categoryService;
	
	@GetMapping("/notice/notice")
	public void notice(Criteria cri, Model model) {
		System.out.println(cri.getCategoryNum());
		cri.setAmount(10);
		int total = boardService.getNoticCount(cri);
		if(cri.getCategoryNum() == 10010) {
			total = boardService.getTotalCount(cri);
		}
		model.addAttribute("list", boardService.getList(cri));
		model.addAttribute("pageMake", new PageDto(cri, total));
		model.addAttribute("c_no",cri.getCategoryNum());
		model.addAttribute("catkeyword",categoryService.getCategory(cri.getCategoryNum()).getC_dist());
		model.addAttribute("categoryNum", cri.getCategoryNum());
	}
	
	@GetMapping("/notice/get")
	public void getNotice(Model model,@Param("b_no") int b_no) {
		BoardVo boardVo = new BoardVo();
		boardVo.setB_no(b_no);
		model.addAttribute("board", boardService.getBoard(boardVo));
	}

	@GetMapping("/notice/insert")
	public void insertNotice(Model model, @Param("c_no") int c_no) {
		System.out.println(c_no);
		model.addAttribute("c_no",c_no);
	}
	
	@PostMapping("/notice/insert")
	@ResponseBody
	public String insertNotice(BoardVo bv, RedirectAttributes rttr) {
		System.out.println("공지사항 등록 아이디==>"+bv.getM_id());
		System.out.println("등록될 C_NO=>"+bv.getC_no());
		
		int re = boardService.insertBoard(bv);

		String msg = "게시물 등록에 실패하였습니다.";
		if(re>0) {
			msg = "게시물 등록에 성공하였습니다!";
		}
		return bv.getB_no()+"";
	}
	
	@GetMapping("/notice/update")
	public void update(BoardVo bv, Model model) {
		model.addAttribute("board", boardService.getBoard(bv));
	}
	
	@PostMapping("/notice/update")
	@ResponseBody
	public String update(BoardVo bv, RedirectAttributes rttr) {
		System.out.println("게시물 수정!");
		System.out.println(bv);
		String msg = "게시물 수정에 실패했습니다.";
		int re = boardService.updateBoard(bv);
		if( re > 0 ) {
			msg = "게시물 수정에 성공했습니다.";
		}
		rttr.addFlashAttribute("result", msg);
		return bv.getB_no()+"";
	}
	
	@PostMapping("/notice/delete")
	@ResponseBody
	public String delete(BoardVo bv){
		String msg = "0";
		System.out.println(bv.getB_no());
		int result = boardService.deleteBoard(bv);
		if(result > 0 ) {
			msg = "1";
		}
		System.out.println(msg);
		return msg;
	}
	
	//게시물 등록 이미지 콜백 컨트롤러.
	@PostMapping(value="/testUpload", produces = "application/json; charset=utf-8")
	@ResponseBody
	public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
		JsonObject jsonObject = new JsonObject();
		
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
	public String FileDBupload(@RequestBody List<BoardFilesVo> files) {
		System.out.println(files);
		for(BoardFilesVo bfv : files) {
			boardFilesService.insert(bfv);
		}
		return "msg";
	}

}
