package com.aeho.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aeho.demo.vo.ChatRoomVo;

@Controller
public class ChatMainController {
	
	List<ChatRoomVo> chatList = new ArrayList<ChatRoomVo>();
	static int cr_num = 0;

	@RequestMapping("/")
	public ModelAndView chat(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("chat");
		return mav;
	}
	
	//방페이지
	@RequestMapping("/room")
	public ModelAndView room(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("room");
		return mav;
	}
	
	//방 생성
	@RequestMapping("/createRoom")
	public @ResponseBody List<ChatRoomVo> createRoom(HttpServletRequest request, @RequestParam HashMap<Object, Object> params){
		String cr_name = (String)params.get("cr_name");
		if(cr_name != null && !cr_name.trim().equals("")) {
			ChatRoomVo chatRoom = new ChatRoomVo();
			chatRoom.setCr_num(++cr_num);
			chatRoom.setCr_name(cr_name);
			chatList.add(chatRoom);
		}
		return chatList;
	}
	
	@RequestMapping("/getRoom")
	public @ResponseBody List<ChatRoomVo> getRoom(HttpServletRequest request, @RequestParam HashMap<Object, Object> params){
		return chatList;
	}
	
	@RequestMapping("/moveChat")
	public ModelAndView chat(HttpServletRequest request, @RequestParam HashMap<Object, Object> params) {
		ModelAndView mav = new ModelAndView();
		int cr_num = Integer.parseInt((String)params.get("cr_num"));
		System.out.println("cr_num:"+cr_num);
		List<ChatRoomVo> new_list = chatList.stream().filter(o->o.getCr_num()==cr_num).collect(Collectors.toList());
		if(new_list != null && new_list.size() > 0) {
			mav.addObject("cr_name", params.get("cr_name"));
			mav.addObject("cr_num", params.get("cr_num"));
			mav.setViewName("chat");
		}else {
			mav.setViewName("room");
		}
		return mav;
	}
}
