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
import com.aeho.demo.vo.QnaBoardFilesVo;


@Controller
public class ChatMainController {
	List<ChatRoomVo> roomList = new ArrayList<ChatRoomVo>();
	static int roomNumber = 0;
	
	
	@RequestMapping("/chat")
	public ModelAndView chat(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chat");
		return mv;
	}
	
	
	@RequestMapping("/room")
	public ModelAndView room(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("room");
		return mv;
	}
	
	
	@RequestMapping("/createRoom")
	public @ResponseBody List<ChatRoomVo> createRoom(HttpServletRequest request, @RequestParam HashMap<Object, Object> params, ChatRoomVo crv){
		String roomName = (String) params.get("roomName");
		String m_id = crv.getM_id();
		if(roomName != null && !roomName.trim().equals("")) {
			ChatRoomVo room = new ChatRoomVo();
			room.setRoomNumber(roomNumber++);
			room.setRoomName(roomName.trim());
			room.setM_id(m_id);
			roomList.add(room);
			System.out.println(roomList);
		}
		return roomList;
	}
	
	
	@RequestMapping("/delete")
	public @ResponseBody List<ChatRoomVo> deleteRoom(HttpServletRequest request, ChatRoomVo params){
		int roomNumber = params.getRoomNumber();
		System.out.println(params);
		if(params.getRoomNumber() >= -1) {
			//params.get("roomName");
			roomList.remove(params.getRoomNumber());
			System.out.println(roomList);
		}
		return roomList;
	}
	
	
	@RequestMapping("/getRoom")
	public @ResponseBody List<ChatRoomVo> getRoom(HttpServletRequest request, @RequestParam HashMap<Object, Object> params){
		return roomList;
	}
	
	
	@RequestMapping("/moveChating")
	public ModelAndView chating(HttpServletRequest request, @RequestParam HashMap<Object, Object> params) {
		ModelAndView mv = new ModelAndView();
		int roomNumber = Integer.parseInt((String) params.get("roomNumber"));
		
		List<ChatRoomVo> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
		if(new_list != null && new_list.size() > 0) {
			mv.addObject("roomName", params.get("roomName"));
			mv.addObject("roomNumber", params.get("roomNumber"));
			mv.setViewName("chat");
		}else {
			mv.setViewName("room");
		}
		return mv;
	}
}