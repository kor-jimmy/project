package com.aeho.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@GetMapping("/aeho")
	public String main() {
		return "redirect:/main/main";
	}
	
	@GetMapping("/main/main")
	public void getMain() {
		
	}
}
