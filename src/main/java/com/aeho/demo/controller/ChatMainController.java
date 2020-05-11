package com.aeho.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChatMainController {

	@RequestMapping("/")
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView("chat");
		return mav;
	}
}
