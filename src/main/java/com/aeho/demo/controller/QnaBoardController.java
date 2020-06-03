package com.aeho.demo.controller;

import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

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
import com.aeho.demo.domain.Criteria3;
import com.aeho.demo.domain.PageDto;
import com.aeho.demo.domain.PageDto3;
import com.aeho.demo.service.CategoryService;
import com.aeho.demo.service.QnaBoardFilesService;
import com.aeho.demo.service.QnaBoardService;
import com.aeho.demo.vo.CategoryVo;
import com.aeho.demo.vo.QnaBoardFilesVo;
import com.aeho.demo.vo.QnaBoardVo;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/qnaboard/*")
@AllArgsConstructor
public class QnaBoardController {
	
	@Autowired
	private QnaBoardService qnaBoardService;
	public void setQnaBoardService(QnaBoardService qnaBoardService) {
		this.qnaBoardService = qnaBoardService;
	}
	@Autowired
	private CategoryService categoryService;
	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}
	@Autowired
	private QnaBoardFilesService qnaBoardFilesService;
	public void setQnaBoardFilesService(QnaBoardFilesService qnaBoardFilesService) {
		this.qnaBoardFilesService = qnaBoardFilesService;
	}
	
	@GetMapping("/list")
	public void list (HttpServletRequest request,Criteria3 cri,Model model) {
		int total = qnaBoardService.getTotalCount(cri);
		System.out.println(total);
		System.out.println("list:"+cri);
		model.addAttribute("list", qnaBoardService.getListWithPaging(cri));
		model.addAttribute("pageMake", new PageDto3(cri, total));
		model.addAttribute("c_no",cri.getCategoryNum());
		model.addAttribute("catKeyword",categoryService.getCategory(cri.getCategoryNum()).getC_dist());
	}
	
	@GetMapping("/get")
	public void getQnaBoard(HttpServletRequest request,QnaBoardVo qbv, Model model) {
		model.addAttribute("qnaboard", qnaBoardService.getQnaBoard(qbv.getQb_no()));
	}
	
	@GetMapping("/insert")
	public void insert(HttpServletRequest request,Model model, @Param("c_no") int c_no, @Param("qb_no") int qb_no) {
		CategoryVo cv = categoryService.getCategory(c_no);
		
		model.addAttribute("cv",cv);
		model.addAttribute("qb_no", qb_no);
		model.addAttribute("c_no", c_no);
	}
	
	@PostMapping(value="/insert")
	@ResponseBody
	public String insert(HttpServletRequest request, QnaBoardVo qbv, RedirectAttributes rttr) throws Exception {
			System.out.println("등록되는 큐엔에이 정보===>>"+qbv);
		//String str = "게시물 등록에 실패했습니다.";
				System.out.println(qbv.getQb_no());
				int pno = qbv.getQb_no();
		
				int qb_no = 0;
						//qbv.getQb_no();
				int qb_ref = pno;
				int qb_level = 0;
				int qb_step = 0;
				
				if(pno!=0) {
					QnaBoardVo qnaBoardVo = qnaBoardService.getQnaBoard(pno);
					qb_no = qnaBoardVo.getQb_no();
					qb_ref = qnaBoardVo.getQb_ref();
					qb_level = qnaBoardVo.getQb_level();
					qb_step = qnaBoardVo.getQb_step();
					
					HashMap map = new HashMap();
					map.put("qb_ref", qb_ref);
					map.put("qb_step", qb_step);
					qnaBoardService.updateStep(map);
					System.out.println(map);
					
					qb_level++;
					qb_step++;
				}
				
				//qbv.setQb_no(qb_no);
				qbv.setQb_ref(qb_ref);
				qbv.setQb_level(qb_level);
				qbv.setQb_step(qb_step);
				//System.out.println(qbv);
				int re = qnaBoardService.insertQnaBoard(qbv);
				//String str = "게시물 등록에 실패했습니다.";
				//if(re>0) {
				//	str = "게시물 등록에 성공했습니다.";
				//}
				//rttr.addFlashAttribute("result",str);
				//rttr.addFlashAttribute("qb_no",qbv.getQb_no());
				//String msg = categoryService.getCategory(qbv.getC_no()).getC_dist();
				//String encoding = URLEncoder.encode(msg,"UTF-8");
				//System.out.println(msg);
				//System.out.println(qbv.getQb_no());
				return qbv.getQb_no()+"";
	}
	
	@GetMapping("/replyInsert")
	public void replyInsert(HttpServletRequest request,Model model, @Param("c_no")int c_no, QnaBoardVo qbv) {
		CategoryVo cv = categoryService.getCategory(c_no);
		model.addAttribute("cv",cv);
	} 
	
	@PostMapping(value = "/replyInsert")
	@ResponseBody
	public void replyInsert(HttpServletRequest request,QnaBoardVo qbv, String up_qb_content,RedirectAttributes rttr) throws Exception {
		String msg = categoryService.getCategory(qbv.getC_no()).getC_dist();
		String encoding = URLEncoder.encode(msg, "UTF-8");
		
		qbv.setQb_title(qbv.getQb_title());
		qbv.setQb_ref(qbv.getQb_ref());
		qbv.setQb_level(qbv.getQb_level()+1);
		qbv.setQb_step(qbv.getQb_step()+1);
		
		qbv.setQb_content(up_qb_content);
		qnaBoardService.replyInsert(qbv);
	}
	
	@GetMapping("/update")
	public void update(HttpServletRequest request,QnaBoardVo qbv, Model model) {
		model.addAttribute("qnaboard", qnaBoardService.getQnaBoard(qbv.getQb_no()));
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String update(HttpServletRequest request,QnaBoardVo qbv, RedirectAttributes rttr) {
		String msg = "게시물 수정에 실패했습니다.";
		int re = qnaBoardService.updateQnaBoard(qbv);
		if( re > 0 ) {
			msg = "게시물 수정에 성공했습니다.";
		}
		rttr.addFlashAttribute("result", msg);
		System.out.println(msg);
		return qbv.getQb_no()+"";
	}
	
	@GetMapping("/delete")
	@ResponseBody
	public String delete(HttpServletRequest request,QnaBoardVo qbv) throws Exception{
		String msg = "0";
		System.out.println(qbv.getQb_no());
		int result = qnaBoardService.deleteQnaBoard(qbv);
		if(result > 0 ) {
			msg = "1";
		}
		return msg;
	}
	
	
	
	
	
	
	
	
	
	//게시물 등록 이미지 콜백 컨트롤러.
		@PostMapping(value="/testUpload", produces = "application/json; charset=utf-8")
		@ResponseBody
		public JsonObject uploadSummernoteImageFile(HttpServletRequest request, @RequestParam("file") MultipartFile multipartFile) {
			JsonObject jsonObject = new JsonObject();
			
			Date date = new Date();
	    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH", Locale.KOREA);
	    	String today = dateFormat.format(date);

	    	String year = today.split("/")[0];
	    	String month = today.split("/")[1];
	    	
			String fileRoot = "C:\\aehoUpload\\qnaboard\\"+year+"\\"+month+"\\";	//저장될 외부 파일 경로
			String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
			//확장자 유효성 검사
			String savedFileName = UUID.randomUUID() +"_"+originalFileName;	//저장될 파일 명
			
			File targetFile = new File(fileRoot + savedFileName);	
			
			try {
				InputStream fileStream = multipartFile.getInputStream();
				FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
				jsonObject.addProperty("url", "/qnaBoardImage/"+savedFileName);
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
		public String FileDBupload(HttpServletRequest request, @RequestBody List<QnaBoardFilesVo> files) {
			System.out.println(files);
			for(QnaBoardFilesVo qbfv : files) {
				qnaBoardFilesService.insert(qbfv);
			}
			return "msg";
		}
}