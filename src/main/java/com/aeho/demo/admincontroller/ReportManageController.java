package com.aeho.demo.admincontroller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aeho.demo.domain.Criteria;
import com.aeho.demo.domain.Criteria2;
import com.aeho.demo.domain.CriteriaForReply;
import com.aeho.demo.domain.PageDto;
import com.aeho.demo.domain.PageDto2;
import com.aeho.demo.domain.PageDtoForReply;
import com.aeho.demo.service.BoardService;
import com.aeho.demo.service.GoodsService;
import com.aeho.demo.service.ReplyService;
import com.aeho.demo.service.ReportService;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.GoodsVo;
import com.aeho.demo.vo.ReplyVo;

@RequestMapping("/admin/report/*")
@Controller
public class ReportManageController {
	
	@Autowired
	private ReportService reportService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private GoodsService goodsService;
	
	@GetMapping("/board")
	public void reportBoard(Criteria cri, Model model) {
		cri.setAmount(30);
		cri.setCategoryNum(0);
		System.out.println(cri);
		System.out.println("카테고리넘버"+cri.getCategoryNum());
		int total = boardService.getReportCount();
		model.addAttribute("list", boardService.getList(cri));
		model.addAttribute("pageMake", new PageDto(cri, total));
		model.addAttribute("c_no",cri.getCategoryNum());
		//model.addAttribute("catkeyword",categoryService.getCategory(cri.getCategoryNum()).getC_dist());
	}
	
	@PostMapping("/chooseBoardDelete")
	@ResponseBody
	public void chooseBoardDelete(@RequestParam(value = "list[]") List<Integer> chooseBno) {
		for(int i=0; i<chooseBno.size(); i++) {
			BoardVo bv = new BoardVo();
			bv.setB_no(chooseBno.get(i));
			boardService.deleteBoard(bv);
		}
		//return "";
	}
	
	@PostMapping("/chooseReplydelete")
	@ResponseBody
	public void chooseReplydelete(@RequestParam(value = "list[]") List<Integer> chooseRno) {
		for(int i=0; i<chooseRno.size(); i++) {
			ReplyVo rv = new ReplyVo();
			rv.setR_no(chooseRno.get(i));
			replyService.deleteReply(rv);
		}
	}
	
	@RequestMapping("reply")
	public void getReportReply(Model model){
		
		CriteriaForReply cri = new CriteriaForReply();
		cri.setAmount(30);
		System.out.println(cri);
		
		int total = replyService.getReportCnt();
		
		List<ReplyVo> replyList = replyService.getReportReply(cri);
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		
		for( int i = 0; i < replyList.size() ; i++) {
			BoardVo bv = new BoardVo();
			bv.setB_no(replyList.get(i).getB_no());
			boardList.add(boardService.getBoard(bv));
		}
		
		model.addAttribute("pageMake", new PageDtoForReply(cri, total));
		model.addAttribute("replyList", replyList);
		model.addAttribute("boardList", boardList);
		
	}
	
	@RequestMapping("goods")
	public void getReportGoods(Model model) {
		
		Criteria2 cri = new Criteria2();
		
		List<GoodsVo> goodsList = goodsService.getReportGoods(cri);
		int total = goodsService.getReportGoods(cri).size();
		
		model.addAttribute("pageMake", new PageDto2(cri, total));
		model.addAttribute("goodsList", goodsList);
	}
	
	@PostMapping("/chooseGoodsDelete")
	@ResponseBody
	public String chooseGoodsdelete(@RequestParam(value = "list[]") List<Integer> chooseGno) {
		String msg = "삭제되지 못 한 게시글이 존재합니다.";
		int re = 0;
		for( int i=0; i<chooseGno.size(); i++ ) {
			GoodsVo gv = new GoodsVo();
			gv.setG_no(chooseGno.get(i));
			re = re + goodsService.deleteGoods(gv);
		}
		
		if( re == chooseGno.size() ) {
			msg = "삭제가 모두 완료되었습니다.";
		}
		System.out.println("re: " + re + "/ chooseGno: "+chooseGno);
		return msg;
	}

}
