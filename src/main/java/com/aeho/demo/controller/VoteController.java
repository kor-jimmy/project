package com.aeho.demo.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
		if( v_result == 1 ) {
			map.put("result", voteTopicService.getVoteTopic(vv.getVt_no()).getVt_count_a()+"");
		}else if( v_result == 2 ) {
			map.put("result", voteTopicService.getVoteTopic(vv.getVt_no()).getVt_count_b()+"");
		}
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
}
