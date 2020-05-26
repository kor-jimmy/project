package com.aeho.demo.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.aeho.demo.dao.VoteTopicDao;
import com.aeho.demo.domain.VoteDataDTO;
import com.aeho.demo.service.VoteService;
import com.aeho.demo.service.VoteTopicService;
import com.aeho.demo.vo.VoteTopicVo;
import com.aeho.demo.vo.VoteVo;
import com.google.gson.Gson;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/vote/*")
@AllArgsConstructor
public class VoteController {
	
	@Autowired
	private VoteService voteService;
	@Autowired
	private VoteTopicService voteTopicService;
	
	@RequestMapping("/vote")
	public void list() {}
	
	@GetMapping("/list")
	@ResponseBody
	public String listVote(Model model) {
		List<VoteTopicVo> list = voteTopicService.ongoingListVoteTopic();
//		model.addAttribute("list", list);
		Gson gson = new Gson();
		System.out.println(list);
		return gson.toJson(list);
	}
	
	@GetMapping("/listEnded")
	@ResponseBody
	public String endedVote() {
		List<VoteTopicVo> list = voteTopicService.endedListVoteTopic();
		Gson gson = new Gson();
		return gson.toJson(list);
	}
	
	@GetMapping("/insert")
	@ResponseBody
	public HashMap<String, String> insertVote(VoteVo vv) {
		String msg = "예기치 않은 오류로 인해 투표가 반영되지 못했습니다! 다시 한번 시도해주세요!";
		int re = voteService.insertVote(vv);
		if(re > 0) {
			msg = "투표가 반영되었습니다. 대단히 감사합니다!";
		}
		int v_result = vv.getV_result();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("msg", msg);
		map.put("result_a", voteTopicService.getVoteTopic(vv.getVt_no()).getVt_count_a()+"");
		map.put("result_b", voteTopicService.getVoteTopic(vv.getVt_no()).getVt_count_b()+"");
		return map;
	}
	
	@GetMapping("/update")
	@ResponseBody
	public HashMap<String, String> updateVote(VoteVo vv) {
		String msg = "예기치 않은 오류로 인해 투표 수정이 반영되지 못했습니다. 다시 한번 시도해주세요!";
		VoteVo v = isChecked(vv);
		vv.setV_no(v.getV_no());
		int re = voteService.updateVote(vv);
		if(re > 0) {
			msg = "수정이 반영되었습니다. 대단히 감사합니다!";
		}
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("msg", msg);
		map.put("resultA", voteTopicService.getVoteTopic(vv.getVt_no()).getVt_count_a()+"");
		map.put("resultB", voteTopicService.getVoteTopic(vv.getVt_no()).getVt_count_b()+"");
		return map;
	}
	
	@GetMapping("/isChecked")
	@ResponseBody
	public VoteVo isChecked(VoteVo vv) {
		String re = "";
		List<VoteVo> list = voteService.isChecked(vv);
		System.out.println(list);
		VoteVo v = new VoteVo();
		if( list.size() > 0 ) {
			v = list.get(0);
		}
		return v;
	}
	
	@RequestMapping("/updateState")
	@ResponseBody
	public int updateState(VoteTopicVo vtv) {
		int re = voteTopicService.updateState(vtv);
		return re;
	}
	
	//관리자용
	
	@RequestMapping("/manage")
	public ModelAndView listAdmin() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("vote/list");
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
