package com.aeho.demo.admincontroller;

import java.io.File;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

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

import com.aeho.demo.dao.CategoryDao;
import com.aeho.demo.dao.LogDao;
import com.aeho.demo.dao.PicksDao;
import com.aeho.demo.domain.Criteria;
import com.aeho.demo.domain.PageDto;
import com.aeho.demo.service.BoardFilesSevice;
import com.aeho.demo.service.BoardService;
import com.aeho.demo.service.CategoryService;
import com.aeho.demo.vo.BoardFilesVo;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.CategoryVo;
import com.aeho.demo.vo.LogVo;
import com.aeho.demo.vo.PicksVo;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

	@Autowired
	private LogDao logDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private PicksDao picksDao;
	
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/admin")
	public void admin() {
		
	}
	
	@GetMapping("/listLog")
	@ResponseBody
	public String listLog() {
		System.out.println("listLog 작동중....");
		List<LogVo> list = logDao.listLogs();
		Gson gson = new Gson();
		String str = gson.toJson(list);
		System.out.println(str);
		return str;
	}
	
	@GetMapping("/popCategory")
	@ResponseBody
	public String popCategory() {
		List<CategoryVo> list = categoryDao.popCategory();
		Gson gson = new Gson();
		String str = gson.toJson(list);
		return str;
	}
	
	// 주별 인기 검색어
	@RequestMapping("/listWeeklyPicks")
	@ResponseBody
	public String listWeeklyPicks() {
		String chartCondition = "weekly";
		List<PicksVo> list = picksDao.listPicksForAdmin(chartCondition);
		Gson gson = new Gson();
		String str = gson.toJson(list);
		return str;
	}
	
	// 월별 인기 검색어
	@RequestMapping("/listMonthlyPicks")
	@ResponseBody
	public String listMonthlyPicks() {
		String chartCondition = "monthly";
		List<PicksVo> list = picksDao.listPicksForAdmin(chartCondition);
		Gson gson = new Gson();
		String str = gson.toJson(list);
		return str;
	}
	
	@GetMapping("/adminNotice")
	@ResponseBody
	public String adminNotice() {
		List<BoardVo> list = boardService.getAdminNotice();
		Gson gson = new Gson();
		String str = gson.toJson(list);
		return str;
	}
	
	@GetMapping("/userNotice")
	@ResponseBody
	public String userNotice() {
		List<BoardVo> list = boardService.getUserNotice();
		Gson gson = new Gson();
		String str = gson.toJson(list);
		return str;
	}
}
