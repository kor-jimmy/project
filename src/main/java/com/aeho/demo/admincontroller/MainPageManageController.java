package com.aeho.demo.admincontroller;

import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aeho.demo.domain.VoteDataDTO;
import com.aeho.demo.service.SlideImagesService;
import com.aeho.demo.vo.SlideImagesVo;
import com.aeho.demo.vo.VoteTopicVo;
import com.google.gson.Gson;

@Controller
@RequestMapping("/admin/main/*")
public class MainPageManageController {
	
	@Autowired
	private SlideImagesService slideImageService;
	
	@RequestMapping("/slider")
	public void listSlider(HttpServletRequest request, Model model) {
		model.addAttribute("imgList", slideImageService.listSlideImages());
	}
	
	@RequestMapping("/getImageInfo")
	@ResponseBody
	public String getSlideImage(HttpServletRequest request, int s_no) {
		SlideImagesVo sv = slideImageService.getSlideImages(s_no);
		Gson gson = new Gson();
		return gson.toJson(sv);
	}
	
	@RequestMapping("/insertSlide")
	@ResponseBody
	public String insertVoteTopic(HttpServletRequest request, SlideImagesVo sv, HttpSession session) {
		String msg = "예기치 않은 오류로 슬라이드 이미지 등록이 정상적으로 완료되지 못 했습니다.";
		
		long time = System.currentTimeMillis();
		int rand = (int)(Math.random()*1000000);
		
		System.out.println(sv);
		SlideImagesVo siv = new SlideImagesVo();
		
		siv.setS_text(sv.getS_text());
		siv.setS_title(sv.getS_title());
		
		String path = request.getRealPath("img");
		System.out.println("path: "+path);

		MultipartFile file = sv.getFile_img();
		
		System.out.println("MultipartFile: " +file);
		
		String filename = time+rand+"_"+file.getOriginalFilename();
		
		
		System.out.println("originalName: "+filename);
		
		siv.setS_img(filename);
		System.out.println("siv: "+siv);
		
		int result = slideImageService.insertSlideImages(siv);
		
		if(result > 0) {
			try {
				byte [] data = file.getBytes();
				FileOutputStream fos = new FileOutputStream(path + "/" + filename);
				
				fos.write(data);
				fos.close();

			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
			msg = "새로운 이미지가 등록되었습니다.";
		}
		
		return msg;
	}
	
	@RequestMapping("/updateSlide")
	@ResponseBody
	public String getSlideImage(HttpServletRequest request, SlideImagesVo sv) {
		long time = System.currentTimeMillis();
		int rand = (int)(Math.random()*1000000);
		
		String msg = "예기치 않은 오류로 슬라이드 이미지 수정이 정상적으로 완료되지 못 했습니다.";
		System.out.println("update: "+ sv);
		
		SlideImagesVo siv = new SlideImagesVo();
		siv.setS_no(sv.getS_no());
		
		String path = request.getRealPath("img");
		System.out.println("path: "+path);
		
		
		siv.setS_text(sv.getS_text());
		siv.setS_title(sv.getS_title());
		
		MultipartFile file = null;
		
		String filename = "";
		
		if(sv.getFile_img() != null) {
			file = sv.getFile_img();
			filename = time+rand+"_"+file.getOriginalFilename();
		}

		SlideImagesVo oldsv = slideImageService.getSlideImages(sv.getS_no());
		
		if(file != null) {
			siv.setS_img(filename);
		}else if(file == null){
			siv.setS_img(oldsv.getS_img());
		}
		
		int re = slideImageService.updateSlideImages(siv);
		
		System.out.println(siv);
		if(re > 0) {
			try {
				
				if(file != null) {
					File tempFile = new File(path + "/" + oldsv.getS_img());
					tempFile.delete();
					
					byte [] dataA = file.getBytes();
					
					FileOutputStream fosA = new FileOutputStream(path+"/"+filename);

					fosA.write(dataA);
					fosA.close();
				}
				
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
			msg = "이미지가 수정되었습니다.";
		}
		
		return msg;
	}
	
	@RequestMapping("/deleteSlide")
	@ResponseBody
	public String deleteSlideImage(HttpServletRequest request, int s_no) {
		String msg = "예기치 않은 오류로 슬라이드 이미지 삭제가 정상적으로 완료되지 못 했습니다.";
		String path = request.getRealPath("img");
		System.out.println(path);
		
		SlideImagesVo sv = slideImageService.getSlideImages(s_no);
		
		int re = slideImageService.deleteSlideImages(s_no);
		
		System.out.println(re);
		if(re > 0) {
			try {
				File file = new File(path + "/" + sv.getS_img());
				file.delete();
			}catch (Exception e) {
				e.getMessage();
			}
			msg = "이미지가 삭제되었습니다.";
		}
		return msg;
	}

}
