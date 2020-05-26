package com.aeho.demo.admincontroller;

import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.aeho.demo.domain.VoteDataDTO;
import com.aeho.demo.service.VoteService;
import com.aeho.demo.service.VoteTopicService;
import com.aeho.demo.vo.VoteTopicVo;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/vote/*")
@AllArgsConstructor
public class VoteManageController {
	
	@Autowired
	private VoteService voteService;
	@Autowired
	private VoteTopicService voteTopicService;

	@RequestMapping("/manage")
	public ModelAndView listAdmin() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/vote/list");
		return mav;
	}
	
	@RequestMapping("/insertVoteTopic")
	@ResponseBody
	public String insertVoteTopic(VoteDataDTO vdd, HttpServletRequest request, HttpSession session) {
		String msg = "예기치 않은 오류로 투표 주제 등록이 정상적으로 완료되지 못 했습니다.";
		
		long time = System.currentTimeMillis();
		int rand = (int)(Math.random()*1000000);
		
		System.out.println(vdd);
		VoteTopicVo vtv = new VoteTopicVo();
		
		String optionA = vdd.getOptionAname();
		String optionB = vdd.getOptionBname();
		
		vtv.setVt_content(optionA+"/"+optionB);
		
		String path = request.getRealPath("img/vote");
		System.out.println("path: "+path);

		MultipartFile fileA = vdd.getFileA();
		MultipartFile fileB = vdd.getFileB();
		
		System.out.println("MultipartFile: " +fileA + "/" + fileB);
		
		String filenameA = time+rand+"_"+fileA.getOriginalFilename();
		String filenameB = time+rand+"_"+fileB.getOriginalFilename();
		
		System.out.println("originalName: "+filenameA+"/"+filenameB);
		
		vtv.setVt_img_a(filenameA);
		vtv.setVt_img_b(filenameB);
		
		System.out.println("vtv: "+vtv);
		int result = voteTopicService.insertVoteTopic(vtv);
		if(result > 0) {
			try {
				byte [] dataA = fileA.getBytes();
				FileOutputStream fosA = new FileOutputStream(path + "/" + filenameA);
				byte [] dataB = fileB.getBytes();
				FileOutputStream fosB = new FileOutputStream(path + "/" + filenameB);
				
				fosA.write(dataA);
				fosB.write(dataB);
				
				fosA.close();
				fosB.close();
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
			msg = "새로운 주제가 등록되었습니다.";
		}
		
		return msg;
	}
	
	@PostMapping("/updateVoteTopic")
	@ResponseBody
	public String updateVoteTopic(VoteDataDTO vdd, HttpServletRequest request) {
		long time = System.currentTimeMillis();
		int rand = (int)(Math.random()*1000000);
		
		String msg = "예기치 않은 오류로 투표 주제 수정이 정상적으로 완료되지 못 했습니다.";
		System.out.println("update: "+vdd);
		VoteTopicVo vtv = new VoteTopicVo();
		vtv.setVt_no(vdd.getVt_no());
		
		String path = request.getRealPath("img/vote");
		System.out.println("path: "+path);
		
		String vt_content = vdd.getOptionAname() + "/" + vdd.getOptionBname();
		vtv.setVt_content(vt_content);
		
		MultipartFile fileA = null;
		MultipartFile fileB = null;
		
		String fileAname = "";
		String fileBname = "";
		
		if(vdd.getFileA() != null) {
			fileA = vdd.getFileA();
			fileAname = time+rand+"_"+fileA.getOriginalFilename();
		}
		if(vdd.getFileB() != null) {
			fileB = vdd.getFileB();
			fileBname = time+rand+"_"+fileB.getOriginalFilename();
		}

		VoteTopicVo oldvtv = voteTopicService.getVoteTopic(vdd.getVt_no());
		
		if(fileA == null && fileB == null) {
			vtv.setVt_img_a(oldvtv.getVt_img_a());
			vtv.setVt_img_b(oldvtv.getVt_img_b());
		}else if(fileA == null){
			vtv.setVt_img_b(fileBname);
			vtv.setVt_img_a(oldvtv.getVt_img_a());
		}else if(fileB == null){
			vtv.setVt_img_a(fileAname);
			vtv.setVt_img_b(oldvtv.getVt_img_b());
		}else {
			vtv.setVt_img_a(fileAname);
			vtv.setVt_img_b(fileBname);
		}
		
		int re = voteTopicService.updateVoteTopic(vtv);
		
		System.out.println(vtv);
		if(re > 0) {
			try {
				
				if(fileA != null && fileB != null) {
					File AFile = new File(path + "/" + oldvtv.getVt_img_b());
					File BFile = new File(path + "/" + oldvtv.getVt_img_b());
					AFile.delete();
					BFile.delete();
					
					byte [] dataA = fileA.getBytes();
					byte [] dataB = fileB.getBytes();
					
					FileOutputStream fosA = new FileOutputStream(path+"/"+fileAname);
					FileOutputStream fosB = new FileOutputStream(path+"/"+fileBname);
					
					fosA.write(dataA);
					fosB.write(dataB);
					
					fosA.close();
					fosB.close();
				}else if(fileA == null && fileB != null){
					File file = new File(path + "/" + oldvtv.getVt_img_b());
					file.delete();
					
					byte [] dataB = fileB.getBytes();
					FileOutputStream fosB = new FileOutputStream(path+"/"+fileBname);
					
					fosB.write(dataB);
					fosB.close();
				}else if(fileB == null && fileA != null){
					File file = new File(path + "/" + oldvtv.getVt_img_a());
					file.delete();
					
					byte [] dataA = fileA.getBytes();
					FileOutputStream fosA = new FileOutputStream(path+"/"+fileAname);
					
					fosA.write(dataA);
					fosA.close();
				}
				
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
			msg = "투표 정보가 수정되었습니다.";
		}
		
		return msg;
	}
	
	@RequestMapping("/deleteVoteTopic")
	@ResponseBody
	public String deleteVoteTopic(VoteTopicVo vtv, HttpServletRequest request) {
		String msg = "예기치 않은 오류로 투표 주제 삭제가 정상적으로 완료되지 못 했습니다.";
		String path = request.getRealPath("img/vote");
		System.out.println(path);
		System.out.println("vtv: "+vtv);
		int re = voteTopicService.deleteVoteTopic(vtv.getVt_no());
		if(re > 0) {
			try {
				File fileA = new File(path + "/" + vtv.getVt_img_a());
				File fileB = new File(path + "/" + vtv.getVt_img_b());
				
				fileA.delete();
				fileB.delete();
			}catch (Exception e) {
				e.getMessage();
			}
			msg = "투표 정보가 삭제되었습니다.";
		}
		return msg;
	}
}
